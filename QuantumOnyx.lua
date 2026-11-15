--[[
	Quantum Onyx - open release loader
	------------------------------------
	Без key-system, без Luarmor, без обфускации.
	Вставляешь в эксплойтер -> жмёшь кнопку -> грузится скрипт с GitHub.

	Настройка:
	  BASE_URL ниже должен указывать на raw-ссылку на твой репозиторий,
	  где лежат папки Games/, Util/, dev/ и scripts/QuantumOnyxPremium.lua.
	  Меняется одной строкой (или через tools/repoint_urls.py).

	Структура файлов в репозитории (важно, payload ищет модули по этим путям):
	  Util/Library.lua
	  Util/KaitunLibrary.lua
	  Util/LibraryModule/Themes.lua
	  Util/BloxFruitModule/Preload/{Data,Visuals,Weebo,UI_Tabs,Funcs,helper}.lua
	  Util/BloxFruitModule/{bypass,HookMeta}.lua
	  dev/niulai.lua
	  Games/{BloxFruits,CutTrees,KickALuckyBlock}.lua
	  scripts/QuantumOnyxPremium.lua
--]]

local BASE_URL = "https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/"

-- Luarmor v4 runtime (тот же, что грузит автор: QuantumOnyx.lua -> LoadStockLoader).
-- Он ставит init-рантайм, который наполняет окружение служебными значениями:
-- без него скрипты падают на _ENV["RaceList"] / D["<random>"] ("You Are Lost!").
local STOCK_LOADER_URL = "https://api.luarmor.net/files/v4/loaders/0ae9fe4cf963e3a13d25eed0e2ce5940.lua"

local function bootRuntime()
	local env = (getgenv and getgenv()) or _G
	if env.QuantumOnyxRuntime then
		return true
	end
	print("[QuantumOnyx] booting Luarmor v4 runtime...")
	local ok, err = pcall(function()
		local body = game:HttpGet(STOCK_LOADER_URL)
		if type(body) ~= "string" or #body == 0 then
			error("empty runtime loader response")
		end
		local chunk, cerr = loadstring(body, "luarmor-stock-loader")
		if not chunk then
			error("runtime compile error: " .. tostring(cerr))
		end
		chunk()
	end)
	if ok then
		env.QuantumOnyxRuntime = true
		print("[QuantumOnyx] runtime ready")
	else
		warn("[QuantumOnyx] runtime init failed: " .. tostring(err))
	end
	return ok
end

-- Blox Fruits = 3 места: Sea 1 / Sea 2 / Sea 3 (+ старый ID из оригинального хаба)
local BLOX_FRUITS = { 2753915544, 4442272183, 7449423635, 994732206 }
local function games(list)
	local t = {}
	for _, id in ipairs(list) do
		t[id] = true
	end
	return t
end

-- скрипты: name = подпись, file = путь в репозитории, games = PlaceId'ы
local SCRIPTS = {
	{ name = "Blox Fruits Premium", file = "scripts/QuantumOnyxPremium.lua", games = games(BLOX_FRUITS), auto = true },
	{ name = "Blox Fruits", file = "Games/BloxFruits.lua", games = games(BLOX_FRUITS) },
	{ name = "Cut Trees", file = "Games/CutTrees.lua", games = games({ 8191429227 }) },
	{ name = "Kick a Lucky Block", file = "Games/KickALuckyBlock.lua", games = {} },
}

-- --------------------------------------------------------------- utils ---

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

local function gameName()
	local ok, name = pcall(function()
		return game:GetService("GameSettings").Name
	end)
	return (ok and name) or ("Place " .. PlaceId)
end

-- эксплойтер иногда отдаёт пустой ответ (наблюдалось: fetched 0 bytes
-- при живом GitHub) - ретраим и считаем пустой ответ ошибкой
local function fetch(url)
	for i = 1, 5 do
		local ok, body = pcall(function()
			return game:HttpGet(url)
		end)
		if ok and type(body) == "string" and #body > 0 then
			return body
		end
		warn("[QuantumOnyx] fetch " .. i .. "/5 failed ("
			.. #(tostring(body)) .. " bytes): " .. url)
		task.wait(1)
	end
	error("fetch failed after 5 tries: " .. url)
end

local function loadRemote(path)
	local url = BASE_URL .. path
	print("[QuantumOnyx] fetching: " .. url)
	local body = fetch(url)
	print("[QuantumOnyx] fetched " .. #body .. " bytes")
	-- GitHub на 404 отдаёт HTML-страницу: Luau падает с непонятной ошибкой
	-- про Unicode, поэтому проверяем явно и показываем нормальный текст
	if body:find("<html", 1, true) or body:find("<!DOCTYPE", 1, true) then
		error("404 / HTML instead of Lua: " .. url)
	end
	local chunk, err = loadstring(body, path)
	if not chunk then
		error("compile error in " .. path .. ": " .. tostring(err))
	end
	print("[QuantumOnyx] compiled " .. path .. ", running...")
	local res = { chunk() }
	print("[QuantumOnyx] finished " .. path)
	return unpack(res)
end

-- ----------------------------------------------------------------- UI ----

local screen = Instance.new("ScreenGui")
screen.Name = "QuantumOnyx"
screen.ResetOnSpawn = false
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function make(class, props)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do
		o[k] = v
	end
	return o
end

local card = make("Frame", {
	Size = UDim2.fromOffset(460, 330),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(18, 18, 22),
	BorderSizePixel = 0,
	Parent = screen,
})
make("UICorner", { CornerRadius = UDim.new(0, 8), Parent = card })
make("UIStroke", { Color = Color3.fromRGB(70, 70, 85), Thickness = 1, Parent = card })

-- заголовок служит ручкой перетаскивания (у Frame нет события Input,
-- перетаскивание вешаем на TextButton)
local titleButton = make("TextButton", {
	Size = UDim2.new(1, -24, 0, 28),
	Position = UDim2.fromOffset(12, 8),
	BackgroundTransparency = 1,
	Text = "Quantum Onyx",
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(240, 240, 245),
	TextXAlignment = Enum.TextXAlignment.Left,
	AutoButtonColor = false,
	Parent = card,
})

make("TextLabel", {
	Size = UDim2.new(1, -24, 0, 18),
	Position = UDim2.fromOffset(12, 36),
	BackgroundTransparency = 1,
	Text = gameName() .. "  (PlaceId " .. PlaceId .. ")",
	TextSize = 12,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(140, 140, 152),
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = card,
})

local status = make("TextLabel", {
	Size = UDim2.new(1, -24, 0, 40),
	Position = UDim2.fromOffset(12, 284),
	BackgroundTransparency = 1,
	Text = "Выбери скрипт (или подожди автозапуск)",
	TextSize = 12,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(160, 160, 172),
	TextXAlignment = Enum.TextXAlignment.Left,
	TextWrapped = true,
	Parent = card,
})

local buttons = {}

local function run(entry, button)
	button.Text = "Loading..."
	status.Text = "Fetching " .. entry.file
	status.TextColor3 = Color3.fromRGB(160, 160, 172)
	print("[QuantumOnyx] run: " .. entry.name .. " (" .. entry.file .. ")")
	task.spawn(function()
		local ok, err = pcall(function()
			bootRuntime()
			return loadRemote(entry.file)
		end)
		if ok then
			status.Text = "Loaded: " .. entry.name
			status.TextColor3 = Color3.fromRGB(110, 220, 140)
			button.Text = "Done"
			print("[QuantumOnyx] OK: " .. entry.name)
		else
			local msg = tostring(err)
			if msg:find("You Are Lost", 1, true) then
				msg = "VM trap (You Are Lost!) - Luarmor runtime did not inject state"
			elseif msg:find("attempt to index nil with", 1, true) then
				msg = msg .. "  [missing runtime global]"
			end
			status.Text = msg
			status.TextColor3 = Color3.fromRGB(240, 120, 120)
			button.Text = "RETRY"
			warn("[QuantumOnyx] FAILED " .. entry.name .. ": " .. msg)
		end
	end)
end

for i, entry in ipairs(SCRIPTS) do
	local y = 64 + (i - 1) * 42
	local detected = entry.games[PlaceId] == true
	local b = make("TextButton", {
		Size = UDim2.new(1, -24, 0, 36),
		Position = UDim2.fromOffset(12, y),
		BackgroundColor3 = detected and Color3.fromRGB(96, 64, 205) or Color3.fromRGB(52, 52, 62),
		BorderSizePixel = 0,
		Text = (detected and "* " or "") .. entry.name,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(245, 245, 250),
		AutoButtonColor = true,
		Parent = card,
	})
	make("UICorner", { CornerRadius = UDim.new(0, 6), Parent = b })
	b.MouseButton1Click:Connect(function()
		run(entry, b)
	end)
	buttons[i] = b

	-- автозапуск первого скрипта, подходящего под текущее место
	if entry.auto and detected then
		print("[QuantumOnyx] auto-load " .. entry.file .. " in 2s (PlaceId " .. PlaceId .. ")")
		task.delay(2, function()
			if b.Text ~= "Done" then
				run(entry, b)
			end
		end)
	end
end

-- перетаскивание окна (классическая схема через UserInputService)
do
	local dragging = false
	local dragStart, startPos

	titleButton.MouseButton1Down:Connect(function()
		dragging = true
		dragStart = UserInputService:GetMouseLocation()
		startPos = card.Position
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging
			and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = UserInputService:GetMouseLocation() - dragStart
			card.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- GUI пересоздаётся после респавна
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		task.wait(1)
		screen.Parent = plr:WaitForChild("PlayerGui")
	end)
end)

print("[QuantumOnyx] loader ready: " .. gameName() .. " (PlaceId " .. PlaceId .. ")")

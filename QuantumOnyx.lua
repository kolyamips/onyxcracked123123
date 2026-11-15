--[[
	Quantum Onyx Lite - загрузчик
	-----------------------------
	Без key-system, без Luarmor, без обфускации: только наш чит.

	Запуск:
		loadstring(game:HttpGet("https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/QuantumOnyx.lua"))()

	В репозитории два файла:
		QuantumOnyx.lua          - этот загрузчик
		Games/QuantumLite.lua    - сам чит (Blox Fruits)
--]]

local BASE_URL = "https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/"

local SCRIPT_NAME = "QuantumLite"
local SCRIPT_FILE = "Games/QuantumLite.lua"

-- Blox Fruits: Sea 1 / Sea 2 / Sea 3 (+ старый ID)
local BLOX_FRUITS = { 2753915544, 4442272183, 7449423635, 994732206 }

-- --------------------------------------------------------------- services ---
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

local isBloxFruits = false
for _, id in ipairs(BLOX_FRUITS) do
	if id == PlaceId then
		isBloxFruits = true
		break
	end
end

local function gameName()
	local ok, name = pcall(function()
		return game:GetService("GameSettings").Name
	end)
	return (ok and name) or ("Place " .. PlaceId)
end

-- эксплойтер иногда отдаёт пустой ответ - ретраим
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
	-- GitHub на 404 отдаёт HTML-страницу
	if body:find("<html", 1, true) or body:find("<!DOCTYPE", 1, true) then
		error("404 / HTML instead of Lua: " .. url)
	end
	local chunk, err = loadstring(body, path)
	if not chunk then
		error("compile error in " .. path .. ": " .. tostring(err))
	end
	print("[QuantumOnyx] compiled " .. path .. ", running...")
	chunk()
	print("[QuantumOnyx] finished " .. path)
end

-- --------------------------------------------------------------------- UI ---
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
	Size = UDim2.fromOffset(460, 210),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(18, 18, 22),
	BorderSizePixel = 0,
	Parent = screen,
})
make("UICorner", { CornerRadius = UDim.new(0, 8), Parent = card })
make("UIStroke", { Color = Color3.fromRGB(70, 70, 85), Thickness = 1, Parent = card })

-- заголовок = ручка перетаскивания
local titleButton = make("TextButton", {
	Size = UDim2.new(1, -24, 0, 28),
	Position = UDim2.fromOffset(12, 8),
	BackgroundTransparency = 1,
	Text = "Quantum Onyx Lite",
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
	Size = UDim2.new(1, -24, 0, 46),
	Position = UDim2.fromOffset(12, 132),
	BackgroundTransparency = 1,
	Text = "Готов к запуску",
	TextSize = 12,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(160, 160, 172),
	TextXAlignment = Enum.TextXAlignment.Left,
	TextWrapped = true,
	Parent = card,
})

local button = make("TextButton", {
	Size = UDim2.new(1, -24, 0, 44),
	Position = UDim2.fromOffset(12, 76),
	BackgroundColor3 = Color3.fromRGB(96, 64, 205),
	BorderSizePixel = 0,
	Text = "Запустить " .. SCRIPT_NAME,
	TextSize = 15,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(245, 245, 250),
	AutoButtonColor = true,
	Parent = card,
})
make("UICorner", { CornerRadius = UDim.new(0, 6), Parent = button })

local running = false

local function run()
	if running then
		return
	end
	running = true
	button.Text = "Loading..."
	status.Text = "Загрузка " .. SCRIPT_FILE
	status.TextColor3 = Color3.fromRGB(160, 160, 172)
	print("[QuantumOnyx] run: " .. SCRIPT_FILE)
	task.spawn(function()
		local ok, err = pcall(loadRemote, SCRIPT_FILE)
		if ok then
			status.Text = "Загружено. RightShift - скрыть окно чита."
			status.TextColor3 = Color3.fromRGB(110, 220, 140)
			button.Text = "Готово"
			print("[QuantumOnyx] OK: " .. SCRIPT_NAME)
		else
			local msg = tostring(err)
			status.Text = msg
			status.TextColor3 = Color3.fromRGB(240, 120, 120)
			button.Text = "ПОВТОРИТЬ"
			warn("[QuantumOnyx] FAILED: " .. msg)
			running = false
		end
	end)
end

button.MouseButton1Click:Connect(run)

-- на Blox Fruits запускаем сразу
if isBloxFruits then
	print("[QuantumOnyx] auto-load " .. SCRIPT_FILE .. " in 2s")
	task.delay(2, function()
		if button.Text ~= "Готово" then
			run()
		end
	end)
else
	status.Text = "Не Blox Fruits. Кнопка запускает чит всё равно."
	status.TextColor3 = Color3.fromRGB(200, 180, 120)
end

-- перетаскивание окна
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
		local gui = plr:FindFirstChild("PlayerGui")
		if gui then
			screen.Parent = gui
		end
	end)
end)

print("[QuantumOnyx] loader ready: " .. gameName() .. " (PlaceId " .. PlaceId .. ")")

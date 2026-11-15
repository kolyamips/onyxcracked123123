--[[
	Quantum Onyx - clean release loader
	---------------------------------------
	Без key-system, без Luarmor, без обфускации.
	Один скрипт: вставляешь в эксплойтер, жмёшь LOAD - грузится нужный скрипт.

	Как опубликовать:
	  1. Залей содержимое scripts/ и lib/ в свой GitHub-репозиторий.
	  2. Поправь BASE_URL ниже на raw-ссылку на свой репозиторий.
	     BASE_URL = "https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/"
	     (или один раз прогони tools/repoint_urls.py --base <твоя ссылка>)
	  3. Скрипт грузит файлы по http, поэтому интернет нужен всегда.
	     Если хочешь грузить локально из workspace эксплойтера -
	     замени LoadRemote() на чтение readfile().
--]]

local BASE_URL = "https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/"

-- какие скрипты за что отвечают
local SCRIPTS = {
	{
		name = "Blox Fruits",
		games = { [994732206] = true },
		file = "scripts/BloxFruits.lua",
	},
	{
		name = "Cut Trees",
		games = { [8191429227] = true },
		file = "scripts/CutTrees.lua",
	},
	{
		name = "Kick a Lucky Block",
		games = { [1627717781] = true },
		file = "scripts/KickALuckyBlock.lua",
	},
	{
		name = "Quantum Onyx Premium (Blox Fruits)",
		games = { [994732206] = true },
		file = "scripts/QuantumOnyxPremium.lua",
	},
}

-- --------------------------------------------------------------- utils ---

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GameId = game.PlaceId

local function gameName()
	local ok, name = pcall(function()
		return game:GetService("GameSettings").Name
	end)
	return ok and name or ("Game " .. GameId)
end

local function loadRemote(path)
	local url = BASE_URL .. path
	local body = game:HttpGet(url)
	local chunk, err = loadstring(body, path)
	if not chunk then
		error("compile error in " .. path .. ": " .. tostring(err))
	end
	return chunk()
end

local function pickScript()
	for _, entry in ipairs(SCRIPTS) do
		if entry.games[GameId] then
			return entry
		end
	end
	return nil
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
	Size = UDim2.fromOffset(420, 250),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(20, 20, 24),
	BorderSizePixel = 0,
	Parent = screen,
})
make("UICorner", { CornerRadius = UDim.new(0, 8), Parent = card })
make("UIStroke", { Color = Color3.fromRGB(70, 70, 85), Thickness = 1, Parent = card })

local title = make("TextLabel", {
	Size = UDim2.new(1, -24, 0, 28),
	Position = UDim2.fromOffset(12, 10),
	BackgroundTransparency = 1,
	Text = "Quantum Onyx",
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(240, 240, 245),
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = card,
})

local subtitle = make("TextLabel", {
	Size = UDim2.new(1, -24, 0, 20),
	Position = UDim2.fromOffset(12, 38),
	BackgroundTransparency = 1,
	Text = gameName(),
	TextSize = 13,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(150, 150, 160),
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = card,
})

local status = make("TextLabel", {
	Size = UDim2.new(1, -24, 0, 20),
	Position = UDim2.fromOffset(12, 150),
	BackgroundTransparency = 1,
	Text = "",
	TextSize = 13,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 210),
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = card,
})

local function makeButton(text, y, color)
	local b = make("TextButton", {
		Size = UDim2.new(1, -24, 0, 40),
		Position = UDim2.fromOffset(12, y),
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		Text = text,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		AutoButtonColor = true,
		Parent = card,
	})
	make("UICorner", { CornerRadius = UDim.new(0, 6), Parent = b })
	return b
end

local detected = pickScript()

local function run(entry, button)
	if not entry then
		status.Text = "No script for this game"
		status.TextColor3 = Color3.fromRGB(240, 120, 120)
		return
	end
	button.Text = "Loading..."
	status.Text = "Fetching " .. entry.file
	status.TextColor3 = Color3.fromRGB(200, 200, 210)
	task.spawn(function()
		local ok, err = pcall(loadRemote, entry.file)
		if ok then
			status.Text = "Loaded"
			status.TextColor3 = Color3.fromRGB(120, 220, 140)
			button.Text = "Done"
		else
			status.Text = tostring(err)
			status.TextColor3 = Color3.fromRGB(240, 120, 120)
			button.Text = "Retry"
		end
	end)
end

if detected then
	local b = makeButton("LOAD " .. detected.name:upper(), 90, Color3.fromRGB(90, 60, 200))
	b.MouseButton1Click:Connect(function()
		run(detected, b)
	end)
else
	local b = makeButton("GAME NOT SUPPORTED", 90, Color3.fromRGB(70, 70, 80))
end

makeButton("PREMIUM", 138, Color3.fromRGB(200, 60, 90)).MouseButton1Click:Connect(function()
	local entry = SCRIPTS[#SCRIPTS]
	local b = makeButton("Loading...", 138, Color3.fromRGB(200, 60, 90))
	run(entry, b)
end)

-- перетаскивание окна
do
	local dragging, dragInput, dragStart, startPos
	card.Input.MouseButton1Down:Connect(function(input)
		dragging = true
		dragStart = input.Position
		startPos = card.Position
		dragInput = input
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			card.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- пересоздать GUI при респавне
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		task.wait(1)
		screen.Parent = plr:WaitForChild("PlayerGui")
	end)
end)

print("[QuantumOnyx] loader ready, game = " .. gameName() .. " (" .. GameId .. ")")

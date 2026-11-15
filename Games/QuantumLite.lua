--[[
	QuantumLite - самостоятельный Blox Fruits хаб
	---------------------------------------------
	Своя реализация: без Luarmor, без VM, без ключа и без серверного рантайма.
	Повторяет набор функций Quantum Onyx по категориям.

	Запуск (или через QuantumOnyx.lua -> "QuantumLite"):
		loadstring(game:HttpGet("https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/Games/QuantumLite.lua"))()

	Правая Shift - скрыть/показать окно.
--]]

-- ================================================================ services ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

-- =================================================================== state ===
local Flags = {}        -- фича -> вкл/выкл / значение
local Threads = {}      -- имя цикла -> поток
local Tight = {}        -- быстрые циклы (меньший шаг)
local ESPCache = {}     -- kind -> { [instance] = gui }
local ToggleSetters = {}

local Waypoint = nil
local FlyBV, FlyBG, FlyConn

local IS_BLOX_FRUITS = game.PlaceId == 2753915544
	or game.PlaceId == 4442272183
	or game.PlaceId == 7449423635
	or game.PlaceId == 994732206

local ENEMY_NAMES = {}
for _, n in ipairs({
	"Bandit", "Monkey", "Blade", "Serpent", "Gorilla", "Pirate", "Brute",
	"Mercenary", "Snow Trooper", "Winter Warrior", "Toga Warrior", "Gladiator",
	"Military Soldier", "Marine", "Sky Bandit", "Bounty Hunter", "Raider",
	"Fishman", "Cursed Skeleton", "Reborn Skeleton", "Living Zombie", "Demonic Soul",
	"Posessed Mummy", "Trainee", "Taskmaster", "Journeyman", "Master", "Boss",
}) do
	ENEMY_NAMES[n] = true
end

local FRUITS = {}
for _, n in ipairs({
	"Rocket", "Spin", "Chop", "Spring", "Bomb", "Smoke", "Spike", "Flame",
	"Falcon", "Ice", "Sand", "Dark", "Diamond", "Light", "Rubber", "Barrier",
	"Ghost", "Magma", "Door", "Quake", "Human", "Buddha", "Love", "Spider",
	"Sound", "Phoenix", "Portal", "Rumble", "Pain", "Blizzard", "Gravity",
	"Mammoth", "Dough", "Shadow", "Venom", "Control", "Spirit", "Dragon",
	"Leopard", "Kitsune", "Yeti", "Gas", "T-Rex",
}) do
	FRUITS[n] = true
end

-- ================================================================= helpers ===
local function getChar()
	local char = LocalPlayer.Character
	if char and char:FindFirstChildOfClass("Humanoid") then
		return char
	end
	return nil
end

local function getHum()
	local char = getChar()
	return char and char:FindFirstChildOfClass("Humanoid")
end

local function getHRP()
	local char = getChar()
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function dist(part)
	local hrp = getHRP()
	if not hrp or not part then
		return math.huge
	end
	return (hrp.Position - part.Position).Magnitude
end

local function isEnemy(model)
	if not model or model == getChar() then
		return false
	end
	if not model:IsA("Model") then
		return false
	end
	local hum = model:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then
		return false
	end
	if not model:FindFirstChild("HumanoidRootPart") then
		return false
	end
	if Players:GetPlayerFromCharacter(model) then
		return false
	end
	if ENEMY_NAMES[model.Name] then
		return true
	end
	local folder = workspace:FindFirstChild("Enemies")
	return folder ~= nil and model.Parent == folder
end

local function collectEnemies(range)
	local out, seen = {}, {}
	local function add(m)
		if seen[m] or not isEnemy(m) then
			return
		end
		local hrp = m:FindFirstChild("HumanoidRootPart")
		if not range or dist(hrp) <= range then
			seen[m] = true
			out[#out + 1] = m
		end
	end
	for _, m in ipairs(workspace:GetChildren()) do
		add(m)
	end
	local folder = workspace:FindFirstChild("Enemies")
	if folder then
		for _, m in ipairs(folder:GetChildren()) do
			add(m)
		end
		-- враги бывают вложены в папки островов
		for _, m in ipairs(folder:GetDescendants()) do
			if m:IsA("Model") then
				add(m)
			end
		end
	end
	return out
end

local function nearestEnemy(range)
	local best, bestD = nil, range or math.huge
	for _, m in ipairs(collectEnemies(range)) do
		local d = dist(m:FindFirstChild("HumanoidRootPart"))
		if d < bestD then
			best, bestD = m, d
		end
	end
	return best
end

local function partOf(obj)
	if not obj then
		return nil
	end
	if obj:IsA("BasePart") then
		return obj
	end
	return obj:FindFirstChildWhichIsA("BasePart")
end

local function isFruitName(name)
	return FRUITS[name] == true or tostring(name):find("Fruit") ~= nil
end

local function findFruits()
	local out = {}
	for _, v in ipairs(workspace:GetChildren()) do
		if v:IsA("Tool") and isFruitName(v.Name) then
			out[#out + 1] = v
		end
	end
	return out
end

local chestCache, chestAt = {}, 0

local function findChests(force)
	if not force and os.clock() - chestAt < 3 then
		return chestCache
	end
	local out = {}
	for _, v in ipairs(workspace:GetDescendants()) do
		if v.Name == "Chest" or v.Name:find("Chest") then
			if v:IsA("Model") or v:IsA("BasePart") then
				local p = partOf(v)
				if p then
					out[#out + 1] = p
				end
			end
		end
	end
	chestCache, chestAt = out, os.clock()
	return out
end

local function notify(text, color)
	print("[QuantumLite] " .. tostring(text))
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "QuantumLite",
			Text = tostring(text),
			Duration = 4,
		})
	end)
end

local function setStatus(text, color)
	if QuantumLite_SetStatus then
		QuantumLite_SetStatus(text, color)
	end
end

-- ================================================================ movement ===
local function tweenTo(cf, time)
	local hrp = getHRP()
	if not hrp or not cf then
		return false
	end
	local ok = pcall(function()
		local tw = TweenService:Create(hrp,
			TweenInfo.new(time or 0.2, Enum.EasingStyle.Linear), { CFrame = cf })
		tw:Play()
		tw.Completed:Wait()
	end)
	return ok
end

local function moveToPart(part, offsetY)
	local hrp = getHRP()
	if not hrp or not part then
		return false
	end
	return tweenTo(part.CFrame * CFrame.new(0, offsetY or 2, 0), 0.2)
end

local function touch(part)
	local hrp = getHRP()
	if not hrp or not part then
		return
	end
	pcall(function()
		hrp.CFrame = part.CFrame
	end)
	if firetouchinterest then
		pcall(firetouchinterest, hrp, part, 0)
		task.wait(0.05)
		pcall(firetouchinterest, hrp, part, 1)
	end
end

-- ================================================================== combat ===
local function toolKind(tool)
	local tip = tostring(tool.ToolTip or ""):lower()
	local kind = tostring(tool:GetAttribute("ToolType") or ""):lower()
	local name = tool.Name:lower()
	for _, k in ipairs({ "melee", "sword", "gun" }) do
		if tip:find(k) or kind:find(k) or name:find(k) then
			return k
		end
	end
	if name:find("fruit") then
		return "fruit"
	end
	if name == "combat" then
		return "melee"
	end
	if name == "dark blade" or name == "cutlass" or name == "katana" or name:find("sword") then
		return "sword"
	end
	return nil
end

local function equip(kind)
	kind = kind or "melee"
	local char = getChar()
	local hum = getHum()
	if not char or not hum then
		return nil
	end
	local equipped = char:FindFirstChildOfClass("Tool")
	if equipped and toolKind(equipped) == kind then
		return equipped
	end
	local backpack = LocalPlayer:FindFirstChild("Backpack")
	for _, container in ipairs({ backpack, char }) do
		if container then
			for _, tool in ipairs(container:GetChildren()) do
				if tool:IsA("Tool") and toolKind(tool) == kind then
					pcall(function()
						hum:EquipTool(tool)
					end)
					return tool
				end
			end
		end
	end
	return equipped
end

local function attack()
	local tool = getChar() and getChar():FindFirstChildOfClass("Tool")
	if tool then
		pcall(function()
			tool:Activate()
		end)
	end
	pcall(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton1(Vector2.new())
	end)
end

local function attackBurst(n, delay)
	for _ = 1, (n or 3) do
		attack()
		task.wait(delay or 0.05)
	end
end

local function remotesFolder()
	return ReplicatedStorage:FindFirstChild("Remotes")
end

local function commE(...)
	local args = table.pack(...)
	local r = remotesFolder()
	local c = r and (r:FindFirstChild("CommE") or r:FindFirstChild("CommE_"))
	if c then
		pcall(function()
			c:FireServer(table.unpack(args, 1, args.n))
		end)
	end
end

local function commF(...)
	local args = table.pack(...)
	local r = remotesFolder()
	local c = r and (r:FindFirstChild("CommF_") or r:FindFirstChild("CommF"))
	if c then
		local ok, res = pcall(function()
			return c:InvokeServer(table.unpack(args, 1, args.n))
		end)
		if ok then
			return res
		end
	end
	return nil
end

local function buso()
	commE("Buso")
end

-- активный квест: читаем заголовок из PlayerGui.Main.Quest
local function currentQuest()
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	local main = pg and pg:FindFirstChild("Main")
	local quest = main and main:FindFirstChild("Quest")
	local container = quest and quest:FindFirstChild("Container")
	local title = container and container:FindFirstChild("QuestTitle")
	local label = title and title:FindFirstChild("Title")
	if label and type(label.Text) == "string" and label.Text ~= "" then
		return label.Text
	end
	return nil
end

-- ===================================================================== ESP ====
local function syncEsp(kind, items, build)
	local cache = ESPCache[kind] or {}
	ESPCache[kind] = cache
	local present = {}
	for _, item in ipairs(items) do
		if item and item.Parent then
			present[item] = true
			if not cache[item] then
				local ok, gui = pcall(build, item)
				if ok and gui then
					cache[item] = gui
				end
			end
		end
	end
	for obj, gui in pairs(cache) do
		if not present[obj] or not obj.Parent then
			pcall(function()
				gui:Destroy()
			end)
			cache[obj] = nil
		end
	end
end

local function hlFor(model, color)
	local hl = Instance.new("Highlight")
	hl.Name = "QL_HL"
	hl.Adornee = model
	hl.FillColor = color
	hl.FillTransparency = 0.6
	hl.OutlineColor = color
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = model
	return hl
end

local function bbFor(part, text, color)
	local bb = Instance.new("BillboardGui")
	bb.Name = "QL_BB"
	bb.Adornee = part
	bb.Size = UDim2.fromOffset(170, 30)
	bb.AlwaysOnTop = true
	bb.StudsOffset = Vector3.new(0, 2.5, 0)
	bb.MaxDistance = 2000
	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(1, 1)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = color
	label.TextStrokeTransparency = 0.3
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.Parent = bb
	bb.Parent = part
	return bb
end

local function refreshEsp()
	if Flags.espPlayers then
		local list = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character then
				list[#list + 1] = plr.Character
			end
		end
		syncEsp("player", list, function(model)
			return hlFor(model, Color3.fromRGB(255, 95, 95))
		end)
	else
		syncEsp("player", {}, function() end)
	end

	if Flags.espEnemies then
		syncEsp("enemy", collectEnemies(), function(model)
			return hlFor(model, Color3.fromRGB(255, 170, 60))
		end)
	else
		syncEsp("enemy", {}, function() end)
	end

	if Flags.espChests then
		syncEsp("chest", findChests(), function(part)
			return bbFor(part, "Chest", Color3.fromRGB(255, 220, 90))
		end)
	else
		syncEsp("chest", {}, function() end)
	end

	if Flags.espFruits then
		local list = {}
		for _, f in ipairs(findFruits()) do
			local p = partOf(f)
			if p then
				list[#list + 1] = p
			end
		end
		syncEsp("fruit", list, function(part)
			local label = part.Parent and part.Parent.Name or part.Name
			return bbFor(part, label, Color3.fromRGB(120, 220, 255))
		end)
	else
		syncEsp("fruit", {}, function() end)
	end
end

-- =================================================================== loops ===
local function setLoop(name, on, interval, fn)
	if on then
		Flags[name] = true
		if not Threads[name] then
			Threads[name] = task.spawn(function()
				while Flags[name] do
					local ok, err = pcall(fn)
					if not ok then
						warn("[QuantumLite] " .. name .. ": " .. tostring(err))
					end
					task.wait(interval or 0.2)
				end
				Threads[name] = nil
			end)
		end
	else
		Flags[name] = false
		Threads[name] = nil
	end
end

local function stopAll()
	for k in pairs(Flags) do
		Flags[k] = false
	end
	for k in pairs(Threads) do
		Threads[k] = nil
	end
	for kind in pairs(ESPCache) do
		ESPCache[kind] = {}
	end
	syncEsp("player", {}, function() end)
	syncEsp("enemy", {}, function() end)
	syncEsp("chest", {}, function() end)
	syncEsp("fruit", {}, function() end)
	if FlyConn then
		pcall(function()
			FlyConn:Disconnect()
		end)
		FlyConn = nil
	end
	for _, bv in ipairs({ FlyBV, FlyBG }) do
		if bv then
			pcall(function()
				bv:Destroy()
			end)
		end
	end
	FlyBV, FlyBG = nil, nil
	pcall(function()
		VirtualUser:CaptureController()
		VirtualUser:ReleaseAllButtons()
	end)
end

-- ====================================================================== UI ===
local Theme = {
	bg = Color3.fromRGB(18, 18, 22),
	panel = Color3.fromRGB(26, 26, 32),
	row = Color3.fromRGB(36, 36, 44),
	accent = Color3.fromRGB(120, 80, 230),
	ok = Color3.fromRGB(90, 200, 150),
	text = Color3.fromRGB(240, 240, 245),
	muted = Color3.fromRGB(150, 150, 162),
	danger = Color3.fromRGB(240, 110, 110),
}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do
		o[k] = v
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local screen = new("ScreenGui", {
	Name = "QuantumLite",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	IgnoreGuiInset = true,
})

local main = new("Frame", {
	Size = UDim2.fromOffset(560, 430),
	Position = UDim2.new(0.5, -280, 0.5, -215),
	BackgroundColor3 = Theme.bg,
	BorderSizePixel = 0,
}, screen)
new("UICorner", { CornerRadius = UDim.new(0, 10) }, main)
new("UIStroke", { Color = Color3.fromRGB(60, 60, 78), Thickness = 1 }, main)

local title = new("TextButton", {
	Size = UDim2.new(1, -100, 0, 32),
	Position = UDim2.fromOffset(14, 6),
	BackgroundTransparency = 1,
	Text = "QuantumLite  •  Blox Fruits",
	TextSize = 17,
	Font = Enum.Font.GothamBold,
	TextColor3 = Theme.text,
	TextXAlignment = Enum.TextXAlignment.Left,
	AutoButtonColor = false,
}, main)

local close = new("TextButton", {
	Size = UDim2.fromOffset(28, 28),
	Position = UDim2.new(1, -40, 0, 9),
	BackgroundColor3 = Theme.row,
	Text = "×",
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	TextColor3 = Theme.text,
	AutoButtonColor = false,
}, main)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, close)

local tabBar = new("Frame", {
	Size = UDim2.new(1, -28, 0, 30),
	Position = UDim2.fromOffset(14, 44),
	BackgroundTransparency = 1,
}, main)
new("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, tabBar)

local statusBar = new("TextLabel", {
	Size = UDim2.new(1, -28, 0, 26),
	Position = UDim2.new(0, 14, 1, -34),
	BackgroundTransparency = 1,
	Text = "Готов",
	TextSize = 12,
	Font = Enum.Font.Gotham,
	TextColor3 = Theme.muted,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextTruncate = Enum.TextTruncate.AtEnd,
}, main)

function QuantumLite_SetStatus(text, color)
	statusBar.Text = tostring(text)
	statusBar.TextColor3 = color or Theme.muted
end

local pages = {}
local currentPage

local function showPage(name)
	currentPage = name
	for pageName, page in pairs(pages) do
		page.Visible = (pageName == name)
	end
	for _, btn in ipairs(tabBar:GetChildren()) do
		if btn:IsA("TextButton") then
			btn.BackgroundColor3 = (btn.Name == name) and Theme.accent or Theme.row
		end
	end
end

local function addTab(name)
	local btn = new("TextButton", {
		Name = name,
		Size = UDim2.fromOffset(80, 28),
		BackgroundColor3 = Theme.row,
		BorderSizePixel = 0,
		Text = name,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextColor3 = Theme.text,
		AutoButtonColor = false,
	}, tabBar)
	new("UICorner", { CornerRadius = UDim.new(0, 6) }, btn)

	local page = new("ScrollingFrame", {
		Name = name,
		Size = UDim2.new(1, -28, 1, -104),
		Position = UDim2.fromOffset(14, 80),
		BackgroundColor3 = Theme.panel,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Theme.accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Visible = false,
	}, main)
	new("UICorner", { CornerRadius = UDim.new(0, 8) }, page)
	new("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, page)
	new("UIPadding", {
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	}, page)

	pages[name] = page
	btn.MouseButton1Click:Connect(function()
		showPage(name)
	end)
	return page
end

local function row(page, height)
	local holder = new("Frame", {
		Size = UDim2.new(1, -8, 0, height or 34),
		BackgroundColor3 = Theme.row,
		BorderSizePixel = 0,
	}, page)
	new("UICorner", { CornerRadius = UDim.new(0, 6) }, holder)
	return holder
end

local UI = {}

function UI.toggle(page, text, default, callback)
	local h = row(page, 34)
	new("TextLabel", {
		Size = UDim2.new(1, -70, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextSize = 13,
		Font = Enum.Font.Gotham,
		TextColor3 = Theme.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, h)

	local state = default and true or false
	local knob = new("TextButton", {
		Size = UDim2.fromOffset(44, 22),
		Position = UDim2.new(1, -54, 0.5, -11),
		BackgroundColor3 = state and Theme.ok or Color3.fromRGB(60, 60, 72),
		Text = state and "ON" or "OFF",
		TextSize = 11,
		Font = Enum.Font.GothamBold,
		TextColor3 = Theme.text,
		AutoButtonColor = false,
	}, h)
	new("UICorner", { CornerRadius = UDim.new(0, 6) }, knob)

	local function paint()
		knob.BackgroundColor3 = state and Theme.ok or Color3.fromRGB(60, 60, 72)
		knob.Text = state and "ON" or "OFF"
	end
	local function set(v)
		state = v and true or false
		paint()
		local ok, err = pcall(callback, state)
		if not ok then
			setStatus(text .. ": " .. tostring(err), Theme.danger)
		end
	end
	knob.MouseButton1Click:Connect(function()
		set(not state)
	end)
	if default then
		task.defer(function()
			pcall(callback, true)
		end)
	end
	ToggleSetters[#ToggleSetters + 1] = function()
		if state then
			set(false)
		end
	end
	return set
end

function UI.button(page, text, callback, color)
	local h = row(page, 32)
	local b = new("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = color or Theme.row,
		BorderSizePixel = 0,
		Text = text,
		TextSize = 13,
		Font = Enum.Font.GothamBold,
		TextColor3 = Theme.text,
		AutoButtonColor = true,
	}, h)
	new("UICorner", { CornerRadius = UDim.new(0, 6) }, b)
	b.MouseButton1Click:Connect(function()
		local ok, err = pcall(callback)
		if not ok then
			setStatus(text .. ": " .. tostring(err), Theme.danger)
		end
	end)
	return b
end

function UI.slider(page, text, min, max, default, callback)
	local h = row(page, 46)
	local caption = new("TextLabel", {
		Size = UDim2.new(1, -20, 0, 16),
		Position = UDim2.fromOffset(10, 4),
		BackgroundTransparency = 1,
		Text = text .. ": " .. tostring(default),
		TextSize = 12,
		Font = Enum.Font.Gotham,
		TextColor3 = Theme.text,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, h)

	local bar = new("Frame", {
		Size = UDim2.new(1, -20, 0, 10),
		Position = UDim2.new(0, 10, 1, -14),
		BackgroundColor3 = Color3.fromRGB(55, 55, 68),
		BorderSizePixel = 0,
	}, h)
	new("UICorner", { CornerRadius = UDim.new(0, 5) }, bar)

	local fill = new("Frame", {
		Size = UDim2.fromScale((default - min) / (max - min), 1),
		BackgroundColor3 = Theme.accent,
		BorderSizePixel = 0,
	}, bar)
	new("UICorner", { CornerRadius = UDim.new(0, 5) }, fill)

	local dragging = false
	local function apply(x)
		local rel = math.clamp((x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
		local value = math.floor(min + (max - min) * rel + 0.5)
		fill.Size = UDim2.fromScale(rel, 1)
		caption.Text = text .. ": " .. tostring(value)
		local ok, err = pcall(callback, value)
		if not ok then
			setStatus(text .. ": " .. tostring(err), Theme.danger)
		end
	end
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			apply(input.Position.X)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			apply(input.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	pcall(callback, default)
end

function UI.textbox(page, placeholder, default, callback)
	local h = row(page, 34)
	local box = new("TextBox", {
		Size = UDim2.new(1, -124, 0, 24),
		Position = UDim2.fromOffset(10, 5),
		BackgroundColor3 = Color3.fromRGB(45, 45, 56),
		BorderSizePixel = 0,
		Text = default or "",
		PlaceholderText = placeholder,
		PlaceholderColor3 = Theme.muted,
		TextSize = 12,
		Font = Enum.Font.Gotham,
		TextColor3 = Theme.text,
		ClearTextOnFocus = false,
	}, h)
	new("UICorner", { CornerRadius = UDim.new(0, 5) }, box)

	local b = new("TextButton", {
		Size = UDim2.fromOffset(94, 24),
		Position = UDim2.new(1, -104, 0, 5),
		BackgroundColor3 = Theme.accent,
		BorderSizePixel = 0,
		Text = "Применить",
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextColor3 = Theme.text,
		AutoButtonColor = false,
	}, h)
	new("UICorner", { CornerRadius = UDim.new(0, 5) }, b)
	b.MouseButton1Click:Connect(function()
		local ok, err = pcall(callback, box.Text)
		if not ok then
			setStatus(tostring(err), Theme.danger)
		end
	end)
	return box
end

-- перетаскивание окна
do
	local dragging, dragStart, startPos
	title.MouseButton1Down:Connect(function()
		dragging = true
		dragStart = UserInputService:GetMouseLocation()
		startPos = main.Position
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = UserInputService:GetMouseLocation() - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

close.MouseButton1Click:Connect(function()
	screen.Enabled = false
end)

-- ================================================================ features ===
-- ------------------------------------------------------------------- Farm ---
local farmPage = addTab("Farm")

UI.toggle(farmPage, "Auto Farm Level (ближайший моб)", false, function(on)
	setLoop("farm", on, 0.15, function()
		local target = nearestEnemy(250)
		if not target then
			return
		end
		equip("melee")
		local hrp = target:FindFirstChild("HumanoidRootPart")
		if hrp and dist(hrp) > 6 then
			tweenTo(hrp.CFrame * CFrame.new(0, 0, 2), 0.12)
		end
		attackBurst(2, 0.05)
	end)
end)

UI.toggle(farmPage, "Auto Chest", false, function(on)
	setLoop("chest", on, 0.4, function()
		local best, bestD = nil, math.huge
		for _, p in ipairs(findChests()) do
			local d = dist(p)
			if d < bestD then
				best, bestD = p, d
			end
		end
		if best then
			moveToPart(best, 2)
			touch(best)
		end
	end)
end)

UI.toggle(farmPage, "Auto Fruit", false, function(on)
	setLoop("fruit", on, 0.4, function()
		for _, f in ipairs(findFruits()) do
			local p = partOf(f)
			if p and dist(p) < 500 then
				moveToPart(p, 2)
				touch(p)
				return
			end
		end
	end)
end)

UI.toggle(farmPage, "Auto Haki (Buso)", false, function(on)
	setLoop("buso", on, 4, buso)
end)

UI.toggle(farmPage, "Auto Quest (StartQuest)", false, function(on)
	setLoop("quest", on, 2, function()
		-- не перезапускаем квест, пока он активен: иначе сбрасывается прогресс
		if currentQuest() then
			return
		end
		local name = Flags.questName or "Bandit"
		local level = Flags.questLevel or 1
		commF("StartQuest", name, level)
	end)
end)

UI.textbox(farmPage, "Имя квеста (NPC)", "Bandit", function(text)
	Flags.questName = text
	setStatus("Квест: " .. text, Theme.ok)
end)

UI.slider(farmPage, "Уровень квеста", 1, 3000, 1, function(v)
	Flags.questLevel = v
end)

UI.button(farmPage, "Сдать квест (CompleteQuest)", function()
	local res = commF("CompleteQuest")
	setStatus("CompleteQuest: " .. tostring(res), Theme.ok)
end)

UI.button(farmPage, "Собрать ближайший сундук", function()
	local best, bestD = nil, math.huge
	for _, p in ipairs(findChests(true)) do
		local d = dist(p)
		if d < bestD then
			best, bestD = p, d
		end
	end
	if best then
		moveToPart(best, 2)
		touch(best)
		setStatus("Сундук собран", Theme.ok)
	else
		setStatus("Сундуков рядом нет", Theme.muted)
	end
end)

-- ----------------------------------------------------------------- Combat ---
local combatPage = addTab("Combat")

UI.toggle(combatPage, "Fast Attack", false, function(on)
	setLoop("fastattack", on, 0.1, function()
		equip("melee")
		attack()
	end)
end)

UI.toggle(combatPage, "Auto Equip Melee", false, function(on)
	setLoop("equipmelee", on, 1.5, function()
		equip("melee")
	end)
end)

UI.toggle(combatPage, "Auto Equip Sword", false, function(on)
	setLoop("equipsword", on, 1.5, function()
		equip("sword")
	end)
end)

UI.toggle(combatPage, "Auto Equip Gun", false, function(on)
	setLoop("equipgun", on, 1.5, function()
		equip("gun")
	end)
end)

UI.slider(combatPage, "Радиус Kill Aura", 5, 150, 30, function(v)
	Flags.auraRadius = v
end)

UI.toggle(combatPage, "Kill Aura", false, function(on)
	setLoop("aura", on, 0.15, function()
		local radius = Flags.auraRadius or 30
		if #collectEnemies(radius) == 0 then
			return
		end
		equip("melee")
		attack()
	end)
end)

UI.toggle(combatPage, "Aimbot (камера)", false, function(on)
	setLoop("aimbot", on, 0.05, function()
		local target = nearestEnemy(Flags.aimRange or 300)
		local hrp = target and target:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return
		end
		local eye = workspace.CurrentCamera.CFrame.Position
		workspace.CurrentCamera.CFrame = CFrame.lookAt(eye, hrp.Position)
	end)
end)

UI.slider(combatPage, "Радиус Aimbot", 50, 1000, 300, function(v)
	Flags.aimRange = v
end)

UI.button(combatPage, "Ударить ближайшего", function()
	local target = nearestEnemy(150)
	if not target then
		setStatus("Врагов рядом нет", Theme.muted)
		return
	end
	equip("melee")
	local hrp = target:FindFirstChild("HumanoidRootPart")
	if hrp then
		tweenTo(hrp.CFrame * CFrame.new(0, 0, 2), 0.15)
	end
	attackBurst(4, 0.06)
	setStatus("Удар: " .. target.Name, Theme.ok)
end)

-- ----------------------------------------------------------------- Visual ---
local visualPage = addTab("Visual")

UI.toggle(visualPage, "ESP Players", false, function(on)
	Flags.espPlayers = on
	refreshEsp()
end)

UI.toggle(visualPage, "ESP Enemies", true, function(on)
	Flags.espEnemies = on
	refreshEsp()
end)

UI.toggle(visualPage, "ESP Chests", false, function(on)
	Flags.espChests = on
	refreshEsp()
end)

UI.toggle(visualPage, "ESP Fruits", false, function(on)
	Flags.espFruits = on
	refreshEsp()
end)

UI.toggle(visualPage, "Fullbright", false, function(on)
	Lighting.Brightness = on and 2 or 1
	Lighting.ClockTime = on and 12 or Lighting.ClockTime
	Lighting.GlobalShadows = not on
	Lighting.EnvironmentDiffuseScale = on and 0.5 or 0
end)

UI.toggle(visualPage, "No Fog", false, function(on)
	Lighting.FogEnd = on and 1000000 or 100000
end)

UI.toggle(visualPage, "Fruit Notifier", false, function(on)
	setLoop("fruitnotify", on, 3, function()
		Flags.seenFruits = Flags.seenFruits or {}
		for _, f in ipairs(findFruits()) do
			if not Flags.seenFruits[f] then
				Flags.seenFruits[f] = true
				notify("Фрукт: " .. f.Name, Theme.accent)
			end
		end
	end)
end)

-- --------------------------------------------------------------- Teleport ---
local tpPage = addTab("Teleport")

UI.button(tpPage, "TP к ближайшему врагу", function()
	local target = nearestEnemy(3000)
	local hrp = target and target:FindFirstChild("HumanoidRootPart")
	local my = getHRP()
	if hrp and my then
		my.CFrame = hrp.CFrame * CFrame.new(0, 0, 3)
		setStatus("TP: " .. target.Name, Theme.ok)
	else
		setStatus("Врагов нет", Theme.muted)
	end
end)

UI.button(tpPage, "TP к ближайшему сундуку", function()
	local best, bestD = nil, math.huge
	for _, p in ipairs(findChests(true)) do
		local d = dist(p)
		if d < bestD then
			best, bestD = p, d
		end
	end
	local my = getHRP()
	if best and my then
		my.CFrame = best.CFrame * CFrame.new(0, 3, 0)
		setStatus("TP к сундуку", Theme.ok)
	else
		setStatus("Сундуков нет", Theme.muted)
	end
end)

UI.button(tpPage, "TP к ближайшему фрукту", function()
	local best, bestD = nil, math.huge
	for _, f in ipairs(findFruits()) do
		local p = partOf(f)
		if p then
			local d = dist(p)
			if d < bestD then
				best, bestD = p, d
			end
		end
	end
	local my = getHRP()
	if best and my then
		my.CFrame = best.CFrame * CFrame.new(0, 3, 0)
		setStatus("TP к фрукту", Theme.ok)
	else
		setStatus("Фруктов нет", Theme.muted)
	end
end)

UI.button(tpPage, "TP к курсору (луч)", function()
	local cam = workspace.CurrentCamera
	local ray = cam:ViewportPointToRay(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { getChar() }
	local hit = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
	local my = getHRP()
	if hit and my then
		my.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
		setStatus("TP к точке", Theme.ok)
	else
		setStatus("Луч не попал", Theme.muted)
	end
end)

UI.button(tpPage, "Запомнить точку", function()
	local hrp = getHRP()
	if hrp then
		Waypoint = hrp.CFrame
		setStatus("Точка сохранена", Theme.ok)
	end
end)

UI.button(tpPage, "Вернуться к точке", function()
	if Waypoint and getHRP() then
		getHRP().CFrame = Waypoint
		setStatus("Вернулся к точке", Theme.ok)
	else
		setStatus("Точка не сохранена", Theme.muted)
	end
end)

UI.button(tpPage, "Вверх на 500 (sky)", function()
	local hrp = getHRP()
	if hrp then
		hrp.CFrame = hrp.CFrame + Vector3.new(0, 500, 0)
		setStatus("Поднялся на 500", Theme.ok)
	end
end)

UI.textbox(tpPage, "x, y, z", "", function(text)
	local x, y, z = text:match("([%-%d%.]+)%s*,%s*([%-%d%.]+)%s*,%s*([%-%d%.]+)")
	local hrp = getHRP()
	if x and hrp then
		hrp.CFrame = CFrame.new(tonumber(x), tonumber(y), tonumber(z))
		setStatus("TP по координатам", Theme.ok)
	else
		setStatus("Формат: x, y, z", Theme.danger)
	end
end)

local playerList = new("Frame", {
	Size = UDim2.new(1, -8, 0, 92),
	BackgroundColor3 = Theme.panel,
	BorderSizePixel = 0,
}, tpPage)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, playerList)
new("UIListLayout", { Padding = UDim.new(0, 4) }, playerList)
new("UIPadding", {
	PaddingTop = UDim.new(0, 4),
	PaddingBottom = UDim.new(0, 4),
	PaddingLeft = UDim.new(0, 4),
	PaddingRight = UDim.new(0, 4),
}, playerList)

local function refreshPlayerList()
	for _, c in ipairs(playerList:GetChildren()) do
		if c:IsA("TextButton") then
			c:Destroy()
		end
	end
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local b = new("TextButton", {
				Size = UDim2.new(1, 0, 0, 22),
				BackgroundColor3 = Theme.row,
				BorderSizePixel = 0,
				Text = plr.Name,
				TextSize = 12,
				Font = Enum.Font.Gotham,
				TextColor3 = Theme.text,
				AutoButtonColor = true,
			}, playerList)
			new("UICorner", { CornerRadius = UDim.new(0, 4) }, b)
			b.MouseButton1Click:Connect(function()
				local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
				local my = getHRP()
				if hrp and my then
					my.CFrame = hrp.CFrame * CFrame.new(0, 0, 3)
					setStatus("TP к " .. plr.Name, Theme.ok)
				end
			end)
		end
	end
end

UI.button(tpPage, "Обновить список игроков", refreshPlayerList)

-- ----------------------------------------------------------------- Player ---
local playerPage = addTab("Player")

UI.slider(playerPage, "WalkSpeed", 16, 300, 16, function(v)
	Flags.speed = v
	local hum = getHum()
	if hum then
		hum.WalkSpeed = v
	end
end)

UI.slider(playerPage, "JumpPower", 50, 300, 50, function(v)
	Flags.jump = v
	local hum = getHum()
	if hum then
		hum.UseJumpPower = true
		hum.JumpPower = v
	end
end)

UI.toggle(playerPage, "Infinite Jump", false, function(on)
	Flags.infJump = on
	if on and not (Flags.infJumpConn) then
		Flags.infJumpConn = true
		UserInputService.JumpRequest:Connect(function()
			if Flags.infJump then
				local hum = getHum()
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	end
end)

UI.toggle(playerPage, "Noclip", false, function(on)
	setLoop("noclip", on, 0.15, function()
		local char = getChar()
		if char then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") and p.CanCollide then
					p.CanCollide = false
				end
			end
		end
	end)
	if not on then
		local char = getChar()
		if char then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
					p.CanCollide = true
				end
			end
		end
	end
end)

UI.toggle(playerPage, "Anti-AFK", false, function(on)
	if on and not Flags.antiAfkConn then
		Flags.antiAfkConn = true
		LocalPlayer.Idled:Connect(function()
			pcall(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end)
	end
end)

UI.toggle(playerPage, "Fly", false, function(on)
	local hrp = getHRP()
	if on then
		if not hrp then
			return
		end
		FlyBV = Instance.new("BodyVelocity")
		FlyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		FlyBV.Velocity = Vector3.zero
		FlyBV.Parent = hrp
		FlyBG = Instance.new("BodyGyro")
		FlyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
		FlyBG.P = 1500
		FlyBG.Parent = hrp
		FlyConn = RunService.RenderStepped:Connect(function()
			local h = getHRP()
			if not h or not FlyBV then
				return
			end
			local dir = Vector3.zero
			local cam = workspace.CurrentCamera
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				dir = dir + cam.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				dir = dir - cam.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				dir = dir - cam.CFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				dir = dir + cam.CFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				dir = dir + Vector3.new(0, 1, 0)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				dir = dir - Vector3.new(0, 1, 0)
			end
			if dir.Magnitude > 0 then
				dir = dir.Unit
			end
			FlyBV.Velocity = dir * (Flags.flySpeed or 80)
			FlyBG.CFrame = cam.CFrame
		end)
	else
		if FlyConn then
			FlyConn:Disconnect()
			FlyConn = nil
		end
		for _, bv in ipairs({ FlyBV, FlyBG }) do
			if bv then
				bv:Destroy()
			end
		end
		FlyBV, FlyBG = nil, nil
	end
end)

UI.slider(playerPage, "Fly Speed", 20, 300, 80, function(v)
	Flags.flySpeed = v
end)

UI.button(playerPage, "Респавн", function()
	local hum = getHum()
	if hum then
		hum.Health = 0
	end
end)

-- ------------------------------------------------------------------- Misc ---
local miscPage = addTab("Misc")

UI.button(miscPage, "Server Hop", function()
	setStatus("Ищу сервер...", Theme.muted)
	local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
	local ok, body = pcall(function()
		return game:HttpGet(url)
	end)
	if not ok or type(body) ~= "string" or #body == 0 then
		setStatus("Server Hop: HTTP недоступен", Theme.danger)
		return
	end
	local okDecode, data = pcall(function()
		return HttpService:JSONDecode(body)
	end)
	if not okDecode or type(data) ~= "table" then
		setStatus("Server Hop: плохой ответ", Theme.danger)
		return
	end
	for _, s in ipairs(data.data or {}) do
		if s.id ~= game.JobId and (s.playing or 0) < (s.maxPlayers or 0) then
			pcall(function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
			end)
			setStatus("Перехожу на сервер", Theme.ok)
			return
		end
	end
	setStatus("Свободных серверов нет", Theme.muted)
end)

UI.button(miscPage, "Rejoin", function()
	pcall(function()
		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end)
end)

UI.button(miscPage, "Скопировать JobId", function()
	local ok = pcall(function()
		setclipboard(tostring(game.JobId))
	end)
	setStatus(ok and "JobId скопирован" or tostring(game.JobId), ok and Theme.ok or Theme.muted)
end)

UI.toggle(miscPage, "FPS Boost", false, function(on)
	pcall(function()
		settings().Rendering.QualityLevel = on and Enum.QualityLevel.Level01 or Enum.QualityLevel.Level21
	end)
	Lighting.GlobalShadows = not on
end)

UI.button(miscPage, "СТОП (выключить всё)", function()
	for _, reset in ipairs(ToggleSetters) do
		pcall(reset)
	end
	stopAll()
	setStatus("Все функции выключены", Theme.danger)
end, Theme.danger)

-- ================================================================ runtime ===
local function attach()
	local playerGui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 10)
	if playerGui then
		screen.Parent = playerGui
	end
end
attach()

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end
	if input.KeyCode == Enum.KeyCode.RightShift then
		screen.Enabled = not screen.Enabled
	end
end)

LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	if Flags.speed then
		local hum = getHum()
		if hum then
			hum.WalkSpeed = Flags.speed
		end
	end
	if Flags.jump then
		local hum = getHum()
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower = Flags.jump
		end
	end
	if screen.Parent == nil then
		attach()
	end
end)

-- периодическое обновление ESP
task.spawn(function()
	while screen.Parent do
		pcall(refreshEsp)
		task.wait(1)
	end
end)

showPage("Farm")
setStatus("Готов  •  RightShift — скрыть окно", Theme.muted)
print("[QuantumLite] loaded, placeId=" .. tostring(game.PlaceId))

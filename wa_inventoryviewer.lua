-- Inventory Viewer for Amber UI (wa.lua)
local InventoryViewer = {
    Enabled = false,
    Target = nil,
    Connections = {},
    ItemCache = {},
    InvListRef = nil
}

local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera

-- Colores extraídos de wa.lua para consistencia
local colors = {
    background = Color3.fromRGB(12, 12, 14),
    secondary = Color3.fromRGB(18, 18, 20),
    border = Color3.fromRGB(35, 35, 40),
    accent = Color3.fromRGB(230, 40, 90),
    text = Color3.fromRGB(220, 220, 220),
    textDim = Color3.fromRGB(140, 140, 145),
}

-- ValueCache and ValueSettings from inari updrage.txt for item pricing
local ValueCache = {
    ["6B45"] = 16, ["AS Val"] = 16, ["ATC Key"] = 4, ["Airfield Key"] = 6, ["Altyn"] = 16,
    ["Altyn Visor"] = 8, ["Attak-5 60L"] = 16, ["Bolts"] = 1, ["Crane Key"] = 6, ["DAGR"] = 8,
    ["Duct Tape"] = 1, ["Fast MT"] = 10, ["Flare Gun"] = 8, ["Fueling Station Key"] = 4,
    ["Garage Key"] = 4, ["Hammer"] = 1, ["JPC"] = 10, ["Lighthouse Key"] = 6, ["M4A1"] = 12,
    ["Nails"] = 1, ["Nuts"] = 1, ["Saiga 12"] = 8, ["Super Glue"] = 1, ["Village Key"] = 4, ["Wrench"] = 1
}

local ValueSettings = {
    [0] = Color3.fromRGB(255, 255, 255),
    [4] = Color3.fromRGB(76, 187, 23),
    [8] = Color3.fromRGB(218, 112, 214),
    [16] = Color3.fromRGB(233, 116, 81),
    [32] = Color3.fromRGB(255, 36, 0)
}

-- Cache for item icons (from inari updrage.txt)
getgenv().ItemIcons = {}
getgenv().TargetHUDEnabled = false
getgenv().InventoryViewerEnabled = false

-- Función para indexar qué ítems existen en el juego según pedido
function InventoryViewer:CacheGameItems()
    local folders = {
        replicatedStorage:FindFirstChild("AmmoTypes"),
        replicatedStorage:FindFirstChild("ItemsList"),
        replicatedStorage:FindFirstChild("ItemsListModels")
    }
    local blacklist = {"MeshPart", "Part", "UnionOperation", "Weld", "WeldConstraint", "Mesh", "SpecialMesh", "HelmetMask", "Harness", "UT", "Hood", "RL", "LU", "RU", "LL", "RA", "LA", "TR", "HD", "Handle", "Casing", "ItemProperties", "Folder", "Configuration", "Model", "SelectionBox", "SurfaceAppearance", "Texture", "Decal"}

    for _, folder in ipairs(folders) do
        if folder then
            for _, item in ipairs(folder:GetChildren()) do
                if not table.find(blacklist, item.Name) then
                    self.ItemCache[item.Name] = true
                    -- Attempt to capture icons if they exist in properties
                    local props = item:FindFirstChild("ItemProperties")
                    local icon = props and props:FindFirstChild("ItemIcon")
                    if icon and (icon:IsA("ImageLabel") or icon:IsA("ImageButton")) then
                        getgenv().ItemIcons[item.Name] = icon.Image
                    end
                end
            end
        end
    end
end

function InventoryViewer:Init(invListRef)
    self:CacheGameItems()
    self.InvListRef = invListRef

    local TargetInfoGui = Create("ScreenGui", {
        Name = "Inari_TargetInfo",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = coreGui
    })
    self.Gui = TargetInfoGui

    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Parent = TargetInfoGui,
        Size = UDim2.new(0, 180, 0, 26),
        Position = UDim2.new(0.5, 300, 0.5, -110),
        BackgroundColor3 = Color3.fromRGB(12, 12, 14),
        BorderSizePixel = 0
    })
    self.MainFrame = MainFrame

    Create("UICorner", {Parent = MainFrame, CornerRadius = UDim.new(0, 6)})

    local MainShadow = Create("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 40, 1, 40),
        ZIndex = 0,
        Image = "rbxassetid://1316045217", -- Assuming this asset ID is correct for a shadow
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118)
    })

    local MainStroke = Create("UIStroke", {
        Parent = MainFrame,
        Color = colors.border,
        Thickness = 1.2
    })

    local TitleBar = Create("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 26),
        BackgroundColor3 = colors.secondary,
        BorderSizePixel = 0
    })
    
    local TitleLabel = Create("TextLabel", {
        Parent = TitleBar,
        Size = UDim2.new(1, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 12,
        Font = Enum.Font.Code,
        Text = "TARGET INFO",
        TextXAlignment = Enum.TextXAlignment.Left
    })
    self.Title = TitleLabel

    local MainLiner = Create("Frame", {
        Parent = TitleBar,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = colors.accent,
        BorderSizePixel = 0
    })

    local StatsContainer = Create("Frame", {
        Name = "Stats",
        Parent = MainFrame,
        Size = UDim2.new(1, -10, 0, 55),
        Position = UDim2.new(0, 5, 0, 30),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = StatsContainer,
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    self.HealthLabel = self:CreateStatsLabel(StatsContainer, "HP: 100/100")
    self.WeaponLabel = self:CreateStatsLabel(StatsContainer, "Tool: None")
    self.ExtraLabel = self:CreateStatsLabel(StatsContainer, "SPD: 16 | DIST: 0")

    local InvScroll = Create("ScrollingFrame", {
        Parent = MainFrame,
        Size = UDim2.new(1, -10, 0, 130),
        Position = UDim2.new(0, 5, 0, 90),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarImageColor3 = colors.accent
    })
    self.InvScroll = InvScroll

    Create("UIGridLayout", {
        Parent = InvScroll,
        CellPadding = UDim2.new(0, 4, 0, 4),
        CellSize = UDim2.new(0, 37, 0, 37)
    })

    -- Tooltip UI
    self.Tooltip = Create("TextLabel", {
        Name = "ItemTooltip",
        Parent = TargetInfoGui,
        Size = UDim2.new(0, 100, 0, 20),
        BackgroundTransparency = 0.8,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.Code,
        TextXAlignment = Enum.TextXAlignment.Center,
        Visible = false,
        ZIndex = 9999
    })
    Create("UICorner", {Parent = self.Tooltip, CornerRadius = UDim.new(0, 4)})

    -- Simple Dragging for MainFrame
    local dragging, dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    userInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
        -- Update tooltip position
        if self.Tooltip and self.Tooltip.Visible then
            self.Tooltip.Position = UDim2.new(0, input.Position.X + 10, 0, input.Position.Y + 10)
        end
    end)
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    -- Unified Target Info Logic (from provided snippet)
    local lastInvContent = ""
    task.spawn(function()
        while task.wait(0.1) do 
            local enabled = getgenv().TargetHUDEnabled or getgenv().InventoryViewerEnabled
            local targetPlayer = InventoryViewer:GetClosestPlayerToMouse() -- Renamed target to targetPlayer for clarity
            local char = targetPlayer and targetPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if enabled and char and hum then
                self:SetVisible(true)
                self.Title.Text = (targetPlayer and targetPlayer.Name or char.Name):upper()
                
                -- Update Stats
                if getgenv().TargetHUDEnabled then
                    StatsContainer.Visible = true
                    self.HealthLabel.Text = string.format("HP: %d/%d", math.round(hum.Health), math.round(hum.MaxHealth))
                    
                    local tool = char:FindFirstChildOfClass("Tool")
                    self.WeaponLabel.Text = "Tool: " .. (tool and tool.Name or "None")
                    
                    local dist = (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart")) and (localPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude or 0
                    self.ExtraLabel.Text = string.format("SPD: %.1f | DIST: %d", hum.WalkSpeed, math.round(dist))
                else
                    StatsContainer.Visible = false
                end

                -- Update Inventory
                if getgenv().InventoryViewerEnabled then
                    InvScroll.Visible = true
                    local items = InventoryViewer:ScanPlayerInventory(targetPlayer)
                    local currentContent = table.concat(items, ",")
                    
                    if currentContent ~= lastInvContent then
                        lastInvContent = currentContent
                        for _, v in pairs(InvScroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
                        for _, itemName in pairs(items) do
                            self:CreateInvItem(InvScroll, itemName, getgenv().ItemIcons[itemName])
                        end
                        
                        if self.InvListRef then -- If a Listbox from wa.lua is provided
                            local displayList = {unpack(items)}
                            table.insert(displayList, 1, "[" .. self.Title.Text .. "]")
                            self.InvListRef:Refresh(displayList)
                        end
                    end
                else
                    InvScroll.Visible = false
                end
                
                -- Adjust Frame Size based on visibility
                local targetSizeY = 26 + (StatsContainer.Visible and 65 or 0) + (InvScroll.Visible and 130 or 0)
                MainFrame.Size = UDim2.new(0, 180, 0, targetSizeY)
                InvScroll.Position = UDim2.new(0, 5, 0, StatsContainer.Visible and 90 or 30)
            else
                self:SetVisible(false)
                lastInvContent = ""
                if self.InvListRef then
                    self.InvListRef:Refresh({"No target found"})
                end
            end
        end
    end)

    return self
end

-- Helper to create UI elements (similar to wa.lua's internal Create)
function Create(class, props)
    local inst = Instance.new(class)
    for i, v in pairs(props) do inst[i] = v end
    return inst
end

function InventoryViewer:CreateStatsLabel(parent, text)
    local l = Create("TextLabel", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 12),
        BackgroundTransparency = 1,
        TextColor3 = colors.textDim,
        TextSize = 10,
        Font = Enum.Font.Code,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = text
    })
    return l
end

function InventoryViewer:CreateInvItem(parent, name, iconId)
    local f = Create("Frame", {
        Parent = parent,
        BackgroundColor3 = colors.secondary,
        BorderSizePixel = 0
    })
    Create("UICorner", {Parent = f, CornerRadius = UDim.new(0, 4)})
    local s = Create("UIStroke", {Parent = f, Color = colors.border, Thickness = 1})
    
    local img = Create("ImageLabel", {
        Parent = f,
        Size = UDim2.new(1, -6, 1, -6),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = iconId or "rbxassetid://0"
    })

    -- Tooltip for item name
    f.MouseEnter:Connect(function()
        tweenService:Create(s, TweenInfo.new(0.2), {Color = colors.accent}):Play()
        if self.Tooltip then
            self.Tooltip.Text = name:upper()
            self.Tooltip.Visible = true
        end
    end)
    f.MouseLeave:Connect(function()
        tweenService:Create(s, TweenInfo.new(0.2), {Color = colors.border}):Play()
        if self.Tooltip then
            self.Tooltip.Visible = false
        end
    end)
    
    return f
end

function InventoryViewer:GetClosestPlayerToMouse()
    local shortestDistance = math.huge
    local closestPlayer = nil
    local mousePos = userInputService:GetMouseLocation()
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local pos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if distance < shortestDistance and distance < 150 then -- Radius of 150px
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    return closestPlayer
end

function InventoryViewer:ScanPlayerInventory(player)
    local foundItems = {}
    local blacklist = {"MeshPart", "Part", "UnionOperation", "Weld", "WeldConstraint", "Mesh", "SpecialMesh", "HelmetMask", "Harness", "UT", "Hood", "RL", "LU", "RU", "LL", "RA", "LA", "TR", "HD", "Handle", "Casing", "ItemProperties", "Folder", "Configuration", "SelectionBox", "SurfaceAppearance", "Texture", "Decal"}
    local function scan(root)
        if not root then return end
        for _, v in pairs(root:GetDescendants()) do
            if table.find(blacklist, v.Name) or table.find(blacklist, v.ClassName) then continue end
            local itemName = nil
            local props = v:FindFirstChild("ItemProperties")
            if props then
                itemName = props:GetAttribute("CallSign")
            end
            if not itemName then
                itemName = v:GetAttribute("CallSign")
            end
            if not itemName and self.ItemCache[v.Name] then
                itemName = v.Name
            end
            if itemName and self.ItemCache[itemName] and not table.find(foundItems, itemName) then
                table.insert(foundItems, itemName)
            end
        end
    end
    if player:IsA("Player") then
        scan(player.Character)
        local bp = player:FindFirstChild("Backpack")
        if bp then scan(bp) end
        local playerFolder = replicatedStorage:FindFirstChild(player.Name)
        local RSInv = playerFolder and playerFolder:FindFirstChild("Inventory")
        if RSInv then
            scan(RSInv)
        end
    elseif player:IsA("Model") then 
        scan(player)
    end
    return foundItems
end

function InventoryViewer:SetVisible(state)
    self.Enabled = state
    if self.Gui then
        self.Gui.Enabled = state
    end
end

function InventoryViewer:Update(targetPlayer, itemsTable)
    -- This function is now mostly handled by the task.spawn loop directly
    -- but we keep it for consistency if needed for external calls.
    -- The task.spawn loop directly updates the UI elements.
    -- This function will primarily be used for the standalone test.
    self.Target = targetPlayer
    if self.Title then
        self.Title.Text = "INV: " .. (targetPlayer and targetPlayer.Name:upper() or "NONE")
    end
    
    if self.InvScroll then
        for _, v in ipairs(self.InvScroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
        for _, itemName in ipairs(itemsTable or {}) do
            self:CreateInvItem(self.InvScroll, itemName, getgenv().ItemIcons[itemName])
        end
    end
end

-- Standalone Test Logic (Para probar sin la UI Library)
task.spawn(function()
    while task.wait(1) do
        if _G.TestWAInventory then -- Define esto como true en tu ejecutor para testear
            if not InventoryViewer.Gui then 
                InventoryViewer:Init()
                InventoryViewer:SetVisible(true)
            end
            -- Simulation of items
            InventoryViewer:Update(localPlayer, {"M4A1", "Medkit", "Ammo", "Keycard"})
            break
        end
    end
end)

return InventoryViewer
    self:CacheGameItems()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "InventoryViewer_WA"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = coreGui
    self.Gui = ScreenGui

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 200, 0, 250)
    Main.Position = UDim2.new(0.5, 300, 0.5, -125) -- Posicionado a la derecha del menu principal
    Main.BackgroundColor3 = colors.background
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Visible = false
    Main.Parent = ScreenGui
    self.MainFrame = Main

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = Main

    local OuterBorder = Instance.new("UIStroke")
    OuterBorder.Thickness = 1.2
    OuterBorder.Color = colors.border
    OuterBorder.Parent = Main

    -- Header (Draggable)
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BackgroundColor3 = colors.secondary
    Header.BorderSizePixel = 0
    Header.Parent = Main
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 6)
    HeaderCorner.Parent = Header

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = "INVENTORY VIEWER"
    TitleLabel.Size = UDim2.new(1, -10, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.Code
    TitleLabel.TextSize = 13
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = Header
    self.Title = TitleLabel

    local AccentLine = Instance.new("Frame")
    AccentLine.Size = UDim2.new(1, 0, 0, 1)
    AccentLine.Position = UDim2.new(0, 0, 1, 0)
    AccentLine.BackgroundColor3 = colors.accent
    AccentLine.BorderSizePixel = 0
    AccentLine.Parent = Header

    -- Content Area
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Items"
    Container.Size = UDim2.new(1, -10, 1, -40)
    Container.Position = UDim2.new(0, 5, 0, 35)
    Container.BackgroundTransparency = 1
    Container.BorderSizePixel = 0
    Container.ScrollBarThickness = 2
    Container.ScrollBarImageColor3 = colors.accent
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Container.Parent = Main
    self.Container = Container

    local Layout = Instance.new("UIGridLayout")
    Layout.CellSize = UDim2.new(0, 42, 0, 42)
    Layout.CellPadding = UDim2.new(0, 5, 0, 5)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Container

    -- Draggable Logic
    local dragging, dragInput, dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)
    userInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    -- Auto-Update Loop: Reacciona según a quién ves
    task.spawn(function()
        while task.wait(0.3) do
            if self.Enabled then
                local target = self:GetClosestPlayerToMouse()
                if target then
                    local items = self:ScanPlayerInventory(target)
                    self:Update(target, items)
                else
                    self:Update(nil, {})
                end
            end
        end
    end)

    return self
end

function InventoryViewer:GetClosestPlayerToMouse()
    local shortestDistance = math.huge
    local closestPlayer = nil
    local mousePos = userInputService:GetMouseLocation()

    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local pos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if distance < shortestDistance and distance < 150 then -- Radio de 150px
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    return closestPlayer
end

function InventoryViewer:ScanPlayerInventory(player)
    local foundItems = {}
    -- Buscar en ReplicatedStorage > NombreJugador > Inventory
    local playerFolder = replicatedStorage:FindFirstChild(player.Name)
    local invFolder = playerFolder and playerFolder:FindFirstChild("Inventory")

    if invFolder then
        for _, item in ipairs(invFolder:GetChildren()) do
            -- Verificamos contra nuestro caché si es un item válido del juego
            if self.ItemCache[item.Name] then
                table.insert(foundItems, item.Name)
            end
        end
    end
    return foundItems
end

function InventoryViewer:SetVisible(state)
    self.Enabled = state
    if self.MainFrame then
        self.MainFrame.Visible = state
        self.Gui.Enabled = state
    end
end

function InventoryViewer:Update(targetPlayer, itemsTable)
    self.Target = targetPlayer
    self.Title.Text = "INV: " .. (targetPlayer and targetPlayer.Name:upper() or "NONE")
    
    -- Limpiar items anteriores
    for _, v in ipairs(self.Container:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end

    -- Crear nuevos cuadros de items
    for _, itemName in ipairs(itemsTable or {}) do
        local ItemFrame = Instance.new("Frame")
        ItemFrame.BackgroundColor3 = colors.secondary
        ItemFrame.BorderSizePixel = 0
        ItemFrame.Parent = self.Container
        Instance.new("UICorner", ItemFrame).CornerRadius = UDim.new(0, 4)
        local s = Instance.new("UIStroke", ItemFrame)
        s.Color = colors.border
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -4, 1, -4)
        Label.Position = UDim2.new(0, 2, 0, 2)
        Label.BackgroundTransparency = 1
        Label.Text = itemName:sub(1, 3):upper() -- Placeholder si no hay iconos
        Label.TextColor3 = colors.textDim
        Label.TextScaled = true
        Label.Font = Enum.Font.Code
        Label.Parent = ItemFrame
        ItemFrame.Name = itemName -- Para debug
    end
end

-- Standalone Test Logic (Para probar sin la UI Library)
task.spawn(function()
    while task.wait(1) do
        if _G.TestWAInventory then -- Define esto como true en tu ejecutor para testear
            if not InventoryViewer.Gui then 
                InventoryViewer:Init()
                InventoryViewer:SetVisible(true)
            end
            -- Simulacion de items
            InventoryViewer:Update(localPlayer, {"M4A1", "Medkit", "Ammo", "Keycard"})
            break
        end
    end
end)

return InventoryViewer

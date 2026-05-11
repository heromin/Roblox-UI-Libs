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
-- Helper para crear instancias
local function Create(class, props)
    local inst = Instance.new(class)
    for i, v in pairs(props) do inst[i] = v end
    return inst
end

-- Cache for item icons (from inari updrage.txt)
getgenv().ItemIcons = {}

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

function InventoryViewer:CreateStatsLabel(parent, text)
    return Create("TextLabel", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 12),
        BackgroundTransparency = 1,
        TextColor3 = colors.textDim,
        TextSize = 10,
        Font = Enum.Font.Code,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = text
    })
end

function InventoryViewer:CreateInvItem(parent, name, iconId)
    local f = Create("Frame", {
        Parent = parent,
        BackgroundColor3 = colors.secondary,
        BorderSizePixel = 0
    })
    Create("UICorner", {Parent = f, CornerRadius = UDim.new(0, 4)})
    local s = Create("UIStroke", {Parent = f, Color = colors.border, Thickness = 1})
    
    Create("ImageLabel", {
        Parent = f,
        Size = UDim2.new(1, -6, 1, -6),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = iconId or "rbxassetid://0"
    })

    f.MouseEnter:Connect(function()
        tweenService:Create(s, TweenInfo.new(0.2), {Color = colors.accent}):Play()
        if self.Tooltip then
            self.Tooltip.Text = name:upper()
            self.Tooltip.Visible = true
        end
    end)
    f.MouseLeave:Connect(function()
        tweenService:Create(s, TweenInfo.new(0.2), {Color = colors.border}):Play()
        if self.Tooltip then self.Tooltip.Visible = false end
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
                    if distance < shortestDistance and distance < 150 then
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
            local itemName = (v:FindFirstChild("ItemProperties") and v.ItemProperties:GetAttribute("CallSign")) or v:GetAttribute("CallSign") or (self.ItemCache[v.Name] and v.Name)
            if itemName and self.ItemCache[itemName] and not table.find(foundItems, itemName) then
                table.insert(foundItems, itemName)
            end
        end
    end
    if player:IsA("Player") then
        scan(player.Character); local bp = player:FindFirstChild("Backpack"); if bp then scan(bp) end
        local playerFolder = replicatedStorage:FindFirstChild(player.Name)
        local RSInv = playerFolder and playerFolder:FindFirstChild("Inventory")
        if RSInv then scan(RSInv) end
    elseif player:IsA("Model") then scan(player) end
    return foundItems
end

function InventoryViewer:SetVisible(state)
    self.Enabled = state
    if self.Gui then self.Gui.Enabled = state end
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

    Create("UIStroke", {Parent = MainFrame, Color = colors.border, Thickness = 1.2})

    local TitleBar = Create("Frame", {Name = "TitleBar", Parent = MainFrame, Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = colors.secondary, BorderSizePixel = 0})
    local TitleLabel = Create("TextLabel", {Parent = TitleBar, Size = UDim2.new(1, -10, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), TextSize = 12, Font = Enum.Font.Code, Text = "TARGET INFO", TextXAlignment = Enum.TextXAlignment.Left})
    self.Title = TitleLabel
    Create("Frame", {Parent = TitleBar, Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, 0), BackgroundColor3 = colors.accent, BorderSizePixel = 0})

    local StatsContainer = Create("Frame", {Name = "Stats", Parent = MainFrame, Size = UDim2.new(1, -10, 0, 55), Position = UDim2.new(0, 5, 0, 30), BackgroundTransparency = 1})
    Create("UIListLayout", {Parent = StatsContainer, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder})

    self.HealthLabel = self:CreateStatsLabel(StatsContainer, "HP: 100/100")
    self.WeaponLabel = self:CreateStatsLabel(StatsContainer, "Tool: None")
    self.ExtraLabel = self:CreateStatsLabel(StatsContainer, "SPD: 16 | DIST: 0")

    local InvScroll = Create("ScrollingFrame", {Parent = MainFrame, Size = UDim2.new(1, -10, 0, 130), Position = UDim2.new(0, 5, 0, 90), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarImageColor3 = colors.accent})
    self.InvScroll = InvScroll
    Create("UIGridLayout", {Parent = InvScroll, CellPadding = UDim2.new(0, 4, 0, 4), CellSize = UDim2.new(0, 37, 0, 37)})

    self.Tooltip = Create("TextLabel", {Name = "ItemTooltip", Parent = TargetInfoGui, Size = UDim2.new(0, 100, 0, 20), BackgroundTransparency = 0.8, BackgroundColor3 = Color3.fromRGB(30, 30, 30), TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Font = Enum.Font.Code, TextXAlignment = Enum.TextXAlignment.Center, Visible = false, ZIndex = 9999})
    Create("UICorner", {Parent = self.Tooltip, CornerRadius = UDim.new(0, 4)})

    local dragging, dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = MainFrame.Position end end)
    userInputService.InputChanged:Connect(function(input) 
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        if self.Tooltip and self.Tooltip.Visible then self.Tooltip.Position = UDim2.new(0, userInputService:GetMouseLocation().X + 10, 0, userInputService:GetMouseLocation().Y + 10) end
    end)
    userInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

    local lastInvContent = ""
    task.spawn(function()
        while task.wait(0.1) do 
            local enabled = getgenv().TargetHUDEnabled or getgenv().InventoryViewerEnabled
            local targetPlayer = self:GetClosestPlayerToMouse()
            local char = targetPlayer and targetPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if enabled and char and hum then
                self.MainFrame.Visible = true
                self.Title.Text = targetPlayer.Name:upper()
                if getgenv().TargetHUDEnabled then
                    StatsContainer.Visible = true
                    self.HealthLabel.Text = string.format("HP: %d/%d", math.round(hum.Health), math.round(hum.MaxHealth))
                    local tool = char:FindFirstChildOfClass("Tool"); self.WeaponLabel.Text = "Tool: " .. (tool and tool.Name or "None")
                    local dist = (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart")) and (localPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude or 0
                    self.ExtraLabel.Text = string.format("SPD: %.1f | DIST: %d", hum.WalkSpeed, math.round(dist))
                else StatsContainer.Visible = false end

                if getgenv().InventoryViewerEnabled then
                    InvScroll.Visible = true
                    local items = self:ScanPlayerInventory(targetPlayer)
                    local currentContent = table.concat(items, ",")
                    if currentContent ~= lastInvContent then
                        lastInvContent = currentContent
                        for _, v in pairs(InvScroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
                        for _, itemName in pairs(items) do self:CreateInvItem(InvScroll, itemName, getgenv().ItemIcons[itemName]) end
                        if self.InvListRef then local dL = {unpack(items)}; table.insert(dL, 1, "[" .. self.Title.Text .. "]"); self.InvListRef:Refresh(dL) end
                    end
                else InvScroll.Visible = false end
                MainFrame.Size = UDim2.new(0, 180, 0, 26 + (StatsContainer.Visible and 65 or 0) + (InvScroll.Visible and 130 or 0))
                InvScroll.Position = UDim2.new(0, 5, 0, StatsContainer.Visible and 90 or 30)
            else
                self.MainFrame.Visible = false; lastInvContent = ""
                if self.InvListRef then self.InvListRef:Refresh({"No target found"}) end
            end
        end
    end)
    return self
end

return InventoryViewer

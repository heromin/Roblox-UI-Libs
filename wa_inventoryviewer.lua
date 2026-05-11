-- Inventory Viewer for Amber UI (wa.lua)
local InventoryViewer = {
    Enabled = false,
    Target = nil,
    Connections = {}
}

local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

-- Colores extraídos de wa.lua para consistencia
local colors = {
    background = Color3.fromRGB(12, 12, 14),
    secondary = Color3.fromRGB(18, 18, 20),
    border = Color3.fromRGB(35, 35, 40),
    accent = Color3.fromRGB(230, 40, 90),
    text = Color3.fromRGB(220, 220, 220),
    textDim = Color3.fromRGB(140, 140, 145),
}

function InventoryViewer:Init()
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

    return self
end

function InventoryViewer:SetVisible(state)
    self.Enabled = state
    if self.MainFrame then
        self.MainFrame.Visible = state
    end
end

function InventoryViewer:Update(targetPlayer, itemsTable)
    if not self.Enabled then return end
    self.Target = targetPlayer
    self.Title.Text = "INV: " .. (targetPlayer and targetPlayer.Name:upper() or "NONE")
    
    -- Limpiar items anteriores
    for _, v in pairs(self.Container:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end

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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

-- =========================================================
-- CONFIGURACIÓN DE COLORES (FATALITY V3 EXACTO)
-- =========================================================
local Theme = {
    Background = Color3.fromRGB(13, 11, 28), -- Azul muy oscuro
    Panel = Color3.fromRGB(18, 16, 36),     -- Paneles elevados
    Accent = Color3.fromRGB(255, 30, 90),   -- Rosa/Rojo Fatality
    Text = Color3.fromRGB(230, 230, 235),
    Disabled = Color3.fromRGB(120, 120, 130),
    Border = Color3.fromRGB(40, 40, 50),     -- Bordes internos
    OuterBorder = {                          -- Degradado del borde exterior
        Start = Color3.fromRGB(255, 40, 80),
        End = Color3.fromRGB(40, 0, 60)
    }
}

local Settings = {
    Combat = {
        Enabled = false,
        FOV = 100,
        Smoothing = 5
    },
    Visuals = {
        EspEnabled = false,
        BoxColor = Color3.fromRGB(255, 30, 90)
    },
    UI_Key = Enum.KeyCode.RightShift,
    UI = {
        Background = Color3.fromRGB(13, 11, 28),
        Panel = Color3.fromRGB(18, 16, 36),
        Accent = Color3.fromRGB(255, 30, 90),
        BorderStart = Color3.fromRGB(255, 30, 90),
        BorderEnd = Color3.fromRGB(40, 0, 60)
    }
}
local StartTime = tick()
local GlobalConnections = {}

-- Función para copia profunda (Deep Copy) para el Reset
local function DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

local DefaultSettings = DeepCopy(Settings)

-- =========================================================
-- SISTEMA DE PERSISTENCIA (Sincronizado)
-- =========================================================
local function SanitizeConfig(tbl, encode)
    local new = {}
    for k, v in pairs(tbl) do
        if typeof(v) == "Color3" and encode then
            new[k] = {r = v.R, g = v.G, b = v.B}
        elseif typeof(v) == "EnumItem" and encode then
            new[k] = {__type = "EnumItem", value = tostring(v)}
        elseif typeof(v) == "table" and v.__type == "EnumItem" and not encode then
            local split = v.value:split(".")
            new[k] = Enum[split[2]][split[3]]
        elseif typeof(v) == "table" and v.r and v.g and v.b and not encode then
            new[k] = Color3.new(v.r, v.g, v.b)
        elseif typeof(v) == "table" then
            new[k] = SanitizeConfig(v, encode)
        else
            new[k] = v
        end
    end
    return new
end

local SliderObjects = {}
local ToggleObjects = {}

-- Función para refrescar visualmente toda la UI tras cargar o resetear
local function RefreshUI()
    local function Sync(st, prefix)
        for k, v in pairs(st) do
            if ToggleObjects[k] then
                ToggleObjects[k].UpdateVisual(v)
            end
            if SliderObjects[k] then
                -- Soporte para sliders que escalan el valor guardado
                SliderObjects[k].UpdateVisual(v)
            end
            if type(v) == "table" then
                Sync(v, k)
            end
        end
    end
    Sync(Settings, "")
end

local function Save() 
    if writefile then 
        local success, encoded = pcall(function()
            return HttpService:JSONEncode(SanitizeConfig(Settings, true))
        end)
        if success then writefile("fatality_v3.json", encoded) end
    end 
end

local function Load() 
    if isfile and isfile("fatality_v3.json") then 
        local ok, data = pcall(function()
            return HttpService:JSONDecode(readfile("fatality_v3.json"))
        end)
        if ok and data then
            local decoded = SanitizeConfig(data, false)
            for k,v in pairs(decoded) do 
                if typeof(v) == "table" and Settings[k] then
                    for k2, v2 in pairs(v) do Settings[k][k2] = v2 end
                else
                    Settings[k] = v 
                end
            end
            RefreshUI()
            return true
        end
    end 
    return false
end

local function ResetToFactory()
    Settings = DeepCopy(DefaultSettings)
    RefreshUI()
    Notify("Settings reset to factory defaults", "success")
end

Load()

-- =========================================================
-- UI FRAMEWORK
-- =========================================================
local function MakeDraggable(obj, dragPart)
    local dragging, dragInput, dragStart, startPos
    table.insert(GlobalConnections, dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = obj.Position
        end
    end))
    table.insert(GlobalConnections, UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end))
    table.insert(GlobalConnections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end))
end

local function BuildFatalityUI()
    local notifyContainer
    local sg = Instance.new("ScreenGui")
    -- gethui protects the UI from weak detections if the executor supports it
    sg.Parent = (gethui and gethui()) or CoreGui
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
    sg.IgnoreGuiInset = true
    sg.ResetOnSpawn = false
    
    -- Main Window
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 710, 0, 480)
    main.Position = UDim2.new(0.5, -355, 0.5, -240)
    main.BackgroundColor3 = Settings.UI.Background
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 4)

    -- Borde Exterior Degradado (Fatality Signature)
    local outerStroke = Instance.new("UIStroke", main)
    outerStroke.Thickness = 2
    outerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    outerStroke.Color = Color3.new(1,1,1)
    local outerGrad = Instance.new("UIGradient", outerStroke)
    outerGrad.Color = ColorSequence.new(Settings.UI.BorderStart, Settings.UI.BorderEnd)
    outerGrad.Rotation = 90

    -- Borde Interior Negro
    local innerBorder = Instance.new("Frame", main)
    innerBorder.Size = UDim2.new(1, -6, 1, -6)
    innerBorder.Position = UDim2.new(0, 3, 0, 3)
    innerBorder.BackgroundColor3 = Settings.UI.Background
    innerBorder.BorderSizePixel = 0
    Instance.new("UIStroke", innerBorder).Color = Color3.new(0,0,0)

    -- =========================================================
    -- SIDE SELECTOR PANEL (Dropdowns & Color Pickers)
    -- =========================================================
    local sidePanel = Instance.new("Frame", main)
    sidePanel.Size = UDim2.new(0, 200, 1, 0)
    sidePanel.Position = UDim2.new(1, 10, 0, 0)
    sidePanel.BackgroundColor3 = Settings.UI.Background
    sidePanel.Visible = false
    Instance.new("UICorner", sidePanel).CornerRadius = UDim.new(0, 4)

    local sOuterStroke = Instance.new("UIStroke", sidePanel)
    sOuterStroke.Thickness = 2
    sOuterStroke.Color = Color3.new(1,1,1)
    local sOuterGrad = Instance.new("UIGradient", sOuterStroke)
    sOuterGrad.Color = ColorSequence.new(Settings.UI.BorderStart, Settings.UI.BorderEnd)
    sOuterGrad.Rotation = 90

    local sInner = Instance.new("Frame", sidePanel)
    sInner.Size = UDim2.new(1, -6, 1, -6)
    sInner.Position = UDim2.new(0, 3, 0, 3)
    sInner.BackgroundColor3 = Settings.UI.Panel
    sInner.BorderSizePixel = 0
    Instance.new("UIStroke", sInner).Color = Color3.new(0,0,0)
    Instance.new("UICorner", sInner).CornerRadius = UDim.new(0, 2)

    local sTitle = Instance.new("TextLabel", sInner)
    sTitle.Size = UDim2.new(1, 0, 0, 30)
    sTitle.BackgroundTransparency = 1
    sTitle.TextColor3 = Theme.Accent
    sTitle.Font = Enum.Font.GothamBold
    sTitle.TextSize = 12
    sTitle.Text = "SELECTOR"

    local sContent = Instance.new("ScrollingFrame", sInner)
    sContent.Size = UDim2.new(1, -10, 1, -40)
    sContent.Position = UDim2.new(0, 5, 0, 35)
    sContent.BackgroundTransparency = 1
    sContent.ScrollBarThickness = 2
    sContent.ScrollBarImageColor3 = Theme.Accent
    sContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    sContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local sLayout = Instance.new("UIListLayout", sContent)
    sLayout.Padding = UDim.new(0, 5)
    sLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function OpenSidePanel(title, setup_cb)
        if sidePanel.Visible and sTitle.Text == title:upper() then
            sidePanel.Visible = false
            return
        end
        for _, v in pairs(sContent:GetChildren()) do if not v:IsA("UIListLayout") then v:Destroy() end end
        sTitle.Text = title:upper()
        setup_cb(sContent)
        sidePanel.Visible = true
    end

    -- =========================================================
    -- FUNCIÓN DE LIMPIEZA COMPLETA (UNLOAD)
    -- =========================================================
    local function Unload()
        Save() -- Auto-guarda la configuracion antes de cerrar
        for _, conn in pairs(GlobalConnections) do
            if conn then conn:Disconnect() end
        end
        if notifyContainer and notifyContainer.Parent then notifyContainer:Destroy() end
        if sg and sg.Parent then sg:Destroy() end
        -- Asegurar que las variables lógicas se detengan
        Settings.Combat.Enabled = false
        Settings.Visuals.EspEnabled = false
        
        -- Limpiar referencias de variables y UI
        SliderObjects = {}
        ToggleObjects = {}
        GlobalConnections = {}
    end

    -- =========================================================
    -- NOTIFICATION SYSTEM (FATALITY STYLE)
    -- =========================================================
    notifyContainer = Instance.new("Frame", sg)
    notifyContainer.Size = UDim2.new(0, 200, 1, -20)
    notifyContainer.Position = UDim2.new(1, -210, 0, 10)
    notifyContainer.BackgroundTransparency = 1
    local notifyList = Instance.new("UIListLayout", notifyContainer)
    notifyList.VerticalAlignment = Enum.VerticalAlignment.Top
    notifyList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    notifyList.Padding = UDim.new(0, 5)

    local NotifyIcons = {
        success = "rbxassetid://3944582848", -- Checkmark
        error = "rbxassetid://3944584456",   -- X mark
        warning = "rbxassetid://3944581539", -- Exclamation mark
        info = "rbxassetid://3944592000"     -- Info icon
    }

    local NotifyColors = {
        success = Color3.fromRGB(0, 255, 120),
        error = Color3.fromRGB(255, 50, 50),
        warning = Color3.fromRGB(255, 150, 0),
        info = Color3.fromRGB(0, 150, 255)
    }

    Notify = function(text, typeOrColor)
        local iconId = NotifyIcons[typeOrColor]
        local accentColor = NotifyColors[typeOrColor] or (typeof(typeOrColor) == "Color3" and typeOrColor) or Theme.Accent

        local n = Instance.new("Frame", notifyContainer)
        n.Size = UDim2.new(1, 0, 0, 25); n.BackgroundColor3 = Theme.Background; n.ClipsDescendants = true
        Instance.new("UICorner", n).CornerRadius = UDim.new(0, 4)
        local accent = Instance.new("Frame", n); accent.Size = UDim2.new(0, 2, 1, 0); accent.BackgroundColor3 = accentColor; accent.BorderSizePixel = 0
        local l = Instance.new("TextLabel", n); l.Size = UDim2.new(1, -10, 1, 0); l.Position = UDim2.new(0, 8, 0, 0)
        l.BackgroundTransparency = 1; l.Text = text; l.TextColor3 = Theme.Text; l.Font = Enum.Font.GothamMedium; l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left
        
        if iconId then
            local icon = Instance.new("ImageLabel", n)
            icon.Size = UDim2.new(0, 14, 0, 14)
            icon.Position = UDim2.new(0, 8, 0.5, -7)
            icon.BackgroundTransparency = 1
            icon.Image = iconId
            icon.ImageColor3 = accentColor
            l.Position = UDim2.new(0, 28, 0, 0) -- Ajustar posición del texto si hay icono
            l.Size = UDim2.new(1, -33, 1, 0)    -- Ajustar tamaño del texto si hay icono
        end

        n.Position = UDim2.new(1, 10, 0, 0)
        TweenService:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(2.5, function()
            local t = TweenService:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 0, 0)})
            t:Play(); t.Completed:Connect(function() n:Destroy() end)
        end)
    end

    -- Top Bar (Drag Area)
    local top = Instance.new("Frame", innerBorder)
    top.Size = UDim2.new(1, 0, 0, 40)
    top.BackgroundTransparency = 1
    MakeDraggable(main, top)

    -- Title
    local title = Instance.new("TextLabel", top)
    title.Size = UDim2.new(0, 100, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.Text = "HYVERION"
    title.TextColor3 = Theme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1

    -- Close Button
    local close = Instance.new("TextButton", top)
    close.Name = "CloseButton"
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -35, 0, 5)
    close.BackgroundTransparency = 1
    close.Text = "×"
    close.TextColor3 = Theme.Disabled
    close.Font = Enum.Font.GothamBold
    close.TextSize = 20
    
    close.MouseEnter:Connect(function() close.TextColor3 = Theme.Accent end)
    close.MouseLeave:Connect(function() close.TextColor3 = Theme.Disabled end)
    close.MouseButton1Click:Connect(Unload)

    -- Global Menu Toggle Listener (Default Key: P)
    table.insert(GlobalConnections, UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Settings.UI_Key then
            main.Visible = not main.Visible
        end
    end))

    -- Main Tabs
    local tabsFrame = Instance.new("Frame", top)
    tabsFrame.Size = UDim2.new(1, -120, 1, 0)
    tabsFrame.Position = UDim2.new(0, 110, 0, 0)
    tabsFrame.BackgroundTransparency = 1
    local tabsList = Instance.new("UIListLayout", tabsFrame)
    tabsList.FillDirection = Enum.FillDirection.Horizontal
    tabsList.Padding = UDim.new(0, 10)

    local container = Instance.new("Frame", innerBorder)
    container.Size = UDim2.new(1, -20, 1, -50)
    container.Position = UDim2.new(0, 10, 0, 45)
    container.BackgroundTransparency = 1

    local firstTab = true

    local function AddMainTab(name)
        local firstSub = true
        local btn = Instance.new("TextButton", tabsFrame)
        btn.AutomaticSize = Enum.AutomaticSize.X
        btn.Size = UDim2.new(0, 40, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = name:upper()
        btn.TextColor3 = Theme.Disabled
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 12

        local page = Instance.new("Frame", container)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false

        -- Sub-Tabs Bar (Lower Level)
        local subTop = Instance.new("Frame", page)
        subTop.Size = UDim2.new(1, 0, 0, 40)
        subTop.BackgroundTransparency = 1
        local subTabsList = Instance.new("UIListLayout", subTop)
        subTabsList.FillDirection = Enum.FillDirection.Horizontal
        subTabsList.Padding = UDim.new(0, 5)

        -- Content Frame
        local contentFrame = Instance.new("Frame", page)
        contentFrame.Size = UDim2.new(1, 0, 1, -45)
        contentFrame.Position = UDim2.new(0, 0, 0, 45)
        contentFrame.BackgroundTransparency = 1

        btn.MouseButton1Click:Connect(function()
            for _, p in pairs(container:GetChildren()) do if p:IsA("Frame") then p.Visible = false end end
            for _, b in pairs(tabsFrame:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Theme.Disabled end end
            page.Visible = true
            btn.TextColor3 = Theme.Accent
            for _, sp in pairs(contentFrame:GetChildren()) do if sp:IsA("ScrollingFrame") then sp.Visible = false end end
            if contentFrame:FindFirstChildOfClass("ScrollingFrame") then contentFrame:FindFirstChildOfClass("ScrollingFrame").Visible = true end
        end)

        if firstTab then page.Visible = true; btn.TextColor3 = Theme.Accent; firstTab = false end

        return {
            AddSubTab = function(subName, iconId)
                local subBtn = Instance.new("TextButton", subTop)
                subBtn.Size = UDim2.new(0, 80, 0, 30)
                subBtn.BackgroundTransparency = 1
                subBtn.Text = subName:upper()
                subBtn.TextColor3 = Theme.Disabled
                subBtn.Font = Enum.Font.Gotham
                subBtn.TextSize = 10

                local icon = Instance.new("ImageLabel", subBtn)
                icon.Size = UDim2.new(0, 30, 0, 15) -- Ajuste de icono
                icon.Position = UDim2.new(0.5, -15, 0, -18)
                icon.BackgroundTransparency = 1
                icon.Image = iconId
                icon.ImageColor3 = Theme.Disabled

                local subPage = Instance.new("ScrollingFrame", contentFrame)
                subPage.Size = UDim2.new(1, 0, 1, 0)
                subPage.BackgroundTransparency = 1
                subPage.Visible = false
                subPage.ScrollBarThickness = 2
                subPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
                subPage.CanvasSize = UDim2.new(0, 0, 0, 0)
                
                local subLayout = Instance.new("UIListLayout", subPage)
                subLayout.FillDirection = Enum.FillDirection.Horizontal
                subLayout.Wraps = true
                subLayout.Padding = UDim.new(0, 8)

                subBtn.MouseButton1Click:Connect(function()
                    for _, sp in pairs(contentFrame:GetChildren()) do if sp:IsA("ScrollingFrame") then sp.Visible = false end end
                    for _, sb in pairs(subTop:GetChildren()) do 
                        if sb:IsA("TextButton") then 
                            sb.TextColor3 = Theme.Disabled
                            local ic = sb:FindFirstChildOfClass("ImageLabel")
                            if ic then ic.ImageColor3 = Theme.Disabled end
                        end 
                    end
                    subPage.Visible = true
                    subBtn.TextColor3 = Theme.Text
                    icon.ImageColor3 = Theme.Accent
                end)

                -- Abrir primera sub-pestaña por defecto
                if firstSub then 
                    subBtn.TextColor3 = Theme.Text; icon.ImageColor3 = Theme.Accent; subPage.Visible = true
                    firstSub = false
                end

                return {
                    AddColumn = function(colName)
                        -- Panel Fatality Style (Como los de la imagen)
                        local col = Instance.new("Frame", subPage)
                        col.Size = UDim2.new(0.32, 0, 0, 20)
                        col.AutomaticSize = Enum.AutomaticSize.Y
                        col.BackgroundColor3 = Theme.Panel
                        col.BorderSizePixel = 0
                        Instance.new("UICorner", col).CornerRadius = UDim.new(0, 3)
                        Instance.new("UIStroke", col).Color = Theme.Border

                        -- Header
                        local h = Instance.new("TextLabel", col)
                        h.Size = UDim2.new(1, 0, 0, 25)
                        h.Text = colName
                        h.TextColor3 = Theme.Disabled
                        h.Font = Enum.Font.GothamMedium
                        h.TextSize = 10
                        h.BackgroundTransparency = 1
                        local line = Instance.new("Frame", h)
                        line.Size = UDim2.new(1, -10, 0, 1)
                        line.Position = UDim2.new(0, 5, 1, 0)
                        line.BackgroundColor3 = Theme.Border
                        line.BorderSizePixel = 0

                        -- List of components
                        local list = Instance.new("Frame", col)
                        list.Size = UDim2.new(1, 0, 0, 0)
                        list.Position = UDim2.new(0, 0, 0, 30)
                        list.AutomaticSize = Enum.AutomaticSize.Y
                        list.BackgroundTransparency = 1
                        Instance.new("UIPadding", list).PaddingLeft = UDim.new(0, 10)
                        Instance.new("UIListLayout", list).Padding = UDim.new(0, 5)

                        return {
                            List = list,
                            AddToggle = function(txt, callback, initial, initialKey)
                                local row = Instance.new("Frame", list)
                                row.Size = UDim2.new(1, -10, 0, 18)
                                row.BackgroundTransparency = 1
                                
                                local box = Instance.new("TextButton", row)
                                box.Size = UDim2.new(0, 12, 0, 12)
                                box.Position = UDim2.new(0, 0, 0.5, -6)
                                box.BackgroundColor3 = Theme.Background
                                box.Text = ""

                                local label = Instance.new("TextLabel", row)
                                label.Size = UDim2.new(1, -20, 1, 0)
                                label.Position = UDim2.new(0, 20, 0, 0)
                                label.Text = txt
                                label.TextColor3 = Theme.Text
                                label.Font = Enum.Font.Gotham
                                label.TextSize = 11
                                label.TextXAlignment = Enum.TextXAlignment.Left
                                label.BackgroundTransparency = 1

                                local bindBtn = Instance.new("TextButton", row)
                                bindBtn.Size = UDim2.new(0, 40, 0, 12)
                                bindBtn.Position = UDim2.new(1, -40, 0.5, -6)
                                bindBtn.BackgroundColor3 = Theme.Panel
                                bindBtn.Text = initialKey and initialKey.Name:upper() or "NONE"
                                bindBtn.TextColor3 = Theme.Disabled
                                bindBtn.Font = Enum.Font.Gotham
                                bindBtn.TextSize = 8
                                Instance.new("UIStroke", bindBtn).Color = Theme.Border

                                local s = initial or false
                                box.BackgroundColor3 = s and Theme.Accent or Theme.Background

                                
                                ToggleObjects[txt] = {
                                    UpdateVisual = function(val)
                                        s = val
                                        box.BackgroundColor3 = s and Theme.Accent or Theme.Background
                                    end
                                }
                                
                                local binding = false
                                local currentKey = initialKey

                                local function toggle(isKey)
                                    s = not s
                                    box.BackgroundColor3 = s and Theme.Accent or Theme.Background
                                    callback(s)
                                    if isKey then
                                        Notify(txt .. (s and ": Enabled" or ": Disabled"), s and "success" or "warning")
                                    end
                                end

                                box.MouseButton1Click:Connect(function() toggle(false) end)
                                
                                bindBtn.MouseButton1Click:Connect(function()
                                    binding = true
                                    bindBtn.Text = "..."
                                end)

                                table.insert(GlobalConnections, UserInputService.InputBegan:Connect(function(input, gpe)
                                    if gpe then return end
                                    if binding then
                                        if input.UserInputType == Enum.UserInputType.Keyboard then
                                            currentKey = input.KeyCode
                                            bindBtn.Text = input.KeyCode.Name:upper()
                                            binding = false
                                        end
                                    elseif currentKey and input.KeyCode == currentKey then
                                        toggle(true)
                                    end
                                end))
                            end,
                            AddSlider = function(txt, min, max, default, callback)
                                -- Implementación rápida de slider Fatality
                                local row = Instance.new("Frame", list)
                                row.Size = UDim2.new(1, -10, 0, 35)
                                row.BackgroundTransparency = 1
                                
                                local label = Instance.new("TextLabel", row)
                                label.Size = UDim2.new(1, 0, 0, 15)
                                label.Text = txt
                                label.TextColor3 = Theme.Text
                                label.Font = Enum.Font.Gotham; label.TextSize = 10
                                label.TextXAlignment = Enum.TextXAlignment.Left; label.BackgroundTransparency = 1
                                
                                local valLabel = Instance.new("TextLabel", row)
                                valLabel.Size = UDim2.new(1, 0, 0, 15)
                                valLabel.Text = tostring(default)
                                valLabel.TextColor3 = Theme.Accent
                                valLabel.Font = Enum.Font.GothamBold; valLabel.TextSize = 10
                                valLabel.TextXAlignment = Enum.TextXAlignment.Right; valLabel.BackgroundTransparency = 1

                                local bg = Instance.new("Frame", row)
                                bg.Size = UDim2.new(1, 0, 0, 8)
                                bg.Position = UDim2.new(0, 0, 0, 20)
                                bg.BackgroundColor3 = Theme.Background; bg.BorderSizePixel = 0

                                local fill = Instance.new("Frame", bg)
                                fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
                                fill.BackgroundColor3 = Theme.Accent; fill.BorderSizePixel = 0

                                local dragging = false
                                local function update()
                                    local inputPos = UserInputService:GetMouseLocation().X
                                    local percent = math.clamp((inputPos - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
                                    local val = math.floor(min + (max - min) * percent)
                                    fill.Size = UDim2.new(percent, 0, 1, 0)
                                    valLabel.Text = tostring(val)
                                    callback(val)
                                end

                                SliderObjects[txt] = {
                                    UpdateVisual = function(val)
                                        local percent = math.clamp((val - min) / (max - min), 0, 1)
                                        fill.Size = UDim2.new(percent, 0, 1, 0)
                                        valLabel.Text = tostring(val)
                                    end
                                };
                                bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; update() end end)
                                table.insert(GlobalConnections, UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then update() end end))
                                table.insert(GlobalConnections, UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end))
                            end,
                            AddButton = function(txt, callback)
                                local btn = Instance.new("TextButton", list)
                                btn.Size = UDim2.new(1, -10, 0, 20)
                                btn.BackgroundColor3 = Theme.Background
                                btn.TextColor3 = Theme.Accent
                                btn.Text = txt:upper()
                                btn.Font = Enum.Font.GothamBold; btn.TextSize = 10
                                btn.AutoButtonColor = false -- Evitar el color gris estándar de Roblox
                                Instance.new("UIStroke", btn).Color = Theme.Border
                                
                                btn.MouseEnter:Connect(function()
                                    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Panel}):Play()
                                end)
                                btn.MouseLeave:Connect(function()
                                    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Background}):Play()
                                end)
                                btn.MouseButton1Click:Connect(function()
                                    btn.TextSize = 8
                                    TweenService:Create(btn, TweenInfo.new(0.1), {TextSize = 10}):Play()
                                    callback()
                                end)
                                return btn
                            end,
                            AddTextBox = function(placeholder)
                                local row = Instance.new("Frame", list)
                                row.Size = UDim2.new(1, -10, 0, 180)
                                row.BackgroundTransparency = 1
                                
                                local boxFrame = Instance.new("Frame", row)
                                boxFrame.Size = UDim2.new(1, 0, 1, 0)
                                boxFrame.BackgroundColor3 = Theme.Background
                                Instance.new("UIStroke", boxFrame).Color = Theme.Border
                                Instance.new("UICorner", boxFrame).CornerRadius = UDim.new(0, 3)

                                local textBox = Instance.new("TextBox", boxFrame)
                                textBox.Size = UDim2.new(1, -10, 1, -10)
                                textBox.Position = UDim2.new(0, 5, 0, 5)
                                textBox.BackgroundTransparency = 1
                                textBox.TextColor3 = Theme.Text
                                textBox.PlaceholderText = placeholder
                                textBox.Text = ""
                                textBox.Font = Enum.Font.Code
                                textBox.TextSize = 10
                                textBox.TextXAlignment = Enum.TextXAlignment.Left
                                textBox.TextYAlignment = Enum.TextYAlignment.Top
                                textBox.MultiLine = true
                                textBox.ClearTextOnFocus = false
                                textBox.ClipsDescendants = true

                                return textBox
                            end,
                            AddInput = function(placeholder)
                                local row = Instance.new("Frame", list)
                                row.Size = UDim2.new(1, -10, 0, 25)
                                row.BackgroundTransparency = 1
                                
                                local boxFrame = Instance.new("Frame", row)
                                boxFrame.Size = UDim2.new(1, 0, 1, 0)
                                boxFrame.BackgroundColor3 = Theme.Background
                                Instance.new("UIStroke", boxFrame).Color = Theme.Border
                                Instance.new("UICorner", boxFrame).CornerRadius = UDim.new(0, 3)

                                local textBox = Instance.new("TextBox", boxFrame)
                                textBox.Size = UDim2.new(1, -10, 1, 0)
                                textBox.Position = UDim2.new(0, 5, 0, 0)
                                textBox.BackgroundTransparency = 1
                                textBox.TextColor3 = Theme.Text
                                textBox.PlaceholderText = placeholder
                                textBox.Text = ""
                                textBox.Font = Enum.Font.Gotham
                                textBox.TextSize = 10
                                textBox.TextXAlignment = Enum.TextXAlignment.Left
                                textBox.ClearTextOnFocus = false

                                return textBox
                            end,
                            AddDropdown = function(txt, options, default, callback)
                                local row = Instance.new("Frame", list)
                                row.Size = UDim2.new(1, -10, 0, 38)
                                row.BackgroundTransparency = 1
                                
                                local label = Instance.new("TextLabel", row)
                                label.Size = UDim2.new(1, 0, 0, 15)
                                label.Text = txt
                                label.TextColor3 = Theme.Text
                                label.Font = Enum.Font.Gotham
                                label.TextSize = 10
                                label.TextXAlignment = Enum.TextXAlignment.Left
                                label.TextTransparency = 0
                                label.BackgroundTransparency = 1
                                
                                local mainBtn = Instance.new("TextButton", row)
                                mainBtn.Size = UDim2.new(1, 0, 0, 18)
                                mainBtn.Position = UDim2.new(0, 0, 0, 18)
                                mainBtn.BackgroundColor3 = Theme.Background
                                mainBtn.TextColor3 = Theme.Accent
                                mainBtn.Text = default
                                mainBtn.TextTransparency = 0
                                mainBtn.Font = Enum.Font.GothamMedium
                                mainBtn.TextSize = 10
                                Instance.new("UIStroke", mainBtn).Color = Theme.Border
                                
                                mainBtn.MouseButton1Click:Connect(function()
                                    OpenSidePanel(txt, function(content)
                                        for _, opt in pairs(options) do
                                            local o = Instance.new("TextButton", content)
                                            o.Size = UDim2.new(1, -10, 0, 25)
                                            o.BackgroundColor3 = Theme.Background
                                            o.Text = opt; o.TextColor3 = Theme.Text
                                            o.Font = Enum.Font.Gotham; o.TextSize = 11
                                            Instance.new("UIStroke", o).Color = Theme.Border
                                            o.MouseButton1Click:Connect(function()
                                                mainBtn.Text = opt; callback(opt); sidePanel.Visible = false
                                            end)
                                        end
                                    end)
                                end)
                            end,
                            AddColorPicker = function(txt, default, callback)
                                local row = Instance.new("Frame", list)
                                row.Size = UDim2.new(1, -10, 0, 20)
                                row.BackgroundTransparency = 1

                                local label = Instance.new("TextLabel", row)
                                label.Size = UDim2.new(1, -30, 1, 0)
                                label.Text = txt
                                label.TextColor3 = Theme.Text
                                label.Font = Enum.Font.Gotham
                                label.TextSize = 11
                                label.TextXAlignment = Enum.TextXAlignment.Left
                                label.TextTransparency = 0
                                label.BackgroundTransparency = 1

                                local colorBox = Instance.new("TextButton", row)
                                colorBox.Size = UDim2.new(0, 20, 0, 12)
                                colorBox.Position = UDim2.new(1, -20, 0.5, -6)
                                colorBox.BackgroundColor3 = default
                                colorBox.Text = ""
                                colorBox.TextTransparency = 0 -- Asegura que no haya transparencia si se le asigna texto
                                Instance.new("UICorner", colorBox).CornerRadius = UDim.new(0, 2)
                                Instance.new("UIStroke", colorBox).Color = Theme.Border

                                local h, s, v = default:ToHSV()
                                local function updateColor()
                                    local color = Color3.fromHSV(h, s, v)
                                    colorBox.BackgroundColor3 = color
                                    callback(color)
                                end

                                colorBox.MouseButton1Click:Connect(function()
                                    OpenSidePanel(txt, function(content)
                                        local svGrid = Instance.new("Frame", content)
                                        svGrid.Size = UDim2.new(1, -20, 0, 120)
                                        svGrid.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                                        svGrid.BorderSizePixel = 0

                                        local sGrad = Instance.new("Frame", svGrid)
                                        sGrad.Size = UDim2.new(1, 0, 1, 0)
                                        sGrad.BackgroundColor3 = Color3.new(1, 1, 1)
                                        sGrad.BorderSizePixel = 0
                                        local g1 = Instance.new("UIGradient", sGrad)
                                        g1.Color = ColorSequence.new(Color3.new(1,1,1))
                                        g1.Transparency = NumberSequence.new(0, 1)

                                        local vGrad = Instance.new("Frame", svGrid)
                                        vGrad.Size = UDim2.new(1, 0, 1, 0)
                                        vGrad.BackgroundColor3 = Color3.new(1, 1, 1)
                                        vGrad.BorderSizePixel = 0
                                        local g2 = Instance.new("UIGradient", vGrad)
                                        g2.Color = ColorSequence.new(Color3.new(0,0,0))
                                        g2.Rotation = 90
                                        g2.Transparency = NumberSequence.new(1, 0)

                                        local svInput = Instance.new("TextButton", svGrid)
                                        svInput.Size = UDim2.new(1, 0, 1, 0)
                                        svInput.BackgroundTransparency = 1; svInput.Text = ""

                                        local hueSlider = Instance.new("TextButton", content)
                                        hueSlider.Size = UDim2.new(1, -20, 0, 20)
                                        hueSlider.BackgroundColor3 = Color3.new(1, 1, 1)
                                        hueSlider.Text = ""
                                        local hueGrad = Instance.new("UIGradient", hueSlider)
                                        hueGrad.Color = ColorSequence.new({
                                            ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
                                            ColorSequenceKeypoint.new(0.2, Color3.fromHSV(0.2, 1, 1)),
                                            ColorSequenceKeypoint.new(0.4, Color3.fromHSV(0.4, 1, 1)),
                                            ColorSequenceKeypoint.new(0.6, Color3.fromHSV(0.6, 1, 1)),
                                            ColorSequenceKeypoint.new(0.8, Color3.fromHSV(0.8, 1, 1)),
                                            ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))
                                        })

                                        local function updateInternal()
                                            svGrid.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                                            updateColor()
                                        end

                                        local draggingSV, draggingH = false, false
                                        svInput.MouseButton1Down:Connect(function() draggingSV = true end)
                                        hueSlider.MouseButton1Down:Connect(function() draggingH = true end)

                                        -- Conexiones locales al selector
                                        local moveConn = UserInputService.InputChanged:Connect(function(input)
                                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                                if draggingSV then
                                                    s = math.clamp((input.Position.X - svInput.AbsolutePosition.X) / svInput.AbsoluteSize.X, 0, 1)
                                                    v = 1 - math.clamp((input.Position.Y - svInput.AbsolutePosition.Y) / svInput.AbsoluteSize.Y, 0, 1)
                                                    updateInternal()
                                                elseif draggingH then
                                                    h = math.clamp((input.Position.X - hueSlider.AbsolutePosition.X) / hueSlider.AbsoluteSize.X, 0, 1)
                                                    updateInternal()
                                                end
                                            end
                                        end)

                                        local endConn = UserInputService.InputEnded:Connect(function(input)
                                            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                                                draggingSV, draggingH = false, false
                                            end
                                        end)

                                        -- Limpiar al cerrar el panel de selección (opcional, pero recomendado)
                                        svGrid.Destroying:Connect(function()
                                            moveConn:Disconnect()
                                            endConn:Disconnect()
                                        end)
                                    end)
                                end)

                                updateColor()
                            end
                        }
                    end
                }
            end
        }
    end

    -- =========================================================
    -- CONFIGURACIÓN DEL MENÚ 
    -- =========================================================
    local Combat = AddMainTab("Combat")
    local Visuals = AddMainTab("Visuals")
    local ConfigTab = AddMainTab("Settings")

    -- EXAMPLE: Combat Tab
    local AimbotSub = Combat.AddSubTab("Aimbot", "rbxassetid://10619092497")
    local MainAimbotCol = AimbotSub.AddColumn("Main Aimbot")
    MainAimbotCol.AddToggle("Enabled", function(v) Settings.Combat.Enabled = v end, Settings.Combat.Enabled)
    MainAimbotCol.AddSlider("Field of View", 1, 500, 100, function(v) Settings.Combat.FOV = v end)
    MainAimbotCol.AddSlider("Smoothing", 1, 20, 5, function(v) Settings.Combat.Smoothing = v end)
    
    -- EXAMPLE: Visuals Tab
    local EspSub = Visuals.AddSubTab("ESP", "rbxassetid://10619091632")
    local MainEspCol = EspSub.AddColumn("Global ESP")
    MainEspCol.AddToggle("Esp Enabled", function(v) Settings.Visuals.EspEnabled = v end, Settings.Visuals.EspEnabled)
    MainEspCol.AddColorPicker("Box Color", Settings.Visuals.BoxColor, function(c) Settings.Visuals.BoxColor = c end)
    MainEspCol.AddDropdown("Box Style", {"Corner", "Full", "3D"}, "Corner", function(v) end)

    -- =========================================================
    -- SETTINGS / CONFIG TAB (OBLIGATORIO PARA SINCRONIZACIÓN)
    -- =========================================================
    local SettingsSub = ConfigTab.AddSubTab("Config", "rbxassetid://10619105435")
    
    local ConfigCol = SettingsSub.AddColumn("Config Management")
    ConfigCol.AddButton("Save Config", Save)
    ConfigCol.AddButton("Load Config", Load)
    ConfigCol.AddButton("Reset to Defaults", ResetToFactory)

    local AppearanceCol = SettingsSub.AddColumn("Appearance")
    AppearanceCol.AddColorPicker("Accent Color", Settings.UI.Accent, function(c)
        Settings.UI.Accent = c
        -- Actualizaría colores dinámicamente si fuera necesario
    end)

    local MenuCol = SettingsSub.AddColumn("Menu Settings")
    MenuCol.AddToggle("Menu Visibility", function(v)
        main.Visible = v
    end, main.Visible, Settings.UI_Key)

    -- Tarea secundaria (background) para auto-guardado
    task.spawn(function()
        while true do
            task.wait(60) -- Guarda automáticamente cada 60 segundos si la UI existe
            if not main or not main.Parent then break end
            Save()
        end
    end)

    Notify("Fatality UI Loaded", "info")
end

BuildFatalityUI()

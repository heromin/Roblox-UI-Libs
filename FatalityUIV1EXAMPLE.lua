--[[ 
    - FATALITY - HYVERION VERSION
    - Soporte para Sliders, Dropdowns y Toggles Reales.
    - Sistema de Pestañas y Sub-Pestañas con Iconos.
]]

local Players = game:GetService("Players")
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
-- CONFIGURACIÓN DE COLORES
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

local OldLighting = {
    Ambient = Lighting.Ambient,
    Brightness = Lighting.Brightness,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows
}

local Settings = {
    Aimbot = { 
        Enabled = false, 
        FOV = 100, 
        Smoothing = 5, 
        TargetPart = "Head", 
        ShowFOV = false, 
        TeamCheck = false,
        VisibleCheck = false,
        Prediction = false,
        PredictAmount = 0.16,
        Method = "Mouse"
    },
    Rage = {
        AntiAim = false,
        Pitch = "Down", -- Down, Up, Zero
        Yaw = "Spin", -- Spin, Backwards, Jitter
        SpinSpeed = 100,
        JitterRange = 45
    },
    ESP = { 
        Enabled = false, 
        TeamCheck = false,
        Names = false, 
        Boxes = false, 
        BoxStyle = "Corner", -- Corner, Full, ThreeD
        Tracers = false,
        TracerOrigin = "Bottom",
        Health = false,
        HealthText = false,
        Skeleton = false,
        Chams = false,
        ShowDistance = false,
        DistanceUnit = "studs", -- "studs" or "meters"
        TextSize = 13,
        BoxThickness = 1,
        SkeletonThickness = 1,
        TracerThickness = 1,
        MaxDistance = 2000,
        RefreshRate = 0.01,
        EnemyColor = Color3.fromRGB(255, 30, 90),
        AllyColor = Color3.fromRGB(0, 255, 120)
    },
    Indicators = {
        Enabled = true,
        ShowFPS = true,
        ShowPing = true,
        ShowTime = true,
        ShowUptime = true,
        HideWithMenu = false,
        ShowWatermark = true
    },
    TargetHUD = {
        Enabled = false
    },
    Keybinds = {},
    World = {
        Nightmode = false,
        Brightness = 100,
        Fullbright = false,
        NoFog = false
    },
    Legit = {
        Enabled = false,
        Triggerbot = false,
        TriggerDelay = 0,
        TriggerTeamCheck = false
    },
    Misc = {
        Bhop = false,
        Autostrafe = false,
        AntiAFK = false,
        SpeedHack = false,
        SpeedValue = 16,
        Noclip = false,
        InfiniteJump = false,
        Fly = false,
        FlySpeed = 50,
        Float = false,
        FloatAscent = 0.4,
        FloatHover = 0.4,
        FloatCooldown = 3,
        Spider = false,
        SilentWalk = false,
        AntiCheatDetection = true
    },
    UI_Key = Enum.KeyCode.P,
    UI = {
        Background = Color3.fromRGB(13, 11, 28),
        Panel = Color3.fromRGB(18, 16, 36),
        Accent = Color3.fromRGB(255, 30, 90),
        BorderStart = Color3.fromRGB(255, 40, 80),
        BorderEnd = Color3.fromRGB(40, 0, 60)
    }
}
local StartTime = tick()

local Crosshair_Settings = {
    Enabled = false, Spin = false, Color = Theme.Accent, 
    Size = 12, Gap = 5, Thickness = 2, Transparency = 0,
    SpinSpeed = 150, RGB = false,
    Outline = false, OutlineColor = Color3.new(0,0,0),
    TStyle = false, Dot = false,
    ShowWatermark = false,
    WatermarkText = "HYVERION"
}

local Drawings = {
    ESP = {},
    Skeleton = {}
}
local GlobalConnections = {}
local ToggleObjects = {}

-- FOV Circle para Aimbot
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Theme.Accent
FOVCircle.Transparency = 0.7

-- =========================================================
-- NUCLEO DE LA LOGICA DE EL ESP
-- =========================================================
local function IsVisible(part, character)
    if not part or not character then return false end
    local origin = Camera.CFrame.Position
    local direction = (part.Position - origin)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {Players.LocalPlayer.Character, Camera}
    params.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, params)
    
    -- Si no hay obstrucción o lo primero que golpeamos es el personaje objetivo
    return result == nil or result.Instance:IsDescendantOf(character)
end

local Highlights = {}

local function GetPlayerColor(player)
    return (player.Team == Players.LocalPlayer.Team) and Settings.ESP.AllyColor or Settings.ESP.EnemyColor
end

local function GetTracerOrigin()
    local origin = Settings.ESP.TracerOrigin
    if origin == "Top" then return Vector2.new(Camera.ViewportSize.X/2, 0)
    elseif origin == "Center" then return Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    end
    return Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
end

-- =========================================================
local function CreateESP(player)
    if player == Players.LocalPlayer then return end
    local esp = {
        Box = {
            TopLeft = Drawing.new("Line"), TopRight = Drawing.new("Line"),
            BottomLeft = Drawing.new("Line"), BottomRight = Drawing.new("Line"),
            Left = Drawing.new("Line"), Right = Drawing.new("Line"),
            Top = Drawing.new("Line"), Bottom = Drawing.new("Line")
        },
        Tracer = Drawing.new("Line"),
        HealthBar = { 
            Outline = Drawing.new("Square"), 
            Fill = Drawing.new("Square"),
            Text = Drawing.new("Text")
        },
        Info = { Name = Drawing.new("Text"), Distance = Drawing.new("Text") }
    }

    for _, line in pairs(esp.Box) do line.Visible = false; line.Thickness = Settings.ESP.BoxThickness end
    esp.Tracer.Visible = false; esp.Tracer.Thickness = Settings.ESP.TracerThickness
    esp.HealthBar.Outline.Visible = false; esp.HealthBar.Outline.Filled = false
    esp.HealthBar.Fill.Visible = false; esp.HealthBar.Fill.Filled = true
    esp.Info.Name.Visible = false; esp.Info.Name.Center = true; esp.Info.Name.Outline = true; esp.Info.Name.Size = 13
    
    esp.HealthBar.Text.Visible = false; esp.HealthBar.Text.Size = 12; esp.HealthBar.Text.Outline = true; esp.HealthBar.Text.Center = true

    esp.Info.Distance.Visible = false
    esp.Info.Distance.Center = true
    esp.Info.Distance.Outline = true
    esp.Info.Distance.Size = 11
    esp.Info.Distance.Color = Color3.new(1,1,1)


    local skeleton = {
        Head = Drawing.new("Line"), Neck = Drawing.new("Line"), UpperSpine = Drawing.new("Line"),
        LeftShoulder = Drawing.new("Line"), LeftUpperArm = Drawing.new("Line"), LeftLowerArm = Drawing.new("Line"),
        RightShoulder = Drawing.new("Line"), RightUpperArm = Drawing.new("Line"), RightLowerArm = Drawing.new("Line"),
        LeftHip = Drawing.new("Line"), LeftUpperLeg = Drawing.new("Line"), LeftLowerLeg = Drawing.new("Line"),
        RightHip = Drawing.new("Line"), RightUpperLeg = Drawing.new("Line"), RightLowerLeg = Drawing.new("Line")
    }
    for _, line in pairs(skeleton) do line.Visible = false; line.Thickness = Settings.ESP.SkeletonThickness end

    Drawings.ESP[player] = esp
    Drawings.Skeleton[player] = skeleton
end

local function RemoveESP(player)
    if Drawings.ESP[player] then
        for _, v in pairs(Drawings.ESP[player].Box) do v:Remove() end
        Drawings.ESP[player].Tracer:Remove()
        for _, v in pairs(Drawings.ESP[player].HealthBar) do v:Remove() end
        for _, v in pairs(Drawings.ESP[player].Info) do v:Remove() end
        Drawings.ESP[player] = nil
    end
    if Drawings.Skeleton[player] then
        for _, v in pairs(Drawings.Skeleton[player]) do v:Remove() end
        Drawings.Skeleton[player] = nil
    end
    if Highlights[player] then Highlights[player]:Destroy(); Highlights[player] = nil end
end

local function UpdateESP(player)
    local esp = Drawings.ESP[player]
    if not esp or not Settings.ESP.Enabled then return end

    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not char or not root or not hum or hum.Health <= 0 then
        for _, v in pairs(esp.Box) do v.Visible = false end
        esp.Tracer.Visible = false
        esp.HealthBar.Fill.Visible = false; esp.HealthBar.Outline.Visible = false
        esp.HealthBar.Text.Visible = false
        esp.Info.Name.Visible = false
        esp.Info.Distance.Visible = false
        return
    end

    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
    local dist = (root.Position - Camera.CFrame.Position).Magnitude

    if not onScreen or dist > Settings.ESP.MaxDistance or (Settings.ESP.TeamCheck and player.Team == Players.LocalPlayer.Team) then
        for _, v in pairs(esp.Box) do v.Visible = false end
        esp.Tracer.Visible = false
        esp.HealthBar.Fill.Visible = false; esp.HealthBar.Outline.Visible = false
        esp.Info.Name.Visible = false
        esp.Info.Distance.Visible = false
        return
    end

    local color = GetPlayerColor(player)
    local size = char:GetExtentsSize()
    local top = Camera:WorldToViewportPoint((root.CFrame * CFrame.new(0, size.Y/2, 0)).Position)
    local bottom = Camera:WorldToViewportPoint((root.CFrame * CFrame.new(0, -size.Y/2, 0)).Position)
    local boxHeight = bottom.Y - top.Y
    local boxWidth = boxHeight * 0.6
    local boxPos = Vector2.new(top.X - boxWidth/2, top.Y)

    -- BOX ESP
    for _, v in pairs(esp.Box) do v.Visible = false end
    if Settings.ESP.Boxes then
        if Settings.ESP.BoxStyle == "ThreeD" then
            local cf = root.CFrame
            local size = char:GetExtentsSize()
            local f_tl = Camera:WorldToViewportPoint((cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2)).Position)
            local f_tr = Camera:WorldToViewportPoint((cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2)).Position)
            local f_bl = Camera:WorldToViewportPoint((cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)).Position)
            local f_br = Camera:WorldToViewportPoint((cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2)).Position)
            local b_tl = Camera:WorldToViewportPoint((cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2)).Position)
            local b_tr = Camera:WorldToViewportPoint((cf * CFrame.new(size.X/2, size.Y/2, size.Z/2)).Position)
            local b_bl = Camera:WorldToViewportPoint((cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2)).Position)
            local b_br = Camera:WorldToViewportPoint((cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2)).Position)

            local function drawLine(l, p1, p2) l.From = Vector2.new(p1.X, p1.Y); l.To = Vector2.new(p2.X, p2.Y); l.Visible = true end
            drawLine(esp.Box.TopLeft, f_tl, f_tr); drawLine(esp.Box.TopRight, f_tr, f_br)
            drawLine(esp.Box.BottomLeft, f_br, f_bl); drawLine(esp.Box.BottomRight, f_bl, f_tl)
            drawLine(esp.Box.Left, b_tl, b_tr); drawLine(esp.Box.Right, b_tr, b_br)
            drawLine(esp.Box.Top, b_br, b_bl); drawLine(esp.Box.Bottom, b_bl, b_tl)
            -- Conectores (reutilizando para no crear mas dibujos)
            -- Nota: En modo 3D completo se requieren 12 líneas. Aquí usamos las 8 disponibles.
        elseif Settings.ESP.BoxStyle == "Corner" then
            local cSize = boxWidth * 0.2
            esp.Box.TopLeft.From = boxPos; esp.Box.TopLeft.To = boxPos + Vector2.new(cSize, 0)
            esp.Box.Left.From = boxPos; esp.Box.Left.To = boxPos + Vector2.new(0, cSize)
            
            esp.Box.TopRight.From = boxPos + Vector2.new(boxWidth, 0); esp.Box.TopRight.To = boxPos + Vector2.new(boxWidth - cSize, 0)
            esp.Box.Right.From = boxPos + Vector2.new(boxWidth, 0); esp.Box.Right.To = boxPos + Vector2.new(boxWidth, cSize)
            
            esp.Box.BottomLeft.From = boxPos + Vector2.new(0, boxHeight); esp.Box.BottomLeft.To = boxPos + Vector2.new(cSize, boxHeight)
            esp.Box.BottomRight.From = boxPos + Vector2.new(0, boxHeight); esp.Box.BottomRight.To = boxPos + Vector2.new(0, boxHeight - cSize)
            
            esp.Box.Top.From = boxPos + Vector2.new(boxWidth, boxHeight); esp.Box.Top.To = boxPos + Vector2.new(boxWidth - cSize, boxHeight)
            esp.Box.Bottom.From = boxPos + Vector2.new(boxWidth, boxHeight); esp.Box.Bottom.To = boxPos + Vector2.new(boxWidth, boxHeight - cSize)
            
            for _, v in pairs(esp.Box) do v.Visible = true end
        else
            esp.Box.Top.From = boxPos; esp.Box.Top.To = boxPos + Vector2.new(boxWidth, 0)
            esp.Box.Bottom.From = boxPos + Vector2.new(0, boxHeight); esp.Box.Bottom.To = boxPos + Vector2.new(boxWidth, boxHeight)
            esp.Box.Left.From = boxPos; esp.Box.Left.To = boxPos + Vector2.new(0, boxHeight)
            esp.Box.Right.From = boxPos + Vector2.new(boxWidth, 0); esp.Box.Right.To = boxPos + Vector2.new(boxWidth, boxHeight)
            esp.Box.Top.Visible = true; esp.Box.Bottom.Visible = true; esp.Box.Left.Visible = true; esp.Box.Right.Visible = true
        end
        for _, v in pairs(esp.Box) do if v.Visible then v.Color = color; v.Thickness = Settings.ESP.BoxThickness end end
    end

    -- TRACERS
    if Settings.ESP.Tracers then
        esp.Tracer.From = GetTracerOrigin(); esp.Tracer.To = Vector2.new(pos.X, pos.Y)
        esp.Tracer.Color = color; esp.Tracer.Visible = true; esp.Tracer.Thickness = Settings.ESP.TracerThickness
    else esp.Tracer.Visible = false end

    -- HEALTH BAR
    if Settings.ESP.Health then
        local hPct = hum.Health / hum.MaxHealth
        esp.HealthBar.Outline.Position = boxPos - Vector2.new(6, 0); esp.HealthBar.Outline.Size = Vector2.new(4, boxHeight)
        esp.HealthBar.Fill.Position = boxPos - Vector2.new(5, -boxHeight); esp.HealthBar.Fill.Size = Vector2.new(2, -boxHeight * hPct)
        esp.HealthBar.Fill.Color = Color3.fromHSV(0.33 * hPct, 1, 1)
        esp.HealthBar.Outline.Visible = true; esp.HealthBar.Fill.Visible = true
        
        if Settings.ESP.HealthText then
            esp.HealthBar.Text.Text = tostring(math.floor(hum.Health))
            esp.HealthBar.Text.Position = esp.HealthBar.Outline.Position + Vector2.new(2, boxHeight * (1 - hPct))
            esp.HealthBar.Text.Color = Color3.new(1,1,1); esp.HealthBar.Text.Visible = true
        else esp.HealthBar.Text.Visible = false end
    else esp.HealthBar.Outline.Visible = false; esp.HealthBar.Fill.Visible = false; esp.HealthBar.Text.Visible = false end

    -- NAMES
    if Settings.ESP.Names then
        esp.Info.Name.Text = player.DisplayName; esp.Info.Name.Position = Vector2.new(top.X, top.Y - (Settings.ESP.TextSize + 2))
        esp.Info.Name.Size = Settings.ESP.TextSize
        esp.Info.Name.Color = Color3.new(1,1,1); esp.Info.Name.Visible = true
    else esp.Info.Name.Visible = false end

    -- DISTANCE ESP
    if Settings.ESP.ShowDistance then
        local distanceText = ""
        if Settings.ESP.DistanceUnit == "meters" then
            distanceText = string.format("%.1f m", dist / 3.281) -- Convert studs to meters
        else -- studs
            distanceText = string.format("%.0f studs", dist)
        end
        
        local nameOffset = Settings.ESP.Names and -15 or 0
        esp.Info.Distance.Text = distanceText
        esp.Info.Distance.Position = Vector2.new(top.X, top.Y + nameOffset + (Settings.ESP.Names and (Settings.ESP.TextSize + 2) or 0))
        esp.Info.Distance.Size = math.max(10, Settings.ESP.TextSize - 2)
        esp.Info.Distance.Color = Color3.new(1,1,1)
        esp.Info.Distance.Visible = true
    else esp.Info.Distance.Visible = false end


    -- SKELETON ESP
    local skel = Drawings.Skeleton[player]
    if Settings.ESP.Skeleton then
        local function drawBone(line, p1, p2)
            local b1 = char:FindFirstChild(p1)
            local b2 = char:FindFirstChild(p2)
            if not b1 and (p1 == "UpperTorso" or p1 == "LowerTorso") then b1 = char:FindFirstChild("Torso") end
            if not b2 and (p2 == "UpperTorso" or p2 == "LowerTorso") then b2 = char:FindFirstChild("Torso") end
            
            if b1 and b2 then
                local v1, o1 = Camera:WorldToViewportPoint(b1.Position)
                local v2, o2 = Camera:WorldToViewportPoint(b2.Position)
                if o1 and o2 then
                    line.From = Vector2.new(v1.X, v1.Y); line.To = Vector2.new(v2.X, v2.Y)
                    line.Color = color; line.Visible = true; line.Thickness = Settings.ESP.SkeletonThickness
                    return
                end
            end
            line.Visible = false
        end
        drawBone(skel.Head, "Head", "UpperTorso")
        drawBone(skel.UpperSpine, "UpperTorso", "LowerTorso")
        drawBone(skel.LeftShoulder, "UpperTorso", "LeftUpperArm")
        drawBone(skel.LeftUpperArm, "LeftUpperArm", "LeftLowerArm")
        drawBone(skel.RightShoulder, "UpperTorso", "RightUpperArm")
        drawBone(skel.RightUpperArm, "RightUpperArm", "RightLowerArm")
        -- ... otros huesos se dibujan igual
    else for _, v in pairs(skel) do v.Visible = false end end

    -- CHAMS (HIGHLIGHT)
    if Settings.ESP.Chams then
        if not Highlights[player] then
            local h = Instance.new("Highlight", char)
            h.FillColor = color; h.OutlineColor = Color3.new(1,1,1); h.FillTransparency = 0.5
            Highlights[player] = h
        end
    elseif Highlights[player] then Highlights[player]:Destroy(); Highlights[player] = nil end
end

table.insert(GlobalConnections, Players.PlayerAdded:Connect(CreateESP))
table.insert(GlobalConnections, Players.PlayerRemoving:Connect(RemoveESP))
for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end

-- =========================================================
-- SISTEMA DE MIRA (CROSSHAIR)
-- =========================================================
local CrossGui = Instance.new("ScreenGui", CoreGui)
CrossGui.IgnoreGuiInset = true
local CrossMain = Instance.new("Frame", CrossGui)
CrossMain.Size = UDim2.new(0, 0, 0, 0); CrossMain.Position = UDim2.new(0.5, 0, 0.5, 0); CrossMain.BackgroundTransparency = 1

local CrossSpinner = Instance.new("Frame", CrossMain)
CrossSpinner.Size = UDim2.new(0, 0, 0, 0); CrossSpinner.BackgroundTransparency = 1

local function CreateLine()
    local f = Instance.new("Frame", CrossSpinner); f.BorderSizePixel = 0; f.Visible = false; return f
end

local Lines = {Top = CreateLine(), Bottom = CreateLine(), Left = CreateLine(), Right = CreateLine(), Dot = CreateLine()}
local currentRotation = 0

-- Watermark Crosshair
local CrossWatermark = Instance.new("TextLabel", CrossMain)
CrossWatermark.BackgroundTransparency = 1
CrossWatermark.TextColor3 = Theme.Text
CrossWatermark.Font = Enum.Font.Code
CrossWatermark.TextSize = 14
CrossWatermark.TextXAlignment = Enum.TextXAlignment.Center
CrossWatermark.AnchorPoint = Vector2.new(0.5, 0)
CrossWatermark.TextStrokeTransparency = 0
CrossWatermark.Text = Crosshair_Settings.WatermarkText
CrossWatermark.Visible = false

table.insert(GlobalConnections, RunService.RenderStepped:Connect(function(dt)
    -- Mira (Crosshair)
    if Crosshair_Settings.Spin then currentRotation = currentRotation + (Crosshair_Settings.SpinSpeed * dt) end
    CrossSpinner.Rotation = currentRotation
    
    local mousePos = UserInputService:GetMouseLocation()
    CrossMain.Position = UDim2.fromOffset(mousePos.X, mousePos.Y)
    
    local color = Crosshair_Settings.Color
    if Crosshair_Settings.RGB then
        color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end

    local crosshairEnabled = Crosshair_Settings.Enabled
    for name, l in pairs(Lines) do 
        l.BackgroundColor3 = color
        l.BackgroundTransparency = Crosshair_Settings.Transparency
        
        local outline = l:FindFirstChild("Outline")
        if Crosshair_Settings.Outline then
            if not outline then
                outline = Instance.new("UIStroke", l)
                outline.Name = "Outline"
                outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                outline.Thickness = 1
            end
            outline.Enabled = true
            outline.Color = Crosshair_Settings.OutlineColor
        elseif outline then
            outline.Enabled = false
        end
    end

    if crosshairEnabled then
        local s, g, t = Crosshair_Settings.Size, Crosshair_Settings.Gap, Crosshair_Settings.Thickness
        Lines.Top.Visible = not Crosshair_Settings.TStyle
        Lines.Bottom.Visible = true; Lines.Left.Visible = true; Lines.Right.Visible = true
        Lines.Dot.Visible = Crosshair_Settings.Dot

        Lines.Top.Size = UDim2.new(0, t, 0, s); Lines.Top.Position = UDim2.new(0, -t/2, 0, -g - s)
        Lines.Bottom.Size = UDim2.new(0, t, 0, s); Lines.Bottom.Position = UDim2.new(0, -t/2, 0, g)
        Lines.Left.Size = UDim2.new(0, s, 0, t); Lines.Left.Position = UDim2.new(0, -g - s, 0, -t/2)
        Lines.Right.Size = UDim2.new(0, s, 0, t); Lines.Right.Position = UDim2.new(0, g, 0, -t/2)
        Lines.Dot.Size = UDim2.new(0, t, 0, t); Lines.Dot.Position = UDim2.new(0, -t/2, 0, -t/2)
    else
        for _, l in pairs(Lines) do l.Visible = false end
    end

    -- Crosshair Watermark Logica
    if Crosshair_Settings.ShowWatermark then
        CrossWatermark.Visible = true
        CrossWatermark.TextColor3 = color
        
        local pulse = (math.sin(tick() * 3) + 1) / 2
        CrossWatermark.TextTransparency = 0.2 + (pulse * 0.3)
        
        CrossWatermark.Text = Crosshair_Settings.WatermarkText
        local wmOffset = Crosshair_Settings.Gap + Crosshair_Settings.Size + 5
        CrossWatermark.Position = UDim2.new(0, 0, 0, wmOffset)
        CrossWatermark.Size = UDim2.new(0, 100, 0, 15)
    else CrossWatermark.Visible = false end
end))

-- =========================================================
-- FUNCIONES DE COMBATE Y VISUALES
-- =========================================================
local function GetAimPart(char)
    if not char then return nil end
    local targetName = Settings.Aimbot.TargetPart
    local part = char:FindFirstChild(targetName)
    -- Fallback para compatibilidad R6/R15
    if not part and (targetName == "Torso" or targetName == "UpperTorso" or targetName == "LowerTorso") then
        part = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("LowerTorso")
    end
    return part
end

local function GetClosestPlayer()
    local target, shortestDist = nil, Settings.Aimbot.FOV
    for _, v in pairs(Players:GetPlayers()) do
        local char = v.Character
        local part = GetAimPart(char)
        if v ~= Players.LocalPlayer and char and part then
            if Settings.Aimbot.TeamCheck and v.Team == Players.LocalPlayer.Team then continue end
            if Settings.Aimbot.VisibleCheck and not IsVisible(part, char) then continue end

            local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    target = v
                end
            end
        end
    end
    return target
end

local lastESPUpdate = 0
table.insert(GlobalConnections, RunService.RenderStepped:Connect(function(dt)
    -- Lógica Aimbot
    if Settings.Aimbot.Enabled then
        local target = GetClosestPlayer()
        if target and target.Character then
            local part = GetAimPart(target.Character)
            if part then
                local pos = part.Position
                
                if Settings.Aimbot.Prediction and target.Character:FindFirstChild("HumanoidRootPart") then
                    pos = pos + (target.Character.HumanoidRootPart.Velocity * (Settings.Aimbot.PredictAmount or 0.16))
                end

                local targetPos, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    if Settings.Aimbot.Method == "Camera" then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, pos)
                    else
                        local mousePos = UserInputService:GetMouseLocation()
                        local smoothing = math.max(1, Settings.Aimbot.Smoothing)
                        
                        if typeof(mousemoverel) == "function" then
                            mousemoverel((targetPos.X - mousePos.X) / smoothing, (targetPos.Y - mousePos.Y) / smoothing)
                        end
                    end
                end
            end
        end
    end
    
    FOVCircle.Visible = Settings.Aimbot.ShowFOV
    FOVCircle.Radius = Settings.Aimbot.FOV
    FOVCircle.Position = UserInputService:GetMouseLocation()

    -- Lógica ESP Optimizada
    if tick() - lastESPUpdate > Settings.ESP.RefreshRate then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer then UpdateESP(p) end
        end
        lastESPUpdate = tick()
    end
end))

-- =========================================================
-- LÓGICA DE MISC (MOVEMENT & UTIL)
-- =========================================================
local lastPosition = Vector3.new(0,0,0)
local floatState = "Idle"
local floatTimer = 0
local lastFloatTick = 0
local safetyTicks = 0

table.insert(GlobalConnections, RunService.Stepped:Connect(function()
    local char = Players.LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if char and root and hum then
        -- Detección de Anti-Cheat (Rubberbanding / Teleport Back)
        if Settings.Misc.AntiCheatDetection and (Settings.Misc.SpeedHack or Settings.Misc.Noclip) then
            local currentPos = root.Position
            local distance = (currentPos - lastPosition).Magnitude
            local expectedMax = (hum.WalkSpeed * (1/60)) + 15 -- Margen de error
            
            -- Si el movimiento entre frames es absurdo (pero no un teleport intencional de mapa)
            if distance > expectedMax and distance < 50 then
                Settings.Misc.SpeedHack = false
                Settings.Misc.Noclip = false
                Settings.Misc.Fly = false
                Notify("SAFETY: Anti-Cheat Detected!", Color3.fromRGB(255, 0, 0))
                Notify("Movement hacks disabled.", Color3.fromRGB(255, 255, 255))
            end
            lastPosition = currentPos
        end

        -- Spider (Wall Climb)
        if Settings.Misc.Spider then
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = {char}
            local ray = workspace:Raycast(root.Position, root.CFrame.LookVector * 2.5, params)
            
            if ray then
                root.Velocity = Vector3.new(root.Velocity.X, 30, root.Velocity.Z)
            end
        end

        -- Logica de float
        if Settings.Misc.Float or floatState ~= "Idle" then
            local now = tick()
            
            if floatState == "Idle" and Settings.Misc.Float then
                if now - lastFloatTick > Settings.Misc.FloatCooldown then
                    floatState = "Ascending"
                    floatTimer = now
                else
                    Settings.Misc.Float = false
                    if ToggleObjects["Float"] then ToggleObjects["Float"].UpdateVisual(false) end
                    if Notify then Notify("Float is on cooldown!", Theme.Accent) end
                end
            end

            if floatState == "Ascending" then
                root.Velocity = Vector3.new(root.Velocity.X, 20, root.Velocity.Z)
                if now - floatTimer > Settings.Misc.FloatAscent then
                    floatState = "Hovering"
                    floatTimer = now
                end
            elseif floatState == "Hovering" then
                root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
                if now - floatTimer > Settings.Misc.FloatHover then
                    floatState = "Descending"
                    floatTimer = now
                end
            elseif floatState == "Descending" then
                -- Light descent to avoid anti-cheat detection
                root.Velocity = Vector3.new(root.Velocity.X, -10, root.Velocity.Z)
                if hum.FloorMaterial ~= Enum.Material.Air or (now - floatTimer > 2.5) then
                    floatState = "Idle"
                    lastFloatTick = now
                    Settings.Misc.Float = false
                    if ToggleObjects["Float"] then ToggleObjects["Float"].UpdateVisual(false) end
                end
            end
        else
            floatState = "Idle"
        end

        -- Silent Walk (Animation Disabler)
        local animate = char:FindFirstChild("Animate")
        if animate then
            animate.Disabled = Settings.Misc.SilentWalk
        end
        if Settings.Misc.SilentWalk then
            for _, track in pairs(hum:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        -- Fly Logic (CFrame based)
        if Settings.Misc.Fly then
            hum.PlatformStand = true
            local flyVec = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then flyVec = flyVec + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then flyVec = flyVec - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then flyVec = flyVec - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then flyVec = flyVec + Camera.CFrame.RightVector end
            root.Velocity = Vector3.new(0,0.1,0)
            root.CFrame = root.CFrame + (flyVec * (Settings.Misc.FlySpeed / 50))
        else
            if hum.PlatformStand then hum.PlatformStand = false end
        end

        -- Bhop
        if Settings.Misc.Bhop and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            if hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end

        -- Speed Hack
        if Settings.Misc.SpeedHack then
            hum.WalkSpeed = Settings.Misc.SpeedValue
        else
            if hum.WalkSpeed ~= 16 then -- Solo restablecer si no es ya la velocidad normal
                hum.WalkSpeed = 16
            end
        end

        -- Noclip
        if Settings.Misc.Noclip then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end))

-- =========================================================
-- LÓGICA DE RAGE (ANTI-AIM)
-- =========================================================
table.insert(GlobalConnections, RunService.Stepped:Connect(function()
    if Settings.Rage.AntiAim then
        local char = Players.LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            -- Pitch (X axis)
            local pAngle = 0
            if Settings.Rage.Pitch == "Down" then pAngle = 89
            elseif Settings.Rage.Pitch == "Up" then pAngle = -89 end
            
            -- Yaw (Y axis)
            local yAngle = 0
            if Settings.Rage.Yaw == "Spin" then
                yAngle = (tick() * (Settings.Rage.SpinSpeed * 5)) % 360
            elseif Settings.Rage.Yaw == "Backwards" then
                yAngle = 180
            elseif Settings.Rage.Yaw == "Jitter" then
                yAngle = (tick() % 0.2 > 0.1) and Settings.Rage.JitterRange or -Settings.Rage.JitterRange
            end
            
            root.CFrame = root.CFrame * CFrame.Angles(math.rad(pAngle), math.rad(yAngle), 0)
        end
    end
end))

-- =========================================================
-- LÓGICA DE LEGIT BOT (TRIGGERBOT)
-- =========================================================
local lastTriggerTime = 0
table.insert(GlobalConnections, RunService.RenderStepped:Connect(function()
    if Settings.Legit.Triggerbot and typeof(mouse1click) == "function" then
        local currentTime = tick()
        if currentTime - lastTriggerTime < (Settings.Legit.TriggerDelay / 1000) then return end

        local mousePos = UserInputService:GetMouseLocation()
        local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {Players.LocalPlayer.Character}
        
        local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
        
        if result and result.Instance:IsA("BasePart") then
            local targetChar = result.Instance.Parent
            if not targetChar:FindFirstChildOfClass("Humanoid") then targetChar = targetChar.Parent end
            
            local targetPlayer = Players:GetPlayerFromCharacter(targetChar)
            if targetPlayer and targetPlayer ~= Players.LocalPlayer then
                if Settings.Legit.TriggerTeamCheck and targetPlayer.Team == Players.LocalPlayer.Team then return end
                
                lastTriggerTime = currentTime
                mouse1click()
            end
        end
    end
end))

-- Anti-AFK
table.insert(GlobalConnections, Players.LocalPlayer.Idled:Connect(function()
    if Settings.Misc.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end))

-- Infinite Jump
table.insert(GlobalConnections, UserInputService.JumpRequest:Connect(function()
    if Settings.Misc.InfiniteJump then
        local hum = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

-- =========================================================
-- UI FRAMEWORK - ESTILO FATALITY V3
-- =========================================================
local function MakeDraggable(obj, dragPart)
    local dragging, dragInput, dragStart, startPos
    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = obj.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

local function BuildFatalityUI()
    local sg = Instance.new("ScreenGui", CoreGui)
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
    sg.IgnoreGuiInset = true
    
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
        for _, conn in pairs(GlobalConnections) do
            if conn then conn:Disconnect() end
        end
        for player, _ in pairs(Drawings.ESP) do
            RemoveESP(player)
        end
        if FOVCircle then FOVCircle:Remove() end
        if CrossGui then CrossGui:Destroy() end
        if notifyContainer then notifyContainer:Destroy() end
        sg:Destroy()
        -- Asegurar que las variables lógicas se detengan
        Settings.Aimbot.Enabled = false
        Settings.ESP.Enabled = false
    end

    -- =========================================================
    -- NOTIFICATION SYSTEM (FATALITY STYLE)
    -- =========================================================
    local notifyContainer = Instance.new("Frame", sg)
    notifyContainer.Size = UDim2.new(0, 200, 1, -20)
    notifyContainer.Position = UDim2.new(1, -210, 0, 10)
    notifyContainer.BackgroundTransparency = 1
    local notifyList = Instance.new("UIListLayout", notifyContainer)
    notifyList.VerticalAlignment = Enum.VerticalAlignment.Top
    notifyList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    notifyList.Padding = UDim.new(0, 5)

    Notify = function(text, color)
        local n = Instance.new("Frame", notifyContainer)
        n.Size = UDim2.new(1, 0, 0, 25); n.BackgroundColor3 = Theme.Background; n.ClipsDescendants = true
        Instance.new("UICorner", n).CornerRadius = UDim.new(0, 4)
        local accent = Instance.new("Frame", n); accent.Size = UDim2.new(0, 2, 1, 0); accent.BackgroundColor3 = color or Theme.Accent; accent.BorderSizePixel = 0
        local l = Instance.new("TextLabel", n); l.Size = UDim2.new(1, -10, 1, 0); l.Position = UDim2.new(0, 8, 0, 0)
        l.BackgroundTransparency = 1; l.Text = text; l.TextColor3 = Theme.Text; l.Font = Enum.Font.GothamMedium; l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left
        
        n.Position = UDim2.new(1, 10, 0, 0)
        TweenService:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(2.5, function()
            local t = TweenService:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 0, 0)})
            t:Play(); t.Completed:Connect(function() n:Destroy() end)
        end)
    end

    -- =========================================================
    -- INDICADORS / WATERMARK WINDOW
    -- =========================================================
    local infoMain = Instance.new("Frame", sg)
    infoMain.Size = UDim2.new(0, 220, 0, 20)
    infoMain.Position = UDim2.new(0, 10, 0, 10)
    infoMain.BackgroundColor3 = Settings.UI.Background
    infoMain.Visible = false
    Instance.new("UICorner", infoMain).CornerRadius = UDim.new(0, 4)
    MakeDraggable(infoMain, infoMain)

    -- Borde Exterior Degradado (Fatality Signature)
    local iOuterStroke = Instance.new("UIStroke", infoMain)
    iOuterStroke.Thickness = 2
    iOuterStroke.Color = Color3.new(1,1,1)
    local iOuterGrad = Instance.new("UIGradient", iOuterStroke)
    iOuterGrad.Color = ColorSequence.new(Settings.UI.BorderStart, Settings.UI.BorderEnd)
    iOuterGrad.Rotation = 90

    -- Borde Interior Negro y Contenedor
    local infoInner = Instance.new("Frame", infoMain)
    infoInner.Size = UDim2.new(1, -6, 1, -6)
    infoInner.Position = UDim2.new(0, 3, 0, 3)
    infoInner.BackgroundColor3 = Settings.UI.Panel
    infoInner.BorderSizePixel = 0
    Instance.new("UIStroke", infoInner).Color = Color3.new(0,0,0)
    Instance.new("UICorner", infoInner).CornerRadius = UDim.new(0, 2)

    local infoList = Instance.new("UIListLayout", infoInner)
    infoList.Padding = UDim.new(0, 2)
    infoList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    infoList.SortOrder = Enum.SortOrder.LayoutOrder

    local function CreateIndicator(name)
        local label = Instance.new("TextLabel", infoInner)
        label.Size = UDim2.new(1, -15, 0, 18)
        label.BackgroundTransparency = 1
        label.TextColor3 = Theme.Text
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Visible = false
        return label
    end

    local iWatermark = CreateIndicator("Watermark")
    local iFPS = CreateIndicator("FPS")
    local iPing = CreateIndicator("Ping")
    local iTime = CreateIndicator("Time")
    local iUp = CreateIndicator("Uptime")

    local lastFPS = 0
    local lastUpdate = tick()
    local firstPosSet = false

    table.insert(GlobalConnections, RunService.RenderStepped:Connect(function()
        local shouldShow = Settings.Indicators.Enabled
        if Settings.Indicators.HideWithMenu and (main == nil or not main.Visible) then
            shouldShow = false
        end

        infoMain.Visible = shouldShow
        if not shouldShow then return end
        
        if not firstPosSet and main then
            infoMain.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset - infoMain.Size.X.Offset - 10, main.Position.Y.Scale, main.Position.Y.Offset)
            firstPosSet = true
        end
        
        if tick() - lastUpdate >= 0.5 then
            lastFPS = math.floor(1/RunService.RenderStepped:Wait())
            lastUpdate = tick()
        end

        local count = 0
        if Settings.Indicators.ShowWatermark then 
            iWatermark.Text = "HYVERION | VER 1.0"
            iWatermark.Visible = true; count = count + 1
        else iWatermark.Visible = false end

        if Settings.Indicators.ShowFPS then 
            iFPS.Text = "FPS: " .. tostring(lastFPS)
            iFPS.Visible = true; count = count + 1
        else iFPS.Visible = false end
        
        if Settings.Indicators.ShowPing then 
            local pingStr = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")
            iPing.Text = "Ping: " .. (pingStr or "0") .. "ms"
            iPing.Visible = true; count = count + 1
        else iPing.Visible = false end
        
        if Settings.Indicators.ShowTime then 
            iTime.Text = "Local Time: " .. os.date("%X")
            iTime.Visible = true; count = count + 1
        else iTime.Visible = false end
        
        if Settings.Indicators.ShowUptime then 
            iUp.Text = "Script Uptime: " .. math.floor(tick() - StartTime) .. "s"
            iUp.Visible = true; count = count + 1
        else iUp.Visible = false end
        
        infoMain.Size = UDim2.new(0, 220, 0, (count * 20) + 10)
    end))

    -- =========================================================
    -- TARGET INFO HUD (ESQUINA SUPERIOR DERECHA)
    -- =========================================================
    local targetHUD = Instance.new("Frame", sg)
    targetHUD.Size = UDim2.new(0, 220, 0, 110)
    targetHUD.Position = UDim2.new(1, -230, 0, 10) -- 10px de margen desde la derecha
    targetHUD.BackgroundColor3 = Settings.UI.Background
    targetHUD.Visible = false
    Instance.new("UICorner", targetHUD).CornerRadius = UDim.new(0, 4)
    MakeDraggable(targetHUD, targetHUD)

    local tOuterStroke = Instance.new("UIStroke", targetHUD)
    tOuterStroke.Thickness = 2
    tOuterStroke.Color = Color3.new(1,1,1)
    local tOuterGrad = Instance.new("UIGradient", tOuterStroke)
    tOuterGrad.Color = ColorSequence.new(Settings.UI.BorderStart, Settings.UI.BorderEnd)
    tOuterGrad.Rotation = 90

    local tInner = Instance.new("Frame", targetHUD)
    tInner.Size = UDim2.new(1, -6, 1, -6)
    tInner.Position = UDim2.new(0, 3, 0, 3)
    tInner.BackgroundColor3 = Settings.UI.Panel
    tInner.BorderSizePixel = 0
    Instance.new("UIStroke", tInner).Color = Color3.new(0,0,0)
    Instance.new("UICorner", tInner).CornerRadius = UDim.new(0, 2)

    local tList = Instance.new("UIListLayout", tInner)
    tList.Padding = UDim.new(0, 2)
    tList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tList.SortOrder = Enum.SortOrder.LayoutOrder

    local function CreateHUDLabel(order)
        local label = Instance.new("TextLabel", tInner)
        label.Size = UDim2.new(1, -15, 0, 18)
        label.BackgroundTransparency = 1
        label.TextColor3 = Theme.Text
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.LayoutOrder = order
        return label
    end

    local hName = CreateHUDLabel(1)
    local hType = CreateHUDLabel(2)
    local hStatus = CreateHUDLabel(3)
    local hWeapon = CreateHUDLabel(4)
    local hSpeed = CreateHUDLabel(5)

    table.insert(GlobalConnections, RunService.RenderStepped:Connect(function()
        if not Settings.TargetHUD.Enabled then
            targetHUD.Visible = false
            return
        end

        local mouse = Players.LocalPlayer:GetMouse()
        local targetObj = mouse.Target
        local char = targetObj and targetObj:FindFirstAncestorOfClass("Model")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if char and hum then
            targetHUD.Visible = true
            local p = Players:GetPlayerFromCharacter(char)
            hName.Text = "Name: " .. (p and p.DisplayName or char.Name)
            hType.Text = "Type: " .. (p and "Player" or "AI Entity")
            hStatus.Text = "Status: " .. (hum.Health > 0 and "Alive" or "Dead")
            hStatus.TextColor3 = hum.Health > 0 and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 50, 50)
            local tool = char:FindFirstChildOfClass("Tool")
            hWeapon.Text = "Weapon: " .. (tool and tool.Name or "None")
            hSpeed.Text = "Speed: " .. math.floor(hum.WalkSpeed) .. " studs/s"
        else
            targetHUD.Visible = false
        end
    end))

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
            CrossGui.Enabled = main.Visible
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
                subPage.ScrollBarThickness = 0
                subPage.ScrollBarThickness = 2
                subPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
                subPage.CanvasSize = UDim2.new(0, 0, 0, 0)
                
                local subLayout = Instance.new("UIListLayout", subPage)
                subLayout.FillDirection = Enum.FillDirection.Horizontal
                subLayout.Padding = UDim.new(0, 10)
                subLayout.Wraps = true
                subLayout.Padding = UDim.new(0, 8)

                subBtn.MouseButton1Click:Connect(function()
                    for _, sp in pairs(contentFrame:GetChildren()) do if sp:IsA("ScrollingFrame") then sp.Visible = false end end
                    for _, sb in pairs(subTop:GetChildren()) do if sb:IsA("TextButton") then sb.TextColor3 = Theme.Disabled; sb.ImageLabel.ImageColor3 = Theme.Disabled end end
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
                        col.Size = UDim2.new(0.33, -7, 0, 20)
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
                            AddToggle = function(txt, callback, initial)
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
                                bindBtn.Text = "NONE"
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
                                local currentKey = nil

                                local function toggle(isKey)
                                    s = not s
                                    box.BackgroundColor3 = s and Theme.Accent or Theme.Background
                                    callback(s)
                                    if isKey then
                                        Notify(txt .. (s and ": Enabled" or ": Disabled"), s and Theme.Accent or Theme.Disabled)
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
                                bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; update() end end)
                                UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then update() end end)
                                UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
                            end,
                            AddButton = function(txt, callback)
                                local btn = Instance.new("TextButton", list)
                                btn.Size = UDim2.new(1, -10, 0, 20)
                                btn.BackgroundColor3 = Theme.Background
                                btn.TextColor3 = Theme.Accent
                                btn.Text = txt:upper()
                                btn.Font = Enum.Font.GothamBold; btn.TextSize = 10
                                Instance.new("UIStroke", btn).Color = Theme.Border
                                btn.MouseButton1Click:Connect(callback)
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

                                        table.insert(GlobalConnections, UserInputService.InputChanged:Connect(function(input)
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
                                        end))

                                        table.insert(GlobalConnections, UserInputService.InputEnded:Connect(function(input)
                                            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                                                draggingSV, draggingH = false, false 
                                            end
                                        end))
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
    -- CONFIGURACIÓN DEL MENÚ (COMO EN LA IMAGEN)
    -- =========================================================
    local Rage = AddMainTab("Rage")
    local Legit = AddMainTab("Legit")
    local Visuals = AddMainTab("Visuals")
    local Misc = AddMainTab("Misc")
    local ConfigTab = AddMainTab("Settings")

    local function Save() if writefile then writefile("fatality_v3.json", HttpService:JSONEncode(Settings)) end end
    local function Load() 
        if isfile and isfile("fatality_v3.json") then 
            local data = HttpService:JSONDecode(readfile("fatality_v3.json"))
            for k,v in pairs(data) do Settings[k] = v end
        end 
    end

    -- Rage -> Aimbot (Iconos de la imagen)
    local AimbotSub = Rage.AddSubTab("Aimbot", "rbxassetid://10619092497") -- Icono de Rifle
    local AntiaimSub = Rage.AddSubTab("Anti-Aim", "rbxassetid://10619092956")

    local AACol = AntiaimSub.AddColumn("Anti-Aim Main")
    AACol.AddToggle("Enable Anti-Aim", function(v) Settings.Rage.AntiAim = v end, Settings.Rage.AntiAim)
    AACol.AddDropdown("Pitch", {"Down", "Up", "Zero"}, "Down", function(v) Settings.Rage.Pitch = v end)
    AACol.AddDropdown("Yaw", {"Spin", "Backwards", "Jitter"}, "Spin", function(v) Settings.Rage.Yaw = v end)
    
    local AASettings = AntiaimSub.AddColumn("Anti-Aim Settings")
    AASettings.AddSlider("Spin Speed", 1, 500, 100, function(v) Settings.Rage.SpinSpeed = v end)
    AASettings.AddSlider("Jitter Range", 1, 180, 45, function(v) Settings.Rage.JitterRange = v end)

    -- Legit -> Legit Bot
    local LegitBotSub = Legit.AddSubTab("Legit Bot", "rbxassetid://10619105435")
    
    local LegitAimbotCol = LegitBotSub.AddColumn("Legit Aimbot")
    LegitAimbotCol.AddToggle("Aimbot Enabled", function(v) Settings.Aimbot.Enabled = v end, Settings.Aimbot.Enabled)
    LegitAimbotCol.AddSlider("Field of View", 1, 360, 30, function(v) Settings.Aimbot.FOV = v end)
    LegitAimbotCol.AddSlider("Smoothing", 1, 100, 15, function(v) Settings.Aimbot.Smoothing = v end)
    LegitAimbotCol.AddToggle("Visible Check", function(v) Settings.Aimbot.VisibleCheck = v end, Settings.Aimbot.VisibleCheck)

    local TriggerCol = LegitBotSub.AddColumn("Triggerbot")
    TriggerCol.AddToggle("Triggerbot Enabled", function(v) Settings.Legit.Triggerbot = v end, Settings.Legit.Triggerbot)
    TriggerCol.AddSlider("Shot Delay (ms)", 0, 500, 50, function(v) Settings.Legit.TriggerDelay = v end)
    TriggerCol.AddToggle("Team Check", function(v) Settings.Legit.TriggerTeamCheck = v end, Settings.Legit.TriggerTeamCheck)

    -- Columna 1 (Auto)
    local ColAuto = AimbotSub.AddColumn("Auto")
    ColAuto.AddSlider("Hitchance (FOV)", 0, 500, 100, function(v) Settings.Aimbot.FOV = v end)
    ColAuto.AddSlider("Pointscale", 0, 100, 100, function(v) end)
    ColAuto.AddToggle("Override", function(v) end)
    ColAuto.AddSlider("Smoothing", 1, 25, 5, function(v) Settings.Aimbot.Smoothing = v end)
    ColAuto.AddSlider("Predict Factor", 0, 100, 16, function(v) Settings.Aimbot.PredictAmount = v / 100 end)

    -- Columna 3 (Aimbot - Los Toggles principales)
    local ColAimbot = AimbotSub.AddColumn("Aimbot")
    ColAimbot.AddToggle("Aimbot", function(v) 
        Settings.Aimbot.Enabled = v 
        if v then
            Notify("Rage Aimbot active. This is highly detectable!", Color3.fromRGB(255, 150, 0))
        end
    end, Settings.Aimbot.Enabled)
    ColAimbot.AddToggle("Team Check", function(v) Settings.Aimbot.TeamCheck = v end, Settings.Aimbot.TeamCheck)
    ColAimbot.AddToggle("Visible Check", function(v) Settings.Aimbot.VisibleCheck = v end, Settings.Aimbot.VisibleCheck)
    ColAimbot.AddToggle("Prediction", function(v) Settings.Aimbot.Prediction = v end, Settings.Aimbot.Prediction)
    ColAimbot.AddToggle("Show FOV Circle", function(v) Settings.Aimbot.ShowFOV = v end, Settings.Aimbot.ShowFOV)
    ColAimbot.AddToggle("Double tap", function(v) end)

    ColAimbot.AddDropdown("Aimbot Method", {"Mouse", "Camera"}, "Mouse", function(v) Settings.Aimbot.Method = v end)
    ColAimbot.AddDropdown("Target Part", {"Head", "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart"}, "Head", function(v) Settings.Aimbot.TargetPart = v end)
    
    -- Pestaña Visuals Reorganizada
    local PlayersSub = Visuals.AddSubTab("Players", "rbxassetid://10619091632")
    local EspCol = PlayersSub.AddColumn("Main ESP")
    EspCol.AddToggle("Enabled", function(v) Settings.ESP.Enabled = v end, Settings.ESP.Enabled)
    EspCol.AddToggle("Team Check", function(v) Settings.ESP.TeamCheck = v end, Settings.ESP.TeamCheck)
    
    local VisCol = PlayersSub.AddColumn("Visuals")
    VisCol.AddToggle("Boxes", function(v) Settings.ESP.Boxes = v end, Settings.ESP.Boxes)
    VisCol.AddToggle("Names", function(v) Settings.ESP.Names = v end, Settings.ESP.Names)
    VisCol.AddSlider("Text Size", 10, 24, 13, function(v) Settings.ESP.TextSize = v end)
    VisCol.AddSlider("Box Thickness", 1, 5, 1, function(v) Settings.ESP.BoxThickness = v end)
    VisCol.AddSlider("Skeleton Thickness", 1, 5, 1, function(v) Settings.ESP.SkeletonThickness = v end)
    VisCol.AddSlider("Tracer Thickness", 1, 5, 1, function(v) Settings.ESP.TracerThickness = v end)
    VisCol.AddToggle("Show Distance", function(v) Settings.ESP.ShowDistance = v end, Settings.ESP.ShowDistance)
    VisCol.AddDropdown("Distance Unit", {"studs", "meters"}, "studs", function(v) Settings.ESP.DistanceUnit = v end)
    VisCol.AddSlider("Max Distance", 100, 5000, 2000, function(v) Settings.ESP.MaxDistance = v end)
    VisCol.AddToggle("Health Bar", function(v) Settings.ESP.Health = v end, Settings.ESP.Health)
    VisCol.AddToggle("Health Text", function(v) Settings.ESP.HealthText = v end, Settings.ESP.HealthText)
    VisCol.AddToggle("Tracers", function(v) Settings.ESP.Tracers = v end, Settings.ESP.Tracers)
    VisCol.AddToggle("Target HUD", function(v) Settings.TargetHUD.Enabled = v end, Settings.TargetHUD.Enabled)
    VisCol.AddToggle("Skeleton", function(v) Settings.ESP.Skeleton = v end, Settings.ESP.Skeleton)

    local ColorCol = PlayersSub.AddColumn("ESP Colors")
    ColorCol.AddColorPicker("Enemy Color", Settings.ESP.EnemyColor, function(c) Settings.ESP.EnemyColor = c end)
    ColorCol.AddColorPicker("Ally Color", Settings.ESP.AllyColor, function(c) Settings.ESP.AllyColor = c end)

    local WorldSub = Visuals.AddSubTab("World", "rbxassetid://10619091140")
    local WorldCol = WorldSub.AddColumn("Environment")
    WorldCol.AddToggle("Nightmode", function(v) 
        Settings.World.Nightmode = v
        Lighting.ClockTime = v and 0 or 12
    end, Settings.World.Nightmode)
    WorldCol.AddSlider("Brightness", 0, 100, 100, function(v) 
        Settings.World.Brightness = v
        Lighting.Brightness = v / 50
    end)
    WorldCol.AddToggle("Fullbright", function(v) 
        Settings.World.Fullbright = v
        Lighting.Ambient = v and Color3.new(1,1,1) or OldLighting.Ambient
    end, Settings.World.Fullbright)
    WorldCol.AddToggle("No Fog", function(v) 
        Settings.World.NoFog = v
        Lighting.FogEnd = v and 9e9 or OldLighting.FogEnd
    end, Settings.World.NoFog)
    WorldCol.AddButton("Optimize Roblox", function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
        end
    end)

    local CrossSub = Visuals.AddSubTab("Crosshair", "rbxassetid://6034287535")
    local CrossCol = CrossSub.AddColumn("Custom Crosshair")
    CrossCol.AddToggle("Enabled", function(v) Crosshair_Settings.Enabled = v end, Crosshair_Settings.Enabled)
    CrossCol.AddToggle("Spin", function(v) Crosshair_Settings.Spin = v end, Crosshair_Settings.Spin)
    CrossCol.AddToggle("RGB Effect", function(v) Crosshair_Settings.RGB = v end, Crosshair_Settings.RGB)
    CrossCol.AddSlider("Spin Speed", 0, 500, 150, function(v) Crosshair_Settings.SpinSpeed = v end)
    CrossCol.AddSlider("Transparency", 0, 100, 0, function(v) Crosshair_Settings.Transparency = v / 100 end)
    CrossCol.AddSlider("Size", 1, 50, 12, function(v) Crosshair_Settings.Size = v end)
    CrossCol.AddSlider("Gap", 0, 20, 5, function(v) Crosshair_Settings.Gap = v end)
    CrossCol.AddSlider("Thickness", 1, 10, 2, function(v) Crosshair_Settings.Thickness = v end)
    CrossCol.AddToggle("Show Watermark", function(v) Crosshair_Settings.ShowWatermark = v end, Crosshair_Settings.ShowWatermark)
    CrossCol.AddToggle("Outline", function(v) Crosshair_Settings.Outline = v end, Crosshair_Settings.Outline)
    CrossCol.AddColorPicker("Outline Color", Crosshair_Settings.OutlineColor, function(v) Crosshair_Settings.OutlineColor = v end)
    CrossCol.AddToggle("T-Style", function(v) Crosshair_Settings.TStyle = v end, Crosshair_Settings.TStyle)
    CrossCol.AddToggle("Dot", function(v) Crosshair_Settings.Dot = v end, Crosshair_Settings.Dot)

    -- Misc Tab
    local MiscSub = Misc.AddSubTab("Main", "rbxassetid://10619093761")
    local MoveCol = MiscSub.AddColumn("Movement")
    
    MoveCol.AddToggle("Safety Protection", function(v) Settings.Misc.AntiCheatDetection = v end, Settings.Misc.AntiCheatDetection)
    MoveCol.AddToggle("Bhop", function(v) Settings.Misc.Bhop = v end, Settings.Misc.Bhop)
    MoveCol.AddToggle("Auto-strafe", function(v) Settings.Misc.Autostrafe = v end, Settings.Misc.Autostrafe)
    MoveCol.AddToggle("Fly (HIGH RISK)", function(v) 
        Settings.Misc.Fly = v 
        if v then
            Notify("Fly enabled. Use with extreme caution!", Color3.fromRGB(255, 150, 0))
        end
    end, Settings.Misc.Fly)
    MoveCol.AddSlider("Fly Speed", 1, 200, 50, function(v) Settings.Misc.FlySpeed = v end)
    
    MoveCol.AddToggle("Float (RISKY)", function(v) Settings.Misc.Float = v end, Settings.Misc.Float)
    MoveCol.AddSlider("Float Ascent (0.1s)", 0, 9, 4, function(v) Settings.Misc.FloatAscent = v / 10 end)
    MoveCol.AddSlider("Float Hover (0.1s)", 0, 9, 4, function(v) Settings.Misc.FloatHover = v / 10 end)
    MoveCol.AddSlider("Float Cooldown", 1, 10, 3, function(v) Settings.Misc.FloatCooldown = v end)
    
    MoveCol.AddToggle("Spider", function(v) Settings.Misc.Spider = v end, Settings.Misc.Spider)
    MoveCol.AddToggle("Silent Walk", function(v) Settings.Misc.SilentWalk = v end, Settings.Misc.SilentWalk)

    MoveCol.AddToggle("Speed Hack (RISKY)", function(v) 
        Settings.Misc.SpeedHack = v 
        if v then
            Notify("Speed Hack enabled. Use with extreme caution!", Color3.fromRGB(255, 100, 0))
        end
    end, Settings.Misc.SpeedHack)
    MoveCol.AddSlider("Speed Value", 16, 200, 16, function(v) Settings.Misc.SpeedValue = v end)
    MoveCol.AddToggle("Noclip (HIGH RISK)", function(v) 
        Settings.Misc.Noclip = v 
        if v then
            Notify("Noclip is active. High ban risk detected!", Color3.fromRGB(255, 50, 0))
        end
    end, Settings.Misc.Noclip)
    MoveCol.AddToggle("Infinite Jump", function(v) 
        Settings.Misc.InfiniteJump = v 
        if v then
            Notify("Infinite Jump active. May flag some anti-cheats.", Color3.fromRGB(255, 200, 0))
        end
    end, Settings.Misc.InfiniteJump)
    MoveCol.AddButton("Warning: Use at your own risk", function() end)

    local OtherCol = MiscSub.AddColumn("Other")
    OtherCol.AddToggle("Anti-AFK", function(v) Settings.Misc.AntiAFK = v end, Settings.Misc.AntiAFK)
    OtherCol.AddButton("Server Hop", function() 
        game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
    end)

    -- Lua Tab (Advanced Executor)
    local Lua = AddMainTab("Lua")
    local LuaSub = Lua.AddSubTab("Executor", "rbxassetid://10619093761")
    
    -- Columna: Editor Principal
    local LuaCol = LuaSub.AddColumn("Editor")
    local scriptBox = LuaCol.AddTextBox("-- Enter your script here...\nprint('Hello from Fatality!')")
    
    LuaCol.AddButton("Run Script", function()
        local code = scriptBox.Text
        if code == "" then return end
        local func, err = loadstring(code)
        if func then
            local success, fault = pcall(func)
            if success then
                Notify("Script executed successfully!", Color3.fromRGB(0, 255, 120))
            else
                Notify("Runtime Error: " .. tostring(fault), Color3.fromRGB(255, 50, 0))
            end
        else
            Notify("Syntax Error: " .. tostring(err), Color3.fromRGB(255, 0, 0))
        end
    end)
    
    LuaCol.AddButton("Clear Editor", function() scriptBox.Text = "" end)
    
    -- Columna: Utilidades y Web
    local LuaUtil = LuaSub.AddColumn("Utilities")
    
    LuaUtil.AddButton("Run from Clipboard", function()
        if getclipboard then
            local code = getclipboard()
            local func, err = loadstring(code)
            if func then pcall(func) else Notify("Clipboard Error: "..tostring(err), Color3.new(1,0,0)) end
        else
            Notify("getclipboard not supported", Color3.new(1,0,0))
        end
    end)
    
    local urlInput = LuaUtil.AddInput("URL Script (HttpGet)")
    LuaUtil.AddButton("Run from URL", function()
        local url = urlInput.Text
        if url ~= "" then
            local success, content = pcall(function() return game:HttpGet(url) end)
            if success then
                local func, err = loadstring(content)
                if func then pcall(func) else Notify("URL Compile Error", Color3.new(1,0,0)) end
            else
                Notify("HTTP Get Failed", Color3.new(1,0,0))
            end
        end
    end)

    -- Columna: Gestor de Archivos
    local LuaFiles = LuaSub.AddColumn("File Manager")
    local fileName = LuaFiles.AddInput("script_name.lua")
    
    LuaFiles.AddButton("Save to File", function()
        if writefile and fileName.Text ~= "" then
            writefile(fileName.Text, scriptBox.Text)
            Notify("Saved: "..fileName.Text, Color3.new(0,1,0))
        end
    end)
    
    LuaFiles.AddButton("Load from File", function()
        if readfile and isfile and isfile(fileName.Text) then
            scriptBox.Text = readfile(fileName.Text)
            Notify("Loaded: "..fileName.Text, Color3.new(0,1,0))
        else
            Notify("File not found", Color3.new(1,0,0))
        end
    end)

    -- Columna: Script Hub
    local ScriptHub = LuaSub.AddColumn("Script Hub")
    ScriptHub.AddButton("Infinite Yield", function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end)
    ScriptHub.AddButton("Dex Explorer", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end)
    ScriptHub.AddButton("Simple Spy", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpy/master/SimpleSpySource.lua"))()
    end)

    -- Settings / Config Tab
    local SettingsSub = ConfigTab.AddSubTab("Config", "rbxassetid://10619105435")
    local MainConf = SettingsSub.AddColumn("Configuration")
    MainConf.AddButton("Save Config", Save)
    MainConf.AddButton("Load Config", Load)

    local UICol = SettingsSub.AddColumn("UI Customization")
    UICol.AddColorPicker("Background Color", Settings.UI.Background, function(c)
        Settings.UI.Background = c
        main.BackgroundColor3 = c
        innerBorder.BackgroundColor3 = c
        sidePanel.BackgroundColor3 = c
        infoMain.BackgroundColor3 = c
    end)
    UICol.AddColorPicker("Panel Color", Settings.UI.Panel, function(c)
        Settings.UI.Panel = c
        sInner.BackgroundColor3 = c
        infoInner.BackgroundColor3 = c
    end)
    UICol.AddColorPicker("Border Gradient Top", Settings.UI.BorderStart, function(c)
        Settings.UI.BorderStart = c
        local seq = ColorSequence.new(c, Settings.UI.BorderEnd)
        outerGrad.Color = seq; sOuterGrad.Color = seq; iOuterGrad.Color = seq
    end)
    UICol.AddColorPicker("Border Gradient Bottom", Settings.UI.BorderEnd, function(c)
        Settings.UI.BorderEnd = c
        local seq = ColorSequence.new(Settings.UI.BorderStart, c)
        outerGrad.Color = seq; sOuterGrad.Color = seq; iOuterGrad.Color = seq
    end)
    
    local MenuCol = SettingsSub.AddColumn("Menu Settings")
    MenuCol.AddToggle("Menu Visibility", function(v)
        main.Visible = not main.Visible
        CrossGui.Enabled = main.Visible
    end, true)

    local IndCol = SettingsSub.AddColumn("Indicators")
    IndCol.AddToggle("Global Enabled", function(v) Settings.Indicators.Enabled = v end, Settings.Indicators.Enabled)
    IndCol.AddToggle("Hide with Menu", function(v) Settings.Indicators.HideWithMenu = v end, Settings.Indicators.HideWithMenu)
    IndCol.AddToggle("Show Watermark", function(v) Settings.Indicators.ShowWatermark = v end, Settings.Indicators.ShowWatermark)
    IndCol.AddToggle("Show FPS", function(v) Settings.Indicators.ShowFPS = v end, Settings.Indicators.ShowFPS)
    IndCol.AddToggle("Show Ping", function(v) Settings.Indicators.ShowPing = v end, Settings.Indicators.ShowPing)
    IndCol.AddToggle("Show Time", function(v) Settings.Indicators.ShowTime = v end, Settings.Indicators.ShowTime)
    IndCol.AddToggle("Show Uptime", function(v) Settings.Indicators.ShowUptime = v end, Settings.Indicators.ShowUptime)
end

BuildFatalityUI()

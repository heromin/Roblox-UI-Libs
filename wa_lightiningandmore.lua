local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LightingMore = {
    CrosshairLines = {
        T = Drawing.new("Line"), B = Drawing.new("Line"), 
        L = Drawing.new("Line"), R = Drawing.new("Line")
    },
    CrosshairText = Drawing.new("Text"),
    CrosshairDot = Drawing.new("Circle")
}

-- Configuración inicial Crosshair
for _, line in pairs(LightingMore.CrosshairLines) do
    line.Visible = false
    line.Thickness = 1.5
    line.Transparency = 1
    line.Color = Color3.new(1, 1, 1)
end

LightingMore.CrosshairDot.Visible = false
LightingMore.CrosshairDot.Filled = true
LightingMore.CrosshairDot.Transparency = 1
LightingMore.CrosshairDot.Color = Color3.new(1, 1, 1)

LightingMore.CrosshairText.Visible = false
LightingMore.CrosshairText.Center = true
LightingMore.CrosshairText.Outline = true
LightingMore.CrosshairText.Font = 2
LightingMore.CrosshairText.Size = 13

function LightingMore:UpdateCrosshair()
    local enabled = getgenv().CrosshairEnabled
    if not enabled then 
        for _, l in pairs(self.CrosshairLines) do l.Visible = false end
        self.CrosshairText.Visible = false
        self.CrosshairDot.Visible = false
        return 
    end

    local center = (getgenv().CrosshairFollowMouse and UIS:GetMouseLocation()) or (Camera.ViewportSize / 2)
    local size = getgenv().CrosshairSize or 10
    local gap = getgenv().CrosshairGap or 5
    local color = getgenv().CrosshairColor or Color3.new(1, 1, 1)
    local thickness = getgenv().CrosshairThickness or 1.5
    local rotation = getgenv().CrosshairRotation or 0

    if getgenv().CrosshairRotating then
        rotation = (tick() * (getgenv().CrosshairRotationSpeed or 2) * 50) % 360
    end

    local function rotate(vec, deg)
        local rad = math.rad(deg)
        local cos, sin = math.cos(rad), math.sin(rad)
        return Vector2.new(vec.X * cos - vec.Y * sin, vec.X * sin + vec.Y * cos)
    end

    local lines = self.CrosshairLines
    lines.T.From = center + rotate(Vector2.new(0, -gap - size), rotation); lines.T.To = center + rotate(Vector2.new(0, -gap), rotation)
    lines.B.From = center + rotate(Vector2.new(0, gap), rotation); lines.B.To = center + rotate(Vector2.new(0, gap + size), rotation)
    lines.L.From = center + rotate(Vector2.new(-gap - size, 0), rotation); lines.L.To = center + rotate(Vector2.new(-gap, 0), rotation)
    lines.R.From = center + rotate(Vector2.new(gap, 0), rotation); lines.R.To = center + rotate(Vector2.new(gap + size, 0), rotation)

    for _, l in pairs(lines) do 
        l.Visible = true 
        l.Color = color
        l.Thickness = thickness
    end

    -- Watermark de la Crosshair
    local watermark = self.CrosshairText
    local textContent = getgenv().CrosshairWatermark or ""
    if getgenv().CrosshairWatermarkEnabled and textContent ~= "" then
        watermark.Visible = true
        watermark.Text = textContent
        watermark.Color = color
        watermark.Position = center + Vector2.new(0, gap + size + 8)
    else
        watermark.Visible = false
    end

    -- Dot central
    local dot = self.CrosshairDot
    if getgenv().CrosshairDotEnabled then
        dot.Visible = true
        dot.Color = color
        dot.Position = center
        dot.Radius = getgenv().CrosshairDotSize or 2
    else
        dot.Visible = false
    end
end

-- Bucle de actualización para el Crosshair
RunService.RenderStepped:Connect(function()
    LightingMore:UpdateCrosshair()
end)

-- Función para Foliage en SpawnerZones
function LightingMore:SetSpawnerFoliage(state)
    local zones = workspace:FindFirstChild("SpawnerZones")
    if not zones then return end
    
    for _, obj in pairs(zones:GetDescendants()) do
        if obj:IsA("BasePart") then
            local mat = obj.Material
            if mat == Enum.Material.Grass or mat == Enum.Material.LeafyGrass or obj.Name:lower():find("leaf") or obj.Name:lower():find("foliage") then
                obj.Transparency = state and 1 or 0
            end
        end
    end
end

-- Funciones de Atmósfera
local function getAtm()
    local a = Lighting:FindFirstChildOfClass("Atmosphere")
    if not a then
        a = Instance.new("Atmosphere", Lighting)
    end
    return a
end

function LightingMore:SetTime(val)
    Lighting.ClockTime = val
end

function LightingMore:SetFOV(val)
    Camera.FieldOfView = val
end

function LightingMore:SetAtmosphereDensity(val)
    getAtm().Density = val
end

function LightingMore:SetAtmosphereHaze(val)
    getAtm().Haze = val
end

function LightingMore:SetAtmosphereColor(color)
    getAtm().Color = color
end

function LightingMore:SetAtmosphereDecay(color)
    getAtm().Decay = color
end

-- Observador para nuevos objetos en SpawnerZones
task.spawn(function()
    local zones = workspace:WaitForChild("SpawnerZones", 10)
    if zones then
        zones.DescendantAdded:Connect(function(obj)
            if getgenv().RemoveSpawnerFoliage and obj:IsA("BasePart") then
                local mat = obj.Material
                if mat == Enum.Material.Grass or mat == Enum.Material.LeafyGrass or obj.Name:lower():find("leaf") then
                    obj.Transparency = 1
                end
            end
        end)
    end
end)

return LightingMore

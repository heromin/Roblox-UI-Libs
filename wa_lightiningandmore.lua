local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LightingMore = {
    CrosshairLines = {
        T = Drawing.new("Line"), B = Drawing.new("Line"), 
        L = Drawing.new("Line"), R = Drawing.new("Line")
    }
}

-- Configuración inicial Crosshair
for _, line in pairs(LightingMore.CrosshairLines) do
    line.Visible = false
    line.Thickness = 1.5
    line.Transparency = 1
    line.Color = Color3.new(1, 1, 1)
end

function LightingMore:UpdateCrosshair()
    local enabled = getgenv().CrosshairEnabled
    if not enabled then 
        for _, l in pairs(self.CrosshairLines) do l.Visible = false end 
        return 
    end

    local center = Camera.ViewportSize / 2
    local size = getgenv().CrosshairSize or 10
    local gap = getgenv().CrosshairGap or 5
    local color = getgenv().CrosshairColor or Color3.new(1, 1, 1)
    local thickness = getgenv().CrosshairThickness or 1.5

    local lines = self.CrosshairLines
    lines.T.From = center - Vector2.new(0, gap + size); lines.T.To = center - Vector2.new(0, gap)
    lines.B.From = center + Vector2.new(0, gap); lines.B.To = center + Vector2.new(0, gap + size)
    lines.L.From = center - Vector2.new(gap + size, 0); lines.L.To = center - Vector2.new(gap, 0)
    lines.R.From = center + Vector2.new(gap, 0); lines.R.To = center + Vector2.new(gap + size, 0)

    for _, l in pairs(lines) do 
        l.Visible = true 
        l.Color = color
        l.Thickness = thickness
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

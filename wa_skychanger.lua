-- Skybox and Cloud Changer
local SkyChanger = {}
local Lighting = game:GetService("Lighting")

local Presets = {
    ["Galaxy"] = "rbxassetid://159454299",
    ["Night"] = "rbxassetid://15470149279",
    ["Sunset"] = "rbxassetid://458016711"
}

function SkyChanger:SetPreset(name)
    local sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)
    local id = Presets[name] or "rbxassetid://0"
    sky.SkyboxBk = id; sky.SkyboxDn = id; sky.SkyboxFt = id; sky.SkyboxLf = id; sky.SkyboxRt = id; sky.SkyboxUp = id
end

function SkyChanger:SetClouds(density)
    local clouds = workspace.Terrain:FindFirstChildOfClass("Clouds")
    if clouds then clouds.Density = density end
end

return SkyChanger

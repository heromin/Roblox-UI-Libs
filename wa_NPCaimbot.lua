-- NPC Combat Module (Integrated with Amber UI & Inari Logic)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Global NPC Combat Settings
getgenv().NPCAimbotEnabled = getgenv().NPCAimbotEnabled or false
getgenv().NPCSilentAimEnabled = getgenv().NPCSilentAimEnabled or false
getgenv().NPCTargetPart = getgenv().NPCTargetPart or "Head"
getgenv().NPCAimbotSmoothness = getgenv().NPCAimbotSmoothness or 1
getgenv().NPCWallCheck = getgenv().NPCWallCheck or false
getgenv().NPCFOVRadius = getgenv().NPCFOVRadius or 100
getgenv().NPCShowFOV = getgenv().NPCShowFOV or false

-- Identify valid NPCs (Logic synced with wa_esp.lua)
local validNPCNames = {}
local function CacheNPCs()
    local RS = game:GetService("ReplicatedStorage")
    local presets = RS:FindFirstChild("AiPresets")
    if presets then
        for _, v in pairs(presets:GetChildren()) do validNPCNames[v.Name] = true end
    end
end
task.spawn(CacheNPCs)

local function isTargetableNPC(model)
    if not model or not model:IsA("Model") then return false end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if not (hum and hum.Health > 0) then return false end
    
    local name = model:GetAttribute("DisplayName") or model:GetAttribute("CallSign") or model.Name
    if validNPCNames[name] or model:GetAttribute("Preset") then return true end
    
    -- Workspace folder checks
    if model.Parent and (model.Parent.Name == "AIs" or model.Parent.Name == "AiZones") then return true end
    return false
end

local function checkVisibility(targetPart, targetCharacter)
    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetCharacter, Camera}
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

local function getClosestNPCToMouse()
    local shortestDistance = math.huge
    local target = nil
    local part = nil
    local mousePos = UIS:GetMouseLocation()

    local function scan(obj)
        if not obj then return end
        for _, v in pairs(obj:GetChildren()) do
            if v:IsA("Model") and isTargetableNPC(v) then
                local hitPart = v:FindFirstChild(getgenv().NPCTargetPart)
                if hitPart then
                    local pos, visible = Camera:WorldToViewportPoint(hitPart.Position)
                    if visible then
                        if getgenv().NPCWallCheck and not checkVisibility(hitPart, v) then continue end
                        local dist = (mousePos - Vector2.new(pos.X, pos.Y)).Magnitude
                        if dist < shortestDistance and dist <= (getgenv().NPCShowFOV and getgenv().NPCFOVRadius or math.huge) then
                            shortestDistance = dist
                            target = v
                            part = hitPart
                        end
                    end
                end
            elseif v:IsA("Folder") then scan(v) end
        end
    end

    scan(workspace:FindFirstChild("AIs"))
    scan(workspace:FindFirstChild("AiZones"))
    return target, part
end

-- FOV Circle logic (NPC Specific)
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = Color3.fromRGB(255, 50, 50)
fovCircle.Thickness = 1.5
fovCircle.NumSides = 64
fovCircle.Filled = false
fovCircle.Transparency = 0.8

local isLocking = false
UIS.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton2 then isLocking = true end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton2 then isLocking = false end end)

RunService.RenderStepped:Connect(function(deltaTime)
    fovCircle.Position = UIS:GetMouseLocation()
    fovCircle.Radius = getgenv().NPCFOVRadius
    fovCircle.Visible = getgenv().NPCShowFOV

    if getgenv().NPCAimbotEnabled and isLocking then
        local _, part = getClosestNPCToMouse()
        if part then
            local targetCFrame = CFrame.new(Camera.CFrame.Position, part.Position)
            local smoothness = getgenv().NPCAimbotSmoothness or 1
            if smoothness > 1 then
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 1/smoothness)
            else
                Camera.CFrame = targetCFrame
            end
        end
    end
end)

-- Silent Aim Hook for NPCs
local BulletModule = nil
pcall(function() BulletModule = require(game:GetService("ReplicatedStorage").Modules.FPS.Bullet) end)

if BulletModule and BulletModule.CreateBullet and hookfunction and newcclosure then
    local OldBullet; OldBullet = hookfunction(BulletModule.CreateBullet, newcclosure(function(...)
        local Args = {...}
        if not checkcaller() and Args[5] and typeof(Args[5]) == "Instance" and getgenv().NPCSilentAimEnabled then
            local Target, Part = getClosestNPCToMouse()
            if Target and Part then
                local Success, ShotCFrame = pcall(function() return Args[5].CFrame end)
                if Success then
                    Args[5].CFrame = CFrame.new(ShotCFrame.Position, Part.Position)
                end
            end
        end
        return OldBullet(table.unpack(Args))
    end))
end

return { GetTarget = getClosestNPCToMouse }

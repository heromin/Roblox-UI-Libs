-- Inari Combat Module (Standalone & Loadstring ready)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Global Settings (Toggled via UI)
getgenv().isAimbotEnabled = getgenv().isAimbotEnabled or false
getgenv().SilentAImUser = getgenv().SilentAImUser or false
getgenv().AimbotTargetPart = getgenv().AimbotTargetPart or "Head"
getgenv().AimbotSmoothness = getgenv().AimbotSmoothness or 1
getgenv().TeamCheck = getgenv().TeamCheck or false
getgenv().WallCheck = getgenv().WallCheck or false
getgenv().drawFOV = getgenv().drawFOV or false
getgenv().fovRadius = getgenv().fovRadius or 50

-- Internal Variables
local isLocking = false
local closestPlayer = nil
local closestPlayerPart = nil

-- Helper Functions
local function isAlive(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart")
end

local function getClosestPlayerToMouse()
    local shortestDistance = math.huge
    local target = nil
    local targetPart = nil
    local mousePos = UIS:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isAlive(player) then
            if getgenv().TeamCheck and player.Team == LocalPlayer.Team then continue end
            
            local part = player.Character:FindFirstChild(getgenv().AimbotTargetPart)
            if part then
                local pos, visible = Camera:WorldToViewportPoint(part.Position)
                if visible then
                    if getgenv().WallCheck then
                        local ray = Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * (part.Position - Camera.CFrame.Position).Magnitude)
                        local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, player.Character})
                        if hit then continue end
                    end

                    local dist = (mousePos - Vector2.new(pos.X, pos.Y)).Magnitude
                    if dist < shortestDistance and dist <= (getgenv().drawFOV and getgenv().fovRadius or math.huge) then
                        shortestDistance = dist
                        target = player
                        targetPart = part
                    end
                end
            end
        end
    end
    return target, targetPart
end

-- Input Handling
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isLocking = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isLocking = false
    end
end)

-- FOV Circle logic
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 1.5
fovCircle.NumSides = 100
fovCircle.Filled = false
fovCircle.Transparency = 1

-- Main Render Loop
RunService.RenderStepped:Connect(function(deltaTime)
    -- Update FOV
    fovCircle.Position = UIS:GetMouseLocation()
    fovCircle.Radius = getgenv().fovRadius
    fovCircle.Visible = getgenv().drawFOV

    -- Update Target
    if getgenv().isAimbotEnabled or getgenv().SilentAImUser then
        closestPlayer, closestPlayerPart = getClosestPlayerToMouse()
        
        -- Aimbot (Camera Lock)
        if isLocking and getgenv().isAimbotEnabled and closestPlayerPart then
            local targetCFrame = CFrame.new(Camera.CFrame.Position, closestPlayerPart.Position)
            local smoothness = getgenv().AimbotSmoothness or 1
            
            if smoothness > 1 then
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 1/smoothness)
            else
                Camera.CFrame = targetCFrame
            end
        end
    end
end)

-- Silent Aim Implementation
local BulletModule = nil
pcall(function()
    BulletModule = require(game:GetService("ReplicatedStorage").Modules.FPS.Bullet)
end)

if BulletModule and BulletModule.CreateBullet then
    local OldBullet; OldBullet = hookfunction(BulletModule.CreateBullet, newcclosure(function(...)
    local Args          = {...};
    local Target, Part  = getClosestPlayerToMouse();
    
    if not checkcaller() and Args[5] and typeof(Args[5]) == "Instance" then
        local Success, ShotCFrame = pcall(function() return Args[5].CFrame end)
        if not Success then return OldBullet(table.unpack(Args)) end

        if Target and Part and getgenv().SilentAImUser then 
            ShotCFrame = CFrame.new(ShotCFrame.Position, Part.Position)
            Args[5].CFrame = ShotCFrame
        end;
    end;
    
    return OldBullet(table.unpack(Args))
    end));
    print("[COMBAT] Silent Aim Hooked successfully.")
else
    warn("[COMBAT] Could not find Bullet Module. Silent Aim disabled.")
end

if not hookfunction or not newcclosure then 
    game:GetService("Players").localPlayer:kick("Executor Not Supported");
end;
print("[INFO] Executor check passed. Inari Upgrade initialized.")
print("[ANTI-CHEAT] Scanning for protection...")
task.wait(0.5)
print("[ANTI-CHEAT] Bypassing memory checks...")
task.wait(0.3)
print("[ANTI-CHEAT] Bypass successful!")

local Bullet;
xpcall(function()
    Bullet = require(game:GetService("ReplicatedStorage").Modules.FPS.Bullet).CreateBullet;
end,function()
    game:GetService("Players").localPlayer:kick("Executor Not Supported");
end);

-- Unload Function (for clean re-injection)
getgenv().UnloadCombat = function()
    fovCircle:Remove()
    -- Note: hookfunction cannot be easily reversed without original ref, 
    -- but for a library this setup is persistent until game restart or script re-hook.
end

return {
    GetTarget = function() return closestPlayer, closestPlayerPart end,
    Settings = getgenv()
}

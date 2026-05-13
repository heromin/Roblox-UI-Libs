--Functions Load
-- [ DEPENDENCIES ] --
local Library     = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa.lua"))()
local Combat      = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa_aimbot%2Bsilentaim.lua"))()
local CombatFuncs = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa_hitimplementations.lua"))()
local Inventory   = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa_inventoryviewer.lua"))()
local esp         = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa_esp.lua"))()
local NPCAimbot   = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa_NPCaimbot.lua"))()
local GunMods     = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa_gunmods.lua"))()
local LightingMod = loadstring(game:HttpGet("https://raw.githubusercontent.com/heromin/Roblox-UI-Libs/refs/heads/main/wa_lightiningandmore.lua"))() -- Asumiendo carga local o remota

-- [ SERVICES ] --
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local Players    = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- [ INITIALIZATION ] --
Inventory:Init()
esp:Init()
local Watermark = Library:Watermark("amber.lol | " .. os.date("%b %d, %Y"))

-- [ WINDOW CONFIGURATION ] --
local Window      = Library:CreateWindow("amber.lol", os.date("%b %d, %Y"))
local TabCombat   = Window:AddTab("Combat")
local TabVisuals  = Window:AddTab("Visual")
local TabMovement = Window:AddTab("Movement")
local TabPlayers  = Window:AddTab("Players")
local TabSettings = Window:AddTab("Settings")

-- ==========================================
-- [ TAB: COMBAT ]
-- ==========================================

-- Main Aimbot
local Aimbot_Section = TabCombat:AddSection("Aimbot", "Left")
TabCombat:AddCheckbox(Aimbot_Section, "Enable Aimbot", false, function(state) getgenv().isAimbotEnabled = state end):AddKeybind(Enum.KeyCode.F)
TabCombat:AddCheckbox(Aimbot_Section, "Silent Aim", false, function(state) getgenv().SilentAImUser = state end):AddKeybind(Enum.KeyCode.G)
TabCombat:AddDropdown(Aimbot_Section, "Target Part", {"Head", "HumanoidRootPart", "UpperTorso"}, "Head", function(val) getgenv().AimbotTargetPart = val end)
TabCombat:AddCheckbox(Aimbot_Section, "Fixed Lock-on", false, function(state) getgenv().AimbotLockTarget = state end)
TabCombat:AddSlider(Aimbot_Section, "Smoothness", 1, 20, 1, function(val) getgenv().AimbotSmoothness = val end)

local Triggerbot_Section = TabCombat:AddSection("Triggerbot", "Right")
TabCombat:AddCheckbox(Triggerbot_Section, "Enable Triggerbot", false, function(state) getgenv().TriggerbotEnabled = state end):AddKeybind(Enum.KeyCode.T)
TabCombat:AddSlider(Triggerbot_Section, "Delay (s)", 0, 1, 0, function(val) getgenv().TriggerbotDelay = val end)

local Checks_Section = TabCombat:AddSection("Checks", "Right")
TabCombat:AddCheckbox(Checks_Section, "Team Check", false, function(state) getgenv().TeamCheck = state end)
TabCombat:AddCheckbox(Checks_Section, "Wall Check", false, function(state) getgenv().WallCheck = state end)
TabCombat:AddCheckbox(Checks_Section, "Show FOV", false, function(state) getgenv().drawFOV = state end)
TabCombat:AddSlider(Checks_Section, "FOV Radius", 30, 500, 50, function(val) getgenv().fovRadius = val end)

-- Gun Modifications
local GunMods_Section = TabCombat:AddSection("Gun Mods", "Left")
TabCombat:AddCheckbox(GunMods_Section, "No Recoil", false, function(state) GunMods:SetNoRecoil(state) end)
TabCombat:AddCheckbox(GunMods_Section, "No Spread", false, function(state) GunMods:SetNoSpread(state) end)
TabCombat:AddCheckbox(GunMods_Section, "No Drag", false, function(state) GunMods:SetNoDrag(state) end)
TabCombat:AddCheckbox(GunMods_Section, "No Drop", false, function(state) GunMods:SetNoDrop(state) end)
TabCombat:AddCheckbox(GunMods_Section, "Instant Aim", false, function(state) getgenv().instantzoom = state end)

-- NPC Combat
local NPCAimbot_Section = TabCombat:AddSection("NPC Combat", "Left")
TabCombat:AddCheckbox(NPCAimbot_Section, "NPC Aimbot", false, function(state) getgenv().NPCAimbotEnabled = state end):AddKeybind(Enum.KeyCode.H)
TabCombat:AddCheckbox(NPCAimbot_Section, "NPC Silent Aim", false, function(state) getgenv().NPCSilentAimEnabled = state end):AddKeybind(Enum.KeyCode.J)
TabCombat:AddDropdown(NPCAimbot_Section, "NPC Target Part", {"Head", "HumanoidRootPart", "UpperTorso"}, "Head", function(val) getgenv().NPCTargetPart = val end)
TabCombat:AddCheckbox(NPCAimbot_Section, "NPC Fixed Lock-on", false, function(state) getgenv().NPCAimbotLockTarget = state end):AddKeybind(Enum.KeyCode.X)
TabCombat:AddSlider(NPCAimbot_Section, "NPC Smoothness", 1, 20, 1, function(val) getgenv().NPCAimbotSmoothness = val end)
TabCombat:AddCheckbox(NPCAimbot_Section, "NPC Wall Check", false, function(state) getgenv().NPCWallCheck = state end)

-- ==========================================
-- [ TAB: VISUALS ]
-- ==========================================

local PlayerESP_Section = TabVisuals:AddSection("Players", "Left")
TabVisuals:AddCheckbox(PlayerESP_Section, "Enable ESP", false, function(state)
    getgenv().ESP_Enabled = state
end):AddKeybind(Enum.KeyCode.V)
TabVisuals:AddCheckbox(PlayerESP_Section, "Boxes", false, function(state) getgenv().ShowBox = state end)
TabVisuals:AddDropdown(PlayerESP_Section, "Box Type", {"2D", "Corner Box Esp"}, "2D", function(val) getgenv().BoxType = val end)
TabVisuals:AddColorPicker(PlayerESP_Section, "Box Color", Color3.new(1,1,1), function(color) getgenv().BoxColor = color end)
TabVisuals:AddCheckbox(PlayerESP_Section, "Health Bar", false, function(state) getgenv().ShowHealth = state end)
TabVisuals:AddCheckbox(PlayerESP_Section, "Names", false, function(state) getgenv().ShowName = state end)
TabVisuals:AddCheckbox(PlayerESP_Section, "Skeletons", false, function(state) getgenv().ShowSkeletons = state end)
TabVisuals:AddCheckbox(PlayerESP_Section, "Tracers", false, function(state) getgenv().ShowTracer = state end)
TabVisuals:AddColorPicker(PlayerESP_Section, "Tracer Color", Color3.new(1,1,1), function(color) getgenv().TracerColor = color end)
TabVisuals:AddCheckbox(PlayerESP_Section, "Distance", false, function(state) getgenv().ShowDistance = state end)
TabVisuals:AddSlider(PlayerESP_Section, "Max Distance", 100, 5000, 2000, function(val) getgenv().MaxDistance = val end)
TabVisuals:AddCheckbox(PlayerESP_Section, "Team Check", false, function(state) getgenv().TeamCheck = state end)
TabVisuals:AddCheckbox(PlayerESP_Section, "Wall Check", false, function(state) getgenv().WallCheck = state end)

local WorldESP_Section = TabVisuals:AddSection("Environment", "Left")
TabVisuals:AddCheckbox(WorldESP_Section, "Container ESP", false, function(state) getgenv().ContainerESP = state end):AddKeybind(Enum.KeyCode.P)
TabVisuals:AddSlider(WorldESP_Section, "Container Distance", 100, 2000, 200, function(val) getgenv().ContainerRenderDistance = val end)
TabVisuals:AddCheckbox(WorldESP_Section, "Vehicle ESP", false, function(state) getgenv().Vehicle_ESP = state end)
TabVisuals:AddSlider(WorldESP_Section, "Vehicle Distance", 100, 5000, 2000, function(val) getgenv().VehicleRenderDistance = val end)
TabVisuals:AddCheckbox(WorldESP_Section, "NPC ESP", false, function(state) getgenv().NPC_ESP = state end)
TabVisuals:AddSlider(WorldESP_Section, "NPC Distance", 100, 5000, 1500, function(val) getgenv().NPCRenderDistance = val end)
TabVisuals:AddCheckbox(WorldESP_Section, "Dropped Items", false, function(state) getgenv().DroppedItemESP = state end)
TabVisuals:AddSlider(WorldESP_Section, "Dropped Item Distance", 100, 2000, 200, function(val) getgenv().DroppedItemRenderDistance = val end)
TabVisuals:AddCheckbox(WorldESP_Section, "Player Loot", false, function(state) getgenv().PlayerLootESP = state end)

local Tracers_Section = TabVisuals:AddSection("Bullet Tracers", "Right")
TabVisuals:AddCheckbox(Tracers_Section, "Enabled", false, function(state) getgenv().BulletTracers = state end)
TabVisuals:AddDropdown(Tracers_Section, "Design", {"Default", "Lightning", "Image", "Beam"}, "Default", function(val) getgenv().TracerDesign = val end)
TabVisuals:AddSlider(Tracers_Section, "Lifetime", 0.1, 5, 0.3, function(val) getgenv().BulletTracersLifetime = val end)
TabVisuals:AddSlider(Tracers_Section, "Thickness", 0.01, 1, 0.05, function(val) getgenv().TracerThickness = val end)
TabVisuals:AddTextbox(Tracers_Section, "Texture ID", "rbxassetid://18837739", function(val) getgenv().TracerTextureID = val end)
TabVisuals:AddColorPicker(Tracers_Section, "Tracer Color", Color3.fromRGB(131, 194, 242), function(color) getgenv().TracerColor = color end)

local Hitmarkers_Section = TabVisuals:AddSection("Hitmarkers", "Right")
TabVisuals:AddCheckbox(Hitmarkers_Section, "Enabled", false, function(state) getgenv().HitMarkers = state end)
TabVisuals:AddCheckbox(Hitmarkers_Section, "Center Hitmarker", false, function(state) getgenv().CenterHitmarker = state end)
TabVisuals:AddDropdown(Hitmarkers_Section, "Type", {"X", "Cross", "Circle"}, "X", function(val) getgenv().HitmarkerType = val end)
TabVisuals:AddSlider(Hitmarkers_Section, "Size", 1, 30, 7, function(val) getgenv().HitmarkersSize = val end)
TabVisuals:AddSlider(Hitmarkers_Section, "Lifetime", 0.1, 2, 0.4, function(val) getgenv().HitmarkersLifetime = val end)
TabVisuals:AddColorPicker(Hitmarkers_Section, "Marker Color", Color3.fromRGB(255, 255, 255), function(color) getgenv().HitmarkersColor = color end)

local HitFeedback_Section = TabVisuals:AddSection("Feedback", "Right")
TabVisuals:AddCheckbox(HitFeedback_Section, "Hit Sounds", false, function(state) getgenv().HitSound = state end)
TabVisuals:AddDropdown(HitFeedback_Section, "Sound Type", {"Bell", "Skeet", "Neverlose", "Metallic", "Bubble"}, "Bell", function(val) getgenv().SelectedHitSound = val end)
TabVisuals:AddSlider(HitFeedback_Section, "Sound Volume", 0, 10, 2, function(val) getgenv().HitSoundVolume = val end)
TabVisuals:AddCheckbox(HitFeedback_Section, "Hit Logs", false, function(state) getgenv().HitLogsEnabled = state end)
TabVisuals:AddSlider(HitFeedback_Section, "Log Lifetime", 1, 30, 5, function(val) getgenv().HitLogsLifetime = val end)
TabVisuals:AddDropdown(HitFeedback_Section, "Log Font", {"UI", "System", "Plex", "Monospace"}, "Monospace", function(val) 
    local fontMap = {["UI"] = 0, ["System"] = 1, ["Plex"] = 2, ["Monospace"] = 3}
    getgenv().HitLogsFont = fontMap[val] or 3
end)
TabVisuals:AddColorPicker(HitFeedback_Section, "Log Color", Color3.fromRGB(255, 255, 255), function(color) getgenv().HitLogsColor = color end)

local Camera_Section = TabVisuals:AddSection("Camera", "Right")
TabVisuals:AddSlider(Camera_Section, "Field of View", 70, 120, 90, function(val)
    workspace.CurrentCamera.FieldOfView = val
end)
TabVisuals:AddCheckbox(Camera_Section, "Enable Zoom", false, function(state)
    if state then
        getgenv().OldFOV = workspace.CurrentCamera.FieldOfView
        LightingMod:SetFOV(getgenv().ZoomFOV or 30)
    else
        LightingMod:SetFOV(getgenv().OldFOV or 90)
    end
end):AddKeybind(Enum.KeyCode.Q)
TabVisuals:AddSlider(Camera_Section, "Zoom Amount", 1, 60, 30, function(val) getgenv().ZoomFOV = val end)

local Crosshair_Section = TabVisuals:AddSection("Custom Crosshair", "Right")
TabVisuals:AddCheckbox(Crosshair_Section, "Enable Crosshair", false, function(state) getgenv().CrosshairEnabled = state end)
TabVisuals:AddSlider(Crosshair_Section, "Size", 1, 50, 10, function(val) getgenv().CrosshairSize = val end)
TabVisuals:AddSlider(Crosshair_Section, "Gap", 0, 20, 5, function(val) getgenv().CrosshairGap = val end)
TabVisuals:AddSlider(Crosshair_Section, "Thickness", 1, 5, 2, function(val) getgenv().CrosshairThickness = val end)
TabVisuals:AddSlider(Crosshair_Section, "Rotation", 0, 360, 0, function(val) getgenv().CrosshairRotation = val end)
TabVisuals:AddCheckbox(Crosshair_Section, "Infinite Rotation", false, function(state) getgenv().CrosshairRotating = state end)
TabVisuals:AddSlider(Crosshair_Section, "Rotation Speed", 1, 10, 2, function(val) getgenv().CrosshairRotationSpeed = val end)
TabVisuals:AddColorPicker(Crosshair_Section, "Color", Color3.new(1,1,1), function(color) getgenv().CrosshairColor = color end)
TabVisuals:AddCheckbox(Crosshair_Section, "Follow Mouse", false, function(state) getgenv().CrosshairFollowMouse = state end)
TabVisuals:AddCheckbox(Crosshair_Section, "Center Dot", false, function(state) getgenv().CrosshairDotEnabled = state end)
TabVisuals:AddSlider(Crosshair_Section, "Dot Size", 1, 10, 2, function(val) getgenv().CrosshairDotSize = val end)
TabVisuals:AddCheckbox(Crosshair_Section, "Enable Watermark", false, function(state) getgenv().CrosshairWatermarkEnabled = state end)
TabVisuals:AddTextbox(Crosshair_Section, "Watermark Text", "amber.lol", function(val) getgenv().CrosshairWatermark = val end)

local Lighting_Section = TabVisuals:AddSection("Lighting & Environment", "Left")
TabVisuals:AddSlider(Lighting_Section, "Clock Time", 0, 24, 12, function(val) LightingMod:SetTime(val) end)
TabVisuals:AddSlider(Lighting_Section, "Fog/Atm. Density", 0, 1, 0.3, function(val) LightingMod:SetAtmosphereDensity(val) end)
TabVisuals:AddSlider(Lighting_Section, "Atmosphere Haze", 0, 10, 0, function(val) LightingMod:SetAtmosphereHaze(val) end)
TabVisuals:AddColorPicker(Lighting_Section, "Atmosphere Color", Color3.new(1,1,1), function(color) LightingMod:SetAtmosphereColor(color) end)
TabVisuals:AddCheckbox(Lighting_Section, "No Spawner Foliage", false, function(state) 
    getgenv().RemoveSpawnerFoliage = state
    LightingMod:SetSpawnerFoliage(state)
end)

-- ==========================================
-- [ TAB: MOVEMENT ]
-- ==========================================

local MainMove_Section = TabMovement:AddSection("Utilities", "Left")
TabMovement:AddCheckbox(MainMove_Section, "Enable Fly", false, function(Value) 
    getgenv().FlyEnabled = Value
    local Character, RootPart = LocalPlayer.Character, (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
    
    if Value and RootPart then
        local vel = Instance.new("BodyVelocity")
        vel.Name = "FlyVelocity"
        vel.Velocity = Vector3.new(0, 0, 0)
        vel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        vel.Parent = RootPart
        
        local gyro = Instance.new("BodyGyro")
        gyro.Name = "FlyGyro"
        gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.P = 9e4
        gyro.CFrame = RootPart.CFrame
        gyro.Parent = RootPart
        
        if Character:FindFirstChildOfClass("Humanoid") then
            Character.Humanoid.PlatformStand = true
        end
    else
        if RootPart then
            if RootPart:FindFirstChild("FlyVelocity") then RootPart.FlyVelocity:Destroy() end
            if RootPart:FindFirstChild("FlyGyro") then RootPart.FlyGyro:Destroy() end
        end
        if Character and Character:FindFirstChildOfClass("Humanoid") then
            Character.Humanoid.PlatformStand = false
        end
    end
end)
TabMovement:AddSlider(MainMove_Section, "Fly Speed", 10, 500, 50, function(val) getgenv().FlySpeedValue = val end)
TabMovement:AddCheckbox(MainMove_Section, "CFrame Speed", false, function(state) getgenv().CFrameSpeedEnabled = state end)
TabMovement:AddSlider(MainMove_Section, "Speed Amount", 16, 200, 16, function(val) getgenv().CFrameSpeedValue = val end)
TabMovement:AddCheckbox(MainMove_Section, "Spider (Wall Climb)", false, function(state) getgenv().SpiderEnabled = state end)

local ExtraMove_Section = TabMovement:AddSection("Extra", "Right")
TabMovement:AddCheckbox(ExtraMove_Section, "Third Person", false, function(state) getgenv().ThirdPersonEnabled = state end):AddKeybind(Enum.KeyCode.C)
TabMovement:AddSlider(ExtraMove_Section, "Third Person Distance", 0, 50, 10, function(val) getgenv().ThirdPersonDistance = val end)
TabMovement:AddButton(ExtraMove_Section, "Reset Velocity", function()
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- ==========================================
-- [ TAB: PLAYERS ]
-- ==========================================

local Players_Section = TabPlayers:AddSection("Target Tools", "Left")
TabPlayers:AddCheckbox(Players_Section, "Target HUD", false, function(state) getgenv().TargetHUDEnabled = state end)
TabPlayers:AddButton(Players_Section, "Toggle Inventory Viewer", function()
    getgenv().InventoryViewerEnabled = not getgenv().InventoryViewerEnabled
end)

-- ==========================================
-- [ TAB: SETTINGS ]
-- ==========================================

local Settings_Section = TabSettings:AddSection("Configuration", "Left")
TabSettings:AddButton(Settings_Section, "Minimize UI", function() Window:SetOpen(false) end)
TabSettings:AddCheckbox(Settings_Section, "Menu Visible", true, function(state) Window:SetOpen(state) end):AddKeybind(Enum.KeyCode.RightShift)
TabSettings:AddCheckbox(Settings_Section, "Show Watermark", true, function(state)
    Watermark:SetVisible(state)
end)
TabSettings:AddButton(Settings_Section, "Test Notification", function()
    Library:Notify("Amber UI", "Notification working correctly!", 5)
end)
TabSettings:AddCheckbox(Settings_Section, "Show Keybind List", false, function(state)
    if Library.KeybindList then Library.KeybindList.Main.Visible = state end
end)

TabSettings:AddButton(Settings_Section, "Unload Script", function()
    Library:Unload()
end)

local Theme_Section = TabSettings:AddSection("Theme", "Right")
TabSettings:AddColorPicker(Theme_Section, "Accent Color", Color3.fromRGB(230, 40, 90), function(color)
    -- Nota: wa.lua usa variables locales para colores, 
    -- para cambiar el tema en tiempo real necesitarías exponer 'colors' en la librería.
    print("New Theme Color Selected")
end)

-- [ LOAD NOTIFICATION ] --
Library:UpdateKeybindList("AmberLoad", "Amber Loaded", "HOME", true, true)
task.delay(2, function()
    Library:UpdateKeybindList("AmberLoad", "Amber Loaded", "HOME", false, true)
end)

-- ==========================================
-- [ MOVEMENT CONTROL LOOP ]
-- ==========================================

RunService.RenderStepped:Connect(function(deltaTime)
    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    
    if not Character or not RootPart then return end

    -- Third Person Logic (Camera and transparency control)
    if getgenv().ThirdPersonEnabled then
        local camera = workspace.CurrentCamera
        camera.CFrame = camera.CFrame * CFrame.new(0, 0, getgenv().ThirdPersonDistance or 10)
        
        -- Show local character and hide viewmodel
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then v.LocalTransparencyModifier = 0 end
        end
        for _, v in pairs(camera:GetChildren()) do
            if v:IsA("Model") or v:IsA("BasePart") then
                for _, part in pairs(v:GetDescendants()) do
                    if part:IsA("BasePart") then part.LocalTransparencyModifier = 1 end
                end
            end
        end
    end

    -- CFrame Speed Implementation
    if getgenv().CFrameSpeedEnabled then
        local moveDirection = Vector3.new()
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Vector3.new(0, 0, -1) end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection + Vector3.new(0, 0, 1) end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection + Vector3.new(-1, 0, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Vector3.new(1, 0, 0) end
            
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit
                local speed = getgenv().CFrameSpeedValue or 16
                local moveCFrame = CFrame.new(moveDirection * speed * deltaTime)
                RootPart.CFrame = RootPart.CFrame * moveCFrame
            end
        end
    end

    -- Fly Implementation (Direction and rotation update)
    if getgenv().FlyEnabled then
        local moveDirection = Vector3.new()
        
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Vector3.new(0, 0, -1) end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection + Vector3.new(0, 0, 1) end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection + Vector3.new(-1, 0, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Vector3.new(1, 0, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection + Vector3.new(0, -1, 0) end
        
        if RootPart:FindFirstChild("FlyVelocity") then
            local camera = workspace.CurrentCamera
            local speed = getgenv().FlySpeedValue or 50
            local velocity = (camera.CFrame:VectorToWorldSpace(moveDirection).Unit * speed)
            RootPart.FlyVelocity.Velocity = moveDirection.Magnitude > 0 and velocity or Vector3.new(0, 0, 0)
            
            if RootPart:FindFirstChild("FlyGyro") then
                RootPart.FlyGyro.CFrame = camera.CFrame
            end
        end
    end

    -- Spider Implementation (Wall climb)
    if getgenv().SpiderEnabled and not getgenv().FlyEnabled and UIS:IsKeyDown(Enum.KeyCode.W) then
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {Character}
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        
        local raycastResult = workspace:Raycast(RootPart.Position, RootPart.CFrame.LookVector * 2.5, raycastParams)
        
        if raycastResult and raycastResult.Instance then
            RootPart.Velocity = Vector3.new(RootPart.Velocity.X, 30, RootPart.Velocity.Z)
        end
    end
end)

-- Welcome notification
Library:Notify("amber.lol", "Script loaded successfully!", 5)

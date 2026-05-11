local ESP = (function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local localPlayer = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local cache = {}
    local bones = {{"Head", "UpperTorso"},{"UpperTorso", "RightUpperArm"},{"RightUpperArm", "RightLowerArm"},{"RightLowerArm", "RightHand"},{"UpperTorso", "LeftUpperArm"},{"LeftUpperArm", "LeftLowerArm"},{"LeftLowerArm", "LeftHand"},{"UpperTorso", "LowerTorso"},{"LowerTorso", "LeftUpperLeg"},{"LeftUpperLeg", "LeftLowerLeg"},{"LeftLowerLeg", "LeftFoot"},{"LowerTorso", "RightUpperLeg"},{"RightUpperLeg", "RightLowerLeg"},{"RightLowerLeg", "RightFoot"}}
    local ESP_SETTINGS = {BoxOutlineColor = Color3.new(0, 0, 0), BoxColor = Color3.new(1, 1, 1), NameColor = Color3.new(1, 1, 1), HealthOutlineColor = Color3.new(0, 0, 0), HealthHighColor = Color3.new(0, 1, 0), HealthLowColor = Color3.new(1, 0, 0), CharSize = Vector2.new(4, 6), Teamcheck = false, WallCheck = false, Enabled = false, ShowBox = false, BoxType = "2D", ShowName = false, ShowHealth = false, ShowDistance = false, ShowSkeletons = false, ShowTracer = false, TracerColor = Color3.new(1, 1, 1), TracerThickness = 2, SkeletonsColor = Color3.new(1, 1, 1), TracerPosition = "Bottom", MaxDistance = 2000}
    local function create(class, properties)
        local drawing = Drawing.new(class)
        for property, value in pairs(properties) do drawing[property] = value end
        return drawing
    end
    local function createEsp(player)
        cache[player] = {
            tracer = create("Line", {Thickness = ESP_SETTINGS.TracerThickness, Color = ESP_SETTINGS.TracerColor, Transparency = 0.5}),
            boxOutline = create("Square", {Color = ESP_SETTINGS.BoxOutlineColor, Thickness = 3, Filled = false}),
            box = create("Square", {Color = ESP_SETTINGS.BoxColor, Thickness = 1, Filled = false}),
            name = create("Text", {Color = ESP_SETTINGS.NameColor, Outline = true, Center = true, Size = 13}),
            healthOutline = create("Line", {Thickness = 3, Color = ESP_SETTINGS.HealthOutlineColor}),
            health = create("Line", {Thickness = 1}),
            distance = create("Text", {Color = Color3.new(1, 1, 1), Size = 12, Outline = true, Center = true}),
            boxLines = {},
            skeletonlines = {}
        }
    end
    local function removeEsp(player)
        local esp = cache[player]
        if not esp then return end
        for _, drawing in pairs(esp) do
            if type(drawing) == "table" then
                for _, sub in pairs(drawing) do
                    if type(sub) == "table" and sub[1] and sub[1].Remove then sub[1]:Remove()
                    elseif type(sub) ~= "table" and sub.Remove then sub:Remove() end
                end
            elseif drawing.Remove then drawing:Remove() end
        end
        cache[player] = nil
    end
    local function hideEsp(esp)
        for _, drawing in pairs(esp) do
            if type(drawing) == "table" then
                for _, sub in pairs(drawing) do
                    if type(sub) == "table" and sub[1] and sub[1].Remove then sub[1].Visible = false
                    elseif type(sub) ~= "table" and sub.Remove then sub.Visible = false end
                end
            elseif drawing.Remove then drawing.Visible = false end
        end
    end
    local function updateEsp()
        for player, esp in pairs(cache) do
            local character = player.Character
            if character and (not ESP_SETTINGS.Teamcheck or (player.Team ~= localPlayer.Team)) then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                local head = character:FindFirstChild("Head")
                local humanoid = character:FindFirstChild("Humanoid")
                local isBehindWall = ESP_SETTINGS.WallCheck and (function()
                    local ray = Ray.new(camera.CFrame.Position, (rootPart.Position - camera.CFrame.Position).Unit * (rootPart.Position - camera.CFrame.Position).Magnitude)
                    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {localPlayer.Character, character})
                    return hit and hit:IsA("Part")
                end)()
                local distance = (camera.CFrame.p - (rootPart and rootPart.Position or Vector3.new())).Magnitude
                if rootPart and head and humanoid and (not isBehindWall) and ESP_SETTINGS.Enabled and distance <= (ESP_SETTINGS.MaxDistance or 2000) then
                    local hrp2D, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        local charSize = (camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0)).Y - camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 2.6, 0)).Y) / 2
                        local boxSize = Vector2.new(math.floor(charSize * 1.8), math.floor(charSize * 1.9))
                        local boxPos = Vector2.new(math.floor(hrp2D.X - charSize * 1.8 / 2), math.floor(hrp2D.Y - charSize * 1.6 / 2))
                        if ESP_SETTINGS.ShowName then
                            esp.name.Visible, esp.name.Text, esp.name.Position = true, string.lower(player.Name), Vector2.new(boxSize.X / 2 + boxPos.X, boxPos.Y - 16)
                        else esp.name.Visible = false end
                        if ESP_SETTINGS.ShowBox then
                            if ESP_SETTINGS.BoxType == "2D" then
                                esp.box.Size, esp.box.Position, esp.box.Visible = boxSize, boxPos, true
                                esp.boxOutline.Size, esp.boxOutline.Position, esp.boxOutline.Visible = boxSize, boxPos, true
                                for _, l in ipairs(esp.boxLines) do l:Remove() end esp.boxLines = {}
                            elseif ESP_SETTINGS.BoxType == "Corner Box Esp" then
                                local lw, lh, lt = (boxSize.X/5), (boxSize.Y/6), 1
                                if #esp.boxLines == 0 then for i=1,16 do esp.boxLines[i] = create("Line", {Thickness=1, Color=ESP_SETTINGS.BoxColor}) end end
                                local bl = esp.boxLines
                                bl[1].From, bl[1].To = Vector2.new(boxPos.X-lt, boxPos.Y-lt), Vector2.new(boxPos.X+lw, boxPos.Y-lt)
                                bl[2].From, bl[2].To = Vector2.new(boxPos.X-lt, boxPos.Y-lt), Vector2.new(boxPos.X-lt, boxPos.Y+lh)
                                bl[3].From, bl[3].To = Vector2.new(boxPos.X+boxSize.X-lw, boxPos.Y-lt), Vector2.new(boxPos.X+boxSize.X+lt, boxPos.Y-lt)
                                bl[4].From, bl[4].To = Vector2.new(boxPos.X+boxSize.X+lt, boxPos.Y-lt), Vector2.new(boxPos.X+boxSize.X+lt, boxPos.Y+lh)
                                bl[5].From, bl[5].To = Vector2.new(boxPos.X-lt, boxPos.Y+boxSize.Y-lh), Vector2.new(boxPos.X-lt, boxPos.Y+boxSize.Y+lt)
                                bl[6].From, bl[6].To = Vector2.new(boxPos.X-lt, boxPos.Y+boxSize.Y+lt), Vector2.new(boxPos.X+lw, boxPos.Y+boxSize.Y+lt)
                                bl[7].From, bl[7].To = Vector2.new(boxPos.X+boxSize.X-lw, boxPos.Y+boxSize.Y+lt), Vector2.new(boxPos.X+boxSize.X+lt, boxPos.Y+boxSize.Y+lt)
                                bl[8].From, bl[8].To = Vector2.new(boxPos.X+boxSize.X+lt, boxPos.Y+boxSize.Y-lh), Vector2.new(boxPos.X+boxSize.X+lt, boxPos.Y+boxSize.Y+lt)
                                for i=9,16 do bl[i].Thickness, bl[i].Color = 2, ESP_SETTINGS.BoxOutlineColor end
                                bl[9].From, bl[9].To = Vector2.new(boxPos.X, boxPos.Y), Vector2.new(boxPos.X, boxPos.Y+lh)
                                bl[10].From, bl[10].To = Vector2.new(boxPos.X, boxPos.Y), Vector2.new(boxPos.X+lw, boxPos.Y)
                                bl[11].From, bl[11].To = Vector2.new(boxPos.X+boxSize.X-lw, boxPos.Y), Vector2.new(boxPos.X+boxSize.X, boxPos.Y)
                                bl[12].From, bl[12].To = Vector2.new(boxPos.X+boxSize.X, boxPos.Y), Vector2.new(boxPos.X+boxSize.X, boxPos.Y+lh)
                                bl[13].From, bl[13].To = Vector2.new(boxPos.X, boxPos.Y+boxSize.Y-lh), Vector2.new(boxPos.X, boxPos.Y+boxSize.Y)
                                bl[14].From, bl[14].To = Vector2.new(boxPos.X, boxPos.Y+boxSize.Y), Vector2.new(boxPos.X+lw, boxPos.Y+boxSize.Y)
                                bl[15].From, bl[15].To = Vector2.new(boxPos.X+boxSize.X-lw, boxPos.Y+boxSize.Y), Vector2.new(boxPos.X+boxSize.X, boxPos.Y+boxSize.Y)
                                bl[16].From, bl[16].To = Vector2.new(boxPos.X+boxSize.X, boxPos.Y+boxSize.Y-lh), Vector2.new(boxPos.X+boxSize.X, boxPos.Y+boxSize.Y)
                                for _, l in ipairs(bl) do l.Visible = true end esp.box.Visible, esp.boxOutline.Visible = false, false
                            end
                        else esp.box.Visible, esp.boxOutline.Visible = false, false end
                        if ESP_SETTINGS.ShowHealth then
                            local hpPct = humanoid.Health / humanoid.MaxHealth
                            esp.healthOutline.Visible, esp.health.Visible = true, true
                            esp.healthOutline.From, esp.healthOutline.To = Vector2.new(boxPos.X - 6, boxPos.Y + boxSize.Y), Vector2.new(boxPos.X - 6, boxPos.Y)
                            esp.health.From, esp.health.To = Vector2.new(boxPos.X - 5, boxPos.Y + boxSize.Y), Vector2.new(boxPos.X - 5, boxPos.Y + boxSize.Y - hpPct * boxSize.Y)
                            esp.health.Color = ESP_SETTINGS.HealthLowColor:Lerp(ESP_SETTINGS.HealthHighColor, hpPct)
                        else esp.healthOutline.Visible, esp.health.Visible = false, false end
                        if ESP_SETTINGS.ShowDistance then
                            esp.distance.Visible, esp.distance.Text, esp.distance.Position = true, string.format("%.1f studs", distance), Vector2.new(boxPos.X + boxSize.X / 2, boxPos.Y + boxSize.Y + 5)
                        else esp.distance.Visible = false end
                        if ESP_SETTINGS.ShowSkeletons then
                            if #esp.skeletonlines == 0 then for _, bp in ipairs(bones) do if character:FindFirstChild(bp[1]) and character:FindFirstChild(bp[2]) then esp.skeletonlines[#esp.skeletonlines+1] = {create("Line", {Thickness=1, Color=ESP_SETTINGS.SkeletonsColor}), bp[1], bp[2]} end end end
                            for _, ld in ipairs(esp.skeletonlines) do
                                if character:FindFirstChild(ld[2]) and character:FindFirstChild(ld[3]) then
                                    local p1, p2 = camera:WorldToViewportPoint(character[ld[2]].Position), camera:WorldToViewportPoint(character[ld[3]].Position)
                                    ld[1].From, ld[1].To, ld[1].Visible = Vector2.new(p1.X, p1.Y), Vector2.new(p2.X, p2.Y), true
                                else ld[1].Visible = false end
                            end
                        else for _, ld in ipairs(esp.skeletonlines) do ld[1].Visible = false end end
                        if ESP_SETTINGS.ShowTracer then
                            local ty = (ESP_SETTINGS.TracerPosition == "Top" and 0) or (ESP_SETTINGS.TracerPosition == "Middle" and camera.ViewportSize.Y / 2) or camera.ViewportSize.Y
                            esp.tracer.Visible, esp.tracer.From, esp.tracer.To = true, Vector2.new(camera.ViewportSize.X / 2, ty), Vector2.new(hrp2D.X, hrp2D.Y)
                        else esp.tracer.Visible = false end
                    else hideEsp(esp) end
                else hideEsp(esp) end
            else hideEsp(esp) end
        end
    end
    for _, p in ipairs(Players:GetPlayers()) do if p ~= localPlayer then createEsp(p) end end
    Library:Connect(Players.PlayerAdded, function(p) if p ~= localPlayer then createEsp(p) end end)
    Library:Connect(Players.PlayerRemoving, removeEsp)
    Library:Connect(RunService.RenderStepped, updateEsp)
    return ESP_SETTINGS
end)();

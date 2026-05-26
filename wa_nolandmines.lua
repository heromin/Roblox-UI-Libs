-- No Landmines Utility
local NoLandmines = { Enabled = false, Connections = {} }

function NoLandmines:SetEnabled(state)
    self.Enabled = state
    if state then
        local zones = workspace:FindFirstChild("AiZones")
        if not zones then return end
        
        local targets = {"Landmines", "Claymores", "OutpostLandmines", "BridgeClaymores"}
        for _, name in ipairs(targets) do
            local folder = zones:FindFirstChild(name)
            if folder then
                for _, m in pairs(folder:GetChildren()) do m:Destroy() end
                table.insert(self.Connections, folder.ChildAdded:Connect(function(c)
                    if self.Enabled and (c.Name == "PMN2" or c.Name == "MON50") then
                        task.wait(0.1)
                        c:Destroy()
                    end
                end))
            end
        end
    else
        for _, v in pairs(self.Connections) do v:Disconnect() end
    end
end

return NoLandmines

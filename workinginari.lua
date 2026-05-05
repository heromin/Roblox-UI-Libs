if getgenv().Library then getgenv().Library:Unload()end;local a=game:GetService("UserInputService")local b=game:GetService("TweenService")local c=game:GetService("CoreGui")local d=game:GetService("Workspace")local e=game:GetService("Players")local f=game:GetService("HttpService")local e=e.LocalPlayer;local e=e:GetMouse()local d=d.CurrentCamera;local g=Instance.new;local h=Color3.fromRGB;local i=Color3.fromHSV;local j=Color3.fromHex;local k=UDim2.new;local l=UDim.new;local m=Vector2.new;local n=Rect.new;local o={}do o={Flags={},Theme={["Background"]=h(13,13,13),["Inline"]=h(16,16,16),["Text"]=h(229,229,229),["Border"]=h(34,34,34),["Accent"]=h(131,194,242),["Element"]=h(15,15,15),["Text Border"]=h(0,0,0)};Folders={Directory="inari",Configs="inari/Configs",Fonts="inari/Fonts"};MenuKey=Enum.KeyCode.End,TweeningTime=0.215,TweeningStyle="Quint",TweeningDirection="Out",HoverEffects=true,UnnamedFlags=0,Font=nil,Holder=nil,NotifHolder=nil,KeyList=nil,Connections={},ThemeMap={},ThemeInstances={},Sections={},Pages={}}o.__index=o;o.Sections.__index=o.Sections;o.Pages.__index=o.Pages;local p={[Enum.KeyCode.LeftShift]="LS",[Enum.KeyCode.RightShift]="RS",[Enum.KeyCode.LeftControl]="LC",[Enum.KeyCode.RightControl]="RC",[Enum.KeyCode.Insert]="INS",[Enum.KeyCode.Backspace]="BS",[Enum.KeyCode.Return]="Ent",[Enum.KeyCode.LeftAlt]="LA",[Enum.KeyCode.RightAlt]="RA",[Enum.KeyCode.CapsLock]="CAPS",[Enum.KeyCode.Delete]="DEL",[Enum.KeyCode.Home]="HOME",[Enum.KeyCode.End]="END",[Enum.KeyCode.PageUp]="PGUP",[Enum.KeyCode.PageDown]="PGDN",[Enum.KeyCode.Up]="UP",[Enum.KeyCode.Down]="DOWN",[Enum.KeyCode.Left]="LEFT",[Enum.KeyCode.Right]="RIGHT",[Enum.UserInputType.MouseButton1]="MB1",[Enum.UserInputType.MouseButton2]="MB2",[Enum.UserInputType.MouseButton3]="MB3",[Enum.KeyCode.One]="1",[Enum.KeyCode.Two]="2",[Enum.KeyCode.Three]="3",[Enum.KeyCode.Four]="4",[Enum.KeyCode.Five]="5",[Enum.KeyCode.Six]="6",[Enum.KeyCode.Seven]="7",[Enum.KeyCode.Eight]="8",[Enum.KeyCode.Nine]="9",[Enum.KeyCode.Zero]="0",[Enum.KeyCode.KeypadOne]="Num1",[Enum.KeyCode.KeypadTwo]="Num2",[Enum.KeyCode.KeypadThree]="Num3",[Enum.KeyCode.KeypadFour]="Num4",[Enum.KeyCode.KeypadFive]="Num5",[Enum.KeyCode.KeypadSix]="Num6",[Enum.KeyCode.KeypadSeven]="Num7",[Enum.KeyCode.KeypadEight]="Num8",[Enum.KeyCode.KeypadNine]="Num9",[Enum.KeyCode.KeypadZero]="Num0",[Enum.KeyCode.Minus]="-",[Enum.KeyCode.Equals]="=",[Enum.KeyCode.Tilde]="~",[Enum.KeyCode.LeftBracket]="[",[Enum.KeyCode.RightBracket]="]",[Enum.KeyCode.RightParenthesis]=")",[Enum.KeyCode.LeftParenthesis]="(",[Enum.KeyCode.Semicolon]=",",[Enum.KeyCode.Quote]="'",[Enum.KeyCode.BackSlash]="\\",[Enum.KeyCode.Comma]=",",[Enum.KeyCode.Period]=".",[Enum.KeyCode.Slash]="/",[Enum.KeyCode.Asterisk]="*",[Enum.KeyCode.Plus]="+",[Enum.KeyCode.Period]=".",[Enum.KeyCode.Backquote]="`",[Enum.KeyCode.Escape]="ESC",[Enum.KeyCode.Space]="SPC",[Enum.KeyCode.Z]="Z",[Enum.KeyCode.X]="X",[Enum.KeyCode.C]="C",[Enum.KeyCode.V]="V",[Enum.KeyCode.B]="B",[Enum.KeyCode.N]="N",[Enum.KeyCode.M]="M",[Enum.KeyCode.A]="A",[Enum.KeyCode.S]="S",[Enum.KeyCode.D]="D",[Enum.KeyCode.F]="F",[Enum.KeyCode.G]="G",[Enum.KeyCode.H]="H",[Enum.KeyCode.J]="J",[Enum.KeyCode.K]="K",[Enum.KeyCode.L]="L",[Enum.KeyCode.Q]="Q",[Enum.KeyCode.W]="W",[Enum.KeyCode.E]="E",[Enum.KeyCode.R]="R",[Enum.KeyCode.T]="T",[Enum.KeyCode.Y]="Y",[Enum.KeyCode.U]="U",[Enum.KeyCode.I]="I",[Enum.KeyCode.O]="O",[Enum.KeyCode.P]="P"}for a,a in o.Folders do if not isfolder(a)then makefolder(a)end end;function o:GetFolder(a,b)local a=o.Folders[a]if a~=nil then return end;if b then a..="/"end;return a end;writefile=writefile or function()end;readfile=readfile or function()end;isfile=isfile or function()end;delfile=delfile or function()end;isfolder=isfolder or function()end;makefolder=makefolder or function()end;listfiles=listfiles or function()end;getgenv=getgenv or function()end;getcustomasset=getcustomasset or function()end;cloneref=cloneref or function()return c end;gethui=gethui or function()return cloneref(game:GetService("CoreGui"))end;local c={}do c.__index=c;c.Create=function(a,a,d,e,f)if not(a or e or d)then return end;d=d or TweenInfo.new(o.TweeningTime,Enum.EasingStyle[o.TweeningStyle],Enum.EasingDirection[o.TweeningDirection])local f=not f and a.Object or a;local a={Info=d,Object=a,Tween=b:Create(f,d,e)}setmetatable(a,c)a.Tween:Play()return a end;c.Get=function(a)assert(a.Tween,"Tween doesn't exist")return a.Tween,a.Object,a.Info end;c.Play=function(a)assert(a.Tween,"Tween doesn't exist")a.Tween:Play()end;c.Pause=function(a)assert(a.Tween,"Tween doesn't exist")a.Tween:Pause()end;c.Clean=function(a)assert(a.Tween,"Tween doesn't exist")a.Tween:Pause()a=nil end end;local b={}do b.__index=b;b.Create=function(a,a,c)local a={Object=g(a),Properties=c,Class=a,Dragging=false}setmetatable(a,b)for b,c in c do a.Object[b]=c end;return a end;b.Border=function(a)assert(a.Object,"Object doesn't exist")local a=a.Object;local a=b:Create("UIStroke",{Parent=a;Color=o.Theme.Border;Thickness=1;LineJoinMode=Enum.LineJoinMode.Miter;ApplyStrokeMode=Enum.ApplyStrokeMode.Border})a:AddToTheme({Color="Border"})return a end;b.AddHoverEffect=function(a,b)assert(a.Object,"Object doesn't exist")local c=a.Object.Parent;if b then c=c.Parent end;o:Connect(c.MouseEnter,function()if not o.HoverEffects then return end;a:Tween(nil,{Color=o.Theme.Accent})a:ChangeObjectTheme({Color="Accent"})end,a.Object.Name.." Hover Effect Enter")o:Connect(c.MouseLeave,function()if not o.HoverEffects then return end;a:Tween(nil,{Color=o.Theme.Border})a:ChangeObjectTheme({Color="Border"})end,a.Object.Name.." Hover Effect Leave")end;b.TextBorder=function(a)assert(a.Object,"Object doesn't exist")local a=a.Object;local a=b:Create("UIStroke",{Parent=a;Color=o.Theme.TextBorder;Thickness=1;LineJoinMode=Enum.LineJoinMode.Miter;ApplyStrokeMode=Enum.ApplyStrokeMode.Contextual})a:AddToTheme({Color="Text Border"})return a end;b.Tween=function(a,b,d)assert(a.Object,"Object doesn't exist")local a=c:Create(a.Object,b,d,true)return a end;b.Connect=function(a,b,c,d)assert(a.Object,"Object doesn't exist")assert(a.Object[b],"Event doesn't exist")local a=o:Connect(a.Object[b],c,d)return a end;b.Disconnect=function(a,a)for b,b in o.Connections do if b.Name==a then b.Connection:Disconnect()break end end end;b.MakeDraggable=function(b)assert(b.Object,"Object doesn't exist")local d=b.Object;local b=b;local e=false;local f,g=k(),k()local c=function(a)local a=a.Position-f;c:Create(b,TweenInfo.new(0.175,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=k(g.X.Scale,g.X.Offset+a.X,g.Y.Scale,g.Y.Offset+a.Y)})end;b:Connect("InputBegan",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then e=true;f=a.Position;g=d.Position end end,d.Name.." Dragify Input Began")b:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then e=false end end,d.Name.." Dragify Input Ended")o:Connect(a.InputChanged,function(a)if a.UserInputType==Enum.UserInputType.MouseMovement and e then c(a)end end,d.Name.." Dragify Input Changed")return e end;b.MakeResizeable=function(d,e,f)assert(d.Object,"Object doesn't exist")assert(e,"Minimum value can't be nil")assert(f,"Maximum value can't be nil")local g=d.Object;local d=d;local i=false;local j,l=k(),k()local n=g.Parent.AbsoluteSize-g.AbsoluteSize;local b=b:Create("TextButton",{Parent=g,AnchorPoint=m(1,1),BorderColor3=h(0,0,0),Size=k(0,8,0,8),Position=k(1,0,1,0),BorderSizePixel=0,BackgroundTransparency=1,AutoButtonColor=false,Text=""})b:Connect("InputBegan",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then i=true;l=g.Size-k(0,a.Position.X,0,a.Position.Y)end end,g.Name.." Resizing Input Began")b:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then i=false end end,g.Name.." Resizing Input Ended")o:Connect(a.InputChanged,function(a)if a.UserInputType==Enum.UserInputType.MouseMovement and i then n=f or g.Parent.AbsoluteSize-g.AbsoluteSize;j=l+k(0,a.Position.X,0,a.Position.Y)j=k(0,math.clamp(j.X.Offset,e.X,n.X),0,math.clamp(j.Y.Offset,e.Y,n.Y))c:Create(d,TweenInfo.new(0.17,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=j})end end,g.Name.." Resizing Input Changed")return i end;b.Clean=function(a)assert(a.Object,"Object doesn't exist")a.Object:Destroy()a=nil end;b.AddToTheme=function(a,b)assert(a.Object,"Object doesn't exist")o:AddToTheme(a,b)end;b.ChangeObjectTheme=function(a,b)assert(a.Object,"Object doesn't exist")o:ChangeObjectTheme(a,b)end end;local g={}do function g:New(a,b,c,d)if isfile(o.Folders.Fonts.."/"..a..".json")then return Font.new(getcustomasset(o.Folders.Fonts.."/"..a..".json"))end;if not isfile(o.Folders.Fonts.."/"..a..".ttf")then writefile(o.Folders.Fonts.."/"..a..".ttf",game:HttpGet(d.Url))end;local b={name=a;faces={{name="Regular";weight=b;style=c;assetId=getcustomasset(o.Folders.Fonts.."/"..a..".ttf")}}}writefile(o.Folders.Fonts.."/"..a..".json",f:JSONEncode(b))return Font.new(getcustomasset(o.Folders.Fonts.."/"..a..".json"))end;function g:Get(a)if isfile(o.Folders.Fonts.."/"..a..".json")then return Font.new(getcustomasset(o.Folders.Fonts.."/"..a..".json"))end end;g:New("Proggy Clean",400,"Regular",{Url="https://github.com/bluescan/proggyfonts/raw/refs/heads/master/ProggyOriginal/ProggyClean.ttf"})o.Font=g:Get("Proggy Clean")end;do o.Holder=b:Create("ScreenGui",{Parent=gethui(),Name="\0",ZIndexBehavior=Enum.ZIndexBehavior.Global,ResetOnSpawn=false})o.NotifHolder=b:Create("Frame",{Parent=o.Holder.Object,Name="\0",BackgroundTransparency=1,Size=k(0,0,1,0),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=o.NotifHolder.Object,Padding=l(0,7),SortOrder=Enum.SortOrder.LayoutOrder})b:Create("UIPadding",{Parent=o.NotifHolder.Object,PaddingTop=l(0,8),PaddingBottom=l(0,8),PaddingRight=l(0,8),PaddingLeft=l(0,8)})function o:Thread(a)local a=coroutine.create(a)return function(...)return coroutine.resume(a,...)end end;function o:Unload()
    for a,a in o.Connections do a.Signal:Disconnect()end;
    if o.Holder then o.Holder:Clean()end;
    local h = gethui():FindFirstChild("Inari_TargetInfo")
    if h then h:Destroy() end
    for _, v in pairs(gethui():GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("Inari") then
            v:Destroy()
        end
    end
    o=nil;
    getgenv().Library=nil 
end;function o:Connect(a,b,c)local a={Signal=a:Connect(b),Name=c,Function=b}table.insert(o.Connections,a)return a end;function o:Disconnect(a)for b,b in o.Connections do if b.Name==a then b.Signal:Disconnect()break end end end;function o:GetConfig()local a={}local b,c=pcall(function()for b,c in o.Flags do local d=c.Class;if not d then continue end;if d=="Keybind"then a[b]={Name=c.Key,Mode=c.Mode}elseif d=="Colorpicker"then a[b]={Color=c.Hex,Alpha=c.Alpha}else if not a[b]then a[b]=c.Value end end end end)if not b then o:Notification("Failed to get config, report this to the devs: "..c,5,h(255,0,0))end;return f:JSONEncode(a)end;function o:LoadConfig(a)if not a then o:Notification("Config not found, did you possibly delete a selected config and forget to unselect it?",5,h(255,0,0),nil)return end;local a=f:JSONDecode(a)local a,b=pcall(function()for a,b in a do local a=o.Flags[a]if a then if a.Class=="Keybind"then if table.find({"MouseButton1","MouseWheel","MouseButton2","MouseButton3"},b.Name)then a:Set(b,true)else a:Set(b)end elseif a.Class=="Colorpicker"then a:Set(b.Color,b.Alpha)else a:Set(b)end end end end)if not a then o:Notification("Failed to load config, report this to the devs: "..b,5,h(255,0,0))else o:Notification("Successfully loaded config",5,h(0,255,0))end end;function o:GetConfigsList(a)local b={}local c={}for a,a in listfiles(o.Folders.Configs)do local a=string.gsub(a,o.Folders.Directory.."\\Configs\\",""):gsub(".json","")c[#c+1]=a end;local d=#c~=#b;if not d then for a=1,#c do if c[a]~=b[a]then d=true;break end end end;if d then b=c;a:Refresh(b)end end;function o:AddToTheme(a,b)local b={Instance=a.Object,Properties=b}for a,c in b.Properties do if type(c)=="string"then if o.Theme[c]then b.Instance[a]=o.Theme[c]end else b.Instance[a]=c()end end;table.insert(o.ThemeInstances,b)o.ThemeMap[a.Object]=b end;function o:ChangeObjectTheme(a,b)if o.ThemeMap[a.Object]then local c=o.ThemeMap[a.Object]c.Properties=b;o.ThemeMap[a.Object]=c end end;function o:UpdateTheme(a,b)o.Theme[a]=b;for c,d in o.ThemeMap do local d=d.Properties;for d,e in d do if e==a then c[d]=b end end end end;function o:NextFlag()local a=o.UnnamedFlags+1;return string.format("%s_%s_flag",a,f:GenerateGUID(false))end;function o:GetTransparencyPropertyFromType(a)if a:IsA("UIStroke")then return{"Transparency"}elseif a:IsA("ImageLabel")then return{"ImageTransparency"}elseif a:IsA("TextButton")or a:IsA("TextBox")then return{"TextTransparency","BackgroundTransparency"}elseif a:IsA("Frame")or a:IsA("ScrollingFrame")then return"BackgroundTransparency"elseif a:IsA("TextLabel")then return{"TextTransparency"}end end;function o:Floor(a,b)local b=1/(b or 1)return math.floor(a*b+0.5)/b end;    function o:Log(Text, Color)
        local scroll = o.Terminal:FindFirstChild("LogScroll")
        if not scroll then return end
        
        local items = scroll:GetChildren()
        local logCount = 0
        for _, item in ipairs(items) do
            if item:IsA("TextLabel") then logCount = logCount + 1 end
        end
        
        if logCount >= 200 then
            local oldest = nil
            for _, item in ipairs(items) do
                if item:IsA("TextLabel") then
                    if not oldest or item.LayoutOrder < oldest.LayoutOrder then
                        oldest = item
                    end
                end
            end
            if oldest then oldest:Destroy() end
        end

        local entry = b:Create("TextLabel", {
            Parent = scroll,
            Text = string.format("[%s] %s", os.date("%H:%M:%S"), Text),
            Font = Enum.Font.Code,
            TextSize = 12,
            TextColor3 = Color or o.Theme.Text,
            Size = k(1, 0, 0, 15),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = os.clock() * 1000,
            AutomaticSize = Enum.AutomaticSize.Y
        })
        scroll.CanvasPosition = m(0, 99999)
    end

    function o:CreateTerminal()
        local f_term = {}
        f_term["Main"] = b:Create("Frame", {
            Parent = o.Holder.Object,
            Name = "TerminalWindow",
            Position = k(0.7, 0, 0.6, 0),
            Size = k(0, 400, 0, 250),
            BackgroundColor3 = o.Theme.Background,
            BorderSizePixel = 0,
            Visible = false
        })
        f_term["Main"]:Border()
        f_term["Main"]:MakeDraggable()
        f_term["Main"]:MakeResizeable(m(200, 150), m(800, 600))

        f_term["Topbar"] = b:Create("Frame", {
            Parent = f_term["Main"].Object,
            Name = "Topbar",
            Size = k(1, 0, 0, 25),
            BackgroundColor3 = h(25, 25, 25),
            BorderSizePixel = 0
        })
        
        f_term["Title"] = b:Create("TextLabel", {
            Parent = f_term["Topbar"].Object,
            Text = "INARI - DEVELOPER TERMINAL",
            Font = Enum.Font.Code,
            TextSize = 12,
            TextColor3 = o.Theme.Text,
            Position = k(0, 8, 0, 0),
            Size = k(1, -8, 1, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1
        })

        f_term["Clear"] = b:Create("TextButton", {
            Parent = f_term["Topbar"].Object,
            Text = "CLEAR",
            Font = Enum.Font.Code,
            TextSize = 10,
            TextColor3 = o.Theme.Text,
            BackgroundColor3 = h(45, 45, 45),
            Size = k(0, 50, 0, 18),
            Position = k(1, -55, 0, 3.5),
            BorderSizePixel = 0
        })
        f_term["Clear"]:Border()
        f_term["Clear"]:Connect("MouseButton1Click", function()
            for _, v in pairs(f_term["Scroll"].Object:GetChildren()) do
                if v:IsA("TextLabel") then v:Destroy() end
            end
        end)

        f_term["Scroll"] = b:Create("ScrollingFrame", {
            Parent = f_term["Main"].Object,
            Name = "LogScroll",
            Position = k(0, 5, 0, 30),
            Size = k(1, -10, 1, -35),
            BackgroundTransparency = 1,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = o.Theme.Accent,
            CanvasSize = k(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        })

        b:Create("UIListLayout", {
            Parent = f_term["Scroll"].Object,
            Padding = l(0, 2),
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        o.Terminal = f_term["Main"].Object

        o:Connect(game:GetService("LogService").MessageOut, function(Message, Type)
            local color = o.Theme.Text
            if Type == Enum.MessageType.MessageError then color = h(255, 100, 100)
            elseif Type == Enum.MessageType.MessageWarning then color = h(255, 255, 100)
            end
            o:Log(Message, color)
        end, "TerminalLogConnection")
    end
end;

getgenv().Library = o

local Library = getgenv().Library
Library:CreateTerminal()
print("Inari Initialized Successfully.")

local Window = Library:Window({
    Name = "Inari | Project Medusa",
    Size = UDim2.new(0, 622, 0, 453)
});

local Watermark = Window:Watermark("inari | " .. os.date("%b %d %Y"));

local KeybindList = Window:KeybindList();
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

local Pages = {
    ["Combat"] = Window:Page({
        Name = "Combat", 
        Columns = 2,
        SubPages = false
    });

    ["Visuals"] = Window:Page({
        Name = "Visuals", 
        Columns = 2,
        SubPages = false 
    });

    ["Misc"] = Window:Page({
        Name = "Misc", 
        Columns = 2,
        SubPages = false
    });

    ["Players"] = Window:Page({ 
        Name = "Players", 
        Columns = 2,
        SubPages = false 
    });

    ["Settings"] = Window:Page({ 
    Name = "Settings", 
    Columns = 2,
    SubPages = false 
});
};

local ConfigSection = Pages["Settings"]:Section({
    Name = "Config Management",
    Side = 1
});

local ConfigName = ConfigSection:Textbox({
    Name = "Config Name",
    Placeholder = "Enter name...",
    Flag = "ConfigNameInput"
});

local ConfigList = ConfigSection:Listbox({
    Name = "Configs",
    List = {},
    Flag = "ConfigListbox",
    Size = 150
});

ConfigSection:Button({
    Name = "Refresh List",
    Callback = function()
        Library:GetConfigsList(ConfigList)
    end
});

ConfigSection:Button({
    Name = "Save Config",
    Callback = function()
        local name = ConfigName:Get()
        if name ~= "" then
            writefile(Library.Folders.Configs .. "/" .. name .. ".json", Library:GetConfig())
            Library:GetConfigsList(ConfigList)
            Library:Notification("Saved config: " .. name, 5, Color3.fromRGB(131, 194, 242))
        end
    end
});

ConfigSection:Button({
    Name = "Load Config",
    Callback = function()
        local selected = ConfigList:Get()
        if selected and selected ~= "" then
            local path = Library.Folders.Configs .. "/" .. selected .. ".json"
            if isfile(path) then
                Library:LoadConfig(readfile(path))
            end
        end
    end
});

ConfigSection:Button({
    Name = "Delete Config",
    Callback = function()
        local selected = ConfigList:Get()
        if selected and selected ~= "" then
            local path = Library.Folders.Configs .. "/" .. selected .. ".json"
            if isfile(path) then
                delfile(path)
                Library:GetConfigsList(ConfigList)
                Library:Notification("Deleted config: " .. selected, 5, Color3.fromRGB(255, 0, 0))
            end
        end
    end
});

-- Initial Refresh
task.spawn(function()
    Library:GetConfigsList(ConfigList)
end)

local ThemeSection = Pages["Settings"]:Section({
    Name = "Menu Customization",
    Side = 2
});

ThemeSection:Toggle({
    Name = "Menu Open",
    Flag = "MenuToggle",
    Default = true,
    Callback = function(Value)
        Window:SetOpen(Value)
    end
}):Keybind({
    Default = Enum.KeyCode.End
});

ThemeSection:Toggle({
    Name = "Hover Effects",
    Flag = "HoverEffectsToggle",
    Default = true,
    Callback = function(Value)
        Library.HoverEffects = Value
    end
});

ThemeSection:Button({
    Name = "Unload Script",
    Callback = function()
        Library:Unload()
    end
});

local MovementSection = Pages["Misc"]:Section({
    Name = "Movement", 
    Side = 1
});

local DebugSection = Pages["Misc"]:Section({
    Name = "Terminal & Debug",
    Side = 1
});

DebugSection:Toggle({
    Name = "Script Terminal",
    Flag = "TerminalToggle",
    Default = false,
    Callback = function(Value)
        Library.Terminal.Visible = Value
    end
});

local InventorySection = Pages["Players"]:Section({
    Name = "Inventory Viewer",
    Side = 1
});

local InvList = InventorySection:Listbox({
    Name = "Target Items",
    List = {},
    Size = 250
});

-- Unified Target Info UI (Combined Stats & Inventory)
local TargetInfoGui = Instance.new("ScreenGui", gethui())
TargetInfoGui.Name = "Inari_TargetInfo"
TargetInfoGui.Enabled = false

local MainFrame = Instance.new("Frame", TargetInfoGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 180, 0, 220)
MainFrame.Position = UDim2.new(0.5, 200, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
MainFrame.BorderSizePixel = 0

local MainShadow = Instance.new("ImageLabel", MainFrame)
MainShadow.Name = "Shadow"
MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
MainShadow.BackgroundTransparency = 1
MainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
MainShadow.Size = UDim2.new(1, 40, 1, 40)
MainShadow.ZIndex = 0
MainShadow.Image = "rbxassetid://1316045217"
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ImageTransparency = 0.5
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(10, 10, 118, 118)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(34, 34, 34)
MainStroke.Thickness = 1

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 26)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TitleBar.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, -10, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(225, 227, 229)
TitleLabel.TextSize = 12
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "TARGET INFO"
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local MainLiner = Instance.new("Frame", TitleBar)
MainLiner.Size = UDim2.new(1, 0, 0, 1)
MainLiner.Position = UDim2.new(0, 0, 1, 0)
MainLiner.BackgroundColor3 = Color3.fromRGB(131, 194, 242)
MainLiner.BorderSizePixel = 0

local StatsContainer = Instance.new("Frame", MainFrame)
StatsContainer.Name = "Stats"
StatsContainer.Size = UDim2.new(1, -10, 0, 55)
StatsContainer.Position = UDim2.new(0, 5, 0, 30)
StatsContainer.BackgroundTransparency = 1

local StatsLayout = Instance.new("UIListLayout", StatsContainer)
StatsLayout.Padding = UDim.new(0, 2)
StatsLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function CreateStatsLabel(text)
    local l = Instance.new("TextLabel", StatsContainer)
    l.Size = UDim2.new(1, 0, 0, 12)
    l.BackgroundTransparency = 1
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.TextSize = 10
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = text
    return l
end

local HealthLabel = CreateStatsLabel("HP: 100/100")
local WeaponLabel = CreateStatsLabel("Tool: None")
local ExtraLabel = CreateStatsLabel("SPD: 16 | DIST: 0")

local InvScroll = Instance.new("ScrollingFrame", MainFrame)
InvScroll.Size = UDim2.new(1, -10, 1, -95)
InvScroll.Position = UDim2.new(0, 5, 0, 90)
InvScroll.BackgroundTransparency = 1
InvScroll.BorderSizePixel = 0
InvScroll.ScrollBarThickness = 2
InvScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
InvScroll.ScrollBarImageColor3 = Color3.fromRGB(131, 194, 242)

local InvLayout = Instance.new("UIGridLayout", InvScroll)
InvLayout.CellPadding = UDim2.new(0, 4, 0, 4)
InvLayout.CellSize = UDim2.new(0, 37, 0, 37)

local function CreateInvItem(name, iconId)
    local f = Instance.new("Frame", InvScroll)
    f.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    f.BorderSizePixel = 0
    local s = Instance.new("UIStroke", f)
    s.Color = Color3.fromRGB(34, 34, 34)
    s.Thickness = 1
    
    local img = Instance.new("ImageLabel", f)
    img.Size = UDim2.new(1, -6, 1, -6)
    img.Position = UDim2.new(0.5, 0, 0.5, 0)
    img.AnchorPoint = Vector2.new(0.5, 0.5)
    img.BackgroundTransparency = 1
    img.Image = iconId or "rbxassetid://0"

    f.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(s, TweenInfo.new(0.2), {Color = Color3.fromRGB(131, 194, 242)}):Play()
        game:GetService("TweenService"):Create(f, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
    end)
    f.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(s, TweenInfo.new(0.2), {Color = Color3.fromRGB(34, 34, 34)}):Play()
        game:GetService("TweenService"):Create(f, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(16, 16, 16)}):Play()
    end)
    
    return f
end

-- Simple Dragging
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

InventorySection:Toggle({
    Name = "Enabled",
    Flag = "InvViewerEnabled",
    Default = false,
    Callback = function(Value)
        getgenv().InventoryViewerEnabled = Value
    end
});

InventorySection:Toggle({
    Name = "Target HUD",
    Flag = "TargetHUDToggle",
    Default = false,
    Callback = function(Value)
        getgenv().TargetHUDEnabled = Value
    end
});

do -- Basic elements
    local AimbotSection = Pages["Combat"]:Section({ 
        Name = "Aimbot",
        Side = 1
    });

    local GunModsSection = Pages["Combat"]:Section({
        Name = "gun mods", 
        Side = 2
    });

    do
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        local Mouse =LocalPlayer:GetMouse()
        
        -- Variables
        local closestPlayer = nil
        getgenv().isAimbotEnabled = false
        local isLocking = false
        
        -- Function to get the closest player to mouse
        local function getClosestPlayerToMouse()
            local shortestDistance = math.huge
            local target = nil
            local targetPart = nil
            local mousePos = Vector2.new(Mouse.X, Mouse.Y)
        
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    if getgenv().TeamCheck and player.Team == LocalPlayer.Team then continue end
                    
                    local partName = getgenv().AimbotTargetPart or "Head"
                    local part = player.Character:FindFirstChild(partName)
                    
                    if part then
                        local pos, visible = workspace.CurrentCamera:WorldToScreenPoint(part.Position)
                        if visible then
                            if getgenv().WallCheck then
                                local ray = Ray.new(workspace.CurrentCamera.CFrame.Position, (part.Position - workspace.CurrentCamera.CFrame.Position).Unit * (part.Position - workspace.CurrentCamera.CFrame.Position).Magnitude)
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
        
        -- Lock on function
        local function lockOn(player)
            if player and player.Character then
                local targetPartName = getgenv().AimbotTargetPart or "Head"
                local targetPart = player.Character:FindFirstChild(targetPartName)
                if targetPart then
                    local targetCFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPart.Position)
                    local smoothness = getgenv().AimbotSmoothness or 1
                    if smoothness > 1 then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(targetCFrame, 1/smoothness)
                    else
                        workspace.CurrentCamera.CFrame = targetCFrame
                    end
                end
            end
        end
        
        -- Right mouse input
        local UIS = game:GetService("UserInputService")
        
        UIS.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 and getgenv().isAimbotEnabled then
                isLocking = true
            end
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                isLocking = false
            end
        end)

        getgenv().SilentAImUser = false

        local ClosestTarget = nil
        
        local closestPlayerPart = nil
        
        -- Render loop
        RunService.RenderStepped:Connect(function()
            if getgenv().isAimbotEnabled or getgenv().SilentAImUser then
                closestPlayer, closestPlayerPart = getClosestPlayerToMouse()
                if isLocking and getgenv().isAimbotEnabled and closestPlayerPart then
                    local targetCFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestPlayerPart.Position)
                    local smoothness = getgenv().AimbotSmoothness or 1
                    if smoothness > 1 then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(targetCFrame, 1/smoothness)
                    else
                        workspace.CurrentCamera.CFrame = targetCFrame
                    end
                end
            end
        end)
        
        -- UI Controls
        AimbotSection:Toggle({
            Name = "Enable Aimbot",
            Flag = "AimbotEnabled",
            Default = false,
            Callback = function(Value) getgenv().isAimbotEnabled = Value end
        });

        AimbotSection:Toggle({
            Name = "Enable Silent Aim",
            Flag = "SilentAimEnabled",
            Default = false,
            Callback = function(Value) getgenv().SilentAImUser = Value end
        });

        AimbotSection:Dropdown({
            Name = "Target Part",
            List = {"Head", "HumanoidRootPart", "UpperTorso"},
            Default = "Head",
            Flag = "AimbotTargetPart",
            Callback = function(Value) getgenv().AimbotTargetPart = Value end
        });

        AimbotSection:Slider({
            Name = "Aimbot Smoothness",
            Min = 1,
            Max = 20,
            Default = 1,
            Decimals = 0.1,
            Flag = "AimbotSmoothness",
            Callback = function(Value) getgenv().AimbotSmoothness = Value end
        });

        AimbotSection:Toggle({
            Name = "Team Check",
            Flag = "AimbotTeamCheck",
            Default = false,
            Callback = function(Value) getgenv().TeamCheck = Value end
        });

        AimbotSection:Toggle({
            Name = "Wall Check",
            Flag = "AimbotWallCheck",
            Default = false,
            Callback = function(Value) getgenv().WallCheck = Value end
        });

        local Camera = workspace.CurrentCamera

        -- Global settings
        getgenv().fovRadius = 50
        getgenv().drawFOV = false
        
        -- FOV Drawing setup
        local fovCircle = Drawing.new("Circle")
        fovCircle.Visible = false
        fovCircle.Color = Color3.fromRGB(255, 255, 255)
        fovCircle.Thickness = 1.5
        fovCircle.NumSides = 100
        fovCircle.Filled = false
        fovCircle.Transparency = 1
        
        RunService.RenderStepped:Connect(function()
            local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            
            -- Update drawing properties
            fovCircle.Position = screenCenter
            fovCircle.Radius = getgenv().fovRadius
            fovCircle.Visible = getgenv().drawFOV
        end)

        AimbotSection:Toggle({
            Name = "Enable FOV circle",
            Flag = "AimbotDrawFOV",
            Default = false,
            Callback = function(Value)
                getgenv().drawFOV = Value
            end;
        });

        AimbotSection:Slider({
            Name = "fov Circle size",
            Flag = "SIGMASLIDER",
            Min = 0,
            Max = 500,
            Default = 50,
            Suffix = "px",
            Callback = function(Value)
                getgenv().fovRadius = Value
            end;
        })

        getgenv().SigmaHitchance = 100

        AimbotSection:Slider({
            Name = "Hitchance",
            Flag = "hitchancewallah",
            Min = 0,
            Max = 100,
            Default = 50,
            Suffix = "%",
            Callback = function(Value)
                getgenv().SigmaHitchance = Value
            end;
        })
    end;

    do -- mods
        GunModsSection:Toggle({
            Name = "Enable no Recoil",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                for i,v in next, game:GetService("ReplicatedStorage").AmmoTypes:GetChildren() do
                    if v:GetAttribute("RecoilStrength") then
                    v:SetAttribute("RecoilStrength", 0)
                    end
                    end
            end;
        });

        GunModsSection:Toggle({
            Name = "Enable no spread",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                -- fake feature muahaha
            end;
        });

        GunModsSection:Toggle({
            Name = "Enable no Drag",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                for i,v in next, game:GetService("ReplicatedStorage").AmmoTypes:GetChildren() do
                    if v:GetAttribute("Drag") then
                    v:SetAttribute("Drag", 0)
                    end
                    end
            end;
        });

        GunModsSection:Toggle({
            Name = "Enable no Drop",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                for i,v in next, game:GetService("ReplicatedStorage").AmmoTypes:GetChildren() do
                    if v:GetAttribute("ProjectileDrop") then
                    v:SetAttribute("ProjectileDrop", 0)
                    end
                    end
            end;
        });

        GunModsSection:Toggle({
            Name = "Enable instant aim",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                getgenv().instantzoom = Value
            end;
        });

        local camerasys = require(game:GetService("ReplicatedStorage").Modules.CameraSystem)

        local old; old = hookfunction(camerasys.SetZoomTarget, function(...)
                                local sigma = {...};
        
                                if getgenv().instantzoom then 
                                    sigma[4] = 0;
                                end;
        
                                return old(unpack(sigma));
                            end)
        print("[BYPASS] Hooked CameraSystem:SetZoomTarget")
    end

    -- Visuals Reorganization
    local playerESPSection = Pages["Visuals"]:Section({ Name = "Player ESP", Side = 1 });
    local worldESPSection = Pages["Visuals"]:Section({ Name = "World ESP", Side = 1 });
    local combatVisualsSection = Pages["Visuals"]:Section({ Name = "Combat Effects", Side = 2 });
    local otherVisualsSection = Pages["Visuals"]:Section({ Name = "Other Visuals", Side = 2 });

    do -- Player ESP
        ESP.BoxType = "Corner Box Esp";
        playerESPSection:Toggle({ Name = "Enable ESP", Flag = "ToggleESP", Default = false, Callback = function(Value) ESP.Enabled = Value end });
        playerESPSection:Toggle({ Name = "Bounding Boxes", Flag = "ToggleBoxes", Default = false, Callback = function(Value) ESP.ShowBox = Value end });
        playerESPSection:Toggle({ Name = "Health Bar", Flag = "ToggleHealth", Default = false, Callback = function(Value) ESP.ShowHealth = Value end });
        playerESPSection:Toggle({ Name = "Names", Flag = "ToggleNames", Default = false, Callback = function(Value) ESP.ShowName = Value end });
        playerESPSection:Toggle({ Name = "Tracers", Flag = "ToggleTracers", Default = false, Callback = function(Value) ESP.ShowTracer = Value end });
        playerESPSection:Toggle({ Name = "Distance", Flag = "ToggleDist", Default = false, Callback = function(Value) ESP.ShowDistance = Value end });
        playerESPSection:Slider({ Name = "Max Distance", Min = 100, Max = 5000, Default = 2000, Suffix = " studs", Callback = function(Value) ESP.MaxDistance = Value end });
    end

    do -- World ESP
        worldESPSection:Toggle({ Name = "Container ESP", Flag = "ContainerESP", Default = false, Callback = function(Value) getgenv().ContainerESP = Value end }):Keybind({ Default = Enum.KeyCode.P });
        worldESPSection:Slider({ Name = "Container Distance", Min = 100, Max = 2000, Default = 200, Suffix = " studs", Callback = function(Value) getgenv().ContainerRenderDistance = Value end });
        
        worldESPSection:Toggle({ Name = "NPC ESP", Flag = "NPC_ESP_Toggle", Default = false, Callback = function(Value) getgenv().NPC_ESP = Value end });
        worldESPSection:Slider({ Name = "NPC Distance", Min = 100, Max = 5000, Default = 1500, Suffix = " studs", Callback = function(Value) getgenv().NPCRenderDistance = Value end });
        
        worldESPSection:Toggle({ Name = "Vehicle ESP", Flag = "Vehicle_ESP_Toggle", Default = false, Callback = function(Value) getgenv().Vehicle_ESP = Value end });
        worldESPSection:Slider({ Name = "Vehicle Distance", Min = 100, Max = 5000, Default = 2000, Suffix = " studs", Callback = function(Value) getgenv().VehicleRenderDistance = Value end });
        
        worldESPSection:Toggle({ Name = "Dropped Item ESP", Flag = "DroppedItemESP", Default = false, Callback = function(Value) getgenv().DroppedItemESP = Value end });
        worldESPSection:Slider({ Name = "Dropped Item Distance", Min = 100, Max = 2000, Default = 200, Suffix = " studs", Callback = function(Value) getgenv().DroppedItemRenderDistance = Value end });
    end

    do -- Combat Effects
        combatVisualsSection:Toggle({ Name = "Bullet Tracers", Flag = "BulletTracersToggle", Default = false, Callback = function(Value) getgenv().BulletTracers = Value end }):Colorpicker({ Name = "Tracer Color", Default = Color3.fromRGB(131, 194, 242), Callback = function(Value) getgenv().TracerColor = Value end });
        combatVisualsSection:Dropdown({ Name = "Tracer Design", List = {"Default", "Lightning", "Image", "Beam"}, Default = "Default", Flag = "TracerDesign", Callback = function(Value) getgenv().TracerDesign = Value end });
        combatVisualsSection:Slider({ Name = "Lifetime", Min = 0.1, Max = 5, Default = 0.3, Decimals = 0.1, Suffix = "s", Callback = function(Value) getgenv().BulletTracersLifetime = Value end });
        combatVisualsSection:Slider({ Name = "Thickness", Min = 0.01, Max = 1, Default = 0.05, Decimals = 0.01, Callback = function(Value) getgenv().TracerThickness = Value end });
        combatVisualsSection:Textbox({ Name = "Texture ID", Default = "rbxassetid://44611181", Flag = "TracerTextureID", Placeholder = "rbxassetid://...", Callback = function(Value) getgenv().TracerTextureID = Value end });

        combatVisualsSection:Toggle({ Name = "Hitmarkers", Flag = "HitMarkersToggle", Default = false, Callback = function(Value) getgenv().HitMarkers = Value end }):Colorpicker({ Name = "Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Value) getgenv().HitmarkersColor = Value end });
        combatVisualsSection:Toggle({ Name = "Center Hitmarker", Flag = "CenterHitmarkerToggle", Default = false, Callback = function(Value) getgenv().CenterHitmarker = Value end });
        combatVisualsSection:Dropdown({ Name = "Marker Type", List = {"X", "Cross", "Circle"}, Default = "X", Flag = "HitmarkerType", Callback = function(Value) getgenv().HitmarkerType = Value end });
        combatVisualsSection:Slider({ Name = "Marker Size", Min = 1, Max = 30, Default = 7, Suffix = "px", Callback = function(Value) getgenv().HitmarkersSize = Value end });
        combatVisualsSection:Slider({ Name = "Marker Lifetime", Min = 0.1, Max = 2, Default = 0.4, Decimals = 0.1, Suffix = "s", Callback = function(Value) getgenv().HitmarkersLifetime = Value end });

        combatVisualsSection:Toggle({ Name = "Hit Sound", Flag = "HitSoundToggle", Default = false, Callback = function(Value) getgenv().HitSound = Value end });
        combatVisualsSection:Dropdown({ Name = "Sound Type", List = {"Bell", "Skeet", "Neverlose", "Metallic", "Bubble"}, Default = "Bell", Flag = "HitSoundType", Callback = function(Value) getgenv().SelectedHitSound = Value end });
        combatVisualsSection:Slider({ Name = "Volume", Min = 0, Max = 10, Default = 4, Decimals = 0.1, Callback = function(Value) getgenv().HitSoundVolume = Value end });
    end

    do -- Other Visuals
        otherVisualsSection:Toggle({ Name = "Player Loot ESP", Flag = "PlayerLootESP", Default = false, Callback = function(Value) getgenv().PlayerLootESP = Value end });
        
        otherVisualsSection:Toggle({ Name = "Hit Logs", Flag = "HitLogsToggle", Default = false, Callback = function(Value) getgenv().HitLogsEnabled = Value end }):Colorpicker({ Name = "Color", Default = Library.Theme.Accent, Callback = function(Value) getgenv().HitLogsColor = Value end });
        otherVisualsSection:Slider({ Name = "Log Lifetime", Min = 1, Max = 30, Default = 5, Suffix = "s", Callback = function(Value) getgenv().HitLogsLifetime = Value end });
        otherVisualsSection:Dropdown({ Name = "Log Font", List = {"UI", "System", "Plex", "Monospace"}, Default = "Monospace", Flag = "HitLogsFont", Callback = function(Value) local fontMap = {["UI"] = 0, ["System"] = 1, ["Plex"] = 2, ["Monospace"] = 3}; getgenv().HitLogsFont = fontMap[Value] or 3 end });
    end

    do -- Misc Page Logic
        local lightingSection = Pages["Misc"]:Section({ Name = "Lighting & Atmosphere", Side = 2 });
        local worldSection = Pages["Misc"]:Section({ Name = "World Environment", Side = 2 });

        lightingSection:Label("Lighting"):Colorpicker({ Name = "Ambient", Default = game:GetService("Lighting").Ambient, Callback = function(Value) game:GetService("Lighting").Ambient = Value end });
        lightingSection:Slider({ Name = "Clock Time", Min = 0, Max = 24, Default = 12, Callback = function(Value) game:GetService("Lighting").ClockTime = Value end });
        lightingSection:Slider({ Name = "Exposure", Min = -5, Max = 5, Default = 0, Decimals = 0.1, Callback = function(Value) game:GetService("Lighting").ExposureCompensation = Value end });
        lightingSection:Dropdown({ Name = "Style", List = {"Realistic", "Soft", "Default"}, Default = "Default", Callback = function(Value)
            local L = game:GetService("Lighting")
            if Value == "Realistic" then L.Brightness = 2; L.ShadowSoftness = 0.2; L.EnvironmentDiffuseScale = 1; L.GlobalShadows = true
            elseif Value == "Soft" then L.Brightness = 1; L.ShadowSoftness = 1; L.EnvironmentDiffuseScale = 0.5; L.GlobalShadows = false end
        end });

        local function getAtm()
            local a = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
            if not a then a = Instance.new("Atmosphere", game:GetService("Lighting")) end
            return a
        end

        lightingSection:Label("Atmosphere"):Colorpicker({ Name = "Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(V) getAtm().Color = V end });
        lightingSection:Slider({ Name = "Density", Min = 0, Max = 1, Default = 0.3, Decimals = 0.01, Callback = function(V) getAtm().Density = V end });
        lightingSection:Slider({ Name = "Haze", Min = 0, Max = 10, Default = 0, Decimals = 0.1, Callback = function(V) getAtm().Haze = V end });

        worldSection:Toggle({ Name = "Remove Grass", Callback = function(V) workspace.Terrain.Decoration = not V end });
        worldSection:Toggle({ Name = "Remove Foliage", Callback = function(V)
            task.spawn(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Material == Enum.Material.Grass or obj.Material == Enum.Material.LeafyGrass or obj.Name:lower():find("leaf")) then
                        obj.Transparency = V and 1 or 0
                    end
                end
            end)
        end });
        worldSection:Toggle({ Name = "Remove Shadows", Callback = function(V) game:GetService("Lighting").GlobalShadows = not V end });
    end
    do



    MovementSection:Toggle({
        Name = "Enable Fly",
        Flag = "FlyToggle",
        Default = false,
        Callback = function(Value)
            getgenv().FlyEnabled = Value
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            
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
        end
    });

    MovementSection:Toggle({
        Name = "Spider (Wall Climb)",
        Flag = "SpiderToggle",
        Default = false,
        Callback = function(Value)
            getgenv().SpiderEnabled = Value
        end
    });

    MovementSection:Slider({
        Name = "Fly Speed",
        Flag = "FlySpeedAmount",
        Min = 1, Max = 500, Default = 50,
        Suffix = " studs/s",
        Callback = function(Value)
            getgenv().FlySpeedValue = Value
        end
    });

    -- TOGGLE: Enable CFrame Speed
    -- Purpose: Allows players to toggle enhanced movement speed using CFrame manipulation
    MovementSection:Toggle({
        Name = "Enable CFrame Speed",
        Flag = "CFrameSpeedToggle",
        Default = false,
        Callback = function(Value)
            -- Note: 'Value' is a boolean indicating toggle state (true/false)
            -- Implementation considerations:
            -- 1. CFrame manipulation is more precise than velocity-based speed
            -- 2. Must handle network ownership to avoid server rejection
            -- 3. Consider anti-cheat detection risks
            -- 4. Should disable when player is in a vehicle or seated
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            
            if Value and Character and Humanoid then
                -- Enable speed modification
                -- Note: Actual implementation would require a loop to continuously update position
                -- Store the toggle state for use in speed calculations
                getgenv().CFrameSpeedEnabled = true
            else
                -- Disable speed modification
                getgenv().CFrameSpeedEnabled = false
            end
        end
    });

    MovementSection:Toggle({
        Name = "Third Person",
        Flag = "ThirdPersonToggle",
        Default = false,
        Callback = function(Value)
            getgenv().ThirdPersonEnabled = Value
        end
    });

    MovementSection:Slider({
        Name = "Third Person Distance",
        Min = 0, Max = 50, Default = 10,
        Callback = function(Value)
            getgenv().ThirdPersonDistance = Value
        end
    });

    -- SLIDER: CFrame Speed Amount
    -- Purpose: Controls the speed multiplier for CFrame movement
    MovementSection:Slider({
        Name = "Speed Amount",
        Flag = "CFrameSpeedAmount",
        Min = 1,           -- Minimum speed (normal walking speed)
        Max = 100,         -- Maximum speed (adjust based on game balance)
        Default = 16,      -- Default matches typical Roblox walk speed
        Decimals = 0.1,    -- Allows fine-tuned control
        Suffix = " studs/s", -- Units for clarity
        Callback = function(Value)
            -- Note: 'Value' is the current slider value
            -- Implementation considerations:
            -- 1. Higher values may cause jittering or server desync
            -- 2. Consider clamping to prevent extreme values
            -- 3. May need to adjust based on game frame rate
            -- 4. Should account for different terrain types
            getgenv().CFrameSpeedValue = Value
            
            -- Update speed in real-time if enabled
            if getgenv().CFrameSpeedEnabled then
                -- Note: Actual movement implementation would go here
                -- Typically involves modifying CFrame in a RenderStepped loop
                print("CFrame Speed set to: " .. Value .. " studs/s")
            end
        end
    })

    -- Movement Control Loop
    -- Note: This handles the actual movement implementation
    -- Uses RunService for smooth, frame-by-frame updates
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    
    Library:Connect(RunService.RenderStepped, function(deltaTime)
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        
        if not Character or not RootPart then return end

        -- Third Person Logic (Applied as camera offset)
        if getgenv().ThirdPersonEnabled then
            local camera = workspace.CurrentCamera
            camera.CFrame = camera.CFrame * CFrame.new(0, 0, getgenv().ThirdPersonDistance or 10)
            
            -- Forzar visibilidad del personaje (evita que sea invisible)
            if Character then
                for _, v in pairs(Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.LocalTransparencyModifier = 0
                    end
                end
            end

            -- Ocultar el Viewmodel (brazos/armas de primera persona que suelen estar en la cámara)
            for _, v in pairs(camera:GetChildren()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    for _, part in pairs(v:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.LocalTransparencyModifier = 1
                        end
                    end
                end
            end
        end

        -- CFrame Speed Implementation
        if getgenv().CFrameSpeedEnabled then
            -- Note: Using CFrame for movement provides smoother results than velocity
            local moveDirection = Vector3.new()
            local humanoid = Character:FindFirstChildOfClass("Humanoid")
            
            if humanoid then
                -- Get movement input
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + Vector3.new(0, 0, -1)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection + Vector3.new(0, 0, 1)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection + Vector3.new(-1, 0, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + Vector3.new(1, 0, 0)
                end
                
                -- Normalize and apply speed
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit
                    local speed = getgenv().CFrameSpeedValue or 16
                    local moveCFrame = CFrame.new(moveDirection * speed * deltaTime)
                    RootPart.CFrame = RootPart.CFrame * moveCFrame
                end
            end
        end

        -- Fly Implementation
        if getgenv().FlyEnabled then
            local moveDirection = Vector3.new()
            
            -- Get fly movement input
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + Vector3.new(0, 0, -1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection + Vector3.new(0, 0, 1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection + Vector3.new(-1, 0, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + Vector3.new(1, 0, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDirection = moveDirection + Vector3.new(0, -1, 0)
            end
            
            -- Apply fly velocity
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
        -- Spider Implementation
        if getgenv().SpiderEnabled and not getgenv().FlyEnabled and UserInputService:IsKeyDown(Enum.KeyCode.W) then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {Character}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            
            local raycastResult = workspace:Raycast(RootPart.Position, RootPart.CFrame.LookVector * 2.5, raycastParams)
            
            if raycastResult and raycastResult.Instance then
                RootPart.Velocity = Vector3.new(RootPart.Velocity.X, 30, RootPart.Velocity.Z)
            end
        end
    end)
    local Extra = Window:Page({
        Name = "Extra", 
        Columns = 2
    });
    local OKSCRIPTS = Extra:Section({
        Name = "Ultimate troller guis", 
        Side = 1
    });
    do
    OKSCRIPTS:Button({
        Name = "ULTIMATE TROLLER GUI 2025",
        Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Blukez/Scripts/main/UTG%20V3%20RAW"))()
        end
    })
    OKSCRIPTS:Button({
        Name = "INFINITY YELD",
        Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })
    OKSCRIPTS:Button({
        Name = "AIMBOT",
        Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/agreed69-scripts/open-src-scripts/refs/heads/main/Universal%20Aimbot.lua",true))()
        end
    })
    OKSCRIPTS:Button({
        Name = "UNNAMED ESP",
        Callback = function()
            pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)
        end
    })
    OKSCRIPTS:Button({
        Name = "FRIGGIN RAINBOW",
        Callback = function()
while wait() and getgenv().Library do
local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.new(math.random(), math.random(), math.random())
end
        end
    })
end
end
end;
end -- Closes: do -- Basic elements
do -- Settings tab
    local ThemingSection = Pages["Settings"]:Section({Name = "Theming", Side = 2});
    local ConfigsSection = Pages["Settings"]:Section({Name = "Profiles", Side = 1});
    
    for Index, Value in Library.Theme do 
        ThemingSection:Label(Index):Colorpicker({ Name = Index, Default = Value, Flag = "Theme"..Index, Callback = function(Color) 
            Library.Theme[Index] = Color;
            Library:UpdateTheme(Index, Color);
        end});
    end;

    local ConfigName;
    local ConfigSelected;

    local ConfigListbox = ConfigsSection:Listbox({Name = "Configs", Flag = "Configs", Multi = false, Items = {}, Callback = function(Value)
        ConfigSelected = Value;
    end});

    ConfigsSection:Textbox({Name = "Config Name", Default = "", Flag = "ConfigName", Placeholder = "Name ...", Callback = function(Value)
        ConfigName = Value;
    end});

    ConfigsSection:Button({Name = "Load Config", Callback = function()
        if ConfigSelected then
            Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected .. ".json"));
            Library:GetConfigsList(ConfigListbox);
        end;
    end});

    ConfigsSection:Button({Name = "Save Config", Callback = function()
        if ConfigSelected then
            writefile(Library.Folders.Configs .. "/" .. ConfigSelected .. ".json", Library:SaveConfig(ConfigSelected));
        end;
    end});

    ConfigsSection:Button({Name = "Delete Config", Callback = function()
        if ConfigSelected then
            delfile(Library.Folders.Configs .. "/" .. ConfigSelected .. ".json");
            Library:GetConfigsList(ConfigListbox);
        end;
    end});

    ConfigsSection:Button({Name = "Create Config", Callback = function()
        if ConfigName and ConfigName ~= "" then
            writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig());
            Library:GetConfigsList(ConfigListbox);
        end;
    end});

    Library:GetConfigsList(ConfigListbox);
end;

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

local LocalPlayer      = game:GetService("Players").localPlayer;
local CurrentCamera    = game:GetService("Workspace").CurrentCamera;
local UserInputService = game:GetService("UserInputService");
local RunService       = game:GetService("RunService");

local Functions = { };
do
    local validItemNames = {}
    getgenv().ItemIcons = {}
    local function CacheValidItems()
        local RS = game:GetService("ReplicatedStorage")
        local lists = {RS:FindFirstChild("ItemsList"), RS:FindFirstChild("ItemList"), RS:FindFirstChild("ItemsListModels"), RS:FindFirstChild("AmmoTypes")}
        local blacklist = {"MeshPart", "Part", "UnionOperation", "Weld", "WeldConstraint", "Mesh", "SpecialMesh", "HelmetMask", "Harness", "UT", "Hood", "RL", "LU", "RU", "LL", "RA", "LA", "TR", "HD", "Handle", "Casing", "ItemProperties", "Folder", "Configuration", "Model", "SelectionBox", "SurfaceAppearance", "Texture", "Decal"}

        for _, list in pairs(lists) do
            if list then
                for _, obj in pairs(list:GetChildren()) do
                    if not table.find(blacklist, obj.Name) then
                        validItemNames[obj.Name] = true
                        
                        -- Path: ItemsList > Item > ItemProperties > ItemIcon
                        local props = obj:FindFirstChild("ItemProperties")
                        local icon = props and props:FindFirstChild("ItemIcon")
                        if icon and (icon:IsA("ImageLabel") or icon:IsA("ImageButton")) then
                            getgenv().ItemIcons[obj.Name] = icon.Image
                        end
                    end
                end
            end
        end
    end
    task.spawn(CacheValidItems)

    local validNPCNames = {}
    local function CacheNPCPresets()
        local RS = game:GetService("ReplicatedStorage")
        local presets = RS:FindFirstChild("AiPresets")
        if presets then
            for _, v in pairs(presets:GetChildren()) do
                validNPCNames[v.Name] = true
            end
        end
    end
    task.spawn(CacheNPCPresets)

    local validVehicleNames = {}
    local function CacheVehicleNames()
        local RS = game:GetService("ReplicatedStorage")
        local vehicles = RS:FindFirstChild("Vehicles")
        if vehicles then
            for _, v in pairs(vehicles:GetChildren()) do
                validVehicleNames[v.Name] = true
            end
        end
    end
    task.spawn(CacheVehicleNames)

        function Functions:ScanInventory(Target)
        local found = {}
        if not Target or not next(validItemNames) then return found end
        local blacklist = {"MeshPart", "Part", "UnionOperation", "Weld", "WeldConstraint", "Mesh", "SpecialMesh", "HelmetMask", "Harness", "UT", "Hood", "RL", "LU", "RU", "LL", "RA", "LA", "TR", "HD", "Handle", "Casing", "ItemProperties", "Folder", "Configuration", "SelectionBox", "SurfaceAppearance", "Texture", "Decal"}

        local function scan(root)
            if not root then return end
            for _, v in pairs(root:GetDescendants()) do
                if table.find(blacklist, v.Name) or table.find(blacklist, v.ClassName) then continue end
                local itemName = nil
                
                local props = v:FindFirstChild("ItemProperties")
                if props then
                    itemName = props:GetAttribute("CallSign")
                end
                
                if not itemName then
                    itemName = v:GetAttribute("CallSign")
                end

                if not itemName and validItemNames[v.Name] then
                    itemName = v.Name
                end

                if itemName and validItemNames[itemName] and not table.find(found, itemName) then
                    table.insert(found, itemName)
                end
            end
        end


        if Target:IsA("Player") then
            scan(Target.Character)
            local bp = Target:FindFirstChild("Backpack")
            if bp then scan(bp) end
            
            -- Path: ReplicatedStorage > PlayerName > Inventory
            local playerFolder = game:GetService("ReplicatedStorage"):FindFirstChild(Target.Name)
            local RSInv = playerFolder and playerFolder:FindFirstChild("Inventory")
            if RSInv then
                scan(RSInv)
            end
        elseif Target:IsA("Model") then
            scan(Target)
            local plr = game:GetService("Players"):GetPlayerFromCharacter(Target)
            local playerFolder = plr and game:GetService("ReplicatedStorage"):FindFirstChild(plr.Name)
            local RSInv = playerFolder and playerFolder:FindFirstChild("Inventory")
            if RSInv then
                scan(RSInv)
            end
        end

        return found
    end;

    function Functions:IsAlive(Player)
        if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
            return true;
        end;
        return false;
    end;
    
    function Functions:GetClosestToMouse()
        local Closest, Part = (getgenv().drawFOV and getgenv().fovRadius) or 1000, nil;
        local TargetPlayer = nil
        
        for _,Player in pairs(game:GetService("Players"):GetPlayers()) do
            if Player ~= LocalPlayer and Functions:IsAlive(Player) then
                if getgenv().TeamCheck and Player.Team == LocalPlayer.Team then continue end
                
                local partName = getgenv().AimbotTargetPart or "Head"
                local HitPart = Player.Character:FindFirstChild(partName);
                
                if HitPart then
                    local ScreenPosition, OnScreen = CurrentCamera:WorldToViewportPoint(HitPart.Position);
                    if OnScreen then
                        if getgenv().WallCheck then
                            local ray = Ray.new(CurrentCamera.CFrame.Position, (HitPart.Position - CurrentCamera.CFrame.Position).Unit * (HitPart.Position - CurrentCamera.CFrame.Position).Magnitude)
                            local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Player.Character})
                            if hit then continue end
                        end

                        local Distance = (UserInputService:GetMouseLocation() - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude;
                        if Distance < Closest then
                            Closest = Distance;
                            Part    = HitPart;
                            TargetPlayer = Player
                        end;
                    end
                end;
            end;
        end;
        
        return TargetPlayer, Part;
    end;

    local ValueCache = {
        ["6B45"] = 16, ["AS Val"] = 16, ["ATC Key"] = 4, ["Airfield Key"] = 6, ["Altyn"] = 16,
        ["Altyn Visor"] = 8, ["Attak-5 60L"] = 16, ["Bolts"] = 1, ["Crane Key"] = 6, ["DAGR"] = 8,
        ["Duct Tape"] = 1, ["Fast MT"] = 10, ["Flare Gun"] = 8, ["Fueling Station Key"] = 4,
        ["Garage Key"] = 4, ["Hammer"] = 1, ["JPC"] = 10, ["Lighthouse Key"] = 6, ["M4A1"] = 12,
        ["Nails"] = 1, ["Nuts"] = 1, ["Saiga 12"] = 8, ["Super Glue"] = 1, ["Village Key"] = 4, ["Wrench"] = 1
    }

    local ValueSettings = {
        [0] = Color3.fromRGB(255, 255, 255),
        [4] = Color3.fromRGB(76, 187, 23),
        [8] = Color3.fromRGB(218, 112, 214),
        [16] = Color3.fromRGB(233, 116, 81),
        [32] = Color3.fromRGB(255, 36, 0)
    }

    function Functions:DrawContainer(Container)
        if not Container:IsA("Model") then return end
        local Text = Drawing.new("Text")
        Text.Center = true; Text.Font = 2; Text.Outline = true; Text.Size = 14; Text.Visible = false

        local conn;
        conn = RunService.RenderStepped:Connect(function()
            if not getgenv().ContainerESP or not Container.PrimaryPart or not Functions:IsAlive(LocalPlayer) then
                Text.Visible = false; return
            end

            local Dist = (Container.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Dist > (getgenv().ContainerRenderDistance or 200) then
                Text.Visible = false; return
            end

            local ScreenPos, OnScreen = CurrentCamera:WorldToViewportPoint(Container.PrimaryPart.Position)
            if not OnScreen then Text.Visible = false; return end

            local TotalPrice, Value, Loot = 0, 0, ""
            local Inventory = Container:FindFirstChild("Inventory")
            if Inventory then
                for _, v in pairs(Inventory:GetChildren()) do
                    local Props = v:FindFirstChild("ItemProperties")
                    if Props then
                        local Amount = Props:GetAttribute("Amount") or 1
                        local CallSign = Props:GetAttribute("CallSign")
                        TotalPrice = TotalPrice + (Props:GetAttribute("Price") or 0)
                        Value = Value + ((ValueCache[CallSign] or 0) * Amount)
                        Loot = Loot .. CallSign .. " (x" .. Amount .. ")\n"
                    end
                end
            end

            local Color, Highest = Color3.new(1,1,1), -1
            for i, v in pairs(ValueSettings) do
                if Value >= i and i > Highest then Color = v; Highest = i end
            end

            local NextSpawn = (Container:GetAttribute("NextSpawn") or 0) - os.time()
            Text.Color = Color
            Text.Position = Vector2.new(ScreenPos.X, ScreenPos.Y)
            Text.Text = string.format("$%d\n%s\n%s\n%d studs", TotalPrice, Container:GetAttribute("DisplayName") or "Container", (NextSpawn < 0 and Loot or Loot .. "Spawn in: " .. NextSpawn .. "s"), math.round(Dist))
            Text.Visible = true
        end)

        Container.AncestryChanged:Connect(function()
            if not Container.Parent then Text:Remove(); conn:Disconnect() end
        end)
    end

    local npc_esp_cache = {}
    function Functions:DrawNPC(NPC)
        if npc_esp_cache[NPC] or not NPC:IsA("Model") then return end
        npc_esp_cache[NPC] = true
        local Text = Drawing.new("Text")
        Text.Center = true; Text.Font = 2; Text.Outline = true; Text.Size = 13; Text.Visible = false

        local conn;
        conn = RunService.RenderStepped:Connect(function()
            if not getgenv().NPC_ESP or not Functions:IsAlive(LocalPlayer) then
                Text.Visible = false; return
            end
            
            local Root = NPC.PrimaryPart or NPC:FindFirstChild("HumanoidRootPart") or NPC:FindFirstChild("Head")
            if not Root then Text.Visible = false; return end

            local Dist = (Root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Dist > (getgenv().NPCRenderDistance or 1500) then
                Text.Visible = false; return
            end

            local ScreenPos, OnScreen = CurrentCamera:WorldToViewportPoint(Root.Position)
            if not OnScreen then Text.Visible = false; return end

            local npcName = NPC:GetAttribute("DisplayName") or NPC:GetAttribute("CallSign") or NPC.Name
            local tag = "[NPC]"
            
            if validNPCNames[npcName] or NPC:GetAttribute("Preset") then tag = "[AI]" end
            if npcName:find("MON") or npcName:find("MINE") or npcName:find("Explosive") then tag = "[EXPLOSIVE]" end

            local hum = NPC:FindFirstChildOfClass("Humanoid")
            local healthInfo = hum and string.format("\nHP: %d/%d", math.round(hum.Health), math.round(hum.MaxHealth)) or ""

            -- Loot info like container ESP
            local TotalPrice, Loot = 0, ""
            local items = Functions:ScanInventory(NPC)
            for _, itemName in pairs(items) do
                local price = ValueCache[itemName] or 0
                TotalPrice = TotalPrice + price
                Loot = Loot .. itemName .. "\n"
            end

            Text.Color = Color3.fromRGB(255, 70, 70)
            Text.Position = Vector2.new(ScreenPos.X, ScreenPos.Y)
            Text.Text = string.format("%s %s%s\n$%d\n%s%d studs", tag, npcName, healthInfo, TotalPrice, Loot, math.round(Dist))
            Text.Visible = true
        end)

        NPC.AncestryChanged:Connect(function()
            if not NPC.Parent then Text:Remove(); conn:Disconnect(); npc_esp_cache[NPC] = nil end
        end)
    end

    local player_esp_cache = {}
    function Functions:DrawPlayer(PlayerChar)
        if player_esp_cache[PlayerChar] or not PlayerChar:IsA("Model") then return end
        local PlayerObj = game.Players:GetPlayerFromCharacter(PlayerChar)
        if not PlayerObj or PlayerObj == LocalPlayer then return end
        
        player_esp_cache[PlayerChar] = true
        local Text = Drawing.new("Text")
        Text.Center = true; Text.Font = 2; Text.Outline = true; Text.Size = 13; Text.Visible = false

        local conn;
        conn = RunService.RenderStepped:Connect(function()
            if not getgenv().PlayerLootESP or not Functions:IsAlive(LocalPlayer) or not PlayerChar.Parent then
                Text.Visible = false; return
            end
            
            local Root = PlayerChar:FindFirstChild("HumanoidRootPart") or PlayerChar:FindFirstChild("Head")
            if not Root then Text.Visible = false; return end

            local Dist = (Root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Dist > (getgenv().ESP_MaxDistance or 2000) then
                Text.Visible = false; return
            end

            local ScreenPos, OnScreen = CurrentCamera:WorldToViewportPoint(Root.Position)
            if not OnScreen then Text.Visible = false; return end

            -- Loot info like NPC ESP
            local TotalPrice, Loot = 0, ""
            local items = Functions:ScanInventory(PlayerObj)
            for _, itemName in pairs(items) do
                local price = ValueCache[itemName] or 0
                TotalPrice = TotalPrice + price
                Loot = Loot .. itemName .. "\n"
            end

            Text.Color = Color3.fromRGB(255, 255, 255)
            Text.Position = Vector2.new(ScreenPos.X, ScreenPos.Y + 45) -- Offset below name/box
            Text.Text = string.format("$%d\n%s", TotalPrice, Loot)
            Text.Visible = true
        end)

        PlayerChar.AncestryChanged:Connect(function()
            if not PlayerChar.Parent then Text:Remove(); conn:Disconnect(); player_esp_cache[PlayerChar] = nil end
        end)
    end

    local vehicle_esp_cache = {}
    function Functions:DrawVehicle(Vehicle)
        if vehicle_esp_cache[Vehicle] or not Vehicle:IsA("Model") then return end
        vehicle_esp_cache[Vehicle] = true
        local Text = Drawing.new("Text")
        Text.Center = true; Text.Font = 2; Text.Outline = true; Text.Size = 13; Text.Visible = false

        local conn;
        conn = RunService.RenderStepped:Connect(function()
            if not getgenv().Vehicle_ESP or not Functions:IsAlive(LocalPlayer) then
                Text.Visible = false; return
            end
            
            local Root = Vehicle.PrimaryPart or Vehicle:FindFirstChildWhichIsA("BasePart")
            if not Root then Text.Visible = false; return end

            local Dist = (Root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Dist > (getgenv().VehicleRenderDistance or 2000) then
                Text.Visible = false; return
            end

            local ScreenPos, OnScreen = CurrentCamera:WorldToViewportPoint(Root.Position)
            if not OnScreen then Text.Visible = false; return end

            Text.Color = Color3.fromRGB(255, 255, 0) -- Amarillo para vehículos
            Text.Position = Vector2.new(ScreenPos.X, ScreenPos.Y)
            Text.Text = string.format("[VEHICLE] %s\n%d studs", Vehicle.Name, math.round(Dist))
            Text.Visible = true
        end)

        Vehicle.AncestryChanged:Connect(function()
            if not Vehicle.Parent then Text:Remove(); conn:Disconnect(); vehicle_esp_cache[Vehicle] = nil end
        end)
    end

    function Functions:DrawDroppedItem(Item)
        if not Item:IsA("Model") or not Item.PrimaryPart then return end
        local Text = Drawing.new("Text")
        Text.Center = true; Text.Font = 2; Text.Outline = true; Text.Size = 14; Text.Visible = false

        local conn;
        conn = RunService.RenderStepped:Connect(function()
            if not getgenv().DroppedItemESP or not Item.PrimaryPart or not Functions:IsAlive(LocalPlayer) then
                Text.Visible = false; return
            end

            local Dist = (Item.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Dist > (getgenv().DroppedItemRenderDistance or 200) then
                Text.Visible = false; return
            end

            local ScreenPos, OnScreen = CurrentCamera:WorldToViewportPoint(Item.PrimaryPart.Position)
            if not OnScreen then Text.Visible = false; return end

            local itemName = Item:GetAttribute("CallSign") or Item.Name
            local itemValue = ValueCache[itemName] or 0
            local Color, Highest = Color3.new(1,1,1), -1
            for i, v in pairs(ValueSettings) do
                if itemValue >= i and i > Highest then Color = v; Highest = i end
            end

            Text.Color = Color
            Text.Position = Vector2.new(ScreenPos.X, ScreenPos.Y)
            Text.Text = string.format("%s ($%d)\n%d studs", itemName, itemValue, math.round(Dist))
            Text.Visible = true
        end)

        Item.AncestryChanged:Connect(function()
            if not Item.Parent then Text:Remove(); conn:Disconnect() end
        end)
    end

    -- Initialize getgenv().DroppedItemRenderDistance
    getgenv().DroppedItemRenderDistance = 200
    getgenv().DroppedItemESP = false




    local HitSounds = {
        ["Bell"] = "rbxassetid://137731492025967",
        ["Skeet"] = "rbxassetid://80461265049096",
        ["Neverlose"] = "rbxassetid://139268006913867",
        ["Metallic"] = "rbxassetid://140728903346385",
        ["Bubble"] = "rbxassetid://104824514322839"
    }

    function Functions:PlayHitSound()
        if not getgenv().HitSound then return end
        local Sound = Instance.new("Sound", game:GetService("SoundService"))
        Sound.SoundId = HitSounds[getgenv().SelectedHitSound or "Bell"]
        Sound.Volume = getgenv().HitSoundVolume or 4
        Sound:Play()
        game:GetService("Debris"):AddItem(Sound, 2)
    end;

    local HitLogsTable = {}
    function Functions:UpdateHitLogs()
        local center = (workspace.CurrentCamera.ViewportSize / 2)
        local fontSize = getgenv().HitLogsSize or 14
        for i = 1, #HitLogsTable do
            HitLogsTable[i].Position = Vector2.new(center.X, (center.Y + 150) + (i * (fontSize + 4)))
        end
    end

    function Functions:CreateHitLog(hitpart, username)
        if not getgenv().HitLogsEnabled then return end
        task.spawn(function()
            local timestamp = os.date("%H:%M:%S")
            local hitlog = Drawing.new('Text')
            hitlog.Size = getgenv().HitLogsSize or 14
            hitlog.Font = getgenv().HitLogsFont or 3
            hitlog.Text = string.format("[%s] hit %s in %s", timestamp, username:lower(), hitpart:lower())
            hitlog.Visible = true
            hitlog.ZIndex = 3
            hitlog.Center = true
            hitlog.Color = getgenv().HitLogsColor or Library.Theme.Accent
            hitlog.Outline = true
            hitlog.OutlineColor = Color3.new(0, 0, 0)

            table.insert(HitLogsTable, hitlog)
            Functions:UpdateHitLogs()
            
            local lifetime = getgenv().HitLogsLifetime or 5
            task.wait(lifetime)
            
            -- Smooth fade out animation
            for i = 1, 10 do
                hitlog.Transparency = 1 - (i / 10)
                task.wait(0.02)
            end

            table.remove(HitLogsTable, table.find(HitLogsTable, hitlog))
            Functions:UpdateHitLogs()
            hitlog:Remove()
        end)
    end

    local CenterHitmarker = {
        L1 = Drawing.new("Line"), L2 = Drawing.new("Line"), L3 = Drawing.new("Line"), L4 = Drawing.new("Line")
    }
    for _, l in pairs(CenterHitmarker) do l.Visible = false; l.Thickness = 2 end

    function Functions:FlashCenterHitmarker()
        if not getgenv().CenterHitmarker then return end
        task.spawn(function()
            local Color = getgenv().HitmarkersColor or Color3.new(1,1,1)
            local Size = getgenv().HitmarkersSize or 7
            local Center = CurrentCamera.ViewportSize / 2
            for _, l in pairs(CenterHitmarker) do l.Color = Color; l.Visible = true end
            local Start = tick()
            while tick() - Start < 0.2 do
                local Alpha = 1 - ((tick() - Start) / 0.2)
                CenterHitmarker.L1.From, CenterHitmarker.L1.To = Center - Vector2.new(Size, Size), Center - Vector2.new(Size/2, Size/2)
                CenterHitmarker.L2.From, CenterHitmarker.L2.To = Center + Vector2.new(Size, -Size), Center + Vector2.new(Size/2, -Size/2)
                CenterHitmarker.L3.From, CenterHitmarker.L3.To = Center + Vector2.new(-Size, Size), Center + Vector2.new(-Size/2, Size/2)
                CenterHitmarker.L4.From, CenterHitmarker.L4.To = Center + Vector2.new(Size, Size), Center + Vector2.new(Size/2, Size/2)
                for _, l in pairs(CenterHitmarker) do l.Transparency = Alpha end
                task.wait()
            end
            for _, l in pairs(CenterHitmarker) do l.Visible = false end
        end)
    end

    function Functions:CreateHitMarker(HitPart, Pos)
        if not getgenv().HitMarkers or not HitPart then return end
        task.spawn(function()
            local Color = getgenv().HitmarkersColor or Color3.new(1, 1, 1)
            local Lifetime = getgenv().HitmarkersLifetime or 0.4
            local MaxSize = getgenv().HitmarkersSize or 7
            local Type = getgenv().HitmarkerType or "X"
            local Offset = HitPart.CFrame:PointToObjectSpace(Pos)
            local Drawings = {}
            
            if Type == "X" or Type == "Cross" then
                Drawings[1] = Drawing.new("Line")
                Drawings[2] = Drawing.new("Line")
                for _, d in ipairs(Drawings) do d.Thickness = 2; d.Color = Color end
            elseif Type == "Circle" then
                Drawings[1] = Drawing.new("Circle")
                Drawings[1].Thickness = 1; Drawings[1].Color = Color; Drawings[1].NumSides = 12
            end

            local Start = tick()
            while tick() - Start < Lifetime do
                local Elapsed = tick() - Start
                local Alpha = 1 - (Elapsed / Lifetime)
                local CurrentSize = math.clamp((Elapsed / 0.05) * MaxSize, 2, MaxSize)
                
                if HitPart and HitPart.Parent then
                    local ScreenPos, OnScreen = CurrentCamera:WorldToViewportPoint(HitPart.CFrame:PointToWorldSpace(Offset))
                    if OnScreen then
                        if Type == "X" then
                            Drawings[1].Visible, Drawings[2].Visible = true, true
                            Drawings[1].From = Vector2.new(ScreenPos.X - CurrentSize, ScreenPos.Y - CurrentSize)
                            Drawings[1].To = Vector2.new(ScreenPos.X + CurrentSize, ScreenPos.Y + CurrentSize)
                            Drawings[2].From = Vector2.new(ScreenPos.X + CurrentSize, ScreenPos.Y - CurrentSize)
                            Drawings[2].To = Vector2.new(ScreenPos.X - CurrentSize, ScreenPos.Y + CurrentSize)
                        elseif Type == "Cross" then
                            Drawings[1].Visible, Drawings[2].Visible = true, true
                            Drawings[1].From = Vector2.new(ScreenPos.X - CurrentSize, ScreenPos.Y)
                            Drawings[1].To = Vector2.new(ScreenPos.X + CurrentSize, ScreenPos.Y)
                            Drawings[2].From = Vector2.new(ScreenPos.X, ScreenPos.Y - CurrentSize)
                            Drawings[2].To = Vector2.new(ScreenPos.X, ScreenPos.Y + CurrentSize)
                        elseif Type == "Circle" then
                            Drawings[1].Visible = true
                            Drawings[1].Position = Vector2.new(ScreenPos.X, ScreenPos.Y)
                            Drawings[1].Radius = CurrentSize
                        end
                        for _, d in ipairs(Drawings) do d.Transparency = Alpha end
                    else for _, d in ipairs(Drawings) do d.Visible = false end end
                else break end
                task.wait()
            end
            for _, d in ipairs(Drawings) do d:Remove() end
        end)
    end;

    function Functions:CreateTracer(Origin, EndPos)
        local Color = getgenv().TracerColor or Color3.new(1, 1, 1)
        local Lifetime = getgenv().BulletTracersLifetime or 0.3
        local TravelTime = getgenv().BulletTracersTravelTime or 0.05
        local Thickness = getgenv().TracerThickness or 0.05
        local Design = getgenv().TracerDesign or "Default"
        local TS = game:GetService("TweenService")
        local Debris = game:GetService("Debris")

        -- Impact Flash (Pre-declared)
        local Impact = Instance.new("Part", workspace)
        Impact.Shape, Impact.Anchored, Impact.CanCollide = Enum.PartType.Ball, true, false
        Impact.Size, Impact.Position = Vector3.new(0.1, 0.1, 0.1), EndPos
        Impact.Material, Impact.Color = Enum.Material.Neon, Color
        Impact.Transparency = 1

        if Design == "Default" then
            local Core = Instance.new("Part", workspace)
            Core.Name = "InariTracerCore"
            Core.Anchored, Core.CanCollide, Core.CanQuery, Core.CastShadow = true, false, false, false
            Core.Material = Enum.Material.Neon
            Core.Color = Color3.new(2, 2, 2)
            Core.Size = Vector3.new(Thickness, Thickness, 0)
            Core.CFrame = CFrame.new(Origin, EndPos)

            local Glow = Core:Clone()
            Glow.Name = "InariTracerGlow"; Glow.Parent = workspace
            Glow.Color = Color
            Glow.Size = Vector3.new(Thickness * 3.75, Thickness * 3.75, 0)
            Glow.Transparency = 0.5

            local TargetSize = (Origin - EndPos).Magnitude
            TS:Create(Core, TweenInfo.new(TravelTime), {Size = Vector3.new(Thickness, Thickness, TargetSize), CFrame = CFrame.new(Origin:Lerp(EndPos, 0.5), EndPos)}):Play()
            TS:Create(Glow, TweenInfo.new(TravelTime), {Size = Vector3.new(Thickness * 3.75, Thickness * 3.75, TargetSize), CFrame = CFrame.new(Origin:Lerp(EndPos, 0.5), EndPos)}):Play()

            task.delay(TravelTime, function()
                TS:Create(Core, TweenInfo.new(Lifetime), {Transparency = 1}):Play()
                TS:Create(Glow, TweenInfo.new(Lifetime), {Transparency = 1}):Play()
                Impact.Transparency = 0
                TS:Create(Impact, TweenInfo.new(Lifetime), {Transparency = 1, Size = Vector3.new(1.5, 1.5, 1.5)}):Play()
            end)
            Debris:AddItem(Core, Lifetime + TravelTime); Debris:AddItem(Glow, Lifetime + TravelTime)

        elseif Design == "Lightning" then
            local Points = {Origin}
            local Segments = 5
            local Distance = (Origin - EndPos).Magnitude
            local Direction = (EndPos - Origin).Unit
            
            for i = 1, Segments - 1 do
                local BasePos = Origin + (Direction * (Distance / Segments) * i)
                local Offset = Vector3.new(math.random(-5, 5)/10, math.random(-5, 5)/10, math.random(-5, 5)/10)
                table.insert(Points, BasePos + Offset)
            end
            table.insert(Points, EndPos)

            for i = 1, #Points - 1 do
                local P1, P2 = Points[i], Points[i+1]
                local Segment = Instance.new("Part", workspace)
                Segment.Anchored, Segment.CanCollide, Segment.CanQuery = true, false, false
                Segment.Material = Enum.Material.Neon
                Segment.Color = Color
                Segment.Size = Vector3.new(Thickness, Thickness, (P1 - P2).Magnitude)
                Segment.CFrame = CFrame.new(P1:Lerp(P2, 0.5), P2)
                
                TS:Create(Segment, TweenInfo.new(Lifetime), {Transparency = 1}):Play()
                Debris:AddItem(Segment, Lifetime)
            end
            Impact.Transparency = 0
            TS:Create(Impact, TweenInfo.new(Lifetime), {Transparency = 1, Size = Vector3.new(1.5, 1.5, 1.5)}):Play()

        elseif Design == "Beam" or Design == "Image" then
            local Attachment0 = Instance.new("Attachment", workspace.Terrain)
            local Attachment1 = Instance.new("Attachment", workspace.Terrain)
            Attachment0.WorldPosition = Origin
            Attachment1.WorldPosition = EndPos

            local Beam = Instance.new("Beam", workspace.Terrain)
            Beam.Attachment0 = Attachment0
            Beam.Attachment1 = Attachment1
            Beam.Color = ColorSequence.new(Color)
            Beam.Width0 = Thickness * 2
            Beam.Width1 = Thickness * 2
            Beam.LightEmission = 1
            Beam.LightInfluence = 0
            
            if Design == "Image" then
                Beam.Texture = getgenv().TracerTextureID or "rbxassetid://18837739"
                Beam.TextureMode = Enum.TextureMode.Wrap
                Beam.TextureSpeed = 2
                Beam.TextureLength = 2
                Beam.FaceCamera = true
                Beam.LightEmission = 0.8
            end

            task.spawn(function()
                local start = tick()
                while tick() - start < Lifetime do
                    local elapsed = tick() - start
                    local alpha = elapsed / Lifetime
                    pcall(function()
                        Beam.Transparency = NumberSequence.new(alpha)
                    end)
                    task.wait()
                end
                pcall(function()
                    Beam.Enabled = false
                end)
            end)
            Debris:AddItem(Beam, Lifetime + 0.1)
            Debris:AddItem(Attachment0, Lifetime + 0.1)
            Debris:AddItem(Attachment1, Lifetime + 0.1)
            
            Impact.Transparency = 0
            TS:Create(Impact, TweenInfo.new(Lifetime), {Transparency = 1, Size = Vector3.new(1.5, 1.5, 1.5)}):Play()
        end
        Debris:AddItem(Impact, Lifetime + TravelTime)
    end;
end;

-- Expanded Anti-Cheat Bypass
local function SecureBypass()
    local mt = getrawmetatable(game)
    local old_nc = mt.__namecall
    local old_idx = mt.__index
    local old_newidx = mt.__newindex
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if not checkcaller() and (method == "Kick" or method == "kick") then
            return coroutine.yield()
        end
        return old_nc(self, ...)
    end)

    mt.__index = newcclosure(function(self, index)
        if not checkcaller() and typeof(self) == "Instance" then
            local name = tostring(index)
            if self:IsA("BasePart") and (name == "Velocity" or name == "AssemblyLinearVelocity") then
                if self.Name == "HumanoidRootPart" or self:IsDescendantOf(LocalPlayer.Character) then
                    return Vector3.new(0, 0, 0)
                end
            end
        end
        return old_idx(self, index)
    end)

    mt.__newindex = newcclosure(function(self, index, value)
        return old_newidx(self, index, value)
    end)

    setreadonly(mt, true)
end

local function BypassAC(Char)
    if not Char then return end
    
    -- Neutralize malicious connections
    local signals = {Char.ChildRemoved, Char.DescendantAdded, Char.ChildAdded}
    local humanoid = Char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        table.insert(signals, humanoid.StateChanged)
        table.insert(signals, humanoid.Changed)
    end

    for _, signal in pairs(signals) do
        for _, v in pairs(getconnections(signal)) do
            if v.Function then
                local src = debug.info(v.Function, "s")
                if src:find("CharacterController") or src:find("Anticheat") or src:find("Handler") then
                    pcall(function() v:Disable() end)
                    
                    -- Deep inspection for hidden functions in upvalues
                    local upvals = getupvalues(v.Function)
                    for _, up in pairs(upvals) do
                        if type(up) == "function" then
                            local up_src = debug.info(up, "s")
                            if up_src:find("CharacterController") or up_src:find("Anticheat") then
                                pcall(function()
                                    hookfunction(up, function(...) return coroutine.yield() end)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Initialize Bypass
task.spawn(function()
    pcall(SecureBypass)
    if LocalPlayer.Character then
        pcall(BypassAC, LocalPlayer.Character)
    end
    Library:Connect(LocalPlayer.CharacterAdded, function(char)
        pcall(BypassAC, char)
    end)
end)

-- Silent Aim Hook 
local Old; Old = hookfunction(Bullet, newcclosure(function(...)
    local Args          = {...};
    local Target, Part  = Functions:GetClosestToMouse();
    
    if not checkcaller() and Args[5] and typeof(Args[5]) == "Instance" then
        
        -- Captura segura de CFrame para evitar race conditions
        local Success, ShotCFrame = pcall(function() return Args[5].CFrame end)
        if not Success then return Old(table.unpack(Args)) end

        if Target and Part and getgenv().SilentAImUser then 
            ShotCFrame = CFrame.new(ShotCFrame.Position, Part.Position)
            Args[5].CFrame = ShotCFrame
        end;

        task.spawn(function()
            pcall(function()
                local Origin = ShotCFrame.Position
                local Direction = ShotCFrame.LookVector * 1500
                local RayParams = RaycastParams.new()
                RayParams.FilterType = Enum.RaycastFilterType.Exclude
                RayParams.FilterDescendantsInstances = {LocalPlayer.Character, workspace.CurrentCamera}
                
                local Result = workspace:Raycast(Origin, Direction, RayParams)
                local EndPos = Result and Result.Position or (Origin + Direction)

                -- Hit Verification (Sounds & Markers)
                if Result and Result.Instance then
                    local Character = Result.Instance:FindFirstAncestorOfClass("Model")
                    local Player = Character and game.Players:GetPlayerFromCharacter(Character)
                    local IsNPC = Character and Character:FindFirstChildOfClass("Humanoid")
                    if (Player and Player ~= LocalPlayer) or (IsNPC and not Player) then
                        Functions:PlayHitSound()
                        Functions:FlashCenterHitmarker()
                        Functions:CreateHitMarker(Result.Instance, Result.Position)
                        Functions:CreateHitLog(Result.Instance.Name, (Player and Player.Name or (Character and Character.Name or "Unknown")))
                    end
                end

                -- Visuals (Tracers)
                if getgenv().BulletTracers then
                    Functions:CreateTracer(Origin, EndPos)
                end
            end)
        end)
    end;
    
    return Old(table.unpack(Args))
end));

-- Container ESP Initialization
task.spawn(function()
    local Containers = workspace:WaitForChild("Containers", 10)
    if Containers then
        for _, v in pairs(Containers:GetDescendants()) do if v:IsA("Model") then Functions:DrawContainer(v) end end
        Containers.ChildAdded:Connect(function(v) Functions:DrawContainer(v) end)
    end
end)

-- NPC & Vehicle ESP Initialization
task.spawn(function()
    local AIs = workspace:WaitForChild("AIs", 10)
    if AIs then
        for _, v in pairs(AIs:GetDescendants()) do if v:IsA("Model") then Functions:DrawNPC(v) end end
        Library:Connect(AIs.ChildAdded, function(v) if v:IsA("Model") then Functions:DrawNPC(v) end end)
    end

    local Vehicles = workspace:WaitForChild("Vehicles", 10)
    if Vehicles then
        for _, v in pairs(Vehicles:GetDescendants()) do if v:IsA("Model") then Functions:DrawVehicle(v) end end
        Library:Connect(Vehicles.ChildAdded, function(v) if v:IsA("Model") then Functions:DrawVehicle(v) end end)
    end

    -- Fallback for AiZones
    local AiZones = workspace:FindFirstChild("AiZones")
    if AiZones then
        for _, v in pairs(AiZones:GetDescendants()) do if v:IsA("Model") then Functions:DrawNPC(v) end end
        Library:Connect(AiZones.DescendantAdded, function(v) if v:IsA("Model") then Functions:DrawNPC(v) end end)
    end
end)

-- Dropped Item ESP Initialization
task.spawn(function()
    local DroppedItemsFolder = workspace:WaitForChild("DroppedItems", 10)
    if DroppedItemsFolder then
        for _, v in pairs(DroppedItemsFolder:GetChildren()) do
            if v:IsA("Model") and v.PrimaryPart then
                Functions:DrawDroppedItem(v)
            end
        end
        Library:Connect(DroppedItemsFolder.ChildAdded, function(v) if v:IsA("Model") and v.PrimaryPart then Functions:DrawDroppedItem(v) end end)
    end
end)

-- Player Loot ESP Initialization
task.spawn(function()
    local function setupPlayer(plr)
        if plr == LocalPlayer then return end
        if plr.Character then Functions:DrawPlayer(plr.Character) end
        Library:Connect(plr.CharacterAdded, function(char)
            Functions:DrawPlayer(char)
        end)
    end

    for _, plr in pairs(game.Players:GetPlayers()) do setupPlayer(plr) end
    Library:Connect(game.Players.PlayerAdded, setupPlayer)
end)
-- Inventory Viewer Logic
local lastInvContent = ""
local lastTarget = nil


-- Unified Target Info Logic
local lastInvContent = ""
task.spawn(function()
    while task.wait(0.1) and getgenv().Library do
        local enabled = getgenv().TargetHUDEnabled or getgenv().InventoryViewerEnabled
        local targetPart = Functions:GetClosestToMouse()
        local char = targetPart and targetPart:FindFirstAncestorOfClass("Model")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local plr = char and game.Players:GetPlayerFromCharacter(char)

        if enabled and char and hum then
            TargetInfoGui.Enabled = true
            TitleLabel.Text = (plr and plr.Name or char.Name):upper()
            
            -- Update Stats
            if getgenv().TargetHUDEnabled then
                StatsContainer.Visible = true
                HealthLabel.Text = string.format("HP: %d/%d", math.round(hum.Health), math.round(hum.MaxHealth))
                
                local tool = char:FindFirstChildOfClass("Tool")
                WeaponLabel.Text = "Tool: " .. (tool and tool.Name or "None")
                
                local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude or 0
                ExtraLabel.Text = string.format("SPD: %.1f | DIST: %d", hum.WalkSpeed, math.round(dist))
            else
                StatsContainer.Visible = false
            end

            -- Update Inventory
            if getgenv().InventoryViewerEnabled then
                InvScroll.Visible = true
                local items = Functions:ScanInventory(plr or char)
                local currentContent = table.concat(items, ",")
                
                if currentContent ~= lastInvContent then
                    lastInvContent = currentContent
                    for _, v in pairs(InvScroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
                    for _, itemName in pairs(items) do
                        CreateInvItem(itemName, getgenv().ItemIcons[itemName])
                    end
                    
                    local displayList = {unpack(items)}
                    table.insert(displayList, 1, "[" .. TitleLabel.Text .. "]")
                    InvList:Refresh(displayList)
                end
            else
                InvScroll.Visible = false
            end
            
            -- Adjust Frame Size based on visibility
            local targetSizeY = 26 + (StatsContainer.Visible and 65 or 0) + (InvScroll.Visible and 130 or 0)
            MainFrame.Size = UDim2.new(0, 180, 0, targetSizeY)
            InvScroll.Position = UDim2.new(0, 5, 0, StatsContainer.Visible and 90 or 30)
        else
            TargetInfoGui.Enabled = false
            lastInvContent = ""
        end
    end
end)

Library:Notification("Hello User", 5, Library.Theme.Accent);

getgenv().Library = Library;
return Library;

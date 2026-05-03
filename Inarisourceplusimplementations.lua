if getgenv().Library then getgenv().Library:Unload()end;local a=game:GetService("UserInputService")local b=game:GetService("TweenService")local c=game:GetService("CoreGui")local d=game:GetService("Workspace")local e=game:GetService("Players")local f=game:GetService("HttpService")local e=e.LocalPlayer;local e=e:GetMouse()local d=d.CurrentCamera;local g=Instance.new;local h=Color3.fromRGB;local i=Color3.fromHSV;local j=Color3.fromHex;local k=UDim2.new;local l=UDim.new;local m=Vector2.new;local n=Rect.new;local o={}do o={Flags={},Theme={["Background"]=h(13,13,13),["Inline"]=h(16,16,16),["Text"]=h(229,229,229),["Border"]=h(34,34,34),["Accent"]=h(131,194,242),["Element"]=h(15,15,15),["Text Border"]=h(0,0,0)};Folders={Directory="inari",Configs="inari/Configs",Fonts="inari/Fonts"};MenuKey=Enum.KeyCode.End,TweeningTime=0.215,TweeningStyle="Quint",TweeningDirection="Out",HoverEffects=true,UnnamedFlags=0,Font=nil,Holder=nil,NotifHolder=nil,KeyList=nil,Connections={},ThemeMap={},ThemeInstances={},Sections={},Pages={}}o.__index=o;o.Sections.__index=o.Sections;o.Pages.__index=o.Pages;local p={[Enum.KeyCode.LeftShift]="LS",[Enum.KeyCode.RightShift]="RS",[Enum.KeyCode.LeftControl]="LC",[Enum.KeyCode.RightControl]="RC",[Enum.KeyCode.Insert]="INS",[Enum.KeyCode.Backspace]="BS",[Enum.KeyCode.Return]="Ent",[Enum.KeyCode.LeftAlt]="LA",[Enum.KeyCode.RightAlt]="RA",[Enum.KeyCode.CapsLock]="CAPS",[Enum.KeyCode.Delete]="DEL",[Enum.KeyCode.Home]="HOME",[Enum.KeyCode.End]="END",[Enum.KeyCode.PageUp]="PGUP",[Enum.KeyCode.PageDown]="PGDN",[Enum.KeyCode.Up]="UP",[Enum.KeyCode.Down]="DOWN",[Enum.KeyCode.Left]="LEFT",[Enum.KeyCode.Right]="RIGHT",[Enum.UserInputType.MouseButton1]="MB1",[Enum.UserInputType.MouseButton2]="MB2",[Enum.UserInputType.MouseButton3]="MB3",[Enum.KeyCode.One]="1",[Enum.KeyCode.Two]="2",[Enum.KeyCode.Three]="3",[Enum.KeyCode.Four]="4",[Enum.KeyCode.Five]="5",[Enum.KeyCode.Six]="6",[Enum.KeyCode.Seven]="7",[Enum.KeyCode.Eight]="8",[Enum.KeyCode.Nine]="9",[Enum.KeyCode.Zero]="0",[Enum.KeyCode.KeypadOne]="Num1",[Enum.KeyCode.KeypadTwo]="Num2",[Enum.KeyCode.KeypadThree]="Num3",[Enum.KeyCode.KeypadFour]="Num4",[Enum.KeyCode.KeypadFive]="Num5",[Enum.KeyCode.KeypadSix]="Num6",[Enum.KeyCode.KeypadSeven]="Num7",[Enum.KeyCode.KeypadEight]="Num8",[Enum.KeyCode.KeypadNine]="Num9",[Enum.KeyCode.KeypadZero]="Num0",[Enum.KeyCode.Minus]="-",[Enum.KeyCode.Equals]="=",[Enum.KeyCode.Tilde]="~",[Enum.KeyCode.LeftBracket]="[",[Enum.KeyCode.RightBracket]="]",[Enum.KeyCode.RightParenthesis]=")",[Enum.KeyCode.LeftParenthesis]="(",[Enum.KeyCode.Semicolon]=",",[Enum.KeyCode.Quote]="'",[Enum.KeyCode.BackSlash]="\\",[Enum.KeyCode.Comma]=",",[Enum.KeyCode.Period]=".",[Enum.KeyCode.Slash]="/",[Enum.KeyCode.Asterisk]="*",[Enum.KeyCode.Plus]="+",[Enum.KeyCode.Period]=".",[Enum.KeyCode.Backquote]="`",[Enum.KeyCode.Escape]="ESC",[Enum.KeyCode.Space]="SPC",[Enum.KeyCode.Z]="Z",[Enum.KeyCode.X]="X",[Enum.KeyCode.C]="C",[Enum.KeyCode.V]="V",[Enum.KeyCode.B]="B",[Enum.KeyCode.N]="N",[Enum.KeyCode.M]="M",[Enum.KeyCode.A]="A",[Enum.KeyCode.S]="S",[Enum.KeyCode.D]="D",[Enum.KeyCode.F]="F",[Enum.KeyCode.G]="G",[Enum.KeyCode.H]="H",[Enum.KeyCode.J]="J",[Enum.KeyCode.K]="K",[Enum.KeyCode.L]="L",[Enum.KeyCode.Q]="Q",[Enum.KeyCode.W]="W",[Enum.KeyCode.E]="E",[Enum.KeyCode.R]="R",[Enum.KeyCode.T]="T",[Enum.KeyCode.Y]="Y",[Enum.KeyCode.U]="U",[Enum.KeyCode.I]="I",[Enum.KeyCode.O]="O",[Enum.KeyCode.P]="P"}for a,a in o.Folders do if not isfolder(a)then makefolder(a)end end;function o:GetFolder(a,b)local a=o.Folders[a]if a~=nil then return end;if b then a..="/"end;return a end;writefile=writefile or function()end;readfile=readfile or function()end;isfile=isfile or function()end;delfile=delfile or function()end;isfolder=isfolder or function()end;makefolder=makefolder or function()end;listfiles=listfiles or function()end;getgenv=getgenv or function()end;getcustomasset=getcustomasset or function()end;cloneref=cloneref or function()return c end;gethui=gethui or function()return cloneref(game:GetService("CoreGui"))end;local c={}do c.__index=c;c.Create=function(a,a,d,e,f)if not(a or e or d)then return end;d=d or TweenInfo.new(o.TweeningTime,Enum.EasingStyle[o.TweeningStyle],Enum.EasingDirection[o.TweeningDirection])local f=not f and a.Object or a;local a={Info=d,Object=a,Tween=b:Create(f,d,e)}setmetatable(a,c)a.Tween:Play()return a end;c.Get=function(a)assert(a.Tween,"Tween doesn't exist")return a.Tween,a.Object,a.Info end;c.Play=function(a)assert(a.Tween,"Tween doesn't exist")a.Tween:Play()end;c.Pause=function(a)assert(a.Tween,"Tween doesn't exist")a.Tween:Pause()end;c.Clean=function(a)assert(a.Tween,"Tween doesn't exist")a.Tween:Pause()a=nil end end;local b={}do b.__index=b;b.Create=function(a,a,c)local a={Object=g(a),Properties=c,Class=a,Dragging=false}setmetatable(a,b)for b,c in c do a.Object[b]=c end;return a end;b.Border=function(a)assert(a.Object,"Object doesn't exist")local a=a.Object;local a=b:Create("UIStroke",{Parent=a;Color=o.Theme.Border;Thickness=1;LineJoinMode=Enum.LineJoinMode.Miter;ApplyStrokeMode=Enum.ApplyStrokeMode.Border})a:AddToTheme({Color="Border"})return a end;b.AddHoverEffect=function(a,b)assert(a.Object,"Object doesn't exist")local c=a.Object.Parent;if b then c=c.Parent end;o:Connect(c.MouseEnter,function()if not o.HoverEffects then return end;a:Tween(nil,{Color=o.Theme.Accent})a:ChangeObjectTheme({Color="Accent"})end,a.Object.Name.." Hover Effect Enter")o:Connect(c.MouseLeave,function()if not o.HoverEffects then return end;a:Tween(nil,{Color=o.Theme.Border})a:ChangeObjectTheme({Color="Border"})end,a.Object.Name.." Hover Effect Leave")end;b.TextBorder=function(a)assert(a.Object,"Object doesn't exist")local a=a.Object;local a=b:Create("UIStroke",{Parent=a;Color=o.Theme.TextBorder;Thickness=1;LineJoinMode=Enum.LineJoinMode.Miter;ApplyStrokeMode=Enum.ApplyStrokeMode.Contextual})a:AddToTheme({Color="Text Border"})return a end;b.Tween=function(a,b,d)assert(a.Object,"Object doesn't exist")local a=c:Create(a.Object,b,d,true)return a end;b.Connect=function(a,b,c,d)assert(a.Object,"Object doesn't exist")assert(a.Object[b],"Event doesn't exist")local a=o:Connect(a.Object[b],c,d)return a end;b.Disconnect=function(a,a)for b,b in o.Connections do if b.Name==a then b.Connection:Disconnect()break end end end;b.MakeDraggable=function(b)assert(b.Object,"Object doesn't exist")local d=b.Object;local b=b;local e=false;local f,g=k(),k()local c=function(a)local a=a.Position-f;c:Create(b,TweenInfo.new(0.175,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=k(g.X.Scale,g.X.Offset+a.X,g.Y.Scale,g.Y.Offset+a.Y)})end;b:Connect("InputBegan",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then e=true;f=a.Position;g=d.Position end end,d.Name.." Dragify Input Began")b:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then e=false end end,d.Name.." Dragify Input Ended")o:Connect(a.InputChanged,function(a)if a.UserInputType==Enum.UserInputType.MouseMovement and e then c(a)end end,d.Name.." Dragify Input Changed")return e end;b.MakeResizeable=function(d,e,f)assert(d.Object,"Object doesn't exist")assert(e,"Minimum value can't be nil")assert(f,"Maximum value can't be nil")local g=d.Object;local d=d;local i=false;local j,l=k(),k()local n=g.Parent.AbsoluteSize-g.AbsoluteSize;local b=b:Create("TextButton",{Parent=g,AnchorPoint=m(1,1),BorderColor3=h(0,0,0),Size=k(0,8,0,8),Position=k(1,0,1,0),BorderSizePixel=0,BackgroundTransparency=1,AutoButtonColor=false,Text=""})b:Connect("InputBegan",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then i=true;l=g.Size-k(0,a.Position.X,0,a.Position.Y)end end,g.Name.." Resizing Input Began")b:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then i=false end end,g.Name.." Resizing Input Ended")o:Connect(a.InputChanged,function(a)if a.UserInputType==Enum.UserInputType.MouseMovement and i then n=f or g.Parent.AbsoluteSize-g.AbsoluteSize;j=l+k(0,a.Position.X,0,a.Position.Y)j=k(0,math.clamp(j.X.Offset,e.X,n.X),0,math.clamp(j.Y.Offset,e.Y,n.Y))c:Create(d,TweenInfo.new(0.17,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=j})end end,g.Name.." Resizing Input Changed")return i end;b.Clean=function(a)assert(a.Object,"Object doesn't exist")a.Object:Destroy()a=nil end;b.AddToTheme=function(a,b)assert(a.Object,"Object doesn't exist")o:AddToTheme(a,b)end;b.ChangeObjectTheme=function(a,b)assert(a.Object,"Object doesn't exist")o:ChangeObjectTheme(a,b)end end;local g={}do function g:New(a,b,c,d)if isfile(o.Folders.Fonts.."/"..a..".json")then return Font.new(getcustomasset(o.Folders.Fonts.."/"..a..".json"))end;if not isfile(o.Folders.Fonts.."/"..a..".ttf")then writefile(o.Folders.Fonts.."/"..a..".ttf",game:HttpGet(d.Url))end;local b={name=a;faces={{name="Regular";weight=b;style=c;assetId=getcustomasset(o.Folders.Fonts.."/"..a..".ttf")}}}writefile(o.Folders.Fonts.."/"..a..".json",f:JSONEncode(b))return Font.new(getcustomasset(o.Folders.Fonts.."/"..a..".json"))end;function g:Get(a)if isfile(o.Folders.Fonts.."/"..a..".json")then return Font.new(getcustomasset(o.Folders.Fonts.."/"..a..".json"))end end;g:New("Proggy Clean",400,"Regular",{Url="https://github.com/bluescan/proggyfonts/raw/refs/heads/master/ProggyOriginal/ProggyClean.ttf"})o.Font=g:Get("Proggy Clean")end;do o.Holder=b:Create("ScreenGui",{Parent=gethui(),Name="\0",ZIndexBehavior=Enum.ZIndexBehavior.Global,ResetOnSpawn=false})o.NotifHolder=b:Create("Frame",{Parent=o.Holder.Object,Name="\0",BackgroundTransparency=1,Size=k(0,0,1,0),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=o.NotifHolder.Object,Padding=l(0,7),SortOrder=Enum.SortOrder.LayoutOrder})b:Create("UIPadding",{Parent=o.NotifHolder.Object,PaddingTop=l(0,8),PaddingBottom=l(0,8),PaddingRight=l(0,8),PaddingLeft=l(0,8)})function o:Thread(a)local a=coroutine.create(a)return function(...)return coroutine.resume(a,...)end end;function o:Unload()for a,a in o.Connections do a.Signal:Disconnect()end;if o.Holder then o.Holder:Clean()end;o=nil;getgenv().Library=nil end;function o:Connect(a,b,c)local a={Signal=a:Connect(b),Name=c,Function=b}table.insert(o.Connections,a)return a end;function o:Disconnect(a)for b,b in o.Connections do if b.Name==a then b.Signal:Disconnect()break end end end;function o:GetConfig()local a={}local b,c=pcall(function()for b,c in o.Flags do local d=c.Class;if not d then continue end;if d=="Keybind"then a[b]={Name=c.Key,Mode=c.Mode}elseif d=="Colorpicker"then a[b]={Color=c.Hex,Alpha=c.Alpha}else if not a[b]then a[b]=c.Value end end end end)if not b then o:Notification("Failed to get config, report this to the devs: "..c,5,h(255,0,0))end;return f:JSONEncode(a)end;function o:LoadConfig(a)if not a then o:Notification("Config not found, did you possibly delete a selected config and forget to unselect it?",5,h(255,0,0),nil)return end;local a=f:JSONDecode(a)local a,b=pcall(function()for a,b in a do local a=o.Flags[a]if a then if a.Class=="Keybind"then if table.find({"MouseButton1","MouseWheel","MouseButton2","MouseButton3"},b.Name)then a:Set(b,true)else a:Set(b)end elseif a.Class=="Colorpicker"then a:Set(b.Color,b.Alpha)else a:Set(b)end end end end)if not a then o:Notification("Failed to load config, report this to the devs: "..b,5,h(255,0,0))else o:Notification("Successfully loaded config",5,h(0,255,0))end end;function o:GetConfigsList(a)local b={}local c={}for a,a in listfiles(o.Folders.Configs)do local a=string.gsub(a,o.Folders.Directory.."\\Configs\\",""):gsub(".json","")c[#c+1]=a end;local d=#c~=#b;if not d then for a=1,#c do if c[a]~=b[a]then d=true;break end end end;if d then b=c;a:Refresh(b)end end;function o:AddToTheme(a,b)local b={Instance=a.Object,Properties=b}for a,c in b.Properties do if type(c)=="string"then if o.Theme[c]then b.Instance[a]=o.Theme[c]end else b.Instance[a]=c()end end;table.insert(o.ThemeInstances,b)o.ThemeMap[a.Object]=b end;function o:ChangeObjectTheme(a,b)if o.ThemeMap[a.Object]then local c=o.ThemeMap[a.Object]c.Properties=b;o.ThemeMap[a.Object]=c end end;function o:UpdateTheme(a,b)o.Theme[a]=b;for c,d in o.ThemeMap do local d=d.Properties;for d,e in d do if e==a then c[d]=b end end end end;function o:NextFlag()local a=o.UnnamedFlags+1;return string.format("%s_%s_flag",a,f:GenerateGUID(false))end;function o:GetTransparencyPropertyFromType(a)if a:IsA("UIStroke")then return{"Transparency"}elseif a:IsA("ImageLabel")then return{"ImageTransparency"}elseif a:IsA("TextButton")or a:IsA("TextBox")then return{"TextTransparency","BackgroundTransparency"}elseif a:IsA("Frame")or a:IsA("ScrollingFrame")then return"BackgroundTransparency"elseif a:IsA("TextLabel")then return{"TextTransparency"}end end;function o:Floor(a,b)local b=1/(b or 1)return math.floor(a*b+0.5)/b end;function o:Colorpicker(d)local e={IsOpen=false,Hue=0,Saturation=0,Value=0,Color=Color3.fromRGB(0,0,0),Hex="",Alpha=0,Class="Colorpicker"}local f={}do f["Colorbutton"]=b:Create("TextButton",{Parent=d.Parent.Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,AnchorPoint=m(1,0.5),Name="\0",Position=k(1,0,0,0),Size=k(0,23,0,13),BorderSizePixel=0,TextSize=14,BackgroundColor3=h(131,194,242)})f["Colorbutton"]:Border():AddHoverEffect()b:Create("UIGradient",{Parent=f["Colorbutton"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(86,86,86))}})local a=function(a)local b=5;local c=math.floor(a/b)local a=a%b;local b=f["Colorbutton"].Object.AbsoluteSize;local c=4;local a=(b.X+c)*a-c;return k(1,-a+23,0.5,0)end;f["Colorbutton"].Object.Position=a(d.Count)f["ColorpickerWindow"]=b:Create("Frame",{Parent=o.Holder.Object,Name="\0",Position=k(0,0,0,0),BorderColor3=h(0,0,0),Size=k(0,194,0,163),BorderSizePixel=0,BackgroundColor3=h(13,13,13)})f["ColorpickerWindow"]:AddToTheme({BackgroundColor3="Background"})f["ColorpickerWindow"]:Border()f["ColorpickerWindow"]:MakeResizeable(m(165,145),m(9999,9999))f["ColorpickerWindow"]:MakeDraggable()f["Shadow"]=b:Create("ImageLabel",{Parent=f["ColorpickerWindow"].Object,ImageColor3=h(131,194,242),ImageTransparency=0.4300000071525574,AnchorPoint=m(0.5,0.5),Image="rbxassetid://112971167999062",ZIndex=-1,BorderSizePixel=0,SliceCenter=n(m(112,112),m(147,147)),ScaleType=Enum.ScaleType.Slice,BorderColor3=h(0,0,0),BackgroundTransparency=1,Position=k(0.5,0,0.5,0),SliceScale=0.6000000238418579,Name="Shadow",Size=k(1,55,1,55),BackgroundColor3=h(255,255,255)})f["Shadow"]:AddToTheme({ImageColor3="Accent"})b:Create("UIPadding",{Parent=f["ColorpickerWindow"].Object,PaddingTop=l(0,5),PaddingBottom=l(0,5),PaddingRight=l(0,5),PaddingLeft=l(0,5)})f["Hue"]=b:Create("ImageButton",{Parent=f["ColorpickerWindow"].Object,BorderColor3=h(0,0,0),AnchorPoint=m(1,0),Image="rbxassetid://133334110106525",Name="\0",Position=k(1,0,0,0),Size=k(0,13,1,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})f["Hue"]:Border()f["HueDragger"]=b:Create("Frame",{Parent=f["Hue"].Object,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,0,1),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})f["HueDragger"]:Border()f["Alpha"]=b:Create("TextButton",{Parent=f["ColorpickerWindow"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,AnchorPoint=m(0,1),Name="\0",Position=k(0,0,1,0),Size=k(1,-17,0,13),BorderSizePixel=0,TextSize=14,BackgroundColor3=h(255,0,0)})f["Alpha"]:Border()f["Checkers"]=b:Create("ImageLabel",{Parent=f["Alpha"].Object,ScaleType=Enum.ScaleType.Tile,BorderColor3=h(0,0,0),Name="\0",Image="http://www.roblox.com/asset/?id=18274452449",BackgroundTransparency=1,Size=k(1,0,1,0),TileSize=k(0,6,0,6),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})b:Create("UIGradient",{Parent=f["Checkers"].Object,Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)}})f["AlphaDragger"]=b:Create("Frame",{Parent=f["Alpha"].Object,Name="\0",BorderColor3=h(0,0,0),Size=k(0,1,1,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})f["AlphaDragger"]:Border()f["Palette"]=b:Create("TextButton",{Parent=f["ColorpickerWindow"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,Name="\0",Size=k(1,-17,1,-17),BorderSizePixel=0,TextSize=14,BackgroundColor3=h(255,0,0)})f["Saturation"]=b:Create("ImageLabel",{Parent=f["Palette"].Object,BorderColor3=h(0,0,0),Image="rbxassetid://130624743341203",BackgroundTransparency=1,Name="\0",Size=k(1,0,1,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})f["Value"]=b:Create("ImageLabel",{Parent=f["Palette"].Object,BorderColor3=h(0,0,0),Image="rbxassetid://96192970265863",BackgroundTransparency=1,Name="\0",Size=k(1,0,1,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})f["Palette"]:Border()f["PaletteDragger"]=b:Create("Frame",{Parent=f["Palette"].Object,Name="\0",BorderColor3=h(0,0,0),Size=k(0,2,0,2),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})f["PaletteDragger"]:Border()end;local b=false;local g=false;local l=false;f["ColorpickerWindow"].Object.BackgroundTransparency=1;for a,a in f["ColorpickerWindow"].Object:GetDescendants()do if a:IsA("Frame")or a:IsA("TextButton")then a.BackgroundTransparency=1 elseif a:IsA("ImageLabel")or a:IsA("ImageButton")then a.ImageTransparency=1;a.BackgroundTransparency=1 elseif a:IsA("TextLabel")or a:IsA("TextBox")then a.TextTransparency=1 elseif a:IsA("UIStroke")then a.Transparency=1 end end;function e:Update(a)local b,c,g=e.Hue,e.Saturation,e.Value;e.Color=i(b,c,g)e.Hex=e.Color:ToHex()f["Colorbutton"]:Tween(nil,{BackgroundColor3=e.Color})f["Palette"]:Tween(nil,{BackgroundColor3=i(b,1,1)})if not a then f["Alpha"]:Tween(nil,{BackgroundColor3=e.Color})end;if d.Callback then pcall(d.Callback,e.Color,e.Alpha)end end;function e:SetOpen(a)e.IsOpen=a or not e.IsOpen;f["ColorpickerWindow"].Object.Position=k(0,f["Colorbutton"].Object.AbsolutePosition.X,0,f["Colorbutton"].Object.AbsolutePosition.Y+12)if e.IsOpen then f["ColorpickerWindow"].Object.Visible=true;f["ColorpickerWindow"].Object.ZIndex=15;f["ColorpickerWindow"]:Tween(nil,{BackgroundTransparency=0})for a,a in f["ColorpickerWindow"].Object:GetDescendants()do if not a.ClassName:find("UI")and not a.Name:find("Shadow")then a.ZIndex=15 end;if a:IsA("Frame")or a:IsA("TextButton")then c:Create(a,nil,{BackgroundTransparency=0},true)elseif a:IsA("ImageLabel")or a:IsA("ImageButton")then c:Create(a,nil,{ImageTransparency=0},true)elseif a:IsA("TextLabel")or a:IsA("TextBox")then c:Create(a,nil,{TextTransparency=0},true)elseif a:IsA("UIStroke")then c:Create(a,nil,{Transparency=0},true)end end else for a,a in f["ColorpickerWindow"].Object:GetDescendants()do if not a.ClassName:find("UI")and not a.Name:find("Shadow")then a.ZIndex=1 end;if a:IsA("Frame")or a:IsA("TextButton")then c:Create(a,nil,{BackgroundTransparency=1},true)elseif a:IsA("ImageLabel")or a:IsA("ImageButton")then c:Create(a,nil,{ImageTransparency=1},true)elseif a:IsA("TextLabel")or a:IsA("TextBox")then c:Create(a,nil,{TextTransparency=1},true)elseif a:IsA("UIStroke")then c:Create(a,nil,{Transparency=1},true)end end;f["ColorpickerWindow"]:Tween(nil,{BackgroundTransparency=1})task.wait(0.1)f["ColorpickerWindow"].Object.Visible=false;f["ColorpickerWindow"].Object.ZIndex=1 end end;function e:Set(a,b)if type(a)=="table"then a=h(a[1],a[2],a[3])b=a[4]elseif type(a)=="string"then a=j(a)end;e.Hue,e.Saturation,e.Value=a:ToHSV()e.Color=a;e.Hex=a:ToHex()e.Alpha=b or 0;local a=math.clamp(1-self.Saturation,0,1)local b=math.clamp(1-self.Value,0,1)f["PaletteDragger"].Object.Position=k(a,0,b,0)local a=math.clamp(self.Hue,0,0.985)f["HueDragger"].Object.Position=k(0,0,a,0)local a=math.clamp(self.Alpha,0,0.985)f["AlphaDragger"].Object.Position=k(0,0,a,0)e:Update()end;function e:SlidePalette(a)if not b then return end;local b=math.clamp(1-(a.Position.X-f["Palette"].Object.AbsolutePosition.X)/f["Palette"].Object.AbsoluteSize.X,0,1)local c=math.clamp(1-(a.Position.Y-f["Palette"].Object.AbsolutePosition.Y)/f["Palette"].Object.AbsoluteSize.Y,0,1)e.Saturation=b;e.Value=c;local b=math.clamp((a.Position.X-f["Palette"].Object.AbsolutePosition.X)/f["Palette"].Object.AbsoluteSize.X,0,0.987)local a=math.clamp((a.Position.Y-f["Palette"].Object.AbsolutePosition.Y)/f["Palette"].Object.AbsoluteSize.Y,0,0.985)f["PaletteDragger"]:Tween(nil,{Position=k(b,0,a,0)})e:Update()end;function e:SlideHue(a)if not g then return end;local b=math.clamp((a.Position.Y-f["Hue"].Object.AbsolutePosition.Y)/f["Hue"].Object.AbsoluteSize.Y,0,1)e.Hue=b;local a=math.clamp((a.Position.Y-f["Hue"].Object.AbsolutePosition.Y)/f["Hue"].Object.AbsoluteSize.Y,0,0.985)f["HueDragger"]:Tween(nil,{Position=k(0,0,a,0)})e:Update()end;function e:SlideAlpha(a)if not l then return end;local b=math.clamp((a.Position.X-f["Alpha"].Object.AbsolutePosition.X)/f["Alpha"].Object.AbsoluteSize.X,0,1)e.Alpha=b;local a=math.clamp((a.Position.X-f["Alpha"].Object.AbsolutePosition.X)/f["Alpha"].Object.AbsoluteSize.X,0,0.987)f["AlphaDragger"]:Tween(nil,{Position=k(a,0,0,0)})e:Update(true)end;function e:Get()return e.Color end;function e:GetAlpha()return e.Alpha end;function e:SetVisiblity(a)f["Colorbutton"].Object.Visible=a end;f["Colorbutton"]:Connect("MouseButton1Click",function()e:SetOpen(not e.IsOpen)end,d.Name.." Open Event")f["Palette"]:Connect("InputBegan",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then b=true;e:SlidePalette(a)end end,d.Name.." Palette Input Began")f["Palette"]:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then b=false end end,d.Name.." Palette Input Ended")f["Hue"]:Connect("InputBegan",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then g=true;e:SlideHue(a)end end,d.Name.." Hue Input Began")f["Hue"]:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then g=false end end,d.Name.." Hue Input Ended")f["Alpha"]:Connect("InputBegan",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then l=true;e:SlideAlpha(a)end end,d.Name.." Alpha Input Began")f["Alpha"]:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then l=false end end,d.Name.." Alpha Input Ended")o:Connect(a.InputChanged,function(a)if a.UserInputType==Enum.UserInputType.MouseMovement then if b then e:SlidePalette(a)end;if g then e:SlideHue(a)end;if l then e:SlideAlpha(a)end end end,d.Name.." Palette Input Changed")if d.Default then e:Set(d.Default,d.Alpha)end;return e end;function o:Keybind(d)local e={IsOpen=false,Key=nil,Mode="",State=false,Class="Keybind"}local f=o.KeyList:AddNewKey("None","None")local g={}do g["Key"]=b:Create("TextButton",{Parent=d.Parent.Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,AnchorPoint=m(1,0),Size=k(0,0,1,0),Name="\0",Position=k(1,0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=14,BackgroundColor3=h(15,15,15)})g["Key"]:AddToTheme({BackgroundColor3="Element"})g["Key"]:Border():AddHoverEffect()b:Create("UIPadding",{Parent=g["Key"].Object,PaddingRight=l(0,4),PaddingLeft=l(0,3)})g["Value"]=b:Create("TextLabel",{Parent=g["Key"].Object,FontFace=o.Font,TextColor3=h(229,229,229),BorderColor3=h(0,0,0),Text="None",Name="\0",BackgroundTransparency=1,Size=k(0,0,1,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})g["Value"]:AddToTheme({TextColor3="Text"})g["Value"]:TextBorder()b:Create("UIGradient",{Parent=g["Key"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(0.041,h(189,189,189)),ColorSequenceKeypoint.new(0.315,h(255,255,255)),ColorSequenceKeypoint.new(1,h(255,255,255))}})g["Window"]=b:Create("Frame",{Parent=g["Key"].Object,Visible=false,BorderColor3=h(0,0,0),AnchorPoint=m(1,0),Name="\0",Position=k(1,0,1,4),Size=k(0,60,0,52),BorderSizePixel=0,BackgroundColor3=h(16,16,16)})g["Window"]:AddToTheme({BackgroundColor3="Inline"})g["Window"]:Border()b:Create("UIGradient",{Parent=g["Window"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(0.041,h(189,189,189)),ColorSequenceKeypoint.new(0.315,h(255,255,255)),ColorSequenceKeypoint.new(1,h(255,255,255))}})g["Toggle"]=b:Create("TextButton",{Parent=g["Window"].Object,FontFace=o.Font,TextColor3=h(131,194,242),BorderColor3=h(0,0,0),Text="Toggle",AutoButtonColor=false,Name="\0",BackgroundTransparency=1,Position=k(0,0,0,2),Size=k(1,0,0,15),BorderSizePixel=0,TextSize=12,BackgroundColor3=h(255,255,255)})g["Toggle"]:AddToTheme({TextColor3="Text"})g["Toggle"]:TextBorder()g["Hold"]=b:Create("TextButton",{Parent=g["Window"].Object,FontFace=o.Font,TextColor3=h(229,229,229),TextTransparency=0.2800000011920929,Text="Hold",AutoButtonColor=false,Name="\0",Size=k(1,0,0,15),BackgroundTransparency=1,Position=k(0,0,0,17),BorderSizePixel=0,BorderColor3=h(0,0,0),TextSize=12,BackgroundColor3=h(255,255,255)})g["Hold"]:AddToTheme({TextColor3="Text"})g["Hold"]:TextBorder()g["Always"]=b:Create("TextButton",{Parent=g["Window"].Object,FontFace=o.Font,TextColor3=h(229,229,229),TextTransparency=0.2800000011920929,Text="Always",AutoButtonColor=false,Name="\0",Size=k(1,0,0,15),BackgroundTransparency=1,Position=k(0,0,0,34),BorderSizePixel=0,BorderColor3=h(0,0,0),TextSize=12,BackgroundColor3=h(255,255,255)})g["Always"]:AddToTheme({TextColor3="Text"})g["Always"]:TextBorder()end;local b=false;function e:Get()return e.State end;function e:GetKey()return e.Key end;function e:SetVisiblity(a)g["Key"].Object.Visible=a end;function e:SetOpen(a)e.IsOpen=a;g["Window"].Object.ZIndex=a and 15 or 1;if e.IsOpen then g["Window"].Object.Visible=true;g["Window"]:Tween(nil,{BackgroundTransparency=0})task.wait(0.06)for a,a in g["Window"].Object:GetDescendants()do if a:IsA("TextButton")then c:Create(a,nil,{TextTransparency=0},true)elseif a:IsA("UIStroke")then c:Create(a,nil,{Transparency=0},true)end;if not a.ClassName:find("UI")then a.ZIndex=15 end end else for a,a in g["Window"].Object:GetDescendants()do if a:IsA("TextButton")then c:Create(a,nil,{TextTransparency=1},true)elseif a:IsA("UIStroke")then c:Create(a,nil,{Transparency=1},true)end;if not a.ClassName:find("UI")then a.ZIndex=1 end end;task.wait(0.06)g["Window"]:Tween(nil,{BackgroundTransparency=1})task.wait(0.05)g["Window"].Object.Visible=false end end;function e:SetMode(a)e.Mode=a;if a=="Toggle"then g["Toggle"]:Tween(nil,{TextColor3=o.Theme.Accent})g["Hold"]:Tween(nil,{TextColor3=o.Theme.Text})g["Always"]:Tween(nil,{TextColor3=o.Theme.Text})o:ChangeObjectTheme(g["Toggle"],{TextColor3="Accent"})o:ChangeObjectTheme(g["Hold"],{TextColor3="Text"})o:ChangeObjectTheme(g["Always"],{TextColor3="Text"})elseif a=="Hold"then g["Toggle"]:Tween(nil,{TextColor3=o.Theme.Text})g["Hold"]:Tween(nil,{TextColor3=o.Theme.Accent})g["Always"]:Tween(nil,{TextColor3=o.Theme.Text})o:ChangeObjectTheme(g["Toggle"],{TextColor3="Text"})o:ChangeObjectTheme(g["Hold"],{TextColor3="Accent"})o:ChangeObjectTheme(g["Always"],{TextColor3="Text"})elseif a=="Always"then g["Toggle"]:Tween(nil,{TextColor3=o.Theme.Text})g["Hold"]:Tween(nil,{TextColor3=o.Theme.Text})g["Always"]:Tween(nil,{TextColor3=o.Theme.Accent})e.State=true end;if e.Key then f:Set(e.Key,d.Name)end end;function e:Press(a)if e.Mode=="Always"then e.State=true elseif e.Mode=="Once"then e.State=true;task.wait(0.1)e.State=false elseif e.Mode=="Hold"then e.State=a elseif e.Mode=="Toggle"then e.State=not e.State end;if e.Key then f:SetStatus(e.State)end;if d.Callback then pcall(d.Callback,e.State)end end;function e:Set(a,c)if c then if type(a)=="table"then a=Enum.UserInputType[a.Name]end;b=true;local c=""if p[a]then c=p[a]else c=string.sub(a.Name,1,2)end;e.Key=a;g["Value"].Object.Text=c;g["Value"]:Tween(nil,{TextColor3=o.Theme.Text})g["Value"]:ChangeObjectTheme({TextColor3="Text"})b=false else if a and(type(a)=="table"or typeof(a)=="EnumItem")and a.Name then b=true;if p[a.Name]then g["Value"].Object.Text=p[a.Name]e.Key=p[a.Name]else g["Value"].Object.Text=a.Name:sub(1,2)e.Key=a.Name:sub(1,2)end;if type(a)=="table"and a.Name~=""then e.Key=Enum.KeyCode[a.Name]else e.Key=a end;g["Value"]:Tween(nil,{TextColor3=o.Theme.Text})g["Value"]:ChangeObjectTheme({TextColor3="Text"})b=false end end;if e.Key then f:Set(e.Key,d.Name)end end;g["Key"]:Connect("MouseButton2Down",function()e:SetOpen(not e.IsOpen)end,d.Name.." Open Event")g["Key"]:Connect("MouseButton1Click",function()b=true;g["Value"]:Tween(nil,{TextColor3=o.Theme.Accent})g["Value"]:ChangeObjectTheme({TextColor3="Accent"})a.InputBegan:Connect(function(a)if a.UserInputType==Enum.UserInputType.Keyboard and b then e:Set(a.KeyCode)b=false elseif a.UserInputType==Enum.UserInputType.MouseButton1 and b then e:Set(Enum.UserInputType.MouseButton1,true)elseif a.UserInputType==Enum.UserInputType.MouseButton2 and b then e:Set(Enum.UserInputType.MouseButton2,true)elseif a.UserInputType==Enum.UserInputType.MouseButton3 and b then e:Set(Enum.UserInputType.MouseButton3,true)elseif a.UserInputType==Enum.UserInputType.MouseWheel and b then e:Set(Enum.UserInputType.MouseWheel,true)else b=false end end)end,d.Name.." Pick Event")o:Connect(a.InputBegan,function(a)if a.KeyCode==e.Key and not b then if e.Mode=="Toggle"then e:Press()elseif e.Mode=="Hold"then e:Press(true)end elseif a.UserInputType==e.Key and not b then if e.Mode=="Toggle"then e:Press()elseif e.Mode=="Hold"then e:Press(true)end end end,d.Name.." Input Began")o:Connect(a.InputEnded,function(a)if a.KeyCode==e.Key and not b then if e.Mode=="Hold"then e:Press(false)end elseif a.UserInputType==e.Key and not b then if e.Mode=="Hold"then e:Press(false)end end end,d.Name.." Input Ended")g["Toggle"]:Connect("MouseButton1Down",function()e:SetMode("Toggle")end,d.Name.." Toggle Event")g["Hold"]:Connect("MouseButton1Down",function()e:SetMode("Hold")end,d.Name.." Hold Event")g["Always"]:Connect("MouseButton1Down",function()e:SetMode("Always")e:Press(true)end,d.Name.." Always Event")if d.Default then e:Set(d.Default)end;return e end;function o:Watermark(a)local c={}local d={}do d["Watermark"]=b:Create("Frame",{Parent=o.Holder.Object,BorderColor3=h(0,0,0),AnchorPoint=m(0.5,0),Name="\0",Position=k(0.5,0,0,15),Size=k(0,0,0,20),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=h(13,13,13)})d["Watermark"]:AddToTheme({BackgroundColor3="Background"})d["Watermark"]:Border()d["Watermark"]:MakeDraggable()b:Create("UIPadding",{Parent=d["Watermark"].Object,PaddingRight=l(0,5),PaddingLeft=l(0,5)})d["Title"]=b:Create("TextLabel",{Parent=d["Watermark"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=a,Name="\0",Size=k(1,0,1,0),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})d["Title"]:AddToTheme({TextColor3="Text"})d["Title"]:TextBorder()d["Liner"]=b:Create("Frame",{Parent=d["Watermark"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,-5,1,0),BorderColor3=h(0,0,0),Size=k(1,10,0,1),BorderSizePixel=0,BackgroundColor3=h(131,194,242)})d["Liner"]:AddToTheme({BackgroundColor3="Accent"})end;function c:SetVisiblity(a)d["Watermark"].Object.Visible=a end;return c end;function o:Notification(a,d,e)local f={}do f["Notification"]=b:Create("Frame",{Parent=o.NotifHolder.Object,Name="\0",Size=k(0,0,0,21),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=h(13,13,13)})f["Notification"]:AddToTheme({BackgroundColor3="Background"})f["Notification"]:Border()f["Title"]=b:Create("TextLabel",{Parent=f["Notification"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=a,Position=k(0,0,0,-1),Name="\0",Size=k(1,0,1,0),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})f["Title"]:AddToTheme({TextColor3="Text"})f["Title"]:TextBorder()f["Liner"]=b:Create("Frame",{Parent=f["Notification"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,-5,1,0),BorderColor3=h(0,0,0),Size=k(1,10,0,1),BorderSizePixel=0,BackgroundColor3=e})b:Create("UIPadding",{Parent=f["Notification"].Object,PaddingRight=l(0,5),PaddingLeft=l(0,5)})end;f["Notification"].Object.BackgroundTransparency=1;for a,a in f["Notification"].Object:GetDescendants()do if a:IsA("TextLabel")then a.TextTransparency=1 elseif a:IsA("ImageLabel")then a.ImageTransparency=1 elseif a:IsA("UIStroke")then a.Transparency=1 elseif a:IsA("Frame")then a.BackgroundTransparency=1 end end;task.spawn(function()f["Notification"]:Tween(nil,{BackgroundTransparency=0})task.wait(0.08)for a,a in f["Notification"].Object:GetDescendants()do if a:IsA("TextLabel")then c:Create(a,nil,{TextTransparency=0},true)elseif a:IsA("ImageLabel")then c:Create(a,nil,{ImageTransparency=0},true)elseif a:IsA("UIStroke")then c:Create(a,nil,{Transparency=0},true)elseif a:IsA("Frame")then c:Create(a,nil,{BackgroundTransparency=0},true)end end;task.delay(d+0.1,function()for a,a in f["Notification"].Object:GetDescendants()do if a:IsA("TextLabel")then c:Create(a,nil,{TextTransparency=1},true)elseif a:IsA("ImageLabel")then c:Create(a,nil,{ImageTransparency=1},true)elseif a:IsA("UIStroke")then c:Create(a,nil,{Transparency=1},true)elseif a:IsA("Frame")then c:Create(a,nil,{BackgroundTransparency=1},true)end end;task.wait(0.08)f["Notification"]:Tween(nil,{BackgroundTransparency=1})task.wait(0.2)f["Notification"]:Clean()end)end)end;function o:KeybindList()local a={}o.KeyList=a;local c={}do c["KeybindsList"]=b:Create("Frame",{Parent=o.Holder.Object,AnchorPoint=m(0,0.5),Name="\0",Position=k(0,15,0.5,0),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.XY,BackgroundColor3=h(13,13,13)})c["KeybindsList"]:AddToTheme({BackgroundColor3="Background"})c["KeybindsList"]:Border()c["KeybindsList"]:MakeDraggable()c["Title"]=b:Create("TextLabel",{Parent=c["KeybindsList"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text="Keybinds",Name="\0",Size=k(0,0,0,15),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Title"]:AddToTheme({TextColor3="Text"})c["Title"]:TextBorder()b:Create("UIPadding",{Parent=c["KeybindsList"].Object,PaddingTop=l(0,5),PaddingBottom=l(0,5),PaddingRight=l(0,5),PaddingLeft=l(0,5)})c["Content"]=b:Create("Frame",{Parent=c["KeybindsList"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,0,0,18),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.XY,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=c["Content"].Object,Padding=l(0,3),SortOrder=Enum.SortOrder.LayoutOrder})b:Create("UIPadding",{Parent=c["Content"].Object,PaddingRight=l(0,5),PaddingLeft=l(0,5)})end;function a:AddNewKey(a,d)local e=p[a]if not p[a]then a=tostring(a):sub(1,2)end;local b=b:Create("TextLabel",{Parent=c["Content"].Object,FontFace=o.Font,TextColor3=h(240,240,240),BorderColor3=h(0,0,0),Text=`{RealKey}: {Name}`,Name="\0",Size=k(0,0,0,15),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})o:AddToTheme(b,{TextColor3="Text"})b:TextBorder()local a={Text=b,Key=a,RealKey=e,Name=d,IsActive=false}function a:SetStatus(c)a.IsActive=c;b:Tween(nil,{TextColor3=c and o.Theme.Accent or o.Theme.Text})if c then o:ChangeObjectTheme(b,{TextColor3="Accent"})else o:ChangeObjectTheme(b,{TextColor3="Text"})end end;function a:Set(a,c)local c=p[a]if not p[a]then a=tostring(a):sub(1,2)end;b.Object.Text=`{RealKey}: {Name}`end;return a end;function a:SetVisiblity(a)c["KeybindsList"].Object.Visible=a or true end;return a end;function o:Window(e)e=e or{}local e={Name=e.Name or e.name or"Nigger Cupcake",Size=e.Size or e.size or k(0,622,0,453),FadeSpeed=e.FadeSpeed or e.fadespeed or 0.2,Icon=e.Icon or e.icon or nil,TransparencyCache={},IsOpen=true,Pages={},SubPages={},Sections={},Elements={}}local f={}do f["MainFrame"]=b:Create("Frame",{Parent=o.Holder.Object,Name="\0",Position=k(0,d.ViewportSize.X/3,0,d.ViewportSize.Y/3),BorderColor3=h(0,0,0),Size=e.Size,BorderSizePixel=0,BackgroundColor3=h(13,13,13)})f["MainFrame"]:AddToTheme({BackgroundColor3="Background"})f["MainFrame"]:MakeDraggable()f["MainFrame"]:Border()f["MainFrame"]:MakeResizeable(m(e.Size.X.Offset,e.Size.Y.Offset),m(9999,9999))f["Shadow"]=b:Create("ImageLabel",{Parent=f["MainFrame"].Object,ImageColor3=h(131,194,242),ImageTransparency=0.43,AnchorPoint=m(0.5,0.5),Image="rbxassetid://112971167999062",ZIndex=-1,BorderSizePixel=0,SliceCenter=n(m(112,112),m(147,147)),ScaleType=Enum.ScaleType.Slice,BorderColor3=h(0,0,0),BackgroundTransparency=1,Position=k(0.5,0,0.5,0),SliceScale=0.6000000238418579,Name="\0",Size=k(1,55,1,55),BackgroundColor3=h(255,255,255)})f["Shadow"]:AddToTheme({ImageColor3="Accent"})f["Inline"]=b:Create("Frame",{Parent=f["MainFrame"].Object,Name="\0",Position=k(0,6,0,36),BorderColor3=h(0,0,0),Size=k(1,-12,1,-42),BorderSizePixel=0,BackgroundColor3=h(16,16,16)})f["Inline"]:AddToTheme({BackgroundColor3="Inline"})f["Inline"]:Border()f["Topbar"]=b:Create("Frame",{Parent=f["MainFrame"].Object,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,0,30),BorderSizePixel=0,BackgroundColor3=h(25,25,25)})f["Topbar"]:AddToTheme({BackgroundColor3="Background"})f["Title"]=b:Create("TextLabel",{Parent=f["Topbar"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=e.Name,Name="\0",Size=k(0,0,0,15),AnchorPoint=m(0,0.5),Position=k(0,3,0.5,2),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})f["Title"]:AddToTheme({TextColor3="Text"})f["Title"]:TextBorder()f["Liner"]=b:Create("Frame",{Parent=f["Title"].Object,AnchorPoint=m(1,0),Name="\0",Position=k(1,12,0,-10),BorderColor3=h(0,0,0),Size=k(0,1,1,15),BorderSizePixel=0,BackgroundColor3=h(34,34,34)})f["Liner"]:AddToTheme({BackgroundColor3="Border"})b:Create("UIPadding",{Parent=f["Title"].Object,PaddingLeft=l(0,5)})if e.Icon then f["Icon"]=b:Create("ImageLabel",{Parent=f["Topbar"].Object,Visible=false,ScaleType=Enum.ScaleType.Fit,BorderColor3=h(0,0,0),Image=e.Icon,BackgroundTransparency=1,Name="\0",Size=k(0,28,0,28),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})f["Title"].Object.Position=k(0,30,0.5,2)end;f["Liner2"]=b:Create("Frame",{Parent=f["Topbar"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,0,1,0),BorderColor3=h(0,0,0),Size=k(1,0,0,1),BorderSizePixel=0,BackgroundColor3=h(34,34,34)})f["Liner2"]:AddToTheme({BackgroundColor3="Border"})f["Pages"]=b:Create("Frame",{Parent=f["Topbar"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,f["Title"].Object.TextBounds.X+22,0,5),BorderColor3=h(0,0,0),Size=k(1,-(f["Title"].Object.TextBounds.X+22),1,-9),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=f["Pages"].Object,FillDirection=Enum.FillDirection.Horizontal,VerticalFlex=Enum.UIFlexAlignment.Fill,Padding=l(0,5),SortOrder=Enum.SortOrder.LayoutOrder})f["Pages"].Object.Position=k(0,f["Title"].Object.TextBounds.X+22,0,5)f["Pages"].Object.Size=k(1,-(f["Title"].Object.TextBounds.X+22),1,-9)end;function e:SetTitle(a)f["Title"].Object.Text=a;f["Pages"].Object.Position=k(0,f["Title"].Object.TextBounds.X+22,0,5)f["Pages"].Object.Size=k(1,-(f["Title"].Object.TextBounds.X+22),1,-9)end;function e:AddToTransparencyCache(a,b)if not e.TransparencyCache[a]then e.TransparencyCache[a]=b end end;function e:SetOpen(a)e.IsOpen=a or not e.IsOpen;if not e.IsOpen then for a,b in f["MainFrame"].Object:GetDescendants()do if b:IsA("TextButton")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=1,BackgroundTransparency=1},true)e:AddToTransparencyCache(a,b.BackgroundTransparency)elseif b:IsA("ImageLabel")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1},true)e:AddToTransparencyCache(a,b.ImageTransparency)elseif b:IsA("Frame")or b:IsA("ScrollingFrame")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1},true)e:AddToTransparencyCache(a,b.BackgroundTransparency)elseif b:IsA("UIStroke")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Transparency=1},true)e:AddToTransparencyCache(a,b.Transparency)elseif b:IsA("TextLabel")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=1},true)e:AddToTransparencyCache(a,b.TextTransparency)end end;task.wait(0.1)f["MainFrame"]:Tween(TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=1})else f["MainFrame"]:Tween(TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=0})task.wait(0.1)for a,b in f["MainFrame"].Object:GetDescendants()do if not e.TransparencyCache[a]then continue end;if b:IsA("TextButton")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=0,BackgroundTransparency=e.TransparencyCache[a]},true)elseif b:IsA("ImageLabel")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=e.TransparencyCache[a]},true)elseif b:IsA("Frame")or b:IsA("ScrollingFrame")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=e.TransparencyCache[a]},true)elseif b:IsA("UIStroke")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Transparency=e.TransparencyCache[a]},true)elseif b:IsA("TextLabel")then c:Create(b,TweenInfo.new(e.FadeSpeed,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=e.TransparencyCache[a]},true)end end end end;o:Connect(a.InputBegan,function(a,b)if b then return end;if a.KeyCode==o.MenuKey then e:SetOpen()end end)e:SetTitle(e.Name)e.Elements=f;return setmetatable(e,o)end;function o:Page(a)a=a or{}local a={Window=self,Name=a.Name or a.name or"Nigger Cupcake",SubPagesAllowed=a.SubPages or a.subpages or false,Columns=a.Columns or a.columns or 2,Active=false,ColumnsData={},Elements={}}local c={}do c["Inactive"]=b:Create("TextButton",{Parent=a.Window.Elements["Pages"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,Name="\0",BackgroundTransparency=1,Size=k(0,0,0,20),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=14,BackgroundColor3=h(255,255,255)})b:Create("UIPadding",{Parent=c["Inactive"].Object,PaddingRight=l(0,5),PaddingLeft=l(0,5)})c["Liner"]=b:Create("Frame",{Parent=c["Inactive"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,-5,1,0),BorderColor3=h(0,0,0),Size=k(1,10,0,1),BorderSizePixel=0,BackgroundTransparency=1,BackgroundColor3=h(34,34,34)})c["Liner"]:AddToTheme({BackgroundColor3="Accent"})c["Text"]=b:Create("TextLabel",{Parent=c["Inactive"].Object,FontFace=o.Font,TextColor3=h(225,227,229),TextTransparency=0.28,Text=a.Name,Name="\0",Size=k(1,0,1,0),BorderSizePixel=0,BackgroundTransparency=1,BorderColor3=h(0,0,0),TextWrapped=true,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()c["Glow"]=b:Create("Frame",{Parent=c["Inactive"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,-5,0,0),BorderColor3=h(0,0,0),Size=k(1,10,1,0),BorderSizePixel=0,BackgroundColor3=h(131,194,242)})c["Glow"]:AddToTheme({BackgroundColor3="Accent"})b:Create("UIGradient",{Parent=c["Glow"].Object,Rotation=-90,Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.078,0.5249999761581421),NumberSequenceKeypoint.new(0.198,0.75),NumberSequenceKeypoint.new(0.402,0.8999999761581421),NumberSequenceKeypoint.new(1,1)}})c["PageContent"]=b:Create("Frame",{Parent=a.Window.Elements["Inline"].Object,Visible=false,BackgroundTransparency=1,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,1,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})c["SubPages"]=b:Create("Frame",{Parent=c["PageContent"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,5,0,5),BorderColor3=h(0,0,0),Size=k(1,-10,0,23),BorderSizePixel=0,Visible=false,BackgroundColor3=h(17,19,22)})b:Create("UIListLayout",{Parent=c["SubPages"].Object,FillDirection=Enum.FillDirection.Horizontal,VerticalFlex=Enum.UIFlexAlignment.Fill,Padding=l(0,5),SortOrder=Enum.SortOrder.LayoutOrder})c["Columns"]=b:Create("Frame",{Parent=c["PageContent"].Object,Name="\0",Position=k(0,6,0,35),BorderColor3=h(0,0,0),Size=k(1,-12,1,-41),BorderSizePixel=0,BackgroundColor3=h(12,14,16)})c["Columns"]:AddToTheme({BackgroundColor3="Background"})if not a.SubPagesAllowed then b:Create("UIListLayout",{Parent=c["Columns"].Object,FillDirection=Enum.FillDirection.Horizontal,HorizontalFlex=Enum.UIFlexAlignment.Fill,Padding=l(0,2),SortOrder=Enum.SortOrder.LayoutOrder,VerticalFlex=Enum.UIFlexAlignment.Fill})b:Create("UIPadding",{Parent=c["Columns"].Object,PaddingBottom=l(0,8),PaddingLeft=l(0,5),PaddingTop=l(0,5),PaddingRight=l(0,5)})end;c["Columns"]:Border()if a.SubPagesAllowed then c["SubPages"].Object.Visible=true;c["Columns"].Object.Size=k(1,-12,1,-41)c["Columns"].Object.Position=k(0,6,0,35)else c["SubPages"].Object.Visible=false;c["Columns"].Object.Size=k(1,-12,1,-12)c["Columns"].Object.Position=k(0,6,0,6)end;if not a.SubPagesAllowed then for d=1,a.Columns do local c=b:Create("ScrollingFrame",{Parent=c["Columns"].Object,ScrollBarImageColor3=h(131,194,242),MidImage="rbxassetid://85239668542938",Active=true,AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=1,Name="\0",Size=k(0,100,0,100),BackgroundColor3=h(255,255,255),TopImage="rbxassetid://85239668542938",BorderColor3=h(0,0,0),BackgroundTransparency=1,BottomImage="rbxassetid://85239668542938",BorderSizePixel=0,CanvasSize=k(0,0,0,0)})c:AddToTheme({ScrollBarImageColor3="Accent"})b:Create("UIPadding",{Parent=c.Object,PaddingTop=l(0,4),PaddingBottom=l(0,4),PaddingRight=l(0,1),PaddingLeft=l(0,4)})b:Create("UIListLayout",{Parent=c.Object,Padding=l(0,12),SortOrder=Enum.SortOrder.LayoutOrder})a.ColumnsData[d]=c end end end;function a:Switch(b)a.Active=b;c["PageContent"].Object.Visible=a.Active;if a.Active then c["Text"]:Tween(nil,{TextTransparency=0})c["Liner"]:Tween(nil,{BackgroundTransparency=0})c["Glow"]:Tween(nil,{BackgroundTransparency=0})else c["Text"]:Tween(nil,{TextTransparency=0.28})c["Liner"]:Tween(nil,{BackgroundTransparency=1})c["Glow"]:Tween(nil,{BackgroundTransparency=1})end end;c["Inactive"]:Connect("MouseButton1Down",function()for b,b in a.Window.Pages do b:Switch(b==a)end end,a.Name.." Switch Event")if#a.Window.Pages==0 then a:Switch(true)end;a.Elements=c;table.insert(a.Window.Pages,a)return setmetatable(a,o.Pages)end;function o.Pages:SubPage(a)a=a or{}local a={Window=self.Window,Page=self,Name=a.Name or a.name or"Nigger Cupcake",SubPagesAllowed=a.SubPages or a.subpages or false,Columns=a.Columns or a.columns or 2,Active=false,ColumnsData={},Elements={}}local c={}do c["Inactive"]=b:Create("TextButton",{Parent=a.Page.Elements["SubPages"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,Name="\0",BackgroundTransparency=1,Size=k(0,0,0,20),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=14,BackgroundColor3=h(255,255,255)})b:Create("UIPadding",{Parent=c["Inactive"].Object,PaddingRight=l(0,5),PaddingLeft=l(0,5)})c["Liner"]=b:Create("Frame",{Parent=c["Inactive"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,-5,1,0),BackgroundTransparency=1,BorderColor3=h(0,0,0),Size=k(1,10,0,1),BorderSizePixel=0,BackgroundColor3=h(34,34,34)})c["Liner"]:AddToTheme({BackgroundColor3="Accent"})c["Text"]=b:Create("TextLabel",{Parent=c["Inactive"].Object,FontFace=o.Font,TextColor3=h(225,227,229),TextTransparency=0.28,Text=a.Name,Name="\0",Size=k(1,0,1,0),BorderSizePixel=0,BackgroundTransparency=1,BorderColor3=h(0,0,0),TextWrapped=true,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()c["Glow"]=b:Create("Frame",{Parent=c["Inactive"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,-5,0,0),BorderColor3=h(0,0,0),Size=k(1,10,1,0),BorderSizePixel=0,BackgroundColor3=h(131,194,242)})c["Glow"]:AddToTheme({BackgroundColor3="Accent"})b:Create("UIGradient",{Parent=c["Glow"].Object,Rotation=-90,Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.078,0.5249999761581421),NumberSequenceKeypoint.new(0.198,0.75),NumberSequenceKeypoint.new(0.402,0.8999999761581421),NumberSequenceKeypoint.new(1,1)}})c["SubPageContent"]=b:Create("Frame",{Parent=a.Page.Elements["Columns"].Object,Visible=false,BackgroundTransparency=1,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,1,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=c["SubPageContent"].Object,FillDirection=Enum.FillDirection.Horizontal,HorizontalFlex=Enum.UIFlexAlignment.Fill,Padding=l(0,2),SortOrder=Enum.SortOrder.LayoutOrder,VerticalFlex=Enum.UIFlexAlignment.Fill})b:Create("UIPadding",{Parent=c["SubPageContent"].Object,PaddingBottom=l(0,8),PaddingLeft=l(0,5),PaddingTop=l(0,5),PaddingRight=l(0,5)})for d=1,a.Columns do local c=b:Create("ScrollingFrame",{Parent=c["SubPageContent"].Object,ScrollBarImageColor3=h(131,194,242),MidImage="rbxassetid://85239668542938",Active=true,AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=1,Name="\0",Size=k(0,100,0,100),BackgroundColor3=h(255,255,255),TopImage="rbxassetid://85239668542938",BorderColor3=h(0,0,0),BackgroundTransparency=1,BottomImage="rbxassetid://85239668542938",BorderSizePixel=0,CanvasSize=k(0,0,0,0)})c:AddToTheme({ScrollBarImageColor3="Accent"})b:Create("UIPadding",{Parent=c.Object,PaddingTop=l(0,4),PaddingBottom=l(0,4),PaddingRight=l(0,1),PaddingLeft=l(0,4)})b:Create("UIListLayout",{Parent=c.Object,Padding=l(0,12),SortOrder=Enum.SortOrder.LayoutOrder})a.ColumnsData[d]=c end end;function a:Switch(b)a.Active=b;c["SubPageContent"].Object.Visible=a.Active;if a.Active then c["Text"]:Tween(nil,{TextTransparency=0})c["Liner"]:Tween(nil,{BackgroundTransparency=0})c["Glow"]:Tween(nil,{BackgroundTransparency=0})else c["Text"]:Tween(nil,{TextTransparency=0.28})c["Liner"]:Tween(nil,{BackgroundTransparency=1})c["Glow"]:Tween(nil,{BackgroundTransparency=1})end end;c["Inactive"]:Connect("MouseButton1Down",function()for b,b in a.Window.SubPages do b:Switch(b==a)end end,a.Name.." Switch Event")table.insert(a.Window.SubPages,a)return setmetatable(a,o.Pages)end;function o.Pages:MultiSection(a)local a={Window=self.Window,Page=self,Name=a.Name or a.name or"Nigger Cupcake",Side=a.Side or a.side or 1,Sections=a.Sections or a.sections or{"One","Two","Three"},SectionContents={},Elements={}}local c={}do c["MultiSection"]=b:Create("Frame",{Parent=a.Page.ColumnsData[a.Side].Object,Name="\0",Size=k(1,-3,0,25),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=h(16,16,16)})c["MultiSection"]:AddToTheme({BackgroundColor3="Inline"})c["MultiSection"]:Border()b:Create("UIGradient",{Parent=c["MultiSection"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(0.041,h(189,189,189)),ColorSequenceKeypoint.new(0.315,h(255,255,255)),ColorSequenceKeypoint.new(1,h(255,255,255))}})c["Sections"]=b:Create("Frame",{Parent=c["MultiSection"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,0,0,5),BorderColor3=h(0,0,0),Size=k(1,-5,0,21),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=c["Sections"].Object,FillDirection=Enum.FillDirection.Horizontal,HorizontalFlex=Enum.UIFlexAlignment.Fill,Padding=l(0,5),SortOrder=Enum.SortOrder.LayoutOrder,VerticalFlex=Enum.UIFlexAlignment.Fill})b:Create("UIPadding",{Parent=c["MultiSection"].Object,PaddingBottom=l(0,6),PaddingLeft=l(0,6)})c["Content"]=b:Create("Frame",{Parent=c["MultiSection"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,0,0,32),BorderColor3=h(0,0,0),Size=k(1,-6,1,-28),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})end;for d,d in a.Sections do local e={Window=a.Window,Page=a.Page,Name=d,Active=false,Elements={}}local f={}do f["Inactive"]=b:Create("TextButton",{Parent=c["Sections"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,Name="\0",BackgroundTransparency=1,Size=k(0,0,0,20),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=14,BackgroundColor3=h(255,255,255)})b:Create("UIPadding",{Parent=f["Inactive"].Object,PaddingRight=l(0,5),PaddingLeft=l(0,5)})f["Liner"]=b:Create("Frame",{Parent=f["Inactive"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,-5,1,0),BorderColor3=h(0,0,0),Size=k(1,10,0,1),BorderSizePixel=0,BackgroundTransparency=1,BackgroundColor3=h(34,34,34)})f["Liner"]:AddToTheme({BackgroundColor3="Accen"})f["Text"]=b:Create("TextLabel",{Parent=f["Inactive"].Object,FontFace=o.Font,TextColor3=h(225,227,229),TextTransparency=0.28,Text=d,Name="\0",Size=k(1,0,1,0),BorderSizePixel=0,BackgroundTransparency=1,BorderColor3=h(0,0,0),TextWrapped=true,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})f["Text"]:AddToTheme({TextColor3="Text"})f["Text"]:TextBorder()f["Glow"]=b:Create("Frame",{Parent=f["Inactive"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,-5,0,0),BorderColor3=h(0,0,0),Size=k(1,10,1,0),BorderSizePixel=0,BackgroundColor3=h(131,194,242)})f["Glow"]:AddToTheme({BackgroundColor3="Accent"})b:Create("UIGradient",{Parent=f["Glow"].Object,Rotation=-90,Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.078,0.5249999761581421),NumberSequenceKeypoint.new(0.198,0.75),NumberSequenceKeypoint.new(0.402,0.8999999761581421),NumberSequenceKeypoint.new(1,1)}})f["Content"]=b:Create("Frame",{Parent=c["Content"].Object,BackgroundTransparency=1,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,1,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=f["Content"].Object,Padding=l(0,6),SortOrder=Enum.SortOrder.LayoutOrder})function e:Switch(a)e.Active=a;f["Content"].Object.Visible=e.Active;if e.Active then f["Text"]:Tween(nil,{TextTransparency=0})f["Liner"]:Tween(nil,{BackgroundTransparency=0})f["Glow"]:Tween(nil,{BackgroundTransparency=0})else f["Text"]:Tween(nil,{TextTransparency=0.28})f["Liner"]:Tween(nil,{BackgroundTransparency=1})f["Glow"]:Tween(nil,{BackgroundTransparency=1})end end;f["Inactive"]:Connect("MouseButton1Down",function()for a,a in a.SectionContents do a:Switch(a==e)end end,e.Name.." Switch Event")if#a.SectionContents==0 then e:Switch(true)end;e.Elements=f;a.SectionContents[#a.SectionContents+1]=setmetatable(e,o.Sections)end end;a.SectionContents[1]:Switch(true)a.Window.Sections[#a.Window.Sections+1]=a;return table.unpack(a.SectionContents)end;function o.Pages:Section(a)a=a or{}local a={Window=self.Window,Page=self,Name=a.Name or a.name or"Nigger Cupcake",Side=a.Side or a.side or 1,Elements={}}local c={}do c["Section"]=b:Create("Frame",{Parent=a.Page.ColumnsData[a.Side].Object,Name="\0",Size=k(1,-3,0,25),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=h(16,16,16)})c["Section"]:AddToTheme({BackgroundColor3="Inline"})c["Section"]:Border()b:Create("UIPadding",{Parent=c["Section"].Object,PaddingBottom=l(0,6),PaddingLeft=l(0,6)})c["Text"]=b:Create("TextLabel",{Parent=c["Section"].Object,FontFace=o.Font,TextColor3=h(229,229,229),BorderColor3=h(0,0,0),Text=a.Name,Name="\0",Size=k(0,0,0,15),Position=k(0,-1,0,3),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()c["Liner"]=b:Create("Frame",{Parent=c["Section"].Object,Name="\0",Position=k(0,-1,0,20),BorderColor3=h(0,0,0),Size=k(1,-4,0,1),BorderSizePixel=0,BackgroundColor3=h(34,34,34)})c["Liner"]:AddToTheme({BackgroundColor3="Border"})c["Content"]=b:Create("Frame",{Parent=c["Section"].Object,Name="\0",BackgroundTransparency=1,Position=k(0,0,0,28),BorderColor3=h(0,0,0),Size=k(1,-6,1,-28),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})b:Create("UIListLayout",{Parent=c["Content"].Object,Padding=l(0,6),SortOrder=Enum.SortOrder.LayoutOrder})end;a.Elements=c;return setmetatable(a,o.Sections)end;function o.Pages:ScrollableSection(a)a=a or{}local a={Window=self.Window,Page=self,Name=a.Name or a.name or"Nigger Cupcake",Side=a.Side or a.side or 1,SectionSize=a.SectionSize or a.sectionsize or 155,CanvasSize=a.CanvasSize or a.canvassize or 185,Elements={}}local c={}do c["ScrollableSection"]=b:Create("Frame",{Parent=a.Page.ColumnsData[a.Side].Object,Name="\0",Size=k(1,-3,0,25),BorderColor3=h(0,0,0),BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=h(16,16,16)})c["ScrollableSection"]:AddToTheme({BackgroundColor3="Inline"})c["ScrollableSection"]:Border()b:Create("UIPadding",{Parent=c["ScrollableSection"].Object,PaddingBottom=l(0,6),PaddingLeft=l(0,6)})c["Text"]=b:Create("TextLabel",{Parent=c["ScrollableSection"].Object,FontFace=o.Font,TextColor3=h(229,229,229),BorderColor3=h(0,0,0),Text=a.Name,Name="\0",Size=k(0,0,0,15),Position=k(0,-1,0,3),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()c["Liner"]=b:Create("Frame",{Parent=c["ScrollableSection"].Object,Name="\0",Position=k(0,-1,0,20),BorderColor3=h(0,0,0),Size=k(1,-4,0,1),BorderSizePixel=0,BackgroundColor3=h(34,34,34)})c["Liner"]:AddToTheme({BackgroundColor3="Border"})b:Create("UIGradient",{Parent=c["ScrollableSection"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(0.041,h(189,189,189)),ColorSequenceKeypoint.new(0.315,h(255,255,255)),ColorSequenceKeypoint.new(1,h(255,255,255))}})c["Content"]=b:Create("ScrollingFrame",{Parent=c["ScrollableSection"].Object,ScrollBarImageColor3=h(131,194,242),MidImage="rbxassetid://85239668542938",Active=true,AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=1,Name="\0",Size=k(1,-6,0,125),BorderColor3=h(0,0,0),BackgroundColor3=h(255,255,255),TopImage="rbxassetid://85239668542938",Position=k(0,0,0,28),BackgroundTransparency=1,BottomImage="rbxassetid://85239668542938",BorderSizePixel=0,CanvasSize=k(0,0,0,0)})c["Content"]:AddToTheme({ScrollBarImageColor3="Accent"})b:Create("UIListLayout",{Parent=c["Content"].Object,Padding=l(0,6),SortOrder=Enum.SortOrder.LayoutOrder})b:Create("UIPadding",{Parent=c["Content"].Object,PaddingBottom=l(0,6),PaddingLeft=l(0,5),PaddingRight=l(0,5),PaddingTop=l(0,2)})end;a.Elements=c;return setmetatable(a,o.Sections)end;function o.Sections:Toggle(a)a=a or{}local a={Window=self.Window,Page=self.Page,Section=self,Name=a.Name or a.name or"Nigger Cupcake",Default=a.Default or a.default or false,Flag=a.Flag or a.flag or o:NextFlag(),Callback=a.Callback or a.callback or function()end,Value=false,Class="Toggle",Count=0}local c={}do c["Toggle"]=b:Create("TextButton",{Parent=a.Section.Elements["Content"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,BackgroundTransparency=1,Name="\0",Size=k(1,0,0,13),BorderSizePixel=0,TextSize=14,BackgroundColor3=h(255,255,255)})c["Indicator"]=b:Create("Frame",{Parent=c["Toggle"].Object,Name="\0",BorderColor3=h(0,0,0),Size=k(0,12,0,12),BorderSizePixel=0,BackgroundColor3=h(15,15,15)})c["Indicator"]:AddToTheme({BackgroundColor3="Element"})c["Indicator"]:Border():AddHoverEffect(true)b:Create("UIGradient",{Parent=c["Indicator"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(86,86,86))}})c["Text"]=b:Create("TextLabel",{Parent=c["Toggle"].Object,FontFace=o.Font,TextColor3=h(225,227,229),TextTransparency=0.28,Text=a.Name,Name="\0",Size=k(0,0,0,15),Position=k(0,18,0,-1),BorderSizePixel=0,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderColor3=h(0,0,0),AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()end;function a:Set(b)a.Value=b or not a.Value;if a.Value then c["Text"]:Tween(nil,{TextTransparency=0,TextColor3=o.Theme.Accent})c["Indicator"]:Tween(nil,{BackgroundColor3=o.Theme.Accent})c["Indicator"]:ChangeObjectTheme({BackgroundColor3="Accent"})c["Text"]:ChangeObjectTheme({TextColor3="Accent"})else c["Text"]:Tween(nil,{TextTransparency=0.28,TextColor3=o.Theme.Text})c["Indicator"]:Tween(nil,{BackgroundColor3=o.Theme.Element})c["Indicator"]:ChangeObjectTheme({BackgroundColor3="Element"})c["Text"]:ChangeObjectTheme({TextColor3="Text"})end;if a.Callback then pcall(a.Callback,a.Value)end end;function a:Get()return a.Value end;function a:Colorpicker(b)local b={Window=self.Window,Tab=self.Tab,Section=self.Section,Parent=c["Toggle"],Name=b.Name or b.name or"Nigger Cupcake",Flag=b.Flag or b.flag or o:NextFlag(),Default=b.Default or b.default or Color3.fromRGB(255,255,255),Callback=b.Callback or b.callback or function()end,Count=a.Count}a.Count=a.Count+1;b.Count=a.Count;local a=o:Colorpicker(b)o.Flags[b.Flag]=a;return b end;function a:Keybind(a)local a={Window=self.Window,Tab=self.Tab,Section=self.Section,Parent=c["Toggle"],Name=a.Name or a.name or"Nigger Cupcake",Flag=a.Flag or a.flag or o:NextFlag(),Default=a.Default or a.default or"None",Callback=a.Callback or a.callback or function()end}local b=o:Keybind(a)o.Flags[a.Flag]=b;return a end;function a:SetVisiblity(a)c["Toggle"].Object.Visible=a or true end;c["Toggle"]:Connect("MouseButton1Down",function()a:Set()end,a.Name.." Toggle Event")if a.Default then a:Set(a.Default)end;o.Flags[a.Flag]=a;return a end;function o.Sections:Button(a)a=a or{}local a={Window=self.Window,Page=self.Page,Section=self,Name=a.Name or a.name or"Nigger Cupcake",Callback=a.Callback or a.callback or function()end}local c={}do c["Button"]=b:Create("TextButton",{Parent=a.Section.Elements["Content"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,Name="\0",Size=k(1,0,0,18),BorderSizePixel=0,TextSize=14,BackgroundColor3=h(15,15,15)})c["Button"]:AddToTheme({BackgroundColor3="Element"})c["Button"]:Border():AddHoverEffect(false)c["Text"]=b:Create("TextLabel",{Parent=c["Button"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=a.Name,Name="\0",Size=k(0,0,1,0),AnchorPoint=m(0.5,0.5),Position=k(0.5,0,0.5,0),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()b:Create("UIGradient",{Parent=c["Button"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(86,86,86))}})end;function a:Press()c["Button"]:Tween(nil,{BackgroundColor3=o.Theme.Accent})c["Button"]:ChangeObjectTheme({BackgroundColor3="Accent"})task.wait(0.095)c["Button"]:Tween(nil,{BackgroundColor3=o.Theme.Element})c["Button"]:ChangeObjectTheme({BackgroundColor3="Element"})pcall(a.Callback)end;function a:Sub(d)d=d or{}local d={Window=self.Window,Page=self.Page,Section=self,Name=d.Name or d.name,Callback=d.Callback or d.callback or function()end}local e={}do c["ButtonHolder"]=b:Create("Frame",{Parent=a.Section.Elements["Content"].Object,Name="\0",Size=k(1,0,0,18),BorderColor3=h(0,0,0),BorderSizePixel=0,BackgroundColor3=h(255,255,255),BackgroundTransparency=1})c["Button"].Object.Parent=c["ButtonHolder"].Object;c["Button"].Object.Size=k(0.5,-3,0,18)e["Sub"]=b:Create("TextButton",{Parent=c["ButtonHolder"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,AnchorPoint=m(1,0),Name="\0",Position=k(1,0,0,0),Size=k(0.5,-3,0,18),BorderSizePixel=0,TextSize=14,BackgroundColor3=h(15,15,15)})e["Sub"]:AddToTheme({BackgroundColor3="Element"})e["Sub"]:Border():AddHoverEffect(false)e["Text"]=b:Create("TextLabel",{Parent=e["Sub"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=d.Name,Name="\0",Size=k(0,0,1,0),AnchorPoint=m(0.5,0.5),Position=k(0.5,0,0.5,1),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})e["Text"]:AddToTheme({TextColor3="Text"})e["Text"]:TextBorder()b:Create("UIGradient",{Parent=e["Sub"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(86,86,86))}})function d:Press()e["Sub"]:Tween(nil,{BackgroundColor3=o.Theme.Accent})e["Sub"]:ChangeObjectTheme({BackgroundColor3="Accent"})task.wait(0.095)e["Sub"]:Tween(nil,{BackgroundColor3=o.Theme.Element})e["Sub"]:ChangeObjectTheme({BackgroundColor3="Element"})pcall(d.Callback)end;function d:SetVisiblity(a)e["Sub"].Object.Visible=a or true end;e["Sub"]:Connect("MouseButton1Down",function()d:Press()end,d.Name.." Press Event")end end;function a:SetVisiblity(a)c["Button"].Object.Visible=a or true end;c["Button"]:Connect("MouseButton1Down",function()a:Press()end,a.Name.." Press Event")return a end;function o.Sections:Slider(c)c=c or{}local c={Window=self.Window,Page=self.Page,Section=self,Name=c.Name or c.name or"Nigger Cupcake",Min=c.Min or c.min or 0,Default=c.Default or c.default or 0,Max=c.Max or c.max or 100,Flag=c.Flag or c.flag or o:NextFlag(),Suffix=c.Suffix or c.suffix or"",Decimals=c.Decimals or c.decimals or 1,Callback=c.Callback or c.callback or function()end,Value=0,Class="Slider"}local d={}do d["Slider"]=b:Create("Frame",{Parent=c.Section.Elements["Content"].Object,BackgroundTransparency=1,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,0,27),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})d["Text"]=b:Create("TextLabel",{Parent=d["Slider"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=c.Name,Name="\0",Size=k(0,0,0,13),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})d["Text"]:AddToTheme({TextColor3="Text"})d["Text"]:TextBorder()d["Indicator"]=b:Create("TextButton",{Parent=d["Slider"].Object,AnchorPoint=m(0,1),AutoButtonColor=false,Text="",Name="\0",Position=k(0,0,1,0),BorderColor3=h(0,0,0),Size=k(1,0,0,8),BorderSizePixel=0,BackgroundColor3=h(15,15,15)})d["Indicator"]:AddToTheme({BackgroundColor3="Element"})d["Indicator"]:Border():AddHoverEffect(true)b:Create("UIGradient",{Parent=d["Indicator"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(86,86,86))}})d["Accent"]=b:Create("Frame",{Parent=d["Indicator"].Object,Name="\0",Position=k(0,0,0,-1),BorderColor3=h(0,0,0),Size=k(0.25,0,1,0),BorderSizePixel=0,BackgroundColor3=h(131,194,242)})d["Accent"]:AddToTheme({BackgroundColor3="Accent"})b:Create("UIGradient",{Parent=d["Accent"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(159,159,159))}})d["Value"]=b:Create("TextLabel",{Parent=d["Indicator"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text="25%",Name="\0",Size=k(0,0,0,13),AnchorPoint=m(0.5,0),Position=k(0.5,0,0,-2),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})d["Value"]:AddToTheme({TextColor3="Text"})d["Value"]:TextBorder()d["Minus"]=b:Create("TextButton",{Parent=d["Slider"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text="-",AutoButtonColor=false,AnchorPoint=m(1,0),Name="\0",BackgroundTransparency=1,Position=k(1,-12,0,0),Size=k(0,15,0,15),BorderSizePixel=0,TextSize=12,BackgroundColor3=h(255,255,255)})d["Minus"]:AddToTheme({TextColor3="Text"})d["Minus"]:TextBorder()d["Plus"]=b:Create("TextButton",{Parent=d["Slider"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text="+",AutoButtonColor=false,AnchorPoint=m(1,0),Name="\0",BackgroundTransparency=1,Position=k(1,0,0,0),Size=k(0,15,0,15),BorderSizePixel=0,TextSize=12,BackgroundColor3=h(255,255,255)})d["Plus"]:AddToTheme({TextColor3="Text"})d["Plus"]:TextBorder()end;local b=false;function c:Set(a)c.Value=o:Floor(math.clamp(a,c.Min,c.Max),c.Decimals)d["Accent"]:Tween(TweenInfo.new(0.18,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=k((c.Value-c.Min)/(c.Max-c.Min),0,1,0)})d["Value"].Object.Text=tostring(c.Value)..c.Suffix;if c.Callback then pcall(c.Callback,c.Value)end end;function c:Get()return c.Value end;function c:SetVisiblity(a)d["Slider"].Object.Visible=a or true end;d["Indicator"]:Connect("MouseButton1Down",function()b=true;local a=(e.X-d["Indicator"].Object.AbsolutePosition.X)/d["Indicator"].Object.AbsoluteSize.X;local a=((c.Max-c.Min)*a)+c.Min;c:Set(a)end,c.Name.." - InputBegan(Indicator)")d["Indicator"]:Connect("InputEnded",function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then b=false end end,c.Name.." - InputEnded(Indicator)")o:Connect(a.InputChanged,function(a)if a.UserInputType==Enum.UserInputType.MouseMovement and b then local a=(a.Position.X-d["Indicator"].Object.AbsolutePosition.X)/d["Indicator"].Object.AbsoluteSize.X;local a=((c.Max-c.Min)*a)+c.Min;c:Set(a)end end,c.Name.." - InputChanged")d["Plus"]:Connect("MouseButton1Click",function()c:Set(c.Value+c.Decimals)end,c.Name.." - Clicked(Plus)")d["Minus"]:Connect("MouseButton1Click",function()c:Set(c.Value-c.Decimals)end,c.Name.." - Clicked(Minus)")if c.Default then c:Set(c.Default)end;o.Flags[c.Flag]=c;return c end;function o.Sections:Dropdown(a)a=a or{}local a={Window=self.Window,Page=self.Page,Section=self,Name=a.Name or a.name or"Nigger Cupcake",List=a.List or a.list or{},Multi=a.Multi or a.multi or false,Default=a.Default or a.default or 1,Flag=a.Flag or a.flag or o:NextFlag(),Callback=a.Callback or a.callback or function()end,Value="",IsOpen=false,Options={},Class="Dropdown"}local d={}do d["Dropdown"]=b:Create("Frame",{Parent=a.Section.Elements["Content"].Object,BackgroundTransparency=1,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,0,34),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})d["Text"]=b:Create("TextLabel",{Parent=d["Dropdown"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=a.Name,Name="\0",Size=k(0,0,0,13),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})d["Text"]:AddToTheme({TextColor3="Text"})d["Text"]:TextBorder()d["RealDropdown"]=b:Create("Frame",{Parent=d["Dropdown"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,0,1,0),BorderColor3=h(0,0,0),Size=k(1,0,0,17),BorderSizePixel=0,BackgroundColor3=h(15,15,15)})d["RealDropdown"]:AddToTheme({BackgroundColor3="Element"})d["RealDropdown"]:Border():AddHoverEffect(true)b:Create("UIGradient",{Parent=d["RealDropdown"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(86,86,86))}})d["Value"]=b:Create("TextLabel",{Parent=d["RealDropdown"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text="Option",Name="\0",Size=k(0,0,0,13),Position=k(0,5,0,2),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})d["Value"]:AddToTheme({TextColor3="Text"})d["Value"]:TextBorder()d["Open"]=b:Create("TextButton",{Parent=d["RealDropdown"].Object,FontFace=o.Font,TextColor3=h(0,0,0),BorderColor3=h(0,0,0),Text="",AutoButtonColor=false,BackgroundTransparency=1,Name="\0",Size=k(1,0,1,0),BorderSizePixel=0,TextSize=14,BackgroundColor3=h(255,255,255)})d["OpenIcon"]=b:Create("ImageLabel",{Parent=d["RealDropdown"].Object,ScaleType=Enum.ScaleType.Fit,ImageTransparency=0.28,BorderColor3=h(0,0,0),Name="\0",AnchorPoint=m(1,0),Image="rbxassetid://74303691547053",BackgroundTransparency=1,Position=k(1,-5,0,2),Size=k(0,12,0,12),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})d["Liner"]=b:Create("Frame",{Parent=d["RealDropdown"].Object,AnchorPoint=m(1,0),Name="\0",Position=k(1,-22,0,0),BorderColor3=h(0,0,0),Size=k(0,1,1,0),BorderSizePixel=0,BackgroundColor3=h(34,34,34)})d["Liner"]:AddToTheme({BackgroundColor3="Border"})d["OptionHolder"]=b:Create("Frame",{Parent=d["Dropdown"].Object,Visible=false,BorderColor3=h(0,0,0),Name="\0",Position=k(0,0,1,4),Size=k(1,0,0,15),BorderSizePixel=0,BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=h(16,16,16)})d["OptionHolder"]:AddToTheme({BackgroundColor3="Inline"})d["OptionHolder"]:Border()b:Create("UIGradient",{Parent=d["OptionHolder"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(0.041,h(189,189,189)),ColorSequenceKeypoint.new(0.315,h(255,255,255)),ColorSequenceKeypoint.new(1,h(255,255,255))}})b:Create("UIPadding",{Parent=d["OptionHolder"].Object,PaddingTop=l(0,2),PaddingBottom=l(0,2),PaddingRight=l(0,6),PaddingLeft=l(0,6)})b:Create("UIListLayout",{Parent=d["OptionHolder"].Object,SortOrder=Enum.SortOrder.LayoutOrder})end;function a:Set(b)if a.Multi then if type(b)~="table"then return end;a.Value=b;for a,a in a.Options do if not table.find(b,a.Name)then a.IsSelected=false;a.Button:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})a.Button:ChangeObjectTheme({TextColor3="Text"})end end;for b,b in b do a.Options[b].IsSelected=true;a.Options[b].Button:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})a.Options[b].Button:ChangeObjectTheme({TextColor3="Accent"})end;d["Value"].Object.Text=#b>0 and table.concat(b,", ")or"--"else local c=a.Options[b]if not c then return end;a.Value=b;for a,a in a.Options do if a~=c then a.IsSelected=false;a.Button:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})a.Button:ChangeObjectTheme({TextColor3="Text"})end end;c.Button:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})c.Button:ChangeObjectTheme({TextColor3="Accent"})c.IsSelected=true;d["Value"].Object.Text=c.IsSelected and c.Name or"--"end;if a.Callback then pcall(a.Callback,a.Value)end end;local e={}local f=function(a,b)if not e[a]then e[a]=b end end;function a:SetOpen(b)a.IsOpen=b or not a.IsOpen;d["OptionHolder"].Object.ZIndex=a.IsOpen and 15 or 1;if a.IsOpen then d["OptionHolder"].Object.Visible=true;d["OptionHolder"]:Tween(nil,{BackgroundTransparency=0})task.wait(0.1)for a,b in d["OptionHolder"].Object:GetDescendants()do if b:IsA("UIStroke")then c:Create(b,nil,{Transparency=0},true)elseif b:IsA("TextButton")then local a=e[a]if b.TextColor3==o.Theme.Accent then a=0 else a=0.28 end;c:Create(b,nil,{TextTransparency=a},true)b.ZIndex=15 end end else for a,b in d["OptionHolder"].Object:GetDescendants()do if b:IsA("UIStroke")then f(a,b.Transparency)c:Create(b,nil,{Transparency=1},true)elseif b:IsA("TextButton")then f(a,b.TextTransparency)c:Create(b,nil,{TextTransparency=1},true)b.ZIndex=1 end end;task.wait(0.1)d["OptionHolder"]:Tween(nil,{BackgroundTransparency=1})d["OptionHolder"].Object.Visible=false end end;function a:AddOption(c)local b=b:Create("TextButton",{Parent=d["OptionHolder"].Object,FontFace=o.Font,TextColor3=h(229,229,229),TextTransparency=0.28,Text=c,AutoButtonColor=false,Name="\0",Size=k(1,0,0,18),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,BorderColor3=h(0,0,0),TextSize=12,BackgroundColor3=h(255,255,255)})b:AddToTheme({TextColor3="Text"})b:TextBorder()local e={Name=c,Button=b,IsSelected=false}function e:Set()e.IsSelected=not e.IsSelected;if a.Multi then local e=table.find(a.Value,c)if e then table.remove(a.Value,e)else table.insert(a.Value,c)end;local a=#a.Value>0 and table.concat(a.Value,", ")or"--"d["Value"].Object.Text=a;if e then b:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})b:ChangeObjectTheme({TextColor3="Text"})else b:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})b:ChangeObjectTheme({TextColor3="Accent"})end else if e.IsSelected then a.Value=e.Name;for a,a in a.Options do if a~=e then a.IsSelected=false;a.Button:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})a.Button:ChangeObjectTheme({TextColor3="Text"})end end;b:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})b:ChangeObjectTheme({TextColor3="Accent"})d["Value"].Object.Text=e.Name else b:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})b:ChangeObjectTheme({TextColor3="Text"})e.IsSelected=false;a.Value=nil;d["Value"].Object.Text="--"end end;if a.Callback then pcall(a.Callback,a.Value)end end;b:Connect("MouseButton1Down",function()e:Set()end,a.Name.." Option "..c.." Event")a.Options[c]=e end;function a:RemoveOption(b)if a.Options[b]then a.Options[b].Button:Clean()end end;function a:Refresh(b)for b,b in a.Options do a:RemoveOption(b.Name)end;for b,b in b do a:AddOption(b)end end;function a:Get()return a.Value end;function a:SetVisiblity(a)d["Dropdown"].Object.Visible=a end;d["Open"]:Connect("MouseButton1Down",function()a:SetOpen()end,a.Name.." Open Event")for b,b in a.List do a:AddOption(b)end;if a.Default then a:Set(a.Default)end;o.Flags[a.Flag]=a;return a end;function o.Sections:Label(a)local c={Window=self.Window,Page=self.Page,Section=self,Count=0}local d={}do d["Text"]=b:Create("TextLabel",{Parent=c.Section.Elements["Content"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=a,Name="\0",Size=k(1,0,0,15),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})d["Text"]:AddToTheme({TextColor3="Text"})d["Text"]:TextBorder()end;function c:Colorpicker(a)local a={Window=self.Window,Tab=self.Tab,Section=self.Section,Parent=d["Text"],Name=a.Name or a.name or"Nigger Cupcake",Flag=a.Flag or a.flag or o:NextFlag(),Default=a.Default or a.default or Color3.fromRGB(255,255,255),Callback=a.Callback or a.callback or function()end,Count=c.Count}c.Count=c.Count+1;a.Count=c.Count;local b=o:Colorpicker(a)o.Flags[a.Flag]=b;return a end;function c:Keybind(a)local a={Window=self.Window,Tab=self.Tab,Section=self.Section,Parent=d["Text"],Name=a.Name or a.name or"Nigger Cupcake",Flag=a.Flag or a.flag or o:NextFlag(),Default=a.Default or a.default or"None",Callback=a.Callback or a.callback or function()end}local b=o:Keybind(a)o.Flags[a.Flag]=b;return a end;return c end;function o.Sections:Textbox(a)a=a or{}local a={Window=self.Window,Page=self.Page,Section=self,Name=a.Name or a.name or"Nigger Cupcake",Flag=a.Flag or a.flag or o:NextFlag(),Placeholder=a.Placeholder or a.placeholder or". . .",Default=a.Default or a.default or"",Callback=a.Callback or a.callback or function()end,Value="",Class="Textbox"}local c={}do c["Textbox"]=b:Create("Frame",{Parent=a.Section.Elements["Content"].Object,BackgroundTransparency=1,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,0,34),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})c["Text"]=b:Create("TextLabel",{Parent=c["Textbox"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=a.Name,Name="\0",Size=k(0,0,0,13),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()c["Background"]=b:Create("Frame",{Parent=c["Textbox"].Object,AnchorPoint=m(0,1),Name="\0",Position=k(0,0,1,0),BorderColor3=h(0,0,0),Size=k(1,0,0,17),BorderSizePixel=0,BackgroundColor3=h(15,15,15)})c["Background"]:AddToTheme({BackgroundColor3="Element"})c["Background"]:Border():AddHoverEffect(true)b:Create("UIGradient",{Parent=c["Background"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(1,h(86,86,86))}})c["Inline"]=b:Create("TextBox",{Parent=c["Background"].Object,FontFace=o.Font,TextColor3=h(229,229,229),BorderColor3=h(0,0,0),Text="",Name="\0",Size=k(1,0,1,0),BorderSizePixel=0,BackgroundTransparency=1,PlaceholderColor3=h(178,178,178),TextXAlignment=Enum.TextXAlignment.Left,PlaceholderText=a.Placeholder,TextSize=12,ClearTextOnFocus=false,BackgroundColor3=h(255,255,255)})c["Inline"]:AddToTheme({TextColor3="Text"})c["Inline"]:TextBorder()b:Create("UIPadding",{Parent=c["Background"].Object,PaddingRight=l(0,5),PaddingLeft=l(0,5)})end;function a:Set(b)c["Inline"].Object.Text=b;a.Value=b;if a.Callback then pcall(a.Callback,a.Value)end end;function a:Get()return a.Value end;function a:SetVisiblity(a)c["Textbox"].Object.Visible=a end;c["Inline"]:Connect("Focused",function()c["Inline"]:Tween(nil,{TextColor3=o.Theme.Accent})c["Inline"]:ChangeObjectTheme({TextColor3="Accent"})end,a.Name.." Focused")c["Inline"]:Connect("FocusLost",function()c["Inline"]:Tween(nil,{TextColor3=o.Theme.Text})c["Inline"]:ChangeObjectTheme({TextColor3="Text"})a:Set(c["Inline"].Object.Text)end,a.Name.." Unfocused")if a.Default then a:Set(a.Default)end;o.Flags[a.Flag]=a;return a end;function o.Sections:Listbox(a)a=a or{}local a={Window=self.Window,Page=self.Page,Section=self,Name=a.Name or a.name or"Nigger Cupcake",List=a.List or a.list or{},Multi=a.Multi or a.multi or false,Default=a.Default or a.default or 1,Flag=a.Flag or a.flag or o:NextFlag(),Callback=a.Callback or a.callback or function()end,Size=a.Size or a.size or 175,Value="",Options={},Class="Listbox"}local c={}do c["Listbox"]=b:Create("Frame",{Parent=a.Section.Elements["Content"].Object,BackgroundTransparency=1,Name="\0",BorderColor3=h(0,0,0),Size=k(1,0,0,a.Size),BorderSizePixel=0,BackgroundColor3=h(255,255,255)})c["Text"]=b:Create("TextLabel",{Parent=c["Listbox"].Object,FontFace=o.Font,TextColor3=h(225,227,229),BorderColor3=h(0,0,0),Text=a.Name,Name="\0",Size=k(0,0,0,15),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.X,TextSize=12,BackgroundColor3=h(255,255,255)})c["Text"]:AddToTheme({TextColor3="Text"})c["Text"]:TextBorder()c["RealListbox"]=b:Create("ScrollingFrame",{Parent=c["Listbox"].Object,ScrollBarImageColor3=h(131,194,242),MidImage="rbxassetid://85239668542938",Active=true,AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=1,Name="\0",Size=k(1,0,1,-17),BackgroundColor3=h(12,14,16),TopImage="rbxassetid://85239668542938",Position=k(0,0,0,17),BorderColor3=h(0,0,0),BottomImage="rbxassetid://85239668542938",BorderSizePixel=0,CanvasSize=k(0,0,0,0)})c["RealListbox"]:AddToTheme({ScrollBarImageColor3="Accent",BackgroundColor3="Element"})c["RealListbox"]:Border()b:Create("UIGradient",{Parent=c["RealListbox"].Object,Rotation=90,Color=ColorSequence.new{ColorSequenceKeypoint.new(0,h(255,255,255)),ColorSequenceKeypoint.new(0.041,h(189,189,189)),ColorSequenceKeypoint.new(0.315,h(255,255,255)),ColorSequenceKeypoint.new(1,h(255,255,255))}})b:Create("UIListLayout",{Parent=c["RealListbox"].Object,SortOrder=Enum.SortOrder.LayoutOrder})b:Create("UIPadding",{Parent=c["RealListbox"].Object,PaddingTop=l(0,2),PaddingBottom=l(0,2),PaddingRight=l(0,6),PaddingLeft=l(0,6)})end;function a:Set(b)if a.Multi then if type(b)~="table"then return end;a.Value=b;for a,a in a.Options do if not table.find(b,a.Name)then a.IsSelected=false;a.Button:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})a.Button:ChangeObjectTheme({TextColor3="Text"})end end;for b,b in b do a.Options[b].IsSelected=true;a.Options[b].Button:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})a.Options[b].Button:ChangeObjectTheme({TextColor3="Accent"})end else local c=a.Options[b]if not c then return end;a.Value=b;for a,a in a.Options do if a~=c then a.IsSelected=false;a.Button:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})a.Button:ChangeObjectTheme({TextColor3="Text"})end end;c.Button:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})c.Button:ChangeObjectTheme({TextColor3="Accent"})c.IsSelected=true end;if a.Callback then pcall(a.Callback,a.Value)end end;function a:AddOption(d)local b=b:Create("TextButton",{Parent=c["RealListbox"].Object,FontFace=o.Font,TextColor3=h(229,229,229),TextTransparency=0.28,Text=d,AutoButtonColor=false,Name="\0",Size=k(1,0,0,18),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Center,BorderSizePixel=0,BorderColor3=h(0,0,0),TextSize=12,BackgroundColor3=h(255,255,255)})b:AddToTheme({TextColor3="Text"})b:TextBorder()local c={Name=d,Button=b,IsSelected=false}function c:Set()c.IsSelected=not c.IsSelected;if a.Multi then local c=table.find(a.Value,d)if c then table.remove(a.Value,c)else table.insert(a.Value,d)end;if c then b:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})b:ChangeObjectTheme({TextColor3="Text"})else b:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})b:ChangeObjectTheme({TextColor3="Accent"})end else if c.IsSelected then a.Value=c.Name;for a,a in a.Options do if a~=c then a.IsSelected=false;a.Button:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})a.Button:ChangeObjectTheme({TextColor3="Text"})end end;b:Tween(nil,{TextColor3=o.Theme.Accent,TextTransparency=0})b:ChangeObjectTheme({TextColor3="Accent"})else b:Tween(nil,{TextColor3=o.Theme.Text,TextTransparency=0.28})b:ChangeObjectTheme({TextColor3="Text"})c.IsSelected=false;a.Value=nil end end;if a.Callback then pcall(a.Callback,a.Value)end end;b:Connect("MouseButton1Down",function()c:Set()end,a.Name.." Option "..d.." Event")a.Options[d]=c end;function a:RemoveOption(b)if a.Options[b]then a.Options[b].Button:Clean()end end;function a:Refresh(b)for b,b in a.Options do a:RemoveOption(b.Name)end;for b,b in b do a:AddOption(b)end end;function a:Get()return a.Value end;function a:SetVisiblity(a)c["Listbox"].Object.Visible=a end;for b,b in a.List do a:AddOption(b)end;if a.Default then a:Set(a.Default)end;o.Flags[a.Flag]=a;return a end end end;getgenv().Library=o

local Library = getgenv().Library

local Window = Library:Window({ 
    Name = "inari | " .. os.date("%b %d %Y"),
    FadeSpeed = 0.21,
    Icon = nil,
    Size = UDim2.new(0, 622, 0, 453),
});

local Watermark = Window:Watermark("inari | " .. os.date("%b %d %Y"));

local KeybindList = Window:KeybindList();
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))();

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

local MovementSection = Pages["Misc"]:Section({
    Name = "Movement", 
    Side = 1
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
        
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local head = player.Character.Head
                    local pos, visible = workspace.CurrentCamera:WorldToScreenPoint(head.Position)
                    if visible then
                        local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                        if dist < shortestDistance then
                            shortestDistance = dist
                            target = player
                        end
                    end
                end
            end
        
            return target
        end
        
        -- Lock on function
        local function lockOn(player)
            if player and player.Character and player.Character:FindFirstChild("Head") then
                local head = player.Character.Head
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, head.Position)
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

        getgenv().SilentAImNigger = false

        local ClosestNigga = nil
        
        -- Render loop
        RunService.RenderStepped:Connect(function()
            if getgenv().isAimbotEnabled then
                closestPlayer = getClosestPlayerToMouse()
                if isLocking and closestPlayer then
                    lockOn(closestPlayer)
                end
            end

            if getgenv().SilentAImNigger then
                ClosestNigga = getClosestPlayerToMouse()
            end
        end)
        
        -- UI Toggle
        AimbotSection:Toggle({
            Name = "Enable AImbot",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                getgenv().isAimbotEnabled = Value
            end;
        })

        AimbotSection:Toggle({
            Name = "Enable Sielnt aim",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                getgenv().SilentAImNigger = Value
            end;
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
            Flag = "Toggle1231",
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
    end

    -- Visuals Reorganization
    local playerAndContainerSection = Pages["Visuals"]:Section({
        Name = "Player & Container Visuals",
        Side = 1
    });

    local combatVisualsSection = Pages["Visuals"]:Section({
        Name = "Combat Visuals",
        Side = 2
    });

    do -- esp
        ESP.BoxType = "Corner Box Esp";

        playerAndContainerSection:Toggle({
            Name = "Enable ESP",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                ESP.Enabled = Value;
            end;
        });

        playerAndContainerSection:Toggle({
            Name = "bounding boxes",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                ESP.ShowBox = Value
            end;
        });

        playerAndContainerSection:Toggle({
            Name = "Health bar",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                ESP.ShowHealth = Value
            end;
        });

        playerAndContainerSection:Toggle({
            Name = "name",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                ESP.ShowName = Value;
            end;
        });
        
        playerAndContainerSection:Toggle({
            Name = "Tracers",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                ESP.ShowTracer = Value;
            end;
        });

        playerAndContainerSection:Toggle({ 
            Name = "Distance",
            Flag = "Toggle1231",
            Default = false,
            Callback = function(Value)
                ESP.ShowDistance = Value
            end;
        });

        playerAndContainerSection:Toggle({
            Name = "Container ESP",
            Flag = "ContainerESP",
            Default = false,
            Callback = function(Value)
                getgenv().ContainerESP = Value
            end;
        }):Keybind({
            Default = Enum.KeyCode.P,
            Callback = function(Value) end -- handled by internal logic
        });

        playerAndContainerSection:Slider({
            Name = "Render Distance",
            Min = 100, Max = 2000, Default = 200,
            Suffix = " studs",
            Callback = function(Value)
                getgenv().ContainerRenderDistance = Value
            end;
        });

        playerAndContainerSection:Toggle({
            Name = "Dropped Item ESP",
            Flag = "DroppedItemESP",
            Default = false,
            Callback = function(Value)
                getgenv().DroppedItemESP = Value
            end;
        });

        playerAndContainerSection:Slider({
            Name = "Dropped Item Render Distance",
            Min = 100, Max = 2000, Default = 200,
            Suffix = " studs",
            Callback = function(Value)
                getgenv().DroppedItemRenderDistance = Value
            end;
        });

        combatVisualsSection:Toggle({
            Name = "Bullet Tracers",
            Flag = "BulletTracersToggle",
            Default = false,
            Callback = function(Value)
                getgenv().BulletTracers = Value
            end;
        }):Colorpicker({
            Name = "Tracer Color",
            Default = Color3.fromRGB(131, 194, 242),
            Callback = function(Value)
                getgenv().TracerColor = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Bullet Tracers Lifetime",
            Flag = "BulletTracersLifetime",
            Min = 0.1,
            Max = 5,
            Default = 0.3,
            Decimals = 0.1,
            Suffix = "s",
            Callback = function(Value)
                getgenv().BulletTracersLifetime = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Bullet Tracers Travel Time",
            Flag = "BulletTracersTravelTime",
            Min = 0,
            Max = 1,
            Default = 0.05,
            Decimals = 0.01,
            Suffix = "s",
            Callback = function(Value)
                getgenv().BulletTracersTravelTime = Value
            end;
        });

        combatVisualsSection:Toggle({ Name = "Hit Sound",
            Flag = "HitSoundToggle",
            Default = false,
            Callback = function(Value)
                getgenv().HitSound = Value
            end;
        });

        combatVisualsSection:Dropdown({
            Name = "Hit Sound Type",
            List = {"Bell", "Skeet", "Neverlose", "Metallic", "Bubble"},
            Default = "Bell",
            Flag = "HitSoundType",
            Callback = function(Value)
                getgenv().SelectedHitSound = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Hit Sound Volume",
            Flag = "HitSoundVolume",
            Min = 0,
            Max = 10,
            Default = 4,
            Decimals = 0.1,
            Callback = function(Value)
                getgenv().HitSoundVolume = Value
            end;
        });

        combatVisualsSection:Toggle({
            Name = "Hitmarkers",
            Flag = "HitMarkersToggle",
            Default = false,
            Callback = function(Value)
                getgenv().HitMarkers = Value
            end;
        }):Colorpicker({
            Name = "Hitmarker Color",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(Value)
                getgenv().HitmarkersColor = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Hitmarkers Lifetime",
            Flag = "HitmarkersLifetime",
            Min = 0.1,
            Max = 5,
            Default = 0.4,
            Decimals = 0.1,
            Suffix = "s",
            Callback = function(Value)
                getgenv().HitmarkersLifetime = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Hitmarkers Size",
            Flag = "HitmarkersSize",
            Min = 1,
            Max = 30,
            Default = 7,
            Decimals = 1,
            Suffix = "px",
            Callback = function(Value)
                getgenv().HitmarkersSize = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Hitmarkers Thickness",
            Flag = "HitmarkersThickness",
            Min = 1,
            Max = 10,
            Default = 2,
            Decimals = 0.5,
            Callback = function(Value)
                getgenv().HitmarkersThickness = Value
            end;
        });

        -- Original hitLogsSection elements moved to combatVisualsSection
        -- local hitLogsSection = Pages["Visuals"]:Section({ Name = "Hit Logs", Side = 2 });
        combatVisualsSection:Toggle({
            Name = "Enabled",
            Flag = "HitLogsToggle",
            Default = false,
            Callback = function(Value)
                getgenv().HitLogsEnabled = Value
            end;
        }):Colorpicker({
            Name = "Log Color",
            Default = Library.Theme.Accent,
            Callback = function(Value)
                getgenv().HitLogsColor = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Lifetime",
            Flag = "HitLogsLifetime",
            Min = 1,
            Max = 30,
            Default = 5,
            Decimals = 0.5,
            Suffix = "s",
            Callback = function(Value)
                getgenv().HitLogsLifetime = Value
            end;
        });

        combatVisualsSection:Slider({
            Name = "Text Size",
            Flag = "HitLogsSize",
            Min = 10,
            Max = 30,
            Default = 14,
            Callback = function(Value)
                getgenv().HitLogsSize = Value
            end;
        });

        combatVisualsSection:Dropdown({
            Name = "Font",
            List = {"UI", "System", "Plex", "Monospace"},
            Default = "Monospace",
            Flag = "HitLogsFont",
            Callback = function(Value)
                local fontMap = {["UI"] = 0, ["System"] = 1, ["Plex"] = 2, ["Monospace"] = 3}
                getgenv().HitLogsFont = fontMap[Value] or 3
            end;
        });

        local lightingSection = Pages["Misc"]:Section({ Name = "Lighting & Atmosphere", Side = 2 });

        lightingSection:Label("Ambient"):Colorpicker({
            Name = "Ambient",
            Default = game:GetService("Lighting").Ambient,
            Callback = function(Value) game:GetService("Lighting").Ambient = Value end;
        });

        lightingSection:Slider({
            Name = "Clock Time",
            Min = 0, Max = 24, Default = 12,
            Callback = function(Value) game:GetService("Lighting").ClockTime = Value end;
        });

        lightingSection:Slider({
            Name = "Exposure Compensation",
            Min = -5, Max = 5, Default = 0, Decimals = 0.1,
            Callback = function(Value) game:GetService("Lighting").ExposureCompensation = Value end;
        });

        lightingSection:Dropdown({
            Name = "Lighting Style",
            List = {"Realistic", "Soft", "Default"},
            Default = "Default",
            Callback = function(Value)
                local L = game:GetService("Lighting")
                if Value == "Realistic" then
                    L.Brightness = 2; L.ShadowSoftness = 0.2; L.EnvironmentDiffuseScale = 1; L.GlobalShadows = true
                elseif Value == "Soft" then
                    L.Brightness = 1; L.ShadowSoftness = 1; L.EnvironmentDiffuseScale = 0.5; L.GlobalShadows = false
                end
            end;
        });

        local function getAtm()
            local a = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
            if not a then a = Instance.new("Atmosphere", game:GetService("Lighting")) end
            return a
        end

        lightingSection:Label("Atmosphere Color"):Colorpicker({
            Name = "Atmosphere Color",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(V) getAtm().Color = V end;
        });

        lightingSection:Label("Atmosphere Decay"):Colorpicker({
            Name = "Atmosphere Decay",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(V) getAtm().Decay = V end;
        });

        lightingSection:Slider({
            Name = "Atmosphere Glare",
            Min = 0, Max = 10, Default = 0, Decimals = 0.1,
            Callback = function(V) getAtm().Glare = V end;
        });

        lightingSection:Slider({
            Name = "Atmosphere Haze",
            Min = 0, Max = 10, Default = 0, Decimals = 0.1,
            Callback = function(V) getAtm().Haze = V end;
        });

        lightingSection:Slider({
            Name = "Atmosphere Density",
            Min = 0, Max = 1, Default = 0.3, Decimals = 0.01,
            Callback = function(V) getAtm().Density = V end;
        });

        local worldSection = Pages["Misc"]:Section({ Name = "World", Side = 2 });

        worldSection:Toggle({
            Name = "Remove Grass",
            Callback = function(V) workspace.Terrain.Decoration = not V end;
        });

        worldSection:Toggle({
            Name = "Remove Foliage",
            Callback = function(V)
                task.spawn(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Material == Enum.Material.Grass or obj.Material == Enum.Material.LeafyGrass or obj.Name:lower():find("leaf")) then
                            obj.Transparency = V and 1 or 0
                        end
                    end
                end)
            end;
        });

        worldSection:Toggle({
            Name = "Remove Shadows",
            Callback = function(V) game:GetService("Lighting").GlobalShadows = not V end;
        });

    end
    do



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
    
    RunService.RenderStepped:Connect(function(deltaTime)
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
while wait() do
local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.new(math.random(), math.random(), math.random())
end
        end
    })
end
end
end;

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
        
        for _,Player in pairs(game:GetService("Players"):GetChildren()) do
                if Player ~= LocalPlayer and Functions:IsAlive(Player) then
                    local HitPart = Player.Character:FindFirstChild("Head");
                    if HitPart then
                        local ScreenPosition, OnScreen = CurrentCamera:WorldToViewportPoint(HitPart.Position);
                        local Distance = (UserInputService:GetMouseLocation()- Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude;
                        if OnScreen and Distance < Closest then
                            Closest = Distance;
                            Part    = HitPart;
                        end;
                    end;
                end;
            end;
        
        return Part;
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

    function Functions:CreateHitMarker(HitPart, Pos)
        if not getgenv().HitMarkers or not HitPart then return end
        
        task.spawn(function()
            local Color = getgenv().HitmarkersColor or getgenv().TracerColor or Color3.new(1, 1, 1)
            local Lifetime = getgenv().HitmarkersLifetime or 0.4
            local MaxSize = getgenv().HitmarkersSize or 7
            local Thickness = getgenv().HitmarkersThickness or 2
            local Offset = HitPart.CFrame:PointToObjectSpace(Pos)

            local Line1 = Drawing.new("Line")
            local Line2 = Drawing.new("Line")
            
            Line1.Thickness = Thickness
            Line1.Color = Color
            Line2.Thickness = Thickness
            Line2.Color = Color

            local Start = tick()
            while tick() - Start < Lifetime do
                local Elapsed = tick() - Start
                local Alpha = 1 - (Elapsed / Lifetime)
                -- Efecto de expansión: crece rápidamente al inicio
                local CurrentSize = math.clamp((Elapsed / 0.05) * MaxSize, 2, MaxSize)
                
                if HitPart and HitPart.Parent then
                    local CurrentPos = HitPart.CFrame:PointToWorldSpace(Offset)
                    local ScreenPos, OnScreen = CurrentCamera:WorldToViewportPoint(CurrentPos)
                    
                    if OnScreen then
                        Line1.Visible, Line2.Visible = true, true
                        
                        Line1.From = Vector2.new(ScreenPos.X - CurrentSize, ScreenPos.Y - CurrentSize)
                        Line1.To = Vector2.new(ScreenPos.X + CurrentSize, ScreenPos.Y + CurrentSize)

                        Line2.From = Vector2.new(ScreenPos.X + CurrentSize, ScreenPos.Y - CurrentSize)
                        Line2.To = Vector2.new(ScreenPos.X - CurrentSize, ScreenPos.Y + CurrentSize)
                        
                        Line1.Transparency, Line2.Transparency = Alpha, Alpha
                    else
                        Line1.Visible, Line2.Visible = false, false
                    end
                else
                    break
                end
                task.wait()
            end
            
            Line1:Remove()
            Line2:Remove()
        end)
    end;

    function Functions:CreateTracer(Origin, EndPos)
        local Color = getgenv().TracerColor or Color3.new(1, 1, 1)
        local Lifetime = getgenv().BulletTracersLifetime or 0.3
        local TravelTime = getgenv().BulletTracersTravelTime or 0.05
        local TInfo = TweenInfo.new(Lifetime, Enum.EasingStyle.Linear)
        local TS = game:GetService("TweenService")
        local Debris = game:GetService("Debris")

        -- Laser Core (White Inner)
        local Core = Instance.new("Part", workspace)
        Core.Name = "InariTracerCore"
        Core.Anchored, Core.CanCollide, Core.CanQuery, Core.CastShadow = true, false, false, false
        Core.Material = Enum.Material.Neon
        Core.Color = Color3.new(2, 2, 2)
        Core.Size = Vector3.new(0.04, 0.04, 0)
        Core.CFrame = CFrame.new(Origin, EndPos)

        -- External Glow (Colored)
        local Glow = Core:Clone()
        Glow.Name = "InariTracerGlow"; Glow.Parent = workspace
        Glow.Color = Color
        Glow.Size = Vector3.new(0.15, 0.15, 0)
        Glow.Transparency = 0.5

        -- Impact Flash

        local Impact = Instance.new("Part", workspace)
        Impact.Shape, Impact.Anchored, Impact.CanCollide = Enum.PartType.Ball, true, false
        Impact.Size, Impact.Position = Vector3.new(0.1, 0.1, 0.1), EndPos
        Impact.Material, Impact.Color = Enum.Material.Neon, Color

        local TargetSize = (Origin - EndPos).Magnitude
        TS:Create(Core, TweenInfo.new(TravelTime), {Size = Vector3.new(0.04, 0.04, TargetSize), CFrame = CFrame.new(Origin:Lerp(EndPos, 0.5), EndPos)}):Play()
        TS:Create(Glow, TweenInfo.new(TravelTime), {Size = Vector3.new(0.15, 0.15, TargetSize), CFrame = CFrame.new(Origin:Lerp(EndPos, 0.5), EndPos)}):Play()

        task.delay(TravelTime, function()
            TS:Create(Core, TInfo, {Transparency = 1}):Play()
            TS:Create(Glow, TInfo, {Transparency = 1}):Play()
            TS:Create(Impact, TInfo, {Transparency = 1, Size = Vector3.new(1.5, 1.5, 1.5)}):Play()
        end)

        Debris:AddItem(Core, Lifetime + TravelTime); Debris:AddItem(Glow, Lifetime + TravelTime); Debris:AddItem(Impact, Lifetime + TravelTime)
    end;
end;

-- Anti-Cheat Bypass
local function BypassAC(Char)
    if not Char then return end
    for i, v in getconnections(Char.ChildRemoved) do
        if v.Function then
            local src = debug.info(v.Function, "s")
            if src:find("CharacterController") and #getupvalues(v.Function) >= 2 then
                local anticheatFunction = getupvalue(v.Function, 2)
                local old; old = hookfunction(anticheatFunction, newcclosure(function(...)
                    --print("Ban Attempt, Go Fuck")
                    return coroutine.yield()
                end))
            end
        end
    end
    --Char.Humanoid.WalkSpeed = 23
end

task.spawn(function()
    BypassAC(LocalPlayer.Character)
    LocalPlayer.CharacterAdded:Connect(BypassAC)
end)

-- Silent Aim Hook 
local Old; Old = hookfunction(Bullet, newcclosure(function(...)
    local Args          = {...};
    local Target        = Functions:GetClosestToMouse();
    
    if not checkcaller() and Args[5] and typeof(Args[5]) == "Instance" then
        local Target = Functions:GetClosestToMouse();
        
        -- Captura segura de CFrame para evitar race conditions
        local Success, ShotCFrame = pcall(function() return Args[5].CFrame end)
        if not Success then return Old(table.unpack(Args)) end

        if Target and getgenv().SilentAImNigger then 
            ShotCFrame = CFrame.new(ShotCFrame.Position, Target.Position)
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

-- Dropped Item ESP Initialization
task.spawn(function()
    local DroppedItemsFolder = workspace:WaitForChild("DroppedItems", 10)
    if DroppedItemsFolder then
        for _, v in pairs(DroppedItemsFolder:GetChildren()) do
            if v:IsA("Model") and v.PrimaryPart then
                Functions:DrawDroppedItem(v)
            end
        end
        DroppedItemsFolder.ChildAdded:Connect(function(v) if v:IsA("Model") and v.PrimaryPart then Functions:DrawDroppedItem(v) end end)
    end
end)
-- Inventory Viewer Logic
local lastInvContent = ""
local lastTarget = nil
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().InventoryViewerEnabled then
            local target = Functions:GetClosestToMouse()
            local char = target and target:FindFirstAncestorOfClass("Model")
            local plr = char and game.Players:GetPlayerFromCharacter(char)
            
            if char then
                local items = Functions:ScanInventory(plr or char)
                local currentContent = table.concat(items, ",")
                
                InvViewerGui.Enabled = true
                if currentContent ~= lastInvContent then
                    lastInvContent = currentContent
                    InvTitle.Text = (plr and plr.Name or char.Name):upper()
                    
                    for _, v in pairs(InvScroll:GetChildren()) do
                        if v:IsA("Frame") then v:Destroy() end
                    end
                    
                    for _, itemName in pairs(items) do
                        CreateInvItem(itemName, getgenv().ItemIcons[itemName])
                    end
                    
                    local displayList = {unpack(items)}
                    table.insert(displayList, 1, "[" .. (plr and plr.Name or char.Name):upper() .. "]")
                    InvList:Refresh(displayList)
                end
            else
                if lastInvContent ~= "none" then
                    lastInvContent = "none"
                    InvList:Refresh({"No target found"})
                    InvViewerGui.Enabled = false
                end
            end
        else
            if lastInvContent ~= "" then
                lastInvContent = ""
                InvList:Refresh({})
                InvViewerGui.Enabled = false
            end
        end
    end
end)

-- Unified Target Info Logic
local lastInvContent = ""
task.spawn(function()
    while task.wait(0.1) do
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

Library:Notification("Hello Nigger", 5, Library.Theme.Accent);

getgenv().Library = Library;
return Library;

local Library = {
    Flags = {},
    Theme = {
        Main = Color3.fromRGB(20, 20, 20),
        Accent = Color3.fromRGB(0, 120, 255),
        Outline = Color3.fromRGB(35, 35, 35),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(160, 160, 160)
    }
}

local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

function Library:Notify(title, desc)
    local Notif = Instance.new("Frame")
    -- (Notification logic for clean popups)
    print("[" .. title .. "]: " .. desc)
end

function Library:CreateWindow(cfg)
    local Name = cfg.Name or "AquaLib"
    local ScreenGui = Instance.new("ScreenGui", (game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui")) or game.CoreGui)
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 550, 0, 380)
    Main.Position = UDim2.new(0.5, -275, 0.5, -190)
    Main.BackgroundColor3 = self.Theme.Main
    Main.BorderSizePixel = 0
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

    -- Sidebar (Rayfield Style)
    local Side = Instance.new("Frame", Main)
    Side.Size = UDim2.new(0, 150, 1, 0)
    Side.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", Side)

    local TabHolder = Instance.new("ScrollingFrame", Side)
    TabHolder.Size = UDim2.new(1, 0, 1, -50)
    TabHolder.Position = UDim2.new(0, 0, 0, 50)
    TabHolder.BackgroundTransparency = 1
    TabHolder.ScrollBarThickness = 0
    local TabList = Instance.new("UIListLayout", TabHolder)
    TabList.Padding = UDim.new(0, 5)

    -- Menu Toggling
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == (cfg.Keybind or Enum.KeyCode.LeftControl) then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    local Tabs = {}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", TabHolder)
        TabBtn.Size = UDim2.new(1, -20, 0, 30)
        TabBtn.Text = name
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", TabBtn)

        local Page = Instance.new("ScrollingFrame", Main)
        Page.Position = UDim2.new(0, 160, 0, 10)
        Page.Size = UDim2.new(1, -170, 1, -20)
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Main:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            Page.Visible = true
        end)

        local Elements = {}
        
        -- TOGGLE
        function Elements:CreateToggle(name, callback)
            local Tgl = Instance.new("TextButton", Page)
            Tgl.Size = UDim2.new(1, 0, 0, 40)
            Tgl.BackgroundColor3 = Color3.fromRGB(30,30,30)
            Tgl.Text = "  " .. name
            Tgl.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            Tgl.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", Tgl)
            
            local active = false
            Tgl.MouseButton1Click:Connect(function()
                active = not active
                TS:Create(Tgl, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(30,30,30)}):Play()
                callback(active)
            end)
        end

        -- SLIDER
        function Elements:CreateSlider(name, min, max, def, callback)
            local SldBase = Instance.new("Frame", Page)
            SldBase.Size = UDim2.new(1, 0, 0, 50)
            SldBase.BackgroundColor3 = Color3.fromRGB(30,30,30)
            Instance.new("UICorner", SldBase)
            
            local Lab = Instance.new("TextLabel", SldBase)
            Lab.Text = name .. " : " .. def
            Lab.Size = UDim2.new(1, 0, 0, 20)
            Lab.BackgroundTransparency = 1
            Lab.TextColor3 = Color3.new(1,1,1)

            local Bar = Instance.new("Frame", SldBase)
            Bar.Size = UDim2.new(0.8, 0, 0, 4)
            Bar.Position = UDim2.new(0.1, 0, 0.7, 0)
            Bar.BackgroundColor3 = Color3.new(0,0,0)

            local Fill = Instance.new("Frame", Bar)
            Fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)

            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local move = UIS.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            local percent = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                            local val = math.floor(min + (max-min)*percent)
                            Fill.Size = UDim2.new(percent, 0, 1, 0)
                            Lab.Text = name .. " : " .. val
                            callback(val)
                        end
                    end)
                    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then move:Disconnect() end end)
                end
            end)
        end

        return Elements
    end

    function Library:MassiveHello()
        local HG = Instance.new("ScreenGui", ScreenGui.Parent)
        local Lbl = Instance.new("TextLabel", HG)
        Lbl.Size = UDim2.new(1, 0, 1, 0)
        Lbl.Text = "HELLO"
        Lbl.TextColor3 = Color3.new(1,1,1)
        Lbl.TextSize = 150
        Lbl.BackgroundColor3 = Color3.new(0,0,0)
        Lbl.BackgroundTransparency = 0.4
        task.delay(5, function() HG:Destroy() end)
    end

    return Tabs
end

return Library

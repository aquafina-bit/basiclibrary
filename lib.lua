local Library = {}
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AquaLib"
    ScreenGui.Parent = (game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui")) or game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Main

    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Sidebar.Size = UDim2.new(0, 130, 1, 0)
    Sidebar.BorderSizePixel = 0

    local SideCorner = Instance.new("UICorner")
    SideCorner.CornerRadius = UDim.new(0, 10)
    SideCorner.Parent = Sidebar

    local Title = Instance.new("TextLabel")
    Title.Parent = Sidebar
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = title
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.BackgroundTransparency = 1

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar
    TabContainer.Position = UDim2.new(0, 0, 0, 45)
    TabContainer.Size = UDim2.new(1, 0, 1, -50)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)

    local ContentHolder = Instance.new("Frame")
    ContentHolder.Parent = Main
    ContentHolder.Position = UDim2.new(0, 140, 0, 10)
    ContentHolder.Size = UDim2.new(1, -150, 1, -20)
    ContentHolder.BackgroundTransparency = 1

    local Tabs = {}
    local firstTab = true

    function Tabs:CreateTab(tabName)
        local Page = Instance.new("ScrollingFrame")
        Page.Name = tabName.."Page"
        Page.Parent = ContentHolder
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = firstTab
        Page.ScrollBarThickness = 2
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(1, -10, 0, 30)
        TabBtn.BackgroundColor3 = firstTab and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(25, 25, 25)
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 12
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentHolder:GetChildren()) do v.Visible = false end
            for _, v in pairs(TabContainer:GetChildren()) do if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(25, 25, 25) end end
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)

        firstTab = false
        local Elements = {}

        function Elements:CreateSection(name)
            local SecLabel = Instance.new("TextLabel")
            SecLabel.Parent = Page
            SecLabel.Size = UDim2.new(1, 0, 0, 20)
            SecLabel.Text = "— " .. name:upper() .. " —"
            SecLabel.Font = Enum.Font.GothamBold
            SecLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            SecLabel.TextSize = 10
            SecLabel.BackgroundTransparency = 1
        end

        function Elements:CreateToggle(text, callback)
            local Tgl = Instance.new("TextButton")
            Tgl.Parent = Page
            Tgl.Size = UDim2.new(1, 0, 0, 35)
            Tgl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Tgl.Text = "  " .. text
            Tgl.TextColor3 = Color3.fromRGB(200, 200, 200)
            Tgl.Font = Enum.Font.Gotham
            Tgl.TextSize = 13
            Tgl.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", Tgl)

            local Status = Instance.new("Frame")
            Status.Position = UDim2.new(1, -25, 0.5, -7)
            Status.Size = UDim2.new(0, 15, 0, 15)
            Status.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            Status.Parent = Tgl
            Instance.new("UICorner", Status).CornerRadius = UDim.new(1, 0)

            local toggled = false
            Tgl.MouseButton1Click:Connect(function()
                toggled = not toggled
                Status.BackgroundColor3 = toggled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
                callback(toggled)
            end)
        end

        function Elements:CreateSlider(text, min, max, default, callback)
            local Sld = Instance.new("Frame")
            Sld.Parent = Page
            Sld.Size = UDim2.new(1, 0, 0, 45)
            Sld.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Instance.new("UICorner", Sld)

            local Label = Instance.new("TextLabel")
            Label.Parent = Sld
            Label.Size = UDim2.new(1, 0, 0, 25)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Text = text .. ": " .. default
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.BackgroundTransparency = 1
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Bar = Instance.new("Frame")
            Bar.Position = UDim2.new(0, 10, 0, 30)
            Bar.Size = UDim2.new(1, -20, 0, 5)
            Bar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Bar.Parent = Sld

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            Fill.Parent = Bar

            local function update()
                local mousePos = UIS:GetMouseLocation().X
                local barPos = Bar.AbsolutePosition.X
                local barWidth = Bar.AbsoluteSize.X
                local percent = math.clamp((mousePos - barPos) / barWidth, 0, 1)
                local value = math.floor(min + (max - min) * percent)
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                Label.Text = text .. ": " .. value
                callback(value)
            end

            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local move; move = UIS.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then update() end
                    end)
                    UIS.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then move:Disconnect() end
                    end)
                    update()
                end
            end)
        end

        return Elements
    end
    
    function Library:MassiveHello()
        local HG = Instance.new("ScreenGui", ScreenGui.Parent)
        local Lbl = Instance.new("TextLabel", HG)
        Lbl.Size = UDim2.new(1, 0, 1, 0)
        Lbl.BackgroundTransparency = 0.5
        Lbl.BackgroundColor3 = Color3.new(0,0,0)
        Lbl.Text = "HELLO"
        Lbl.TextColor3 = Color3.new(1,1,1)
        Lbl.TextSize = 100
        Lbl.Font = Enum.Font.GothamBold
        task.delay(5, function() HG:Destroy() end)
    end

    return Tabs
end

return Library

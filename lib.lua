-- Save this as lib.lua in your GitHub repo
local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BasicLib"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -150, 0.5, -100)
    Main.Size = UDim2.new(0, 300, 0, 200)
    Main.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -15, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = Main
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 45)
    Container.Size = UDim2.new(1, -20, 1, -55)
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 2

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Container
    UIListLayout.Padding = UDim.new(0, 5)

    -- Draggable functionality
    local dragging, dragInput, dragStart, startPos
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local Elements = {}

    function Elements:CreateButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Name = text
        Button.Parent = Container
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.AutoButtonColor = false
        Button.Font = Enum.Font.Gotham
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        Button.TextSize = 13

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Button

        Button.MouseButton1Click:Connect(function()
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            task.wait(0.1)
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            callback()
        end)
    end

    return Elements
end

return Library

local Library = {}
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BasicLib"
    -- Fallback for Studio testing:
    ScreenGui.Parent = (game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui")) or game.CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.Position = UDim2.new(0.5, -150, 0.5, -100)
    Main.Size = UDim2.new(0, 300, 0, 250) -- Increased height
    Main.BorderSizePixel = 0
    Main.Visible = true
    Main.Active = true
    Main.Draggable = true -- Built-in simple drag for testing
    Main.ZIndex = 10

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
    Title.ZIndex = 11

    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = Main
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 45)
    Container.Size = UDim2.new(1, -20, 1, -55)
    Container.ScrollBarThickness = 2
    Container.CanvasSize = UDim2.new(0, 0, 0, 500)
    Container.ZIndex = 11

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Container
    UIListLayout.Padding = UDim.new(0, 5)

    local Elements = {}

    function Elements:CreateButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Name = text
        Button.Parent = Container
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.Font = Enum.Font.Gotham
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        Button.TextSize = 13
        Button.ZIndex = 12

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Button

        Button.MouseButton1Click:Connect(callback)
    end

    return Elements
end

return Library

-- MyUILibrary.lua
local Library = {}

function Library:CreateWindow(name)
    print("Creating window: " .. name)
    
    -- Insert your ScreenGui and Frame creation code here
    local MainFrame = Instance.new("ScreenGui")
    MainFrame.Name = name
    MainFrame.Parent = game.CoreGui -- Use CoreGui for exploit-style UIs
    
    local Window = {}
    function Window:CreateButton(btnName, callback)
        print("Button created: " .. btnName)
        -- Button creation logic...
    end
    
    return Window
end

return Library -- This is CRITICAL for loadstring to work

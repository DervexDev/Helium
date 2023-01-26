local Gui = require(script.Gui)
local Keybinds = require(script.Keybinds)
local Config = require(script.Config)
local Toolbar = require(script.Toolbar)

local widgetInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 300, 250, 300, 130)
local widget = plugin:CreateDockWidgetPluginGui('Helium', widgetInfo)
local connection = nil

button = Toolbar(plugin, 'Helium', 'rbxassetid://12243614008', function(newButton)
    button = newButton

    if Config.isOpen then
        button:SetActive(true)
    end

    if connection then
        connection:Disconnect()
        connection = nil
    end

    connection = button.Click:Connect(openClose)
end)

widget.Name = 'Helium'
widget.Title = 'Helium'
widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
script.Parent.HeliumGui.Root.Background.Parent = widget

Config.init(plugin)

local function open()
    if not Config.isOpen then
        Config.isOpen = true
        button:SetActive(true)
        Gui.open()
        widget.Enabled = true
    end
end

local function close()
    if Config.isOpen then
        Config.isOpen = false
        button:SetActive(false)
        Gui.close()
        widget.Enabled = false
    end
end

function openClose()
    if Config.isOpen then
        close()
    else
        open()
    end
end

connection = button.Click:Connect(openClose)
widget.WindowFocused:Connect(open)
widget:BindToClose(close)

if widget.Enabled then
    open()
end

if Config.keybindsEnabled then
    Keybinds.bind()
end
local TweenService = game:GetService('TweenService')

local Theme = require(script.Parent.Theme)
local Config = require(script.Parent.Config)
local Camera = require(script.Parent.Camera)
local Keybinds = require(script.Parent.Keybinds)

local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local background = script.Parent.Parent.HeliumGui.Root.Background
local keybindsButton = background.KeybindsEnabled.Button

local connections = {}

local Gui = {}

Keybinds.callback = function(slot)
    background[slot].Buttons.Load.Visible = true
    background[slot].Buttons.Delete.Visible = true
end

function Gui.open()
    Theme.update(true)

    if Config.keybindsEnabled then
        keybindsButton.OnIcon.ImageTransparency = 0
    else
        keybindsButton.OnIcon.ImageTransparency = 1
    end

    for i, _ in pairs(Config.cameras) do
        background[i].Buttons.Load.Visible = true
        background[i].Buttons.Delete.Visible = true
    end

    for _, v in ipairs(background:GetDescendants()) do
        if v:IsA('GuiButton') then
            table.insert(connections, v.MouseButton1Click:Connect(function()
                if v.Name == 'Save' then
                    Config.save(v.Parent.Parent.Name, workspace.CurrentCamera.CFrame)

                    v.Parent.Load.Visible = true
                    v.Parent.Delete.Visible = true

                elseif v.Name == 'Load' then
                    Camera.teleport(Config.load(v.Parent.Parent.Name))
                elseif v.Name == 'Delete' then
                    Config.save(v.Parent.Parent.Name, nil)

                    v.Parent.Load.Visible = false
                    v.Visible = false

                elseif v == keybindsButton then
                    Config.keybindsEnabled = not Config.keybindsEnabled

                    if Config.keybindsEnabled then
                        TweenService:Create(v.OnIcon, TWEEN_INFO, {ImageTransparency = 0}):Play()
                        Keybinds.bind()
                    else
                        TweenService:Create(v.OnIcon, TWEEN_INFO, {ImageTransparency = 1}):Play()
                        Keybinds.unbind()
                    end
                end
            end))
        end
    end
end

function Gui.close()
    for _, v in ipairs(connections) do
        v:Disconnect()
    end

    for _, v in ipairs(background:GetDescendants()) do
        if v:IsA('GuiButton') and (v.Name == 'Load' or v.Name == 'Delete') then
            v.Visible = false
        end
    end

    Theme.update()
end

return Gui
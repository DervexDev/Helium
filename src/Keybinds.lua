local ContextActionService = game:GetService('ContextActionService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')

local Config = require(script.Parent.Config)
local Camera = require(script.Parent.Camera)

local SAVE_KEY = Enum.KeyCode.LeftAlt
local SLOT_KEYS = {
    Enum.KeyCode.One,
    Enum.KeyCode.Two,
    Enum.KeyCode.Three,
    Enum.KeyCode.Four,
    Enum.KeyCode.Five,
    Enum.KeyCode.Six,
    Enum.KeyCode.Seven,
    Enum.KeyCode.Eight,
    Enum.KeyCode.Nine,
    Enum.KeyCode.Zero
}

local Keybinds = {}

local function handleInput(_, state, input)
    if state == Enum.UserInputState.Begin then
        if UserInputService:IsKeyDown(SAVE_KEY) then
            local slot = Config.save(input.KeyCode, workspace.CurrentCamera.CFrame)
            Keybinds.callback(slot)
        else
            Camera.teleport(Config.load(input.KeyCode))
        end
    end
end

function Keybinds.bind()
    if RunService:IsEdit() then
        ContextActionService:BindAction('Helium', handleInput, false, unpack(SLOT_KEYS))
    end
end

function Keybinds.unbind()
    if RunService:IsEdit() then
        ContextActionService:UnbindAction('Helium')
    end
end

Keybinds.callback = nil

return Keybinds
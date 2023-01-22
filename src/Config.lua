local HttpService = game:GetService('HttpService')

local KEY_MAP = {
    [Enum.KeyCode.One ] = 'Slot1',
    [Enum.KeyCode.Two] = 'Slot2',
    [Enum.KeyCode.Three] = 'Slot3',
    [Enum.KeyCode.Four] = 'Slot4',
    [Enum.KeyCode.Five] = 'Slot5',
    [Enum.KeyCode.Six] = 'Slot6',
    [Enum.KeyCode.Seven] = 'Slot7',
    [Enum.KeyCode.Eight] = 'Slot8',
    [Enum.KeyCode.Nine] = 'Slot9',
    [Enum.KeyCode.Zero] = 'Slot10'
}

local Config = {}

local function saveCameras()
    local cameras = {}

    for i, v in pairs(Config.cameras) do
        if v then
            cameras[i] = tostring(v)
        end
    end

    plugin:SetSetting('Cameras', HttpService:JSONEncode(cameras))
end

function Config.init(newPlugin)
    plugin = newPlugin

    if plugin:GetSetting('Cameras') then
        local cameras = HttpService:JSONDecode(plugin:GetSetting('Cameras'))

        for i, v in pairs(cameras) do
            Config.cameras[i] = CFrame.new(unpack(v:split(',')))
        end
    end

    if plugin:GetSetting('KeybindsEnabled') then
        Config.keybindsEnabled = true
    end
end

function Config.load(key)
    if typeof(key) == 'EnumItem' then
        return Config.cameras[KEY_MAP[key]]
    else
        return Config.cameras[key]
    end
end

function Config.save(key, value)
    if typeof(key) == 'EnumItem' then
        Config.cameras[KEY_MAP[key]] = value
    else
        Config.cameras[key] = value
    end

    saveCameras()

    return KEY_MAP[key]
end

Config.keybindsEnabled = true
Config.isOpen = false
Config.cameras = {}

return Config
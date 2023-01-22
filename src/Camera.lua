local camera = workspace.CurrentCamera
local cameraType = camera.CameraType

local Camera = {}

function Camera.teleport(cframe)
    if not cframe then
        return
    end

    if camera.CameraType ~= Enum.CameraType.Scriptable then
        cameraType = camera.CameraType
    end

    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = cframe

    task.wait()
    camera.CameraType = cameraType
end

return Camera
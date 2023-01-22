local Studio = settings():GetService('Studio')

local BLACK = Color3.fromRGB(46, 46, 46)
local WHITE = Color3.fromRGB(255, 255, 255)

local background = script.Parent.Parent.HeliumGui.Root.Background
local lastTheme = 'Dark'
local connection = nil

local Theme = {}

local function updateTheme()
    local theme = Studio.Theme.Name

    if theme == lastTheme then
        return
    end

    lastTheme = theme

    if theme == 'Dark' then
        background.BackgroundColor3 = BLACK

        for _, v in ipairs(background:GetDescendants()) do
            if v:IsA('Frame') or v:IsA('TextButton') then
                v.BackgroundColor3 = WHITE
            elseif v:IsA('ImageLabel') then
                v.ImageColor3 = WHITE
            elseif v:IsA('TextLabel') then
                v.TextColor3 = WHITE
            end
        end
    else
        background.BackgroundColor3 = WHITE

        for _, v in ipairs(background:GetDescendants()) do
            if v:IsA('Frame') or v:IsA('TextButton') then
                v.BackgroundColor3 = BLACK
            elseif v:IsA('ImageLabel') then
                v.ImageColor3 = BLACK
            elseif v:IsA('TextLabel') then
                v.TextColor3 = BLACK
            end
        end
    end
end

function Theme.update(isOpen)
    if isOpen then
        updateTheme()
        connection = Studio.ThemeChanged:Connect(updateTheme)
    else
        connection:Disconnect()
    end
end

return Theme
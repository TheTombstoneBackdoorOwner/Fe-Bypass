local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "FeBypassGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Position = UDim2.new(0.5, -250, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.BorderSizePixel = 0

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Fe Bypass (Private Gui)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local editor = Instance.new("TextBox", frame)
editor.Size = UDim2.new(1, -20, 1, -120)
editor.Position = UDim2.new(0, 10, 0, 50)
editor.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
editor.TextColor3 = Color3.fromRGB(255, 255, 255)
editor.ClearTextOnFocus = false
editor.MultiLine = true
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.Font = Enum.Font.Code
editor.TextSize = 16
editor.Text = ""

local executeBtn = Instance.new("TextButton", frame)
executeBtn.Size = UDim2.new(0, 100, 0, 40)
executeBtn.Position = UDim2.new(0, 10, 1, -50)
executeBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
executeBtn.Text = "Execute"
executeBtn.Font = Enum.Font.GothamBold
executeBtn.TextSize = 16
executeBtn.BorderSizePixel = 0

local clearBtn = Instance.new("TextButton", frame)
clearBtn.Size = UDim2.new(0, 100, 0, 40)
clearBtn.Position = UDim2.new(0, 120, 1, -50)
clearBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.Text = "Clear"
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextSize = 16
clearBtn.BorderSizePixel = 0

local currentRemoteEvent = nil
local currentRemoteFunction = nil

local function scanForRemotes()
    for _, obj in ipairs(ReplicatedStorage:GetChildren()) do
        if obj:IsA("RemoteEvent") and obj.Name == "RemoteEvent" then
            currentRemoteEvent = obj
        elseif obj:IsA("RemoteFunction") and obj.Name == "RemoteExecutor" then
            currentRemoteFunction = obj
        end
    end
end

scanForRemotes()

ReplicatedStorage.ChildAdded:Connect(function(child)
    if child:IsA("RemoteEvent") and child.Name == "RemoteEvent" then
        currentRemoteEvent = child
    elseif child:IsA("RemoteFunction") and child.Name == "RemoteExecutor" then
        currentRemoteFunction = child
    end
end)

ReplicatedStorage.ChildRemoved:Connect(function(child)
    if child == currentRemoteEvent then
        currentRemoteEvent = nil
    elseif child == currentRemoteFunction then
        currentRemoteFunction = nil
    end
end)

executeBtn.MouseButton1Click:Connect(function()
    local status = Instance.new("TextLabel", frame)
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 1, -90)
    status.BackgroundTransparency = 0.5
    status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.Font = Enum.Font.Gotham
    status.TextSize = 14
    status.Text = "Executing..."

    local SS = editor.Text
    local success = false

    if currentRemoteEvent then
        local ok, err = pcall(function()
            currentRemoteEvent:FireServer(SS)
        end)
        if ok then
            status.Text = "Fe Bypass Ran"
            success = true
        else
            status.Text = "Fe Bypass error: " .. tostring(err)
        end
    end

    if currentRemoteFunction then
        local ok, result = pcall(function()
            return currentRemoteFunction:InvokeServer(SS)
        end)
        if ok then
            status.Text = tostring(result or "Fe Bypass Executed")
            success = true
        else
            status.Text = "Fe Bypass error: " .. tostring(result)
        end
    end

    if not success then
        status.Text = "Fe Bypass Not Injected"
    end

    task.wait(2)
    status:Destroy()
end)

clearBtn.MouseButton1Click:Connect(function()
    editor.Text = ""
end)

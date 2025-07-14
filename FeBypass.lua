local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CustomGui"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Position = UDim2.new(0.5, -250, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Editor TextBox
local editor = Instance.new("TextBox")
editor.Size = UDim2.new(1, -20, 1, -80)
editor.Position = UDim2.new(0, 10, 0, 10)
editor.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
editor.TextColor3 = Color3.fromRGB(255, 255, 255)
editor.ClearTextOnFocus = false
editor.MultiLine = true
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.Font = Enum.Font.Code
editor.TextSize = 16
editor.Text = ""
editor.Parent = frame

-- Execute Button
local executeBtn = Instance.new("TextButton")
executeBtn.Size = UDim2.new(0, 100, 0, 40)
executeBtn.Position = UDim2.new(0, 10, 1, -50)
executeBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
executeBtn.Text = "Execute"
executeBtn.Font = Enum.Font.GothamBold
executeBtn.TextSize = 16
executeBtn.BorderSizePixel = 0
executeBtn.Parent = frame

-- Clear Button
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 100, 0, 40)
clearBtn.Position = UDim2.new(0, 120, 1, -50)
clearBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.Text = "Clear"
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextSize = 16
clearBtn.BorderSizePixel = 0
clearBtn.Parent = frame

-- Execute Button Logic (Placeholder for future code execution logic)
executeBtn.MouseButton1Click:Connect(function()
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 1, -90)
    status.BackgroundTransparency = 0.5
    status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.Font = Enum.Font.Gotham
    status.TextSize = 14
    status.Text = "Running..."

    status.Parent = frame

    -- 🔻🔻🔻 PLACEHOLDER FOR EXECUTION LOGIC 🔻🔻🔻
    local code = editor.Text

    -- Insert safe RemoteEvent or feature triggering logic here, e.g.:
    -- remote:FireServer(code)

    -- (Currently does nothing)
    print("Execution placeholder: " .. code)
    -- 🔺🔺🔺 END PLACEHOLDER 🔺🔺🔺

    task.wait(2)
    status:Destroy()
end)

-- Clear Button Logic
clearBtn.MouseButton1Click:Connect(function()
    editor.Text = ""
end)

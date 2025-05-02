local lp = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Giao diện menu
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "AoyamaMenu"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 440)
frame.Position = UDim2.new(0, 30, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local UIListLayout = Instance.new("UIListLayout", frame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

-- Label Rainbow tên
local rainbow = Instance.new("TextLabel", gui)
rainbow.Size = UDim2.new(0, 400, 0, 30)
rainbow.Position = UDim2.new(0, 30, 0, 60)
rainbow.BackgroundTransparency = 1
rainbow.Font = Enum.Font.SourceSansBold
rainbow.TextScaled = true
rainbow.TextStrokeTransparency = 0.4
rainbow.Text = "Aoyama Nanami - Chúa Tể Tối Ưu"
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.003) % 1
    rainbow.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)

-- Lưu ý
local note = Instance.new("TextLabel", frame)
note.Size = UDim2.new(1, 0, 0, 40)
note.Text = "Hãy bật 'Đóng Băng Cơ Thể' trước\nrồi mới bật 'Xóa Mô Hình' để tránh rớt xuống!"
note.TextColor3 = Color3.fromRGB(255, 120, 120)
note.BackgroundTransparency = 1
note.Font = Enum.Font.SourceSans
note.TextSize = 16
note.TextWrapped = true

-- Hàm thêm nút
local function createButton(text, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
end

-- CHỨC NĂNG
createButton("Đóng Băng Cơ Thể", function()
    local char = lp.Character or lp.CharacterAdded:Wait()
    if char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Anchored = true
    end
end)

createButton("Giảm FPS (15)", function()
    if setfpscap then setfpscap(15) end
end)

createButton("Đo FPS", function()
    local fps = 0
    local last = tick()
    RunService.RenderStepped:Connect(function()
        local now = tick()
        fps = math.floor(1 / (now - last))
        rainbow.Text = "FPS: " .. fps .. " | Aoyama Nanami"
        last = now
    end)
end)

createButton("Anti AFK", function()
    local vu = game:service'VirtualUser'
    lp.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

createButton("Xóa Hiệu Ứng", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or v:IsA("Fire") then
            v:Destroy()
        end
    end
end)

createButton("Xóa Màu Toàn Diện", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(100,100,100)
            v.Material = Enum.Material.SmoothPlastic
        end
        if v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end)

createButton("Xóa Ánh Sáng Toàn Bộ", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") or v:IsA("Light") then
            v:Destroy()
        end
    end
end)

createButton("Xóa Mô Hình (80%)", function()
    local count = 0
    for _,v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v ~= lp.Character and math.random() <= 0.8 then
            v:Destroy()
            count += 1
        end
    end
    print("Đã xóa " .. count .. " mô hình.")
end)

createButton("Xóa Mô Hình (100%)", function()
    local count = 0
    for _,v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v ~= lp.Character then
            v:Destroy()
            count += 1
        end
    end
    print("Đã xóa " .. count .. " mô hình.")
end)

createButton("Xóa Người Chơi Gần", function()
    for _,p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character then
            p.Character:Destroy()
        end
    end
end)

createButton("Xóa Mọi Thứ (Trừ Mày)", function()
    for _,v in pairs(workspace:GetChildren()) do
        if v ~= lp.Character then
            v:Destroy()
        end
    end
end)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Tạo GUI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "OptimizeGUI"
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0, 50, 0, 50)
toggle.Position = UDim2.new(0, 10, 0, 100)
toggle.Text = "⚙️"
toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggle.TextColor3 = Color3.new(1,1,1)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 300)
frame.Position = UDim2.new(0, 70, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 4)

toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Hàm tạo nút
local function createButton(text, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(callback)
	local corner = Instance.new("UICorner", btn)
end

-- Chức năng 1: Xóa mô hình 80%
createButton("Xóa 80% Mô Hình", function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if (v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) and math.random() < 0.8 then
			pcall(function() v:Destroy() end)
		end
	end
end)

-- Chức năng 2: Xóa màu
createButton("Xóa Màu", function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Color = Color3.fromRGB(255,255,255)
			v.Material = Enum.Material.SmoothPlastic
		end
	end
end)

-- Chức năng 3: Xóa ánh sáng
createButton("Xóa Ánh Sáng", function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("PointLight") or v:IsA("SurfaceLight") or v:IsA("SpotLight") then
			pcall(function() v:Destroy() end)
		end
	end
end)

-- Chức năng 4: Xóa hiệu ứng
createButton("Xóa Hiệu Ứng", function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Fire") or v:IsA("Smoke") then
			pcall(function() v:Destroy() end)
		end
	end
end)

-- Chức năng 5: Giảm đồ họa
createButton("Giảm Đồ Họa", function()
	Lighting.FogEnd = 100
	Lighting.Brightness = 1
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

-- Chức năng 6: Anti Kick AFK
createButton("Anti Kick AFK", function()
	LocalPlayer.Idled:Connect(function()
		VirtualInputManager:SendKeyEvent(true, "W", false, game)
	end)
end)

-- Chức năng 7: Đóng băng cơ thể
createButton("Đóng Băng Nhân Vật", function()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	for _, v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = true
		end
	end
end)
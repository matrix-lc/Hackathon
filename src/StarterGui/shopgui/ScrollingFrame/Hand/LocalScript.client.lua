local viewportCamera = Instance.new("Camera", script)
viewportCamera.CameraType = Enum.CameraType.Scriptable

local viewportFrame = script.Parent.ViewportFrame
viewportFrame.CurrentCamera = viewportCamera
viewportFrame.Parent = script.Parent

local part = game.ReplicatedStorage.ToolModels.Hand:Clone()

local point = Vector3.new(0,0,0)

part:SetPrimaryPartCFrame(CFrame.new(point))

--part.Position = Vector3.new(0, 0, 0)
part.Parent = viewportFrame

local R = 0

game:GetService("RunService").RenderStepped:Connect(function()
	local cf, size = part:GetBoundingBox()

	local max = math.max(size.X, size.Y, size.Z)

	local distance = (max/math.tan(math.rad(viewportCamera.FieldOfView))) 

	local currentd = (max/2) + distance

	viewportCamera.CFrame = CFrame.Angles(0, math.rad(R), 0) * CFrame.new(point + Vector3.new(0, (currentd / 2 ), currentd), point)

	R += 1
end)




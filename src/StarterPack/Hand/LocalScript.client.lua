--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

--Module

--Remotes
local ToolServer = ReplicatedStorage["ToolServer"]
local GarbageServer = ReplicatedStorage["GarbageServer"]

--Variables
local Tool = script.Parent
local Camera = workspace.CurrentCamera

--Properties
local Equipped = false

function GetTarget()
	local CursorPosition = UserInputService:GetMouseLocation()
	local oray = game.workspace.CurrentCamera:ViewportPointToRay(CursorPosition.X, CursorPosition.Y, 0)
	local ray = Ray.new(game.Workspace.CurrentCamera.CFrame.Position,(oray.Direction * 200))
	local target, mousepos = workspace:FindPartOnRay(ray)
	return target
end

Tool.Equipped:Connect(function()
	Equipped = true
	ToolServer:FireServer(Tool.Name, "Equip")

	UserInputService.InputBegan:Connect(function(Input, isTyping)
		if isTyping then return end

		if Input.UserInputType == Enum.UserInputType.MouseButton1 and Equipped then
			local part = GetTarget()

			if part:IsA("Part") and part.Name == "Garbage" and part.Parent ~= nil  then
				GarbageServer:FireServer(Tool.Name, "PickUp", part)	
			end
		end
	end)
end)

Tool.Unequipped:Connect(function()
	ToolServer:FireServer(Tool.Name, "Unequip")
	Equipped = false
end)
---Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Modules 
local ToolInfo = require(ReplicatedStorage["ToolInfo"])

--Remote 
local ToolServer = ReplicatedStorage["ToolServer"]
local GarbageServer = ReplicatedStorage["GarbageServer"]
local ShopServer = ReplicatedStorage["ShopServer"]

--Variable
local Modules = {}

for _,v in ipairs(script:GetDescendants()) do
	if v:IsA("ModuleScript") then
		Modules[v.Name] = require(v)
	end
end

ToolServer.OnServerEvent:Connect(function(Player, ToolName, FunctionName)
	local Character = Player.Character

	if Character then
		Modules[ToolName][FunctionName](Character, ToolName, FunctionName)
	end
end)

GarbageServer.OnServerEvent:Connect(function(Player, ToolName, FunctionName, Garbage)
	local DEFAULTHEALTH = 100
	local health = Garbage.health
	

	local decrease = 10 * ToolInfo[ToolName]["Multiplier"]

	health.Value -= decrease
	Garbage.BillboardGui.TextLabel.Text = "Health: "..health.Value.."/"..DEFAULTHEALTH
	
	if health.Value<=0 then
		--Garbage:Destroy()
		local backupParent = Garbage.Parent
		Garbage.Parent = nil
		if Garbage.Parent.Name == "Garbages" and Garbage.Name == "Garbage" then
			Player.leaderstats.garbage1.Value += 1
		else
			print("error")
		end

		--[[wait(5)
		Garbage.Parent = backupParent

		Garbage.BillboardGui.TextLabel.Text = "Health: "..DEFAULTHEALTH.."/"..DEFAULTHEALTH
		Garbage.health.Value = DEFAULTHEALTH--]]
	end
end)


ShopServer.OnServerInvoke = function(Player, ToolName, FunctionName)
	local Character = Player.Character
	local PlayerInventory = game.ServerStorage.Inventories[Player.Name]

	if Player.leaderstats.garbage1.Value >= ToolInfo[ToolName]["Price"] then
		Player.leaderstats.garbage1.Value -= ToolInfo[ToolName]["Price"]

		local bru = Player.Backpack:FindFirstChildWhichIsA("Tool") or Character:FindFirstChildWhichIsA("Tool") or nil
		if bru ~= nil then
			bru:Destroy()	
		end
		 
		local Tool = ReplicatedStorage.Tools[ToolName]
		if Player.Backpack:FindFirstChild(Tool) == nil then
			Tool:Clone().Parent = Player.Backpack
		end
		if PlayerInventory:FindFirstChild(Tool) == nil then
			Tool:Clone().Parent = PlayerInventory
		end
		return true
	else
		return false
	end
end


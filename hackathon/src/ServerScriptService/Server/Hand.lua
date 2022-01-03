--idk doing script.Name is so sus but it works
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Hand = {
	["Equip"] = function(Character, ToolName, FunctionName,Data)
		local Tool = ReplicatedStorage["ToolModels"]:FindFirstChild("Hand"):Clone()
		Tool.Name = script.Name
		Tool.Parent = Character

		local Motor6D = Instance.new("Motor6D")
		Motor6D.Part0 = Character:FindFirstChild("RightHand")
		Motor6D.Part1 = Tool:FindFirstChild("MainPrimaryPart")
		Motor6D.Parent = Tool	
	end,

	["Unequip"] = function(Character, ToolName, FunctionName,Data)
		for _,Value in pairs(Character:GetChildren()) do
			if Value.Name == script.Name then
				Value:Destroy()
			end
		end	
	end,
}

return Hand

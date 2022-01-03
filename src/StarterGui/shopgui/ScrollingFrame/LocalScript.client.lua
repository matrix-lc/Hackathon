local replicatedStorage = game:GetService("ReplicatedStorage")

local ToolInfo = require(game.ReplicatedStorage.ToolInfo)

for i, v in pairs(script.Parent:GetChildren()) do 
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function() 
			local value = replicatedStorage:WaitForChild("ShopServer"):InvokeServer(v.Name, "BuyTool")
			
			if value == false then
				local frame = script.Parent.Parent.Decline
				frame.Visible = true
				local price = ToolInfo[v.Name]["Price"]
				frame.NoMoney.Text = "You do not have enough points!"..v.Name.." requires"..price.." points."
				coroutine.wrap(function()
					wait(3)
					frame.Visible = false
				end)()
			end
		end)
	end
end
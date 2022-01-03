
local MarketplaceService = game:GetService("MarketplaceService")
local MainFrame = script.Parent.tenrbxdonation
local tendonation = script.Parent.tenrbxdonation.ImageButton
local onehundreddonation = script.Parent.onehundredrbxdonation.ImageButton
local onethousanddonation = script.Parent.onethousandrbxdonation.ImageButton
player = game.Players.LocalPlayer
local tenid = 26808421
local onehundredid = 26846291
local onethousandid = 26846386
tendonation.MouseButton1Down:Connect(function()
	local success, message = pcall(function()
		haspass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, tenid)
	end)
	if haspass then
		print("player has gamepass")
		
	else
		MarketplaceService:PromptGamePassPurchase(player, tenid)
	end
end)
onehundreddonation.MouseButton1Down:Connect(function()
	local success, message = pcall(function()
		haspass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, onehundredid)
	end)
	if haspass then
		print("player has gamepass")

	else
		MarketplaceService:PromptGamePassPurchase(player, onehundredid)
	end
end)
onethousanddonation.MouseButton1Down:Connect(function()
	local success, message = pcall(function()
		haspass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, onethousandid)
	end)
	if haspass then
		print("player has gamepass")

	else
		MarketplaceService:PromptGamePassPurchase(player, onethousandid)
	end
end)

function onTouch()
	print("touched donations")
	script.Parent.Enabled = true

end
game.Workspace.teamseasdonation.Touched:Connect(onTouch)
function onTouch()
	print("touched shop")
	script.Parent.Enabled = true
	
end
game.Workspace.shopmodel.Shopenable.Touched:Connect(onTouch)
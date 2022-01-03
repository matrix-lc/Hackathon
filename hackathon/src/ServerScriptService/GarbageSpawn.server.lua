while true do
	wait(2)
	
	if #workspace.Garbages:GetChildren() <= 15  then
		local new = game.ReplicatedStorage["Garbage"]:Clone()
		new.Parent = workspace.Garbages
		
		new.Anchored = true
		new.CanCollide = true
		new.CanTouch = true
		new.Position = Vector3.new(math.random(-78.006, 139.833), math.random(20, 20), math.random(67.604, 189.338))
		
		local origin = new.Position
		local ray = Ray.new(origin, new.CFrame.UpVector * -100)
		local hit, pos, norm = game.Workspace:FindPartOnRay(ray)
		new.CFrame = CFrame.new(pos, pos + norm) * CFrame.Angles(math.rad(-90),0,0) * CFrame.new(0, 1, 0)
	end	
end



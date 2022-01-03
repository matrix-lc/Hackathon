local DataStoreService = game:GetService('DataStoreService')
local playerData = DataStoreService:GetDataStore('DataStore2')
--the original data name is playerData, changed it to reset

local Tools = game.ReplicatedStorage.Tools
local Inventories = game.ServerStorage.Inventories

local function onPlayerJoin(player)
	local key = player.UserId.."_Data"
	
	local Inventory = Instance.new("Folder")
	Inventory.Name = player.Name
	Inventory.Parent = Inventories

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local garbage1 = Instance.new("IntValue")
	garbage1.Name = "garbage1"
	garbage1.Parent = leaderstats
	garbage1.Value = 0
	
	local tool = Instance.new("IntValue")
	tool.Name = "tool"
	tool.Parent = player
	tool.Value = 1

	local data
	local success, errormsg = pcall(function()
		data = playerData:GetAsync(key)
	end)
	
	wait(3) -- need this or  poop
	if success then
		print("datasync success")
		for Index, Value in pairs(data or {}) do
			if Index == 1 then
				garbage1.Value = data[1]
			else 
				local Tool = Tools[Value]
				if not player.Backpack:FindFirstChild(Value) then
					Tool:Clone().Parent = player.Backpack
				end
				Tool:Clone().Parent = Inventory 
			end
		end
	else
		print("error when getting data")
		warn(errormsg)
	end
	
	print(garbage1.Value)
	
	print("player loaded in")
end

local function onPlayerExit(player)
	local DataTable = {}
	local PlayerInventory = Inventories[player.Name]
	
	local key = player.UserId.."_Data"
	
	table.insert(DataTable, 1, player.leaderstats.garbage1.Value)-- this is not good but since we only have this value we acan do this
	
	for Index, Value in ipairs(PlayerInventory:GetChildren()) do
		table.insert(DataTable, Index+1, Value.Name)
	end
	
	local success, errormsg = pcall(function()
		playerData:SetAsync(key, DataTable)
	end)
	
	if success then
		print("SAVED PROPERLY")
	else
		print("error in saving")
		warn(errormsg)
	end

	PlayerInventory:Destroy()
	
	--local success, err = pcall(function()
	--	local playerUserId = "Player_"..player.UserId
	--	playerData:SetAsync(playerUserId, player.playerInfo.exp.Value)
	--end)
	--local DataForStore = {}
	--for name, value in pairs(player.questData:GetChildren())do
	--	table.insert(DataForStore, value)
	--	DataForStore[value.Name] = value.Value
	--	print(unpack(DataForStore))
	--end
	--playerData:SetAsync("uid-"..player.UserId, DataForStore)
	--local player_quests = create_table(player)
	--local success, err = pcall(function()
	--	local playerUserId = "Player_"..player.UserId
	--	playerData:SetAsync(playerUserId, player_quests)

	--end)
	--if not success then
	--	warn("could not save data :(")
	--end
	
	
end
game.Players.PlayerAdded:Connect(onPlayerJoin)
game.Players.PlayerRemoving:Connect(onPlayerExit)
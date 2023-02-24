local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
print("Loaded UI Library")
function SetupGUI()
	--vars
	_G.TPForceEnabled = false
	_G.autoRooms = false
	_G.moveToWaypointFinished = true
	_G.DoorESP = true
	_G.RemoveGates = false
	_G.TPForceEnabled = false

	local reachedConnection
	local nextWaypoint
	local currentDoor
	--Services
	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local Character = localPlayer.Character
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local PathfindingService = game:GetService("PathfindingService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Workspace = game:GetService("Workspace")
	local camera = game:GetService("Workspace").Camera

	ScreenGui0 = Instance.new("ScreenGui")
	Frame1 = Instance.new("Frame")
	TextLabel2 = Instance.new("TextLabel")
	UICorner1 = Instance.new("UICorner")
	UICorner2 = Instance.new("UICorner")
	ScreenGui0.Name = "NotifyA60"
	ScreenGui0.Parent = mas
	ScreenGui0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Frame1.Parent = ScreenGui0
	Frame1.Position = UDim2.new(0.684169888, 0, 0.745679021, 0)
	Frame1.Size = UDim2.new(0.295752883, 0, 0.227160498, 0)
	Frame1.BackgroundColor = BrickColor.new("Really red")
	Frame1.BackgroundColor3 = Color3.new(1, 0, 0.0156863)
	TextLabel2.Parent = Frame1
	TextLabel2.Position = UDim2.new(0.0307167768, 0, 0.0582524166, 0)
	TextLabel2.Size = UDim2.new(0.93472594, 0, 0.875, 0)
	TextLabel2.BackgroundColor = BrickColor.new("Black")
	TextLabel2.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
	TextLabel2.Font = Enum.Font.SourceSansBold
	TextLabel2.FontSize = Enum.FontSize.Size14
	TextLabel2.Text = "A-60 has spawned, hide"
	TextLabel2.TextColor = BrickColor.new("Really black")
	TextLabel2.TextColor3 = Color3.new(0, 0, 0)
	TextLabel2.TextScaled = true
	TextLabel2.TextSize = 14
	TextLabel2.TextWrap = true
	TextLabel2.TextWrapped = true
	UICorner1.CornerRadius = UDim.new(0.1, 0)
	UICorner2.CornerRadius = UDim.new(0.1, 0)
	Frame1.Visible = false
	ScreenGui0.Parent = game.CoreGui
	local Players = game:GetService("Players")
	_G.keyESPEnabled = false
	function addESP(inst)
		keyHighlight = Instance.new("Highlight")
		keyHighlight.Parent = game:GetService("CoreGui")
		keyHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		keyHighlight.FillColor = Color3.new(0.2, 1, 0)
		keyHighlight.Adornee = inst
		keyHighlight.Enabled = true
		keyHighlight.OutlineColor = Color3.new(1, 1, 1)
		keyHighlight.FillTransparency = 0.5
		keyHighlight.OutlineTransparency = 0
	end
	function keyESP()
		print("ESP started")
		Workspace.CurrentRooms.DescendantAdded:Connect(function(object)
			if object.Name == "KeyObtain" and _G.keyESPEnabled then
				print("KeyObtain Found!")
				pcall(function()
					if not object:FindFirstChild("Highlight") then
						addESP(object)
					end
				end)
			end
		end)
	end
	_G.bookESPEnabled = false
	function bookESP()
		local Workspace = game:GetService("Workspace")
		print("KeyESP started")
		Workspace.CurrentRooms.ChildAdded:Connect(function(object)
			if object.Name == "50" then
				Workspace.CurrentRooms["50"].DescendantAdded:Connect(function(asset)
					if asset.Name == "LiveHintBook" and _G.bookESPEnabled then
						addESP(asset)
					end
				end)
			end
		end)
	end
	_G.autoRooms = false
	local path = PathfindingService:CreatePath({
		AgentCanJump = false
	})
	
	local player = Players.LocalPlayer
	local character = player.Character
	local humanoid = character:WaitForChild("Humanoid")
	
	
--	local function followPath(waypoint)
--		_G.moveToWaypointFinished = false
--		local waypointsToWalk
--		local success, errorMessage = pcall(function()
--			print("Started Computing")
--			path:ComputeAsync(character.PrimaryPart.Position, waypoint)
--		end)
--	
--		if success and path.Status == Enum.PathStatus.Success then
--			waypointsToWalk = path:GetWaypoints()
--			for index,waypoint in waypointsToWalk do
--				local pathVisibilityPart = Instance.new("Part")
--				pathVisibilityPart.Size = Vector3.new(1, 1, 1)
--				pathVisibilityPart.Position = waypoint.Position
--				pathVisibilityPart.Parent = game.Workspace
--				pathVisibilityPart.CanCollide = false
--				pathVisibilityPart.Anchored = true
--			end
--			if not reachedConnection then
--				reachedConnection = humanoid.MoveToFinished:Connect(function(reached)
--					if reached and nextWaypoint < #waypointsToWalk then
--						nextWaypoint += 1
--						humanoid:MoveTo(waypointsToWalk[nextWaypoint].Position)
--					else
--						reachedConnection:Disconnect()
--						print("Reached waypoint")
--						nextWaypoint = 2
--						_G.moveToWaypointFinished = true
--					end
--				end)
--		end
--			nextWaypoint = 2
--			humanoid:MoveTo(waypointsToWalk[nextWaypoint].Position)
--		else
--			warn("Error:", errorMessage, "At door", currentDoor)
--		end
--	end
	_G.lastComputePathSuccess = true
	function computePath(waypoint)
		pcall(function(success, errormessage)
			path:ComputeAsync(character.PrimaryPart.Position, waypoint)
			waypointsToWalk = path:GetWaypoints()
		end)
		if path.Status == Enum.PathStatus.Success then
			_G.lastComputePathSuccess = true
		else
			warn("Computing got an error:", errormessage)
			warn("nil means no way was found, something blocking the way?")
			_G.lastComputePathSuccess = false
			
		end
		if _G.lastComputePathSuccess then
			for index,waypoint in waypointsToWalk do
				local pathVisibilityPart = Instance.new("Part")
				pathVisibilityPart.Size = Vector3.new(1, 1, 1)
				pathVisibilityPart.Position = waypoint.Position + Vector3.new(0, 1, 0)
				pathVisibilityPart.Parent = game.Workspace
				pathVisibilityPart.CanCollide = false
				pathVisibilityPart.Anchored = true
				pathVisibilityPart.Shape = Enum.PartType.Ball
				pathVisibilityPart.Color = Color3.fromHex("#ff5500")
				pathVisibilityPart.Name = "pathFindingHelpPart"
			end
		end
	end
	
	function walkPath(waypointsToWalk)
		_G.moveToWaypointFinished = false
		if not reachedConnection then
			reachedConnection = humanoid.MoveToFinished:Connect(function(reached)
				if reached and nextWaypoint < #waypointsToWalk then
					nextWaypoint += 1
					humanoid:MoveTo(waypointsToWalk[nextWaypoint].Position)
					if game.Players.LocalPlayer.PlayerGui.MainUI.Initiator["Main_Game"].RemoteListener.Modules[_G.A90.Name].Spawn.IsPlaying then
						repeat wait() until not game.Players.LocalPlayer.PlayerGui.MainUI.Initiator["Main_Game"].RemoteListener.Modules[_G.A90.Name].Spawn.IsPlaying
					end
				else
					reachedConnection:Disconnect()
					reachedConnection = false
					print("Reached waypoint")
					_G.moveToWaypointFinished = true
					nextWaypoint = 2
				end
			end)
		end
		nextWaypoint = 2
		humanoid:MoveTo(waypointsToWalk[nextWaypoint].Position)
	end
	function doAutoRooms()
		for i, inst in pairs(game.Workspace:GetChildren()) do
			if inst.Name == "pathFindingHelpPart" then
				inst:Destroy()
			end
		end
		

		local currentDoor = game.ReplicatedStorage.GameData.LatestRoom.Value + 1
		while _G.autoRooms do
			_G.currentDoor = game.ReplicatedStorage.GameData.LatestRoom
			local currentRoom = game.Workspace.CurrentRooms[currentDoor]
			local currentPathfindingDoorModel = currentRoom:WaitForChild("Door", 5)
			local currentPathfindingDoor = currentPathfindingDoorModel:WaitForChild("Door", 5)
			computePath(currentPathfindingDoor.Position)
			currentDoor = game.ReplicatedStorage.GameData.LatestRoom.Value + 1
			print("Computed path for Door", currentDoor)
			if _G.lastComputePathSuccess then
				walkPath(waypointsToWalk)
				repeat wait() until _G.moveToWaypointFinished
			else
				error("Failed: retrying in 3 seconds")
				wait(3)
			end
		end
	end

	--functions
	function setForceLocation()
		_G.TPLocation = HumanoidRootPart.Position
	end
	
	function tpToForceLocation()
		RunService.Stepped:Connect(function()
			if _G.TPForceEnabled then
				Character:PivotTo(CFrame.new(_G.TPLocation.X, _G.TPLocation.Y, _G.TPLocation.Z))
			end
		end)
	
	end
	function doTPForce()
		UserInputService.InputBegan:Connect(function(input)
			if UserInputService:GetFocusedTextBox() then
				return
			end
			if input.KeyCode == Enum.KeyCode.X then
				if _G.TPForceEnabled == false then
					setForceLocation()
					_G.TPForceEnabled = true
				else
					_G.TPForceEnabled = false
				end
			end
		end)
	end


	function DoorESP()
		game.Workspace.CurrentRooms.ChildAdded:Connect(function(inst)
			pcall(function()
				local Door = inst:WaitForChild("Door")
				if _G.DoorESP then
					addESP(Door)
				end
			end)
		end)
	end


	_G.NotifyRushAmbush = false
	function NotifyRushAmbush()
        print("NotifyRushAmbush Started")
		local Workspace = game:GetService("Workspace")
		local entity
		Workspace.ChildAdded:Connect(function(inst)
			if inst.Name == "RushMoving" or inst.Name == "AmbushMoving" then
				print("Fake Rush/Ambush spawned?")
				if _G.NotifyRushAmbush then
					if inst.Name == "RushMoving" then
						entity = "Rush"
						entityInst = Workspace:FindFirstChild("RushMoving.RushNew")
				elseif inst.Name == "AmbushMoving" then
						entity = "Ambush"
						entityInst = Workspace:FindFirstChild("AmbushMoving.RushNew")
					end
					if entityInst.Position.X < 50000 and entityInst.Position.X > -50000 and entityInst.Position.Z < 50000 and entityInst.Position.Z > -50000 then
						TextLabel2.Text = entity + " has spawned"
						Frame1.Visible = true
						wait(2)
						Frame1.Visible = false
					end
				end
			end
		end)
	end


	_G.A90Cancel = false
	function NoA90()
		local Players = game:GetService("Players")
		pcall(function()
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator["Main_Game"].RemoteListener.Modules.A90.Name = "DisabledA90LOL" --disables A-90
			print("Disabled A90")
		end)
		_G.A90 = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator["Main_Game"].RemoteListener.Modules.DisabledA90LOL
		--local moveControls = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
--		game.Players.LocalPlayer.PlayerGui.MainUI.Initiator["Main_Game"].RemoteListener.Modules.A90.Spawn.Played:Connect(function()
--			if _G.NoA90Enabled then
--				wait(0.4)
--				_G.A90Cancel = true
--				while A90.Spawn.IsPlaying do
--					moveControls:Disable()
--					Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
--					wait()
--				end
--				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.SliderWalkSpeed
--				_G.A90Cancel = false
--				moveControls:Enable()
--			end
--		end)
	end
	_G.SetPlayerSpeed = false
	_G.NoA90Enabled = false
	function SetPlayerSpeedFunc()
		print("SetPlayerSpeedFunc Started")
		while true do
			if _G.A90Cancel == false then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.SliderWalkSpeed
			else
				repeat wait(0.5) until _G.A90Cancel == false
			end
			wait(0.1)
		end
	end


	function NotifyA60()
		print("NotifyA60 Started")
		local Workspace = game:GetService("Workspace")
		Workspace.ChildAdded:Connect(function(inst)
			if inst.Name == "A60" or inst.Name == "A120" then
				print(inst.Name,  "has spawned!")
				if _G.NotifyA60Enabled then
					TextLabel2.Text = inst.Name, "has spawned"
					Frame1.Visible = true
					wait(5)
					Frame1.Visible = false
				end
			end
		end)
	end


	_G.NotifyA60Enabled = false
    function RemoveGates()
        print("RemoveGates Started")
		while true do
			if _G.RemoveGates then
				if Workspace.CurrentRooms.DescendantAdded then
					for _,childs in ipairs(Workspace.CurrentRooms:GetChildren()) do
						pcall(function()
							childs.Gate.ThingToOpen:Destroy()
						end)
					end
				end
            end
        wait(0.5)
        end
    end


	_G.FOV = 70
	function changeFOV()
		RunService.RenderStepped:Connect(function()
			camera.FieldOfView = _G.FOV
		end)
	end


	local Window = Library.CreateLib("Sussy Rooms", "Synapse")

	local DoorsTab = Window:NewTab("Doors")
	local RoomsTab = Window:NewTab("Rooms")
	local LocalPlayerTab = Window:NewTab("LocalPlayer")
	local LocalPlayerSection = LocalPlayerTab:NewSection("Main")
	local DoorsSection = DoorsTab:NewSection("Main")
	local RoomsSection = RoomsTab:NewSection("Main")


	_G.SliderWalkSpeed = 16
	LocalPlayerSection:NewSlider("Speed 20+ laggy", "Changes the localplayers speed, use 20+ for Seek", 80, 15, function(SliderWalkSpeed)
		_G.SliderWalkSpeed = SliderWalkSpeed
	end)

	LocalPlayerSection:NewSlider("FOV", "Changes the FOV", 120, 70, function(FOV)
		_G.FOV = FOV
	end)

	LocalPlayerSection:NewLabel("Press X to set and toggle TPForce")


	DoorsSection:NewToggle("Notify Spawn Events", "Notifies you when Rush/Ambush spawns", function(RushAmbushEnabled)
		if RushAmbushEnabled then
			_G.NotifyRushAmbush = true
		else
			_G.NotifyRushAmbush = false
		end
	end)

	DoorsSection:NewToggle("Door ESP", "Highlights doors", function(DoorESP)
		if DoorESP then
			_G.DoorESP = true
		else
			_G.DoorESP = true
		end
	end)

	DoorsSection:NewToggle("Key ESP", "Highlights keys", function(keyESPToggle)
		if keyESPToggle then
			_G.keyESPEnabled = true
		else
			_G.keyESPEnabled = false
		end
	end)

	DoorsSection:NewToggle("Book ESP", "Highlights books in door 50", function(keyESPToggle)
		if keyESPToggle then
			_G.bookESPEnabled = true
		else
			_G.bookESPEnabled = false
		end
	end)

    DoorsSection:NewToggle("Open Gates", "Automaticly removes the gates in gate rooms", function(OpenGateToggle)
        if OpenGateToggle then
            _G.RemoveGates = true
        else
            _G.RemoveGates = false
        end
    end)


	RoomsSection:NewButton("Disable A-90", "Disables A-90 ", function(NoA90Toggle)
		spawn(NoA90)
	end)

	RoomsSection:NewToggle("Notify A-60", "Notifies you when A-60 spawns", function(NotifyA60Toggle)
		if NotifyA60Toggle then
			_G.NotifyA60Enabled = true
		else
			_G.NotifyA60Enabled = false
		end
	end)

	RoomsSection:NewToggle("Enable Autocomplete Rooms ", "Autocompletes rooms, Warning: Does not hide for you. ", function(autoRoomsToggle)
		if autoRoomsToggle then
			_G.autoRooms = true
		else
			_G.autoRooms = false
		end
	end)

	RoomsSection:NewButton("Start Autocomplete Rooms ", "Autocompletes rooms, Warning: Does not hide for you. ", function(autoRoomsButton)
		spawn(doAutoRooms)
	end)
	
	local CreditsTab = Window:NewTab("Credits")
	local CreditsSection = CreditsTab:NewSection("Credits")

	CreditsSection:NewLabel("Created and scripted by NotTheHeroHere#2348")
	CreditsSection:NewLabel("Created a GUI with KAVO UI")

	--Spawn Functions
	spawn(SetPlayerSpeedFunc)
	spawn(NotifyA60)
	spawn(NotifyRushAmbush)
    spawn(RemoveGates)
	spawn(keyESP)
	spawn(bookESP)
	spawn(changeFOV)
	spawn(tpToForceLocation)
	spawn(doTPForce)
end

SetupGUI()

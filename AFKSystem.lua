--- Credits
-- Youtube: @WhiteRabbitStudioRoblox


-- Put the script in StarterPlayerScripts
local IdleAnimID = "rbxassetid://17654282590" --- Your Animation ID

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local Humanoid = char:WaitForChild("Humanoid")

local IdleAnim = Instance.new("Animation")
IdleAnim.AnimationId = IdleAnimID

local IdleCAnim = Humanoid:LoadAnimation(IdleAnim)

local afkThreshold = 10 -- Time in seconds to consider the player as inactive and run the afk animation
local lastMoveTime = tick()

local function startIdleAnimation()  -- Start the animation when the player is afk and pass the time
	IdleCAnim:Play()
end

local function stopIdleAnimation() -- Stop the afk animation when the player move again
	IdleCAnim:Stop()
end

local function checkActivity() -- Check activity (Player AFk or not)
	local now = tick()
	if now - lastMoveTime > afkThreshold then
		startIdleAnimation()
	else
		stopIdleAnimation()
	end
end

Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
	lastMoveTime = tick()
	checkActivity()
end)

game:GetService("RunService").Stepped:Connect(function()
	checkActivity()
end)

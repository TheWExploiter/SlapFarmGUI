local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

function teleportToRandomPlayerWithTool()
    local players = game.Players:GetPlayers()
    local eligiblePlayers = {}

    for _, randomPlayer in pairs(players) do
        if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hasTool = false
            for _, tool in pairs(randomPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    hasTool = true
                    break
                end
            end
            if hasTool then
                table.insert(eligiblePlayers, randomPlayer)
            end
        end
    end

    if #eligiblePlayers > 0 then
        local randomPlayer = eligiblePlayers[math.random(1, #eligiblePlayers)]
        return randomPlayer
    end
    return nil
end

function teleportBehindPlayer(targetPlayer)
    local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
    local direction = (targetPosition - player.Character.HumanoidRootPart.Position).unit
    local teleportBehindPosition = targetPosition - direction * 5
    player.Character:MoveTo(teleportBehindPosition)
    wait(2)
end

function lookAtPlayer(targetPlayer)
    local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
    local humanoidRootPart = player.Character.HumanoidRootPart

    -- Make sure the player always looks at the target
    while targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local targetDirection = (targetPosition - humanoidRootPart.Position).unit
        humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, targetPosition)
        wait(0.1)  -- Update frequently to keep looking at the player
    end
end

function teleportToGuidePlace()
    local guidePlacePosition = Vector3.new(17892, -130, -3539)
    player.Character:MoveTo(guidePlacePosition)
end

function autoSlap()
    local userInputService = game:GetService("UserInputService")

    while true do
        userInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                mouse.Button1Down:Fire()
            end
        end)
        wait(0.1)
    end
end

spawn(autoSlap)

while true do
    local targetPlayer = teleportToRandomPlayerWithTool()

    if targetPlayer then
        teleportBehindPlayer(targetPlayer)
        lookAtPlayer(targetPlayer)
        teleportToGuidePlace()
    end
    wait(5)  -- Time before starting the next teleportation cycle
end

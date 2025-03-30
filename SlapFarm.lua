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
        local targetPosition = randomPlayer.Character.HumanoidRootPart.Position
        local direction = (randomPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).unit
        local teleportBehindPosition = targetPosition - direction * 5
        player.Character:MoveTo(teleportBehindPosition)
        wait(2)  -- Stay behind for 2 seconds
    end
end

function teleportToGuidePlace()
    local guidePlacePosition = Vector3.new(17892, -130, -3539)
    player.Character:MoveTo(guidePlacePosition)
end

function spamTeleport()
    while true do
        teleportToRandomPlayerWithTool()
        wait(2)  -- Teleport every 2 seconds
    end
end

spawn(spamTeleport)

while true do
    teleportToGuidePlace()  -- Stay safe at the Guide Place
    wait(5)
end

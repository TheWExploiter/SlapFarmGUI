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
        return randomPlayer.Character.HumanoidRootPart.Position
    end
    return nil
end

function orbitAroundPlayer(targetPosition)
    local radius = 5
    local angle = 0
    local center = targetPosition
    local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

    while true do
        local x = center.X + radius * math.cos(angle)
        local z = center.Z + radius * math.sin(angle)
        humanoidRootPart.CFrame = CFrame.new(x, center.Y, z)

        angle = angle + math.rad(5)  -- Adjust the speed of orbiting by changing the angle increment
        wait(0.1)
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
    local targetPosition = teleportToRandomPlayerWithTool()

    if targetPosition then
        orbitAroundPlayer(targetPosition)
    end

    teleportToGuidePlace()
    wait(5)
end

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
        player.Character:MoveTo(targetPosition)
    end
end

function teleportToGuidePlace()
    local guidePlacePosition = Vector3.new(17892, -130, -3539)
    player.Character:MoveTo(guidePlacePosition)
end

function autoSlap()
    local userInputService = game:GetService("UserInputService")
    local playerInput = game:GetService("Players").LocalPlayer

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
    teleportToRandomPlayerWithTool()
    wait(2)
    teleportToGuidePlace()
    wait(7)
end

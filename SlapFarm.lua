local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- List of item names to ignore
local ignoredItems = {"Megarock", "Diamond", "OVERKILL", "Error"}

function teleportToRandomPlayerWithTool()
    local players = game.Players:GetPlayers()
    local eligiblePlayers = {}

    for _, randomPlayer in pairs(players) do
        if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hasTool = false
            local hasIgnoredItem = false

            for _, tool in pairs(randomPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    hasTool = true
                    -- Check if the tool is an ignored item (Megarock or Diamond Glove)
                    if table.find(ignoredItems, tool.Name) then
                        hasIgnoredItem = true
                        break
                    end
                end
            end

            -- Only add the player if they have a tool and don't have any ignored items
            if hasTool and not hasIgnoredItem then
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
    local randomOffset = math.random(4, 6)  -- Randomized offset for teleport distance
    local direction = (targetPosition - player.Character.HumanoidRootPart.Position).unit
    local teleportBehindPosition = targetPosition - direction * randomOffset
    player.Character:MoveTo(teleportBehindPosition)
end

function lookAtPlayer(targetPlayer)
    local humanoidRootPart = player.Character.HumanoidRootPart

    -- Make sure the player always looks at the target
    while targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        local targetDirection = (targetPosition - humanoidRootPart.Position).unit
        humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, targetPosition)
        wait(0.1)  -- Update every 0.1 second
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
        -- Keep teleporting behind the player and slap them continuously
        while true do
            teleportBehindPlayer(targetPlayer)  -- Teleport behind the player
            lookAtPlayer(targetPlayer)  -- Start looking at the player (aimbot)
            wait(0.2)  -- Teleport behind the player every 0.2 seconds
        end
    end

    -- After teleporting and slapping for 5 seconds, teleport to safe spot and start over
    wait(5)
    teleportToGuidePlace()  -- Teleport to guide place (safe spot)
end

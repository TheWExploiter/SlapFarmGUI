local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- List of item names to ignore
local ignoredItems = {"Megarock", "Diamond", "OVERKILL", "Error"}

-- Function to teleport the player behind a target
function teleportBehindPlayer(targetPlayer)
    local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
    local randomOffset = math.random(4, 6)  -- Randomized offset for teleport distance
    local direction = (targetPosition - player.Character.HumanoidRootPart.Position).unit
    local teleportBehindPosition = targetPosition - direction * randomOffset

    -- Instant teleport using CFrame
    player.Character:SetPrimaryPartCFrame(CFrame.new(teleportBehindPosition))
end

-- Function to make the player always look at the target
function lookAtPlayer(targetPlayer)
    local humanoidRootPart = player.Character.HumanoidRootPart

    -- Make sure the player always looks at the target
    while targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") do
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        local targetDirection = (targetPosition - humanoidRootPart.Position).unit
        humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, targetPosition)
        wait(0.1)  -- Update every 0.1 second to keep the aimbot active
    end
end

-- Function to teleport to a random player with a tool (ignores specific tools)
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

-- Function to teleport to the guide place (safe spot)
function teleportToGuidePlace()
    local guidePlacePosition = Vector3.new(17892, -130, -3539)
    player.Character:SetPrimaryPartCFrame(CFrame.new(guidePlacePosition))
end

-- Auto slap function (will click automatically)
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

-- Start the auto slap function
spawn(autoSlap)

while true do
    local targetPlayer = teleportToRandomPlayerWithTool()

    if targetPlayer then
        -- Keep teleporting behind the player and slap them continuously
        local teleportStartTime = tick()
        while tick() - teleportStartTime < 5 do  -- Teleport and slap for 5 seconds
            teleportBehindPlayer(targetPlayer)  -- Teleport behind the player
            lookAtPlayer(targetPlayer)  -- Keep looking at the player (aimbot)
            wait(0.2)  -- Teleport behind the player every 0.2 seconds
        end
    end

    -- After teleporting and slapping for 5 seconds, teleport to safe spot and start over
    teleportToGuidePlace()  -- Teleport to guide place (safe spot)
    wait(1)  -- Wait 1 second before starting again
end

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

function teleportToRandomPlayer()
    local players = game.Players:GetPlayers()
    local randomPlayer = players[math.random(1, #players)]
    if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = randomPlayer.Character.HumanoidRootPart.Position
        player.Character:MoveTo(targetPosition)
    end
end

function teleportToGuidePlace()
    local guidePlacePosition = Vector3.new(17892, -130, -3539)
    player.Character:MoveTo(guidePlacePosition)
end

function autoSlap()
    while true do
        mouse.Button1Down:Fire()
        wait(0.1)
    end
end

spawn(autoSlap)

while true do
    teleportToRandomPlayer()
    wait(3)
    teleportToGuidePlace()
    wait(8)
end
-- Made By Cat

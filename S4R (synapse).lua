-- SPOTIFY 4 ROBLOX (S4R) BY KOTSYAJ

-- SORRY THIS CODE IS EXTREMELY SHIT
-- RELEASING IT ANYWAYS SO ENJOY

-- INCASE SCRIPT IS EXECUTED BEFORE GAME IS LOADED
if not game:IsLoaded() then repeat wait() until game:IsLoaded() end
if not game.Players.LocalPlayer.Character then repeat wait() until game.Players.LocalPlayer.Character end
-- INCASE SCRIPT IS EXECUTED BEFORE GAME IS LOADED

-- IF PLAYER IS TELEPORTED RE EXECUTE THE SCRIPT (SYNAPSE ONLY)
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        syn.queue_on_teleport( "_G.S4RToken = " .. tostring(_G.S4RToken) .. " loadstring(game:HttpGet('https://raw.githubusercontent.com/kotsyaj/S4R/main/S4R%20(synapse).lua'))()")
    end
end)
-- IF PLAYER IS TELEPORTED RE EXECUTE THE SCRIPT (SYNAPSE ONLY)

-- NECESSARY SHITS
local http = game:GetService("HttpService")
local cg = game:GetService("CoreGui")
if cg:FindFirstChild("NowPlaying") then cg["NowPlaying"]:Destroy() end
-- NECESSARY SHITS

-- THE GUI
local NowPlaying = Instance.new("ScreenGui", cg)
local Main = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local LeftBorder = Instance.new("Frame")
local TopBorder = Instance.new("Frame")
local UIGradient_2 = Instance.new("UIGradient")
local BottomBorder = Instance.new("Frame")
local UIGradient_3 = Instance.new("UIGradient")
local songLabel = Instance.new("TextLabel")
NowPlaying.Name = "NowPlaying"
NowPlaying.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Main.Name = "Main"
Main.Parent = NowPlaying
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.0629405826, 0, 0.469252616, 0)
Main.Size = UDim2.new(0, 334, 0, 17)
UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.62), NumberSequenceKeypoint.new(0.05, 0.64), NumberSequenceKeypoint.new(0.23, 0.73), NumberSequenceKeypoint.new(0.88, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient.Parent = Main
LeftBorder.Name = "LeftBorder"
LeftBorder.Parent = Main
LeftBorder.BackgroundColor3 = Color3.fromRGB(0, 185, 0)
LeftBorder.BorderColor3 = Color3.fromRGB(27, 42, 25)
LeftBorder.BorderSizePixel = 0
LeftBorder.Size = UDim2.new(0, 2, 1, 0)
LeftBorder.ZIndex = 3
TopBorder.Name = "TopBorder"
TopBorder.Parent = Main
TopBorder.BackgroundColor3 = Color3.fromRGB(0, 185, 0)
TopBorder.BorderColor3 = Color3.fromRGB(27, 42, 25)
TopBorder.BorderSizePixel = 0
TopBorder.Size = UDim2.new(1, 0, 0, 2)
TopBorder.ZIndex = 3
UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient_2.Parent = TopBorder
BottomBorder.Name = "BottomBorder"
BottomBorder.Parent = Main
BottomBorder.BackgroundColor3 = Color3.fromRGB(0, 185, 0)
BottomBorder.BorderColor3 = Color3.fromRGB(27, 42, 25)
BottomBorder.BorderSizePixel = 0
BottomBorder.Position = UDim2.new(0, 0, 1, -2)
BottomBorder.Size = UDim2.new(1, 0, 0, 2)
BottomBorder.ZIndex = 3
UIGradient_3.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient_3.Parent = BottomBorder
songLabel.Name = "songLabel"
songLabel.Parent = Main
songLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
songLabel.BackgroundTransparency = 1.000
songLabel.Position = UDim2.new(0, 4, 0.200000003, 0)
songLabel.Size = UDim2.new(1, -4, 0.800000012, -2)
songLabel.ZIndex = 2
songLabel.Font = Enum.Font.GothamBold
songLabel.Text = "songName by songArtist"
songLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
songLabel.TextScaled = true
songLabel.TextSize = 14.000
songLabel.TextStrokeTransparency = 0.000
songLabel.TextWrapped = true
songLabel.TextXAlignment = Enum.TextXAlignment.Left
-- THE GUI

-- FUNCTIONS 
local function getPlaying()
    local auth = "Bearer " .. _G.S4RToken
    local apiUrl = "https://api.spotify.com/v1/me/player/currently-playing"
    local response = syn.request({
        Url = apiUrl;
        Method = "GET";
        Headers = {
            ["Accept"] = "application/json",
            ["Authorization"] = auth
        };
    })
    if response.StatusCode == 200 then return(response) else warn("API Rejected Request, Status Code: " .. response.StatusCode) return "error" end -- IF ERRORS THEN RETURNS AS ERROR ELSE RETURNS NECESSARY INFORMATION
end

local function updateGUI()
	local decodedbody, songNameStr, artists, artiststr -- VARIABLES ---------------------------------------------------------------------------------------------------------------------------------------------------------- THIS USED TO
	local playing = getPlaying() -- GETS SPOTIFY API TABLE THING ------------------------------------------------------------------------------------------------------------------------------------------------------------- BE IN A
    if playing == "error" then return end -- IF ERROR THEN RETURNS ----------------------------------------------------------------------------------------------------------------------------------------------------------- PCALL
	decodedbody = http:JSONDecode(playing["Body"]) -- DOES EXACTLY WHAT IT LOOKS LIKE ---------------------------------------------------------------------------------------------------------------------------------------- BUT FUCK IT.
	songNameStr = tostring(decodedbody["item"]["name"]) -- GETS SONG NAME ---------------------------------------------------------------------------------------------------------------------------------------------------- WHILST UR
	artists = decodedbody["item"]["artists"] artiststr = "" for i = 1, #artists, 1 do artiststr =  artiststr .. ", " .. artists[i].name end -- IF MULTIPLE ARTISTS IT LISTS THEM, FOR EXAMPLE: HELP ME BY ROSESLEEVES, QUINN - HERE
	songLabel.Text = songNameStr .. " by ".. string.sub(artiststr, 3) -- DISPLAYS SONG NAME AND ARTIST, EXAPLE: BLISSFULL OVERDOSE BY SEWERSLVT ------------------------------------------------------------------------------ GO TO
	TopBorder.Size = UDim2.new(decodedbody["progress_ms"] / decodedbody["item"]["duration_ms"], 0, 0, 2) -- DURATION PLAYED  ------------------------------------------------------------------------------------------------- KOTSYAJ.FUN
	BottomBorder.Size = UDim2.new(decodedbody["progress_ms"] / decodedbody["item"]["duration_ms"], 0, 0, 2) -- DURATION PLAYED ----------------------------------------------------------------------------------------------- :)
end
-- FUNCTIONS

local function ABCNS_fake_script()
	local script = Instance.new('LocalScript', Main)
	local UIS = game:GetService("UserInputService")
	local dragSpeed = -math.huge
	local dragToggle = nil
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil
	function dragify(Frame)
		function updateInput(input)
	        local Delta = input.Position - dragStart
	        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
	        script.Parent.Position = Position
		end
	    Main.InputBegan:Connect(function(input)
	        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
	            dragToggle = true
	            dragStart = input.Position
	            startPos = Frame.Position
	            input.Changed:Connect(function()
	                if input.UserInputState == Enum.UserInputState.End then
	                    dragToggle = false
	                end
	            end)
	        end
		end)
	    Main.InputChanged:Connect(function(input)
	        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	            dragInput = input
	        end
		end)
	    game:GetService("UserInputService").InputChanged:Connect(function(input)
	        if input == dragInput and dragToggle then
	            updateInput(input)
	        end
	    end)
	end
	dragify(script.Parent)
end
coroutine.wrap(ABCNS_fake_script)()

coroutine.wrap(function()
    while task.wait(.75) do 
        updateGUI() -- DO I EVEN HAVE TO EXPLAIN WHAT THIS IS FOR
    end
end)()

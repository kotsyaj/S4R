if not game.Players.LocalPlayer.Character then repeat wait() until game.Players.LocalPlayer.Character end
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        syn.queue_on_teleport("_G.S4RToken = " .. _G.S4RToken .. " _G.S4RRefreshRate = " .. _G.S4RRefreshRate .. " _G.Colour = {['R'] = " .. _G.Colour.R .. ", ['G'] = " .. _G.Colour.G .. ", ['B'] = " .. _G.Colour.B .. "} _G.S4RSettings = " .. _G.S4RSettings .. " = {AnnounceSong = " .. _G.S4RSettings.AnnounceSong .. "} loadstring(game:HttpGet('https://raw.githubusercontent.com/kotsyaj/S4R/main/S4R%20(synapse).lua'))()")
    end
end)

local http = game:GetService("HttpService")
local cg = game:GetService("CoreGui")
if cg:FindFirstChild("NowPlaying") then cg["NowPlaying"]:Destroy() end
local UIGradient
local LeftBorder
local TopBorder
local UIGradient_2
local BottomBorder
local UIGradient_3
local songLabel
local NowPlaying
local Main
NowPlaying = Instance.new("ScreenGui", cg)
Main = Instance.new("Frame")
UIGradient = Instance.new("UIGradient")
LeftBorder = Instance.new("Frame")
TopBorder = Instance.new("Frame")
UIGradient_2 = Instance.new("UIGradient")
BottomBorder = Instance.new("Frame")
UIGradient_3 = Instance.new("UIGradient")
songLabel = Instance.new("TextLabel")
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
LeftBorder.BackgroundColor3 = Color3.fromRGB(_G.Colour.R, _G.Colour.G, _G.Colour.B)
LeftBorder.BorderColor3 = Color3.fromRGB(27, 42, 25)
LeftBorder.BorderSizePixel = 0
LeftBorder.Size = UDim2.new(0, 2, 1, 0)
LeftBorder.ZIndex = 3
TopBorder.Name = "TopBorder"
TopBorder.Parent = Main
TopBorder.BackgroundColor3 = Color3.fromRGB(_G.Colour.R, _G.Colour.G, _G.Colour.B)
TopBorder.BorderColor3 = Color3.fromRGB(27, 42, 25)
TopBorder.BorderSizePixel = 0
TopBorder.Size = UDim2.new(1, 0, 0, 2)
TopBorder.ZIndex = 3
UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient_2.Parent = TopBorder
BottomBorder.Name = "BottomBorder"
BottomBorder.Parent = Main
BottomBorder.BackgroundColor3 = Color3.fromRGB(_G.Colour.R, _G.Colour.G, _G.Colour.B)
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

local function announce(text)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "all")
end

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
    if response.StatusCode == 200 then return(response) else warn("API Rejected Request, Status Code: " .. response.StatusCode) return "error" end
end

local cachedsong
local currentsong

local function updateGUI()
    local suc, err = pcall(function()
		local decodedbody, songNameStr, artists
		cachedsong = currentsong
		local playing = getPlaying()
		if playing ~= "error" then
			decodedbody = http:JSONDecode(playing["Body"])
			songNameStr = tostring(decodedbody["item"]["name"])
			artists = decodedbody["item"]["artists"]
			local artiststr = ""
			local previousSong = ""
			for i = 1, #artists, 1 do artiststr =  artiststr .. ", " .. artists[i].name end
			currentsong = decodedbody["item"]["name"]
			if cachedsong ~= currentsong then 
				if _G.S4RSettings.AnnounceSong == true then 
					announce("SFR: Currently listening to " .. songNameStr .. " by " .. string.sub(artiststr, 3) .. "...") 
				end 
			end
			songLabel.Text = songNameStr .. " by ".. string.sub(artiststr, 3)
			TopBorder.Size = UDim2.new(decodedbody["progress_ms"] / decodedbody["item"]["duration_ms"], 0, 0, 2)
			BottomBorder.Size = UDim2.new(decodedbody["progress_ms"] / decodedbody["item"]["duration_ms"], 0, 0, 2)
		end
	end)
	if err then warn(err) end
end

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
    while wait(_G.S4RRefreshRate) do 
        updateGUI() 
    end
end)()

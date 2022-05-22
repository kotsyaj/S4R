-- it seems i was not the first
-- also see: https://github.com/AtlasC0R3/bloxify/

local rs = game:GetService("ReplicatedStorage")
local http = require(rs["http"])

local S4R = {}

function S4R.getPlaying(token) -- gets current playing song
	local auth = 'Bearer ' .. token
	local url = 'https://api.spotify.com/v1/me/player/currently-playing'
	local header = {Accept = 'application/json', Authorization = auth}
	local r = http.get(url, {headers = header})
	if (r.status_code ~= 200) then warn(r.status_code) return "error" else return r:json() end
end
function S4R.skipSong(token) -- skips to next song
	local auth = 'Bearer ' .. token
	local url = 'https://api.spotify.com/v1/me/player/next'
	local header = {Accept = 'application/json', Authorization = auth}
	http.post(url, {headers = header, data = "z"})
end

function S4R.previousSong(token) -- rewinds to previous song
	local auth = 'Bearer ' .. token
	local url = 'https://api.spotify.com/v1/me/player/previous'
	local header = {Accept = 'application/json', Authorization = auth}
	http.post(url, {headers = header, data = "z"})
end

function S4R.playTracks(token, tracks) -- plays given track example uri: 'spotify:track:7An2lFHnr78J2jOXytvgJZ'
	local auth = 'Bearer ' .. token
	local header = {Authorization = auth}
	local url = 'https://api.spotify.com/v1/me/player/play'
	if type(tracks) == 'table' then http.put(url, {headers = header, data = {uris = tracks}}) else http.put(url, {headers = header, data = {uris = {tracks}}}) end
end

return S4R

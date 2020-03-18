--Loader
warn("Loading Elevate Gate System")
local sT = tick()

local HubID = "676344814748565533"
local Product = "Gate System"
local MainModel = script.Parent
local myPod = require(4460787902)

-- Services

local http = game:GetService("HttpService")
local myPod = require(4460787902)

-- Whitelist Checker
function disableScripts()
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Script") and v ~= script then
			v.Disabled = true
		end
	end
end
function httpe()
    local s = pcall(function()
        game:GetService('HttpService'):GetAsync('http://www.google.com/') 
    end)
    return s
end

if httpe() == false then
    warn("Failed to Load. Error: HTTPS Not Enabled (Elevate Gate System)")
	disableScripts()
    MainModel:Destroy()
end

if game:GetService("RunService"):IsStudio() then
    warn("Failed to Load. Error: This Product does not Run in Studio. (Elevate Gate System)")
	disableScripts()
    MainModel:Destroy()
end
wait(1)
local PlaceId = game.PlaceId
local PlaceInfo = game:GetService("MarketplaceService"):GetProductInfo(PlaceId)
local gameOwner = nil
if game.CreatorType == Enum.CreatorType.Group then
    gameOwner = game:GetService("GroupService"):GetGroupInfoAsync(PlaceInfo.Creator.CreatorTargetId).Owner.Id
else
    gameOwner = game.CreatorId
end

myPod:GetAsync(HubID, Product, gameOwner, function(Success, Value)
    if Success == false then
        warn("Failed to Load. Error: Product is not Owned. (Elevate Gate System)")
		disableScripts()
        MainModel:Destroy()
	else
		wait(1)
		local setupModule = require(script.ModuleScript):Setup(script.parent,script.Parent:WaitForChild("Workspace"):WaitForChild("GateSystem"), Location, Classes, OpenTime, Logo, TransparentLogo, includeWait, GroupID, StaffMinRank, AirlineImageID)
		if setupModule == true then
			warn("Setup of Directories Complete (Elevate Gate System)")
		else
			warn("Error with Directory Setup (Elevate Gate System")
			warn(setupModule)
		end
		local bind = script.Parent:WaitForChild("SetupBind"):Invoke()
		if bind == true then
			warn("Loaded Elevate Gate System. Time to Complete: "..(math.floor((tick()-sT)*1000)/1000).." Seconds")
		else
			warn("Elevate Gate System Failed to Load with the Following Error:")
			warn(bind)
		end
    end
end)

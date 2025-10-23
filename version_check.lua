local RESOURCE_NAME = GetCurrentResourceName()
local CURRENT_VERSION = "1.0.0"

local CONFIG = {
    versionUrl = "https://raw.githubusercontent.com/Nexure-Dev/versions/main/nexure_notify.txt",
    checkOnStartup = true,
    checkInterval = 3600000,
}

local colors = {
    red = "^1",
    green = "^2",
    yellow = "^3",
    cyan = "^5",
    white = "^7"
}

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function checkVersion()
    PerformHttpRequest(CONFIG.versionUrl, function(statusCode, response, headers)
        if statusCode == 200 then
            local latestVersion = trim(response)
            
            print("\n" .. colors.cyan .. "==================================================" .. colors.white)
            print(colors.cyan .. "  " .. RESOURCE_NAME .. " - Version Check" .. colors.white)
            print(colors.cyan .. "==================================================" .. colors.white)
            print("  Current Version: " .. colors.yellow .. CURRENT_VERSION .. colors.white)
            print("  Latest Version:  " .. colors.green .. latestVersion .. colors.white)
            
            if CURRENT_VERSION == latestVersion then
                print(colors.green .. "  ✓ You are using the latest version!" .. colors.white)
            else
                print(colors.red .. "  ⚠ UPDATE AVAILABLE!" .. colors.white)
                print(colors.yellow .. "  Please download the latest version!" .. colors.white)
                print(colors.white .. "  Download: https://github.com/Nexure-Dev/nexure_rpc" .. colors.white)
            end
            
            print(colors.cyan .. "==================================================" .. colors.white .. "\n")
        else
            print(colors.red .. "[" .. RESOURCE_NAME .. "] Version check failed! (Status: " .. statusCode .. ")" .. colors.white)
        end
    end, 'GET')
end

if CONFIG.checkOnStartup then
    Citizen.CreateThread(function()
        Citizen.Wait(5000) 
        checkVersion()
    end)
end

if CONFIG.checkInterval > 0 then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(CONFIG.checkInterval)
            checkVersion()
        end
    end)
end

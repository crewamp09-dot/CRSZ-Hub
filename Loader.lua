-- ===================================================
-- CRSZ HUB | Multi-Game Loader Engine
-- ===================================================

local PlaceId = game.PlaceId
local BaseUrl = "https://raw.githubusercontent.com/crewamp09-dot/CRSZ-Hub/main/Games/"

-- 20+ Oyuna Özel PlaceId Eşleşme Haritası
local GameScripts = {
    [142823291]  = "MM2.lua",              -- Murder Mystery 2
    [2753915549] = "BloxFruits.lua",       -- Blox Fruits
    [4442272183] = "BloxFruits.lua",       -- Blox Fruits (Sea 2)
    [7449423635] = "BloxFruits.lua",       -- Blox Fruits (Sea 3)
    [10449761463] = "TBS.lua",             -- The Strongest Battlegrounds
    [16146832113] = "Jujutsu.lua",         -- Jujutsu Shenanigans
    [16732694052] = "AnimeVanguards.lua",  -- Anime Vanguards
    [17675760885] = "Rivals.lua",          -- RIVALS
    [286090008]  = "Arsenal.lua",          -- Arsenal
    [301549746]  = "CounterBlox.lua",      -- Counter Blox
    [383310974]  = "BedWars.lua",          -- BedWars
    [9872472334] = "Evade.lua",            -- Evade
    [6516141723] = "Doors.lua",            -- DOORS
    [893973440]  = "FleeFacility.lua",     -- Flee the Facility
    [8737899170] = "PetSim99.lua",         -- Pet Simulator 99
    [13772394330] = "SolsRNG.lua",          -- Sol's RNG
    [4924922222] = "Brookhaven.lua",       -- Brookhaven RP
    [15185202684] = "DressToImpress.lua",  -- Dress To Impress
    [920587237]  = "AdoptMe.lua"           -- Adopt Me!
}

local function LoadScript(fileName)
    local success, err = pcall(function()
        loadstring(game:HttpGet(BaseUrl .. fileName))()
    end)
    if not success then
        warn("⚡ CRSZ Hub: Yükleme hatası -> " .. tostring(err))
    end
end

-- Anti-AFK Motoru
pcall(function()
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0,0))
    end)
end)

if GameScripts[PlaceId] then
    print("⚡ CRSZ Hub: Özel Oyun Tespit Edildi, Yükleniyor...")
    LoadScript(GameScripts[PlaceId])
else
    print("⚡ CRSZ Hub: Universal UI Yükleniyor...")
    LoadScript("Universal.lua")
end

local addonName = "pfUI-DQB"

if not pfUI then
    return
end

local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function()
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00" .. addonName .. "|r loaded.")
end)
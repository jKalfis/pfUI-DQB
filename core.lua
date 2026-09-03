local addonName = "pfUI-DQB"

-- pfUI-DQB only works when pfUI is loaded.
if not pfUI then
    return
end

-- Main pfUI-DQB namespace
pfUI.dqb = pfUI.dqb or {}
local DQB = pfUI.dqb

DQB.name = addonName
DQB.version = "0.1.1"

DQB.config = DQB.config or {}
DQB.modules = DQB.modules or {}


------------------------------------------------------------
-- Module system
------------------------------------------------------------

function DQB:RegisterModule(name, func)
    if not name or not func then
        return
    end

    self.modules[name] = func
end


------------------------------------------------------------
-- Configuration helpers
------------------------------------------------------------

function DQB:GetGlobalConfig(key, default)
    if not pfUI_config
    or not pfUI_config.global
    or pfUI_config.global[key] == nil then
        return default
    end

    return pfUI_config.global[key]
end


function DQB:GetConfig(module, key, default)
    if not pfUI_config
    or not pfUI_config.dqb
    or not pfUI_config.dqb[module]
    or pfUI_config.dqb[module][key] == nil then
        return default
    end

    return pfUI_config.dqb[module][key]
end


function DQB:SetConfig(module, key, value)
    if not pfUI_config then
        pfUI_config = {}
    end

    if not pfUI_config.dqb then
        pfUI_config.dqb = {}
    end

    if not pfUI_config.dqb[module] then
        pfUI_config.dqb[module] = {}
    end

    pfUI_config.dqb[module][key] = value
end


------------------------------------------------------------
-- Enable / Disable
------------------------------------------------------------

function DQB:IsEnabled()
    return self:GetConfig("general", "enable", "1") == "1"
end


function DQB:SetEnabled(enabled)
    if enabled then
        self:SetConfig("general", "enable", "1")
    else
        self:SetConfig("general", "enable", "0")
    end
end


------------------------------------------------------------
-- Debug / chat output
------------------------------------------------------------

function DQB:Debug(message)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(
            "|cff33ffccpf|cffffffffUI-DQB|r: " .. tostring(message)
        )
    end
end


------------------------------------------------------------
-- Initialization
------------------------------------------------------------

function DQB:Initialize()
    self:Debug(
        "initialized v" .. tostring(self.version)
    )

    self:Debug(
        "status: " .. (self:IsEnabled() and "enabled" or "disabled")
    )
end


------------------------------------------------------------
-- Load after WoW variables and pfUI are ready
------------------------------------------------------------

local loader = CreateFrame("Frame")

loader:RegisterEvent("VARIABLES_LOADED")

loader:SetScript("OnEvent", function()
    if event ~= "VARIABLES_LOADED" then
        return
    end

    if not pfUI then
        return
    end

    --------------------------------------------------------
    -- Initialize configuration
    --------------------------------------------------------

    if DQB.InitializeConfig then
        DQB:InitializeConfig()
    end

    --------------------------------------------------------
    -- Initialize pfUI GUI
    --------------------------------------------------------

    if DQB.InitializeGUI then
        DQB:InitializeGUI()
    end

    --------------------------------------------------------
    -- Initialize DQB
    --------------------------------------------------------

    DQB:Initialize()

    --------------------------------------------------------
    -- We only need VARIABLES_LOADED once
    --------------------------------------------------------

    this:UnregisterAllEvents()
end)

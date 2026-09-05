------------------------------------------------------------
-- pfUI-DQB
-- core.lua
------------------------------------------------------------

local addonName = "pfUI-DQB"

-- pfUI-DQB requires pfUI

if not pfUI then
    return
end

-- Main namespace

pfUI.dqb = pfUI.dqb or {}

local DQB = pfUI.dqb

-- Basic information

DQB.name = addonName
DQB.version = "0.2.0"

-- Registered modules

DQB.modules = DQB.modules or {}

-- Register a DQB module

function DQB:RegisterModule(name, func)

    if not name or not func then
        return
    end

    self.modules[name] = func

end

-- Get DQB configuration

function DQB:GetConfig(module, key, default)

    if not pfUI_config
    or not pfUI_config.dqb
    or not pfUI_config.dqb[module]
    or pfUI_config.dqb[module][key] == nil then

        return default
    end

    return pfUI_config.dqb[module][key]

end

-- Set DQB configuration

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

-- Check Dialogs & Quest Log option

function DQB:IsDialogsQuestLogEnabled()

    return self:GetConfig(
        "dialogs_questlog",
        "enable",
        "0"
    ) == "1"

end

-- Check Books option

function DQB:IsBooksEnabled()

    return self:GetConfig(
        "books",
        "enable",
        "0"
    ) == "1"

end

-- Check whether a specific module is enabled

function DQB:IsModuleEnabled(name)

    if name == "gossipquest"
    or name == "questlog" then

        return self:IsDialogsQuestLogEnabled()

    end

    if name == "itemtext" then

        return self:IsBooksEnabled()

    end

    return false

end

-- Debug message

function DQB:Debug(message)

    if DEFAULT_CHAT_FRAME then

        DEFAULT_CHAT_FRAME:AddMessage(
            "|cff33ffccpf|cffffffffUI-DQB|r: "
            .. tostring(message)
        )

    end

end

-- Initialize registered modules

function DQB:Initialize()

    for name, module in pairs(self.modules) do

        if module
        and self:IsModuleEnabled(name) then

            module()

        end

    end

end

-- Initialize after SavedVariables are available

local loader = CreateFrame("Frame")

loader:RegisterEvent("VARIABLES_LOADED")

loader:SetScript("OnEvent", function()

    if event ~= "VARIABLES_LOADED" then
        return
    end

    -- pfUI must exist

    if not pfUI then
        return
    end

    -- Initialize DQB configuration

    if DQB.InitializeConfig then
        DQB:InitializeConfig()
    end

    -- Initialize DQB GUI

    if DQB.CreateGUI then
        DQB:CreateGUI()
    end

    -- Initialize enabled DQB modules

    DQB:Initialize()

    -- No longer need this event

    this:UnregisterAllEvents()

end)
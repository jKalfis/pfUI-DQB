-- pfUI-DQB
-- core.lua
-- Main core and module system for pfUI-DQB.
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
DQB.version = "0.1.1"

DQB.config = DQB.config or {}
DQB.modules = DQB.modules or {}

-- Module system
function DQB:RegisterModule(name, func)

    if not name or not func then
        return
    end

    self.modules[name] = func
end

-- Configuration helpers
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

-- Enable / Disable
function DQB:IsEnabled()

    return self:GetConfig(
        "general",
        "enable",
        "1"
    ) == "1"

end


function DQB:SetEnabled(enabled)

    if enabled then

        self:SetConfig(
            "general",
            "enable",
            "1"
        )

    else

        self:SetConfig(
            "general",
            "enable",
            "0"
        )

    end

end

-- Debug
function DQB:Debug(message)

    if DEFAULT_CHAT_FRAME then

        DEFAULT_CHAT_FRAME:AddMessage(
            "|cff33ffccpf|cffffffffUI-DQB|r: "
            .. tostring(message)
        )

    end

end

-- Initialize modules
function DQB:Initialize()

    self:Debug(
        "initialized v" .. tostring(self.version)
    )


    self:Debug(
        "status: "
        .. (self:IsEnabled() and "enabled" or "disabled")
    )
    
    -- Modules will not initialize when DQB is disabled
    if not self:IsEnabled() then
        return
    end
    
    -- Load registered modules
    for name, module in pairs(self.modules) do

        if module then

            local success, errorMessage = pcall(module)

            if not success then

                self:Debug(
                    "module '" ..
                    tostring(name) ..
                    "' failed: " ..
                    tostring(errorMessage)
                )

            else

                self:Debug(
                    "module '" ..
                    tostring(name) ..
                    "' loaded"
                )

            end

        end

    end

end

-- Initialize after SavedVariables are available
local loader = CreateFrame("Frame")

loader:RegisterEvent("VARIABLES_LOADED")


loader:SetScript("OnEvent", function()

    
    -- Make sure this is the expected event
    if event ~= "VARIABLES_LOADED" then
        return
    end
    
    -- pfUI must exist
    if not pfUI then
        return
    end
    
    -- Initialize configuration
    if DQB.InitializeConfig then

        DQB:InitializeConfig()

    end
    
    -- Initialize GUI
    if DQB.InitializeGUI then

        DQB:InitializeGUI()

    end
    
    -- Initialize DQB modules
    DQB:Initialize()
    
    -- Only execute once
    this:UnregisterAllEvents()

end)

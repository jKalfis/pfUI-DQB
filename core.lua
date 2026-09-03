--[[
  pfUI-DQB
  Dialog, QuestLog & Books pfUI Style

  Core
]]

local addonName = "pfUI-DQB"

-- Make sure pfUI exists.
if not pfUI then
  return
end

-- DQB namespace
pfUI.dqb = pfUI.dqb or {}
local DQB = pfUI.dqb

DQB.name = addonName
DQB.version = "0.1.0"

-- Configuration root
DQB.config = DQB.config or {}

-- Runtime state
DQB.modules = DQB.modules or {}

-- Register a DQB module.
function DQB:RegisterModule(name, func)
  if not name or not func then
    return
  end

  self.modules[name] = func
end

-- Safely get a pfUI global configuration value.
function DQB:GetGlobalConfig(key, default)
  if not pfUI_config
    or not pfUI_config.global
    or pfUI_config.global[key] == nil then
    return default
  end

  return pfUI_config.global[key]
end

-- Safely get DQB configuration.
function DQB:GetConfig(module, key, default)
  if not pfUI_config
    or not pfUI_config.dqb
    or not pfUI_config.dqb[module]
    or pfUI_config.dqb[module][key] == nil then
    return default
  end

  return pfUI_config.dqb[module][key]
end

-- Set DQB configuration.
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

-- Simple debug helper.
function DQB:Debug(message)
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage(
      "|cff33ffccpf|cffffffffUI-DQB|r: " .. tostring(message)
    )
  end
end

-- Wait until pfUI's configuration and GUI are available.
local loader = CreateFrame("Frame")

loader:RegisterEvent("VARIABLES_LOADED")
loader:SetScript("OnEvent", function()
  if event ~= "VARIABLES_LOADED" then
    return
  end

  if not pfUI then
    return
  end

  -- The actual DQB configuration is initialized by config.lua.
  if DQB.InitializeConfig then
    DQB:InitializeConfig()
  end

  -- Build the pfUI configuration entries.
  if DQB.InitializeGUI then
    DQB:InitializeGUI()
  end

  this:UnregisterAllEvents()
end)
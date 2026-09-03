--[[
  pfUI-DQB
  Configuration
]]

if not pfUI or not pfUI.dqb then
  return
end

local DQB = pfUI.dqb

--------------------------------------------------
-- Default configuration
--------------------------------------------------

function DQB:InitializeConfig()

  -- Make sure the DQB root exists.
  if not pfUI_config then
    pfUI_config = {}
  end

  if not pfUI_config.dqb then
    pfUI_config.dqb = {}
  end

  ------------------------------------------------
  -- General
  ------------------------------------------------

  if not pfUI_config.dqb.general then
    pfUI_config.dqb.general = {}
  end

  local general = pfUI_config.dqb.general

  if general.enable == nil then
    general.enable = "1"
  end

  ------------------------------------------------
  -- Quest & Gossip
  ------------------------------------------------

  if not pfUI_config.dqb.questgossip then
    pfUI_config.dqb.questgossip = {}
  end

  local questgossip = pfUI_config.dqb.questgossip

  -- Background
  if questgossip.background_global == nil then
    questgossip.background_global = "1"
  end

  if questgossip.background_color == nil then
    questgossip.background_color = "0,0,0,1"
  end

  if questgossip.background_alpha == nil then
    questgossip.background_alpha = "0.85"
  end

  -- Text
  if questgossip.text_global == nil then
    questgossip.text_global = "1"
  end

  if questgossip.text_font == nil then
    questgossip.text_font = ""
  end

  if questgossip.text_size == nil then
    questgossip.text_size = ""
  end

  if questgossip.text_style == nil then
    questgossip.text_style = ""
  end

  if questgossip.text_color == nil then
    questgossip.text_color = "1,1,1,1"
  end

  ------------------------------------------------
  -- Quest Log
  ------------------------------------------------

  if not pfUI_config.dqb.questlog then
    pfUI_config.dqb.questlog = {}
  end

  local questlog = pfUI_config.dqb.questlog

  if questlog.background_global == nil then
    questlog.background_global = "1"
  end

  if questlog.background_color == nil then
    questlog.background_color = "0,0,0,1"
  end

  if questlog.background_alpha == nil then
    questlog.background_alpha = "0.85"
  end

  if questlog.text_global == nil then
    questlog.text_global = "1"
  end

  if questlog.text_font == nil then
    questlog.text_font = ""
  end

  if questlog.text_size == nil then
    questlog.text_size = ""
  end

  if questlog.text_style == nil then
    questlog.text_style = ""
  end

  if questlog.text_color == nil then
    questlog.text_color = "1,1,1,1"
  end

  ------------------------------------------------
  -- Item Text
  ------------------------------------------------

  if not pfUI_config.dqb.itemtext then
    pfUI_config.dqb.itemtext = {}
  end

  local itemtext = pfUI_config.dqb.itemtext

  if itemtext.background_global == nil then
    itemtext.background_global = "1"
  end

  if itemtext.background_color == nil then
    itemtext.background_color = "0,0,0,1"
  end

  if itemtext.background_alpha == nil then
    itemtext.background_alpha = "0.85"
  end

  if itemtext.text_global == nil then
    itemtext.text_global = "1"
  end

  if itemtext.text_font == nil then
    itemtext.text_font = ""
  end

  if itemtext.text_size == nil then
    itemtext.text_size = ""
  end

  if itemtext.text_style == nil then
    itemtext.text_style = ""
  end

  if itemtext.text_color == nil then
    itemtext.text_color = "1,1,1,1"
  end

  ------------------------------------------------
  -- Merchant
  ------------------------------------------------

  if not pfUI_config.dqb.merchant then
    pfUI_config.dqb.merchant = {}
  end

  local merchant = pfUI_config.dqb.merchant

  if merchant.background_global == nil then
    merchant.background_global = "1"
  end

  if merchant.background_color == nil then
    merchant.background_color = "0,0,0,1"
  end

  if merchant.background_alpha == nil then
    merchant.background_alpha = "0.85"
  end

  if merchant.text_global == nil then
    merchant.text_global = "1"
  end

  if merchant.text_font == nil then
    merchant.text_font = ""
  end

  if merchant.text_size == nil then
    merchant.text_size = ""
  end

  if merchant.text_style == nil then
    merchant.text_style = ""
  end

  if merchant.text_color == nil then
    merchant.text_color = "1,1,1,1"
  end
end

--------------------------------------------------
-- pfUI GUI integration
--------------------------------------------------

function DQB:InitializeGUI()

  if not pfUI.gui then
    return
  end

  if not pfUI.gui.CreateGUIEntry then
    return
  end

  -- Prevent duplicate creation.
  if self.guiInitialized then
    return
  end

  self.guiInitialized = true

  ------------------------------------------------
  -- DQB
  ------------------------------------------------

  local CreateGUIEntry = pfUI.gui.CreateGUIEntry

  ------------------------------------------------
  -- General
  ------------------------------------------------

  CreateGUIEntry(
    "DQB",
    nil,
    function()
      local CreateConfig = pfUI.gui.CreateConfig

      CreateConfig(
        nil,
        "Enable DQB",
        pfUI_config.dqb.general,
        "enable",
        "checkbox"
      )
    end
  )

end
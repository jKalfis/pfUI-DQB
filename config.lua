------------------------------------------------------------
-- pfUI-DQB
-- config.lua
--
-- Default configuration for DQB.
-- GUI registration is handled by gui.lua.
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end

------------------------------------------------------------
-- Default configuration
------------------------------------------------------------

function DQB:InitializeConfig()

    --------------------------------------------------------
    -- Root
    --------------------------------------------------------

    if not pfUI_config then
        pfUI_config = {}
    end

    if not pfUI_config.dqb then
        pfUI_config.dqb = {}
    end

    --------------------------------------------------------
    -- General
    --------------------------------------------------------

    if not pfUI_config.dqb.general then
        pfUI_config.dqb.general = {}
    end

    local general = pfUI_config.dqb.general

    if general.enable == nil then
        general.enable = "1"
    end

    --------------------------------------------------------
    -- Quest & Gossip
    --------------------------------------------------------

    if not pfUI_config.dqb.questgossip then
        pfUI_config.dqb.questgossip = {}
    end

    local questgossip = pfUI_config.dqb.questgossip

    if questgossip.background_global == nil then
        questgossip.background_global = "1"
    end

    if questgossip.background_color == nil then
        questgossip.background_color = "000000"
    end

    if questgossip.background_alpha == nil then
        questgossip.background_alpha = "0.85"
    end

    if questgossip.text_global == nil then
        questgossip.text_global = "1"
    end

    if questgossip.text_font == nil then
        questgossip.text_font = "Arial"
    end

    if questgossip.text_size == nil then
        questgossip.text_size = "12"
    end

    if questgossip.text_style == nil then
        questgossip.text_style = ""
    end

    if questgossip.text_color == nil then
        questgossip.text_color = "ffffff"
    end

    --------------------------------------------------------
    -- Quest Log
    --------------------------------------------------------

    if not pfUI_config.dqb.questlog then
        pfUI_config.dqb.questlog = {}
    end

    local questlog = pfUI_config.dqb.questlog

    if questlog.background_global == nil then
        questlog.background_global = "1"
    end

    if questlog.background_color == nil then
        questlog.background_color = "000000"
    end

    if questlog.background_alpha == nil then
        questlog.background_alpha = "0.85"
    end

    if questlog.text_global == nil then
        questlog.text_global = "1"
    end

    if questlog.text_font == nil then
        questlog.text_font = "Arial"
    end

    if questlog.text_size == nil then
        questlog.text_size = "12"
    end

    if questlog.text_style == nil then
        questlog.text_style = ""
    end

    if questlog.text_color == nil then
        questlog.text_color = "ffffff"
    end

    --------------------------------------------------------
    -- Item Text
    --------------------------------------------------------

    if not pfUI_config.dqb.itemtext then
        pfUI_config.dqb.itemtext = {}
    end

    local itemtext = pfUI_config.dqb.itemtext

    if itemtext.background_global == nil then
        itemtext.background_global = "1"
    end

    if itemtext.background_color == nil then
        itemtext.background_color = "000000"
    end

    if itemtext.background_alpha == nil then
        itemtext.background_alpha = "0.85"
    end

    if itemtext.text_global == nil then
        itemtext.text_global = "1"
    end

    if itemtext.text_font == nil then
        itemtext.text_font = "Arial"
    end

    if itemtext.text_size == nil then
        itemtext.text_size = "12"
    end

    if itemtext.text_style == nil then
        itemtext.text_style = ""
    end

    if itemtext.text_color == nil then
        itemtext.text_color = "ffffff"
    end

    --------------------------------------------------------
    -- Merchant
    --------------------------------------------------------

    if not pfUI_config.dqb.merchant then
        pfUI_config.dqb.merchant = {}
    end

    local merchant = pfUI_config.dqb.merchant

    if merchant.background_global == nil then
        merchant.background_global = "1"
    end

    if merchant.background_color == nil then
        merchant.background_color = "000000"
    end

    if merchant.background_alpha == nil then
        merchant.background_alpha = "0.85"
    end

    if merchant.text_global == nil then
        merchant.text_global = "1"
    end

    if merchant.text_font == nil then
        merchant.text_font = "Arial"
    end

    if merchant.text_size == nil then
        merchant.text_size = "12"
    end

    if merchant.text_style == nil then
        merchant.text_style = ""
    end

    if merchant.text_color == nil then
        merchant.text_color = "ffffff"
    end

end
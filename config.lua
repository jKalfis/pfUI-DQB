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
-- Helpers
------------------------------------------------------------

local function GetPFUIFont()
    if pfUI and pfUI.font_default then
        return pfUI.font_default
    end

    return "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"
end

local function GetPFUIBackgroundAlpha()
    -- Try to use the pfUI global background alpha.
    if pfUI_config
    and pfUI_config.global
    and pfUI_config.global.background_alpha ~= nil then
        return tostring(pfUI_config.global.background_alpha)
    end

    -- Fallback to the value commonly used by pfUI.
    return "0.75"
end

------------------------------------------------------------
-- Initialize configuration
------------------------------------------------------------

function DQB:InitializeConfig()

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

    -- No style selected by default.
    if questgossip.use_pfui_style == nil then
        questgossip.use_pfui_style = "0"
    end

    if questgossip.use_custom_style == nil then
        questgossip.use_custom_style = "0"
    end

    -- Custom settings.
    if not questgossip.custom then
        questgossip.custom = {}
    end

    local custom = questgossip.custom

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end

    if custom.background_color == nil then
        custom.background_color = "000000"
    end

    if custom.background_alpha == nil then
        custom.background_alpha = GetPFUIBackgroundAlpha()
    end

    if custom.font == nil then
        custom.font = GetPFUIFont()
    end

    if custom.title_color == nil then
        custom.title_color = "ffd700"
    end

    if custom.text_color == nil then
        custom.text_color = "ffffff"
    end

    -- Separate opacity for the pfUI preset.
    if questgossip.pfui_background_alpha == nil then
        questgossip.pfui_background_alpha = GetPFUIBackgroundAlpha()
    end

    --------------------------------------------------------
    -- Quest Log
    --------------------------------------------------------

    if not pfUI_config.dqb.questlog then
        pfUI_config.dqb.questlog = {}
    end

    local questlog = pfUI_config.dqb.questlog

    -- No style selected by default.
    if questlog.use_pfui_style == nil then
        questlog.use_pfui_style = "0"
    end

    if questlog.use_custom_style == nil then
        questlog.use_custom_style = "0"
    end

    -- Custom settings.
    if not questlog.custom then
        questlog.custom = {}
    end

    local custom = questlog.custom

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end

    if custom.background_color == nil then
        custom.background_color = "000000"
    end

    if custom.background_alpha == nil then
        custom.background_alpha = GetPFUIBackgroundAlpha()
    end

    if custom.font == nil then
        custom.font = GetPFUIFont()
    end

    if custom.title_color == nil then
        custom.title_color = "ffd700"
    end

    if custom.text_color == nil then
        custom.text_color = "ffffff"
    end

    -- Separate opacity for the pfUI preset.
    if questlog.pfui_background_alpha == nil then
        questlog.pfui_background_alpha = GetPFUIBackgroundAlpha()
    end

    --------------------------------------------------------
    -- Books
    --------------------------------------------------------

    if not pfUI_config.dqb.books then
        pfUI_config.dqb.books = {}
    end

    local books = pfUI_config.dqb.books

    -- No style selected by default.
    if books.use_pfui_style == nil then
        books.use_pfui_style = "0"
    end

    if books.use_custom_style == nil then
        books.use_custom_style = "0"
    end

    -- Custom settings.
    if not books.custom then
        books.custom = {}
    end

    local custom = books.custom

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end

    if custom.background_color == nil then
        custom.background_color = "000000"
    end

    if custom.background_alpha == nil then
        custom.background_alpha = GetPFUIBackgroundAlpha()
    end

    if custom.font == nil then
        custom.font = GetPFUIFont()
    end

    if custom.title_color == nil then
        custom.title_color = "ffd700"
    end

    if custom.text_color == nil then
        custom.text_color = "ffffff"
    end

    -- Separate opacity for the pfUI preset.
    if books.pfui_background_alpha == nil then
        books.pfui_background_alpha = GetPFUIBackgroundAlpha()
    end

    --------------------------------------------------------
    -- Merchant
    --
    -- Reserved for later.
    --------------------------------------------------------

    if not pfUI_config.dqb.merchant then
        pfUI_config.dqb.merchant = {}
    end
end

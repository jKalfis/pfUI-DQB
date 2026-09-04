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

    if pfUI_config
    and pfUI_config.global
    and pfUI_config.global.font_default then
        return pfUI_config.global.font_default
    end

    return "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"
end

local function GetPFUIBackgroundColor()
    if pfUI_config
    and pfUI_config.global
    and pfUI_config.global.background_color then
        return pfUI_config.global.background_color
    end

    return "0,0,0,1"
end

local function GetPFUIBackgroundAlpha()
    if pfUI_config
    and pfUI_config.global
    and pfUI_config.global.background_alpha ~= nil then
        return tostring(pfUI_config.global.background_alpha)
    end

    return "0.75"
end

------------------------------------------------------------
-- Module defaults
------------------------------------------------------------

local function InitializeModule(module)

    if not module then
        return
    end

    --------------------------------------------------------
    -- No style selected by default.
    --------------------------------------------------------

    if module.use_pfui_style == nil then
        module.use_pfui_style = "0"
    end

    if module.use_custom_style == nil then
        module.use_custom_style = "0"
    end

    --------------------------------------------------------
    -- pfUI Style
    --------------------------------------------------------

    if module.pfui_background_alpha == nil then
        module.pfui_background_alpha = GetPFUIBackgroundAlpha()
    end

    --------------------------------------------------------
    -- Custom Style
    --------------------------------------------------------

    if not module.custom then
        module.custom = {}
    end

    local custom = module.custom

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end

    if custom.background_color == nil then
        custom.background_color = GetPFUIBackgroundColor()
    end

    if custom.background_alpha == nil then
        custom.background_alpha = GetPFUIBackgroundAlpha()
    end

    if custom.font == nil then
        custom.font = GetPFUIFont()
    end

    --------------------------------------------------------
    -- DQB visual defaults
    --
    -- Titles = Gold
    -- Text   = White
    --------------------------------------------------------

    if custom.title_color == nil then
        custom.title_color = "1,0.82,0,1"
    end

    if custom.text_color == nil then
        custom.text_color = "1,1,1,1"
    end

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

    InitializeModule(
        pfUI_config.dqb.questgossip
    )

    --------------------------------------------------------
    -- Quest Log
    --------------------------------------------------------

    if not pfUI_config.dqb.questlog then
        pfUI_config.dqb.questlog = {}
    end

    InitializeModule(
        pfUI_config.dqb.questlog
    )

    --------------------------------------------------------
    -- Books
    --------------------------------------------------------

    if not pfUI_config.dqb.books then
        pfUI_config.dqb.books = {}
    end

    InitializeModule(
        pfUI_config.dqb.books
    )

    --------------------------------------------------------
    -- Merchant
    --
    -- Reserved for later.
    --------------------------------------------------------

    if not pfUI_config.dqb.merchant then
        pfUI_config.dqb.merchant = {}
    end
end

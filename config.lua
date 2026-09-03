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
    -- GENERAL
    --------------------------------------------------------

    if not pfUI_config.dqb.general then
        pfUI_config.dqb.general = {}
    end

    local general = pfUI_config.dqb.general

    if general.enable == nil then
        general.enable = "1"
    end


    --------------------------------------------------------
    -- QUEST & GOSSIP
    --------------------------------------------------------

    if not pfUI_config.dqb.questgossip then
        pfUI_config.dqb.questgossip = {}
    end

    local questgossip = pfUI_config.dqb.questgossip


    --------------------------------------------------------
    -- Presets
    --------------------------------------------------------

    if questgossip.pfui_style == nil then
        questgossip.pfui_style = "0"
    end

    if questgossip.fix_fonts == nil then
        questgossip.fix_fonts = "0"
    end


    --------------------------------------------------------
    -- Custom
    --------------------------------------------------------

    if not questgossip.custom then
        questgossip.custom = {}
    end

    local custom = questgossip.custom

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end

    if custom.background_color == nil then
        custom.background_color = "0,0,0,0.85"
    end

    if custom.background_alpha == nil then
        custom.background_alpha = "0.85"
    end

    if custom.font == nil then
        custom.font = "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"
    end

    if custom.title_color == nil then
        custom.title_color = "1,0.84,0"
    end

    if custom.text_color == nil then
        custom.text_color = "1,1,1"
    end


    --------------------------------------------------------
    -- QUEST LOG
    --------------------------------------------------------

    if not pfUI_config.dqb.questlog then
        pfUI_config.dqb.questlog = {}
    end

    local questlog = pfUI_config.dqb.questlog


    --------------------------------------------------------
    -- Presets
    --------------------------------------------------------

    if questlog.pfui_style == nil then
        questlog.pfui_style = "0"
    end

    if questlog.fix_fonts == nil then
        questlog.fix_fonts = "0"
    end


    --------------------------------------------------------
    -- Custom
    --------------------------------------------------------

    if not questlog.custom then
        questlog.custom = {}
    end

    local custom = questlog.custom

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end

    if custom.background_color == nil then
        custom.background_color = "0,0,0,0.85"
    end

    if custom.background_alpha == nil then
        custom.background_alpha = "0.85"
    end

    if custom.font == nil then
        custom.font = "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"
    end

    if custom.title_color == nil then
        custom.title_color = "1,0.84,0"
    end

    if custom.text_color == nil then
        custom.text_color = "1,1,1"
    end


    --------------------------------------------------------
    -- BOOKS
    --------------------------------------------------------
    --
    -- Books corresponds to the original pfUI itemtext.lua.
    --------------------------------------------------------

    if not pfUI_config.dqb.books then
        pfUI_config.dqb.books = {}
    end

    local books = pfUI_config.dqb.books


    --------------------------------------------------------
    -- Presets
    --------------------------------------------------------

    if books.pfui_style == nil then
        books.pfui_style = "0"
    end

    if books.fix_fonts == nil then
        books.fix_fonts = "0"
    end


    --------------------------------------------------------
    -- Custom
    --------------------------------------------------------

    if not books.custom then
        books.custom = {}
    end

    local custom = books.custom

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end

    if custom.background_color == nil then
        custom.background_color = "0,0,0,0.85"
    end

    if custom.background_alpha == nil then
        custom.background_alpha = "0.85"
    end

    if custom.font == nil then
        custom.font = "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"
    end

    if custom.title_color == nil then
        custom.title_color = "1,0.84,0"
    end

    if custom.text_color == nil then
        custom.text_color = "1,1,1"
    end


    --------------------------------------------------------
    -- MERCHANT
    --------------------------------------------------------
    --
    -- Kept untouched for now.
    --------------------------------------------------------

    if not pfUI_config.dqb.merchant then
        pfUI_config.dqb.merchant = {}
    end

end
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
    -- Use pfUI Style
    --------------------------------------------------------

    if questgossip.use_pfui_style == nil then
        questgossip.use_pfui_style = "0"
    end


    --------------------------------------------------------
    -- Use Custom Style
    --------------------------------------------------------

    if questgossip.use_custom_style == nil then
        questgossip.use_custom_style = "0"
    end


    --------------------------------------------------------
    -- pfUI Style
    --------------------------------------------------------

    if questgossip.pfui_background_alpha == nil then

        if pfUI_config.global
        and pfUI_config.global.background_alpha ~= nil then

            questgossip.pfui_background_alpha =
                tostring(
                    pfUI_config.global.background_alpha
                )

        else

            questgossip.pfui_background_alpha =
                "0.75"

        end

    end


    --------------------------------------------------------
    -- Custom Style
    --------------------------------------------------------

    if not questgossip.custom then
        questgossip.custom = {}
    end

    local custom = questgossip.custom


    --------------------------------------------------------
    -- Remove Blizzard Parchment Texture
    --------------------------------------------------------

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end


    --------------------------------------------------------
    -- Background Color
    --------------------------------------------------------

    if custom.background_color == nil then

        if pfUI_config.global
        and pfUI_config.global.background then

            custom.background_color =
                pfUI_config.global.background

        elseif pfUI_config.global
        and pfUI_config.global.background_color then

            custom.background_color =
                pfUI_config.global.background_color

        else

            custom.background_color =
                "0,0,0,1"

        end

    end


    --------------------------------------------------------
    -- Background Opacity
    --------------------------------------------------------

    if custom.background_alpha == nil then

        if pfUI_config.global
        and pfUI_config.global.background_alpha ~= nil then

            custom.background_alpha =
                tostring(
                    pfUI_config.global.background_alpha
                )

        else

            custom.background_alpha =
                "0.75"

        end

    end


    --------------------------------------------------------
    -- Font
    --------------------------------------------------------

    if custom.font == nil then

        if pfUI.font_default then

            custom.font =
                pfUI.font_default

        elseif pfUI_config.global
        and pfUI_config.global.font_default then

            custom.font =
                pfUI_config.global.font_default

        else

            custom.font =
                "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"

        end

    end


    --------------------------------------------------------
    -- Title Color
    --------------------------------------------------------

    if custom.title_color == nil then
        custom.title_color = "1,0.84,0"
    end


    --------------------------------------------------------
    -- Text Color
    --------------------------------------------------------

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
    -- Use pfUI Style
    --------------------------------------------------------

    if questlog.use_pfui_style == nil then
        questlog.use_pfui_style = "0"
    end


    --------------------------------------------------------
    -- Use Custom Style
    --------------------------------------------------------

    if questlog.use_custom_style == nil then
        questlog.use_custom_style = "0"
    end


    --------------------------------------------------------
    -- pfUI Style
    --------------------------------------------------------

    if questlog.pfui_background_alpha == nil then

        if pfUI_config.global
        and pfUI_config.global.background_alpha ~= nil then

            questlog.pfui_background_alpha =
                tostring(
                    pfUI_config.global.background_alpha
                )

        else

            questlog.pfui_background_alpha =
                "0.75"

        end

    end


    --------------------------------------------------------
    -- Custom Style
    --------------------------------------------------------

    if not questlog.custom then
        questlog.custom = {}
    end

    local custom = questlog.custom


    --------------------------------------------------------
    -- Remove Blizzard Parchment Texture
    --------------------------------------------------------

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end


    --------------------------------------------------------
    -- Background Color
    --------------------------------------------------------

    if custom.background_color == nil then

        if pfUI_config.global
        and pfUI_config.global.background then

            custom.background_color =
                pfUI_config.global.background

        elseif pfUI_config.global
        and pfUI_config.global.background_color then

            custom.background_color =
                pfUI_config.global.background_color

        else

            custom.background_color =
                "0,0,0,1"

        end

    end


    --------------------------------------------------------
    -- Background Opacity
    --------------------------------------------------------

    if custom.background_alpha == nil then

        if pfUI_config.global
        and pfUI_config.global.background_alpha ~= nil then

            custom.background_alpha =
                tostring(
                    pfUI_config.global.background_alpha
                )

        else

            custom.background_alpha =
                "0.75"

        end

    end


    --------------------------------------------------------
    -- Font
    --------------------------------------------------------

    if custom.font == nil then

        if pfUI.font_default then

            custom.font =
                pfUI.font_default

        elseif pfUI_config.global
        and pfUI_config.global.font_default then

            custom.font =
                pfUI_config.global.font_default

        else

            custom.font =
                "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"

        end

    end


    --------------------------------------------------------
    -- Title Color
    --------------------------------------------------------

    if custom.title_color == nil then
        custom.title_color = "1,0.84,0"
    end


    --------------------------------------------------------
    -- Text Color
    --------------------------------------------------------

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
    -- Use pfUI Style
    --------------------------------------------------------

    if books.use_pfui_style == nil then
        books.use_pfui_style = "0"
    end


    --------------------------------------------------------
    -- Use Custom Style
    --------------------------------------------------------

    if books.use_custom_style == nil then
        books.use_custom_style = "0"
    end


    --------------------------------------------------------
    -- pfUI Style
    --------------------------------------------------------

    if books.pfui_background_alpha == nil then

        if pfUI_config.global
        and pfUI_config.global.background_alpha ~= nil then

            books.pfui_background_alpha =
                tostring(
                    pfUI_config.global.background_alpha
                )

        else

            books.pfui_background_alpha =
                "0.75"

        end

    end


    --------------------------------------------------------
    -- Custom Style
    --------------------------------------------------------

    if not books.custom then
        books.custom = {}
    end

    local custom = books.custom


    --------------------------------------------------------
    -- Remove Blizzard Parchment Texture
    --------------------------------------------------------

    if custom.remove_parchment == nil then
        custom.remove_parchment = "1"
    end


    --------------------------------------------------------
    -- Background Color
    --------------------------------------------------------

    if custom.background_color == nil then

        if pfUI_config.global
        and pfUI_config.global.background then

            custom.background_color =
                pfUI_config.global.background

        elseif pfUI_config.global
        and pfUI_config.global.background_color then

            custom.background_color =
                pfUI_config.global.background_color

        else

            custom.background_color =
                "0,0,0,1"

        end

    end


    --------------------------------------------------------
    -- Background Opacity
    --------------------------------------------------------

    if custom.background_alpha == nil then

        if pfUI_config.global
        and pfUI_config.global.background_alpha ~= nil then

            custom.background_alpha =
                tostring(
                    pfUI_config.global.background_alpha
                )

        else

            custom.background_alpha =
                "0.75"

        end

    end


    --------------------------------------------------------
    -- Font
    --------------------------------------------------------

    if custom.font == nil then

        if pfUI.font_default then

            custom.font =
                pfUI.font_default

        elseif pfUI_config.global
        and pfUI_config.global.font_default then

            custom.font =
                pfUI_config.global.font_default

        else

            custom.font =
                "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"

        end

    end


    --------------------------------------------------------
    -- Title Color
    --------------------------------------------------------

    if custom.title_color == nil then
        custom.title_color = "1,0.84,0"
    end


    --------------------------------------------------------
    -- Text Color
    --------------------------------------------------------

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

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end

function DQB:InitializeConfig()
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
    -- Gossip & Quest
    ------------------------------------------------

    if not pfUI_config.dqb.gossipquest then
        pfUI_config.dqb.gossipquest = {}
    end

    local gossipquest = pfUI_config.dqb.gossipquest

    if gossipquest.pfui_style == nil then
        gossipquest.pfui_style = "0"
    end

    if gossipquest.fix_fonts == nil then
        gossipquest.fix_fonts = "0"
    end

    if gossipquest.remove_parchment == nil then
        gossipquest.remove_parchment = "0"
    end

    if gossipquest.background_color == nil then
        gossipquest.background_color = "000000"
    end

    if gossipquest.background_alpha == nil then
        gossipquest.background_alpha = "0.85"
    end

    if gossipquest.font == nil then
        gossipquest.font = "Arial"
    end

    if gossipquest.title_color == nil then
        gossipquest.title_color = "ffd100"
    end

    if gossipquest.text_color == nil then
        gossipquest.text_color = "ffffff"
    end

    ------------------------------------------------
    -- Quest Log
    ------------------------------------------------

    if not pfUI_config.dqb.questlog then
        pfUI_config.dqb.questlog = {}
    end

    local questlog = pfUI_config.dqb.questlog

    if questlog.pfui_style == nil then
        questlog.pfui_style = "0"
    end

    if questlog.fix_fonts == nil then
        questlog.fix_fonts = "0"
    end

    if questlog.remove_parchment == nil then
        questlog.remove_parchment = "0"
    end

    if questlog.background_color == nil then
        questlog.background_color = "000000"
    end

    if questlog.background_alpha == nil then
        questlog.background_alpha = "0.85"
    end

    if questlog.font == nil then
        questlog.font = "Arial"
    end

    if questlog.title_color == nil then
        questlog.title_color = "ffd100"
    end

    if questlog.text_color == nil then
        questlog.text_color = "ffffff"
    end

    ------------------------------------------------
    -- Books
    ------------------------------------------------

    if not pfUI_config.dqb.books then
        pfUI_config.dqb.books = {}
    end

    local books = pfUI_config.dqb.books

    if books.pfui_style == nil then
        books.pfui_style = "0"
    end

    if books.fix_fonts == nil then
        books.fix_fonts = "0"
    end

    if books.remove_parchment == nil then
        books.remove_parchment = "0"
    end

    if books.background_color == nil then
        books.background_color = "000000"
    end

    if books.background_alpha == nil then
        books.background_alpha = "0.85"
    end

    if books.font == nil then
        books.font = "Arial"
    end

    if books.title_color == nil then
        books.title_color = "ffd100"
    end

    if books.text_color == nil then
        books.text_color = "ffffff"
    end
end

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end

------------------------------------------------
-- Initialize configuration
------------------------------------------------

if DQB.InitializeConfig then
    DQB:InitializeConfig()
end

------------------------------------------------
-- Helpers
------------------------------------------------

local function CreateModuleConfig(parent, title, config)

    ------------------------------------------------
    -- Remove Blizzard Skin and apply pfUI Style
    ------------------------------------------------

    CreateConfig(
        parent,
        "Remove Blizzard Skin and apply pfUI Style",
        config,
        "pfui_style",
        "checkbox"
    )

    ------------------------------------------------
    -- Fix Fonts
    ------------------------------------------------

    CreateConfig(
        parent,
        "Fix Fonts",
        config,
        "fix_fonts",
        "checkbox"
    )

    ------------------------------------------------
    -- Custom
    ------------------------------------------------

    CreateConfig(
        parent,
        "Custom",
        nil,
        nil,
        "header"
    )

    ------------------------------------------------
    -- Remove Blizzard Parchment Texture
    ------------------------------------------------

    CreateConfig(
        parent,
        "Remove Blizzard Parchment Texture",
        config,
        "remove_parchment",
        "checkbox"
    )

    ------------------------------------------------
    -- Background Color
    ------------------------------------------------

    CreateConfig(
        parent,
        "Background Color",
        config,
        "background_color",
        "color"
    )

    ------------------------------------------------
    -- Background Opacity
    ------------------------------------------------

    CreateConfig(
        parent,
        "Background Opacity",
        config,
        "background_alpha",
        "range",
        0,
        1,
        0.05
    )

    ------------------------------------------------
    -- Font
    ------------------------------------------------

    CreateConfig(
        parent,
        "Font",
        config,
        "font",
        "dropdown"
    )

    ------------------------------------------------
    -- Font Colors
    ------------------------------------------------

    CreateConfig(
        parent,
        "Font Colors",
        nil,
        nil,
        "header"
    )

    ------------------------------------------------
    -- Titles
    ------------------------------------------------

    CreateConfig(
        parent,
        "Titles",
        config,
        "title_color",
        "color"
    )

    ------------------------------------------------
    -- Text
    ------------------------------------------------

    CreateConfig(
        parent,
        "Text",
        config,
        "text_color",
        "color"
    )
end

------------------------------------------------
-- DQB configuration
------------------------------------------------

pfUI:RegisterConfig(
    "dqb",
    "DQB",
    function()

        ------------------------------------------------
        -- General
        ------------------------------------------------

        CreateConfig(
            nil,
            "Enable DQB",
            pfUI_config.dqb.general,
            "enable",
            "checkbox"
        )

        ------------------------------------------------
        -- Gossip & Quest
        ------------------------------------------------

        CreateConfig(
            nil,
            "Gossip & Quest",
            pfUI_config.dqb.gossipquest,
            nil,
            "submenu",
            function()

                CreateModuleConfig(
                    nil,
                    "Gossip & Quest",
                    pfUI_config.dqb.gossipquest
                )

            end
        )

        ------------------------------------------------
        -- Quest Log
        ------------------------------------------------

        CreateConfig(
            nil,
            "Quest Log",
            pfUI_config.dqb.questlog,
            nil,
            "submenu",
            function()

                CreateModuleConfig(
                    nil,
                    "Quest Log",
                    pfUI_config.dqb.questlog
                )

            end
        )

        ------------------------------------------------
        -- Books
        ------------------------------------------------

        CreateConfig(
            nil,
            "Books",
            pfUI_config.dqb.books,
            nil,
            "submenu",
            function()

                CreateModuleConfig(
                    nil,
                    "Books",
                    pfUI_config.dqb.books
                )

            end
        )
    end
)

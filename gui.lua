------------------------------------------------------------
-- pfUI-DQB
-- gui.lua
--
-- Registers DQB configuration inside pfUI's GUI.
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end

------------------------------------------------------------
-- Create GUI
------------------------------------------------------------

function DQB:CreateGUI()

    if not pfUI.gui then
        return
    end

    if self.InitializeConfig then
        self:InitializeConfig()
    end

    if not pfUI_config or not pfUI_config.dqb then
        return
    end

    local CreateConfig = pfUI.gui.CreateConfig
    local CreateGUIEntry = pfUI.gui.CreateGUIEntry

    if not CreateConfig or not CreateGUIEntry then
        return
    end

    --------------------------------------------------------
    -- General
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "General",
        function()

            CreateConfig(
                nil,
                "Enable DQB",
                pfUI_config.dqb.general,
                "enable",
                "checkbox"
            )

        end
    )

    --------------------------------------------------------
    -- Quest & Gossip
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Quest & Gossip",
        function()

            ------------------------------------------------
            -- Use pfUI Style
            ------------------------------------------------

            CreateConfig(
                nil,
                "Use pfUI Style",
                pfUI_config.dqb.questgossip,
                "use_pfui_style",
                "checkbox"
            )

            CreateConfig(
                nil,
                "pfUI Background Opacity",
                pfUI_config.dqb.questgossip,
                "pfui_background_alpha",
                "slider"
            )

            CreateConfig(
                nil,
                "Reset to pfUI Default",
                pfUI_config.dqb.questgossip,
                "reset_pfui",
                "button"
            )

            ------------------------------------------------
            -- Use Custom Style
            ------------------------------------------------

            CreateConfig(
                nil,
                "Use Custom Style",
                pfUI_config.dqb.questgossip,
                "use_custom_style",
                "checkbox"
            )

            ------------------------------------------------
            -- Custom options
            ------------------------------------------------

            CreateConfig(
                nil,
                "Remove Blizzard Parchment Texture",
                pfUI_config.dqb.questgossip.custom,
                "remove_parchment",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Background Color",
                pfUI_config.dqb.questgossip.custom,
                "background_color",
                "color"
            )

            CreateConfig(
                nil,
                "Background Opacity",
                pfUI_config.dqb.questgossip.custom,
                "background_alpha",
                "slider"
            )

            CreateConfig(
                nil,
                "Fonts",
                pfUI_config.dqb.questgossip.custom,
                "font",
                "font"
            )

            CreateConfig(
                nil,
                "Title Color",
                pfUI_config.dqb.questgossip.custom,
                "title_color",
                "color"
            )

            CreateConfig(
                nil,
                "Text Color",
                pfUI_config.dqb.questgossip.custom,
                "text_color",
                "color"
            )

            CreateConfig(
                nil,
                "Reset Custom Values",
                pfUI_config.dqb.questgossip.custom,
                "reset",
                "button"
            )

        end
    )

    --------------------------------------------------------
    -- Quest Log
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Quest Log",
        function()

            ------------------------------------------------
            -- Use pfUI Style
            ------------------------------------------------

            CreateConfig(
                nil,
                "Use pfUI Style",
                pfUI_config.dqb.questlog,
                "use_pfui_style",
                "checkbox"
            )

            CreateConfig(
                nil,
                "pfUI Background Opacity",
                pfUI_config.dqb.questlog,
                "pfui_background_alpha",
                "slider"
            )

            CreateConfig(
                nil,
                "Reset to pfUI Default",
                pfUI_config.dqb.questlog,
                "reset_pfui",
                "button"
            )

            ------------------------------------------------
            -- Use Custom Style
            ------------------------------------------------

            CreateConfig(
                nil,
                "Use Custom Style",
                pfUI_config.dqb.questlog,
                "use_custom_style",
                "checkbox"
            )

            ------------------------------------------------
            -- Custom options
            ------------------------------------------------

            CreateConfig(
                nil,
                "Remove Blizzard Parchment Texture",
                pfUI_config.dqb.questlog.custom,
                "remove_parchment",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Background Color",
                pfUI_config.dqb.questlog.custom,
                "background_color",
                "color"
            )

            CreateConfig(
                nil,
                "Background Opacity",
                pfUI_config.dqb.questlog.custom,
                "background_alpha",
                "slider"
            )

            CreateConfig(
                nil,
                "Fonts",
                pfUI_config.dqb.questlog.custom,
                "font",
                "font"
            )

            CreateConfig(
                nil,
                "Title Color",
                pfUI_config.dqb.questlog.custom,
                "title_color",
                "color"
            )

            CreateConfig(
                nil,
                "Text Color",
                pfUI_config.dqb.questlog.custom,
                "text_color",
                "color"
            )

            CreateConfig(
                nil,
                "Reset Custom Values",
                pfUI_config.dqb.questlog.custom,
                "reset",
                "button"
            )

        end
    )

    --------------------------------------------------------
    -- Books
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Books",
        function()

            ------------------------------------------------
            -- Use pfUI Style
            ------------------------------------------------

            CreateConfig(
                nil,
                "Use pfUI Style",
                pfUI_config.dqb.books,
                "use_pfui_style",
                "checkbox"
            )

            CreateConfig(
                nil,
                "pfUI Background Opacity",
                pfUI_config.dqb.books,
                "pfui_background_alpha",
                "slider"
            )

            CreateConfig(
                nil,
                "Reset to pfUI Default",
                pfUI_config.dqb.books,
                "reset_pfui",
                "button"
            )

            ------------------------------------------------
            -- Use Custom Style
            ------------------------------------------------

            CreateConfig(
                nil,
                "Use Custom Style",
                pfUI_config.dqb.books,
                "use_custom_style",
                "checkbox"
            )

            ------------------------------------------------
            -- Custom options
            ------------------------------------------------

            CreateConfig(
                nil,
                "Remove Blizzard Parchment Texture",
                pfUI_config.dqb.books.custom,
                "remove_parchment",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Background Color",
                pfUI_config.dqb.books.custom,
                "background_color",
                "color"
            )

            CreateConfig(
                nil,
                "Background Opacity",
                pfUI_config.dqb.books.custom,
                "background_alpha",
                "slider"
            )

            CreateConfig(
                nil,
                "Fonts",
                pfUI_config.dqb.books.custom,
                "font",
                "font"
            )

            CreateConfig(
                nil,
                "Title Color",
                pfUI_config.dqb.books.custom,
                "title_color",
                "color"
            )

            CreateConfig(
                nil,
                "Text Color",
                pfUI_config.dqb.books.custom,
                "text_color",
                "color"
            )

            CreateConfig(
                nil,
                "Reset Custom Values",
                pfUI_config.dqb.books.custom,
                "reset",
                "button"
            )

        end
    )
end

------------------------------------------------------------
-- Initialize GUI
------------------------------------------------------------

function DQB:InitializeGUI()
    self:CreateGUI()
end

------------------------------------------------------------
-- Wait for pfUI
------------------------------------------------------------

local event = CreateFrame("Frame")

event:RegisterEvent("ADDON_LOADED")

event:SetScript("OnEvent", function()

    if arg1 == "pfUI" then

        if DQB.InitializeConfig then
            DQB:InitializeConfig()
        end

        if DQB.CreateGUI then
            DQB:CreateGUI()
        end

        event:UnregisterEvent("ADDON_LOADED")
    end

end)

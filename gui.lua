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
-- Create DQB configuration menu
------------------------------------------------------------

function DQB:CreateGUI()

    --------------------------------------------------------
    -- Make sure pfUI GUI is available
    --------------------------------------------------------

    if not pfUI.gui then
        return
    end

    --------------------------------------------------------
    -- Make sure our configuration exists
    --------------------------------------------------------

    if self.InitializeConfig then
        self:InitializeConfig()
    end

    if not pfUI_config or not pfUI_config.dqb then
        return
    end

    --------------------------------------------------------
    -- pfUI GUI helpers
    --------------------------------------------------------

    local CreateConfig = pfUI.gui.CreateConfig
    local CreateGUIEntry = pfUI.gui.CreateGUIEntry

    if not CreateConfig or not CreateGUIEntry then
        return
    end


    --------------------------------------------------------
    -- GENERAL
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
    -- QUEST & GOSSIP
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Quest & Gossip",
        function()

            ------------------------------------------------
            -- Background
            ------------------------------------------------

            CreateConfig(
                nil,
                "Enable Background",
                pfUI_config.dqb.questgossip,
                "background_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Background Color",
                pfUI_config.dqb.questgossip,
                "background_color",
                "color"
            )

            CreateConfig(
                nil,
                "Background Opacity",
                pfUI_config.dqb.questgossip,
                "background_alpha",
                "text"
            )


            ------------------------------------------------
            -- Text
            ------------------------------------------------

            CreateConfig(
                nil,
                "Enable Text",
                pfUI_config.dqb.questgossip,
                "text_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Text Font",
                pfUI_config.dqb.questgossip,
                "text_font",
                "text"
            )

            CreateConfig(
                nil,
                "Text Size",
                pfUI_config.dqb.questgossip,
                "text_size",
                "text"
            )

            CreateConfig(
                nil,
                "Text Style",
                pfUI_config.dqb.questgossip,
                "text_style",
                "text"
            )

            CreateConfig(
                nil,
                "Text Color",
                pfUI_config.dqb.questgossip,
                "text_color",
                "color"
            )

        end
    )


    --------------------------------------------------------
    -- QUEST LOG
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Quest Log",
        function()

            ------------------------------------------------
            -- Background
            ------------------------------------------------

            CreateConfig(
                nil,
                "Enable Background",
                pfUI_config.dqb.questlog,
                "background_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Background Color",
                pfUI_config.dqb.questlog,
                "background_color",
                "color"
            )

            CreateConfig(
                nil,
                "Background Opacity",
                pfUI_config.dqb.questlog,
                "background_alpha",
                "text"
            )


            ------------------------------------------------
            -- Text
            ------------------------------------------------

            CreateConfig(
                nil,
                "Enable Text",
                pfUI_config.dqb.questlog,
                "text_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Text Font",
                pfUI_config.dqb.questlog,
                "text_font",
                "text"
            )

            CreateConfig(
                nil,
                "Text Size",
                pfUI_config.dqb.questlog,
                "text_size",
                "text"
            )

            CreateConfig(
                nil,
                "Text Style",
                pfUI_config.dqb.questlog,
                "text_style",
                "text"
            )

            CreateConfig(
                nil,
                "Text Color",
                pfUI_config.dqb.questlog,
                "text_color",
                "color"
            )

        end
    )


    --------------------------------------------------------
    -- BOOKS
    --------------------------------------------------------
    --
    -- "Books" corresponds to the original pfUI itemtext.lua
    -- functionality.
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Books",
        function()

            ------------------------------------------------
            -- Background
            ------------------------------------------------

            CreateConfig(
                nil,
                "Enable Background",
                pfUI_config.dqb.itemtext,
                "background_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Background Color",
                pfUI_config.dqb.itemtext,
                "background_color",
                "color"
            )

            CreateConfig(
                nil,
                "Background Opacity",
                pfUI_config.dqb.itemtext,
                "background_alpha",
                "text"
            )


            ------------------------------------------------
            -- Text
            ------------------------------------------------

            CreateConfig(
                nil,
                "Enable Text",
                pfUI_config.dqb.itemtext,
                "text_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Text Font",
                pfUI_config.dqb.itemtext,
                "text_font",
                "text"
            )

            CreateConfig(
                nil,
                "Text Size",
                pfUI_config.dqb.itemtext,
                "text_size",
                "text"
            )

            CreateConfig(
                nil,
                "Text Style",
                pfUI_config.dqb.itemtext,
                "text_style",
                "text"
            )

            CreateConfig(
                nil,
                "Text Color",
                pfUI_config.dqb.itemtext,
                "text_color",
                "color"
            )

        end
    )

end


------------------------------------------------------------
-- Compatibility with core.lua
------------------------------------------------------------
--
-- core.lua currently calls InitializeGUI().
-- Keep that name as a wrapper around CreateGUI().
------------------------------------------------------------

function DQB:InitializeGUI()
    self:CreateGUI()
end


------------------------------------------------------------
-- Initialize GUI after pfUI has loaded
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
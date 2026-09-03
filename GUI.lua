------------------------------------------------------------
-- pfUI-DQB
-- GUI
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


------------------------------------------------------------
-- Register DQB configuration GUI
------------------------------------------------------------

pfUI:RegisterModule("dqb_gui", function()

    --------------------------------------------------------
    -- Main DQB category
    --------------------------------------------------------

    CreateGUIEntry("DQB", nil, function()

        ----------------------------------------------------
        -- General
        ----------------------------------------------------

        CreateConfig(
            nil,
            "Enable DQB",
            C.dqb.general,
            "enable",
            "checkbox"
        )

    end)


    --------------------------------------------------------
    -- Quest & Gossip
    --------------------------------------------------------

    CreateGUIEntry("DQB", "Quest & Gossip", function()

        CreateConfig(
            nil,
            "Enable Background",
            C.dqb.questgossip,
            "background_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Background Color",
            C.dqb.questgossip,
            "background_color"
        )

        CreateConfig(
            nil,
            "Background Alpha",
            C.dqb.questgossip,
            "background_alpha"
        )

        CreateConfig(
            nil,
            "Enable Text",
            C.dqb.questgossip,
            "text_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Text Font",
            C.dqb.questgossip,
            "text_font"
        )

        CreateConfig(
            nil,
            "Text Size",
            C.dqb.questgossip,
            "text_size"
        )

        CreateConfig(
            nil,
            "Text Style",
            C.dqb.questgossip,
            "text_style"
        )

        CreateConfig(
            nil,
            "Text Color",
            C.dqb.questgossip,
            "text_color"
        )

    end)


    --------------------------------------------------------
    -- Quest Log
    --------------------------------------------------------

    CreateGUIEntry("DQB", "Quest Log", function()

        CreateConfig(
            nil,
            "Enable Background",
            C.dqb.questlog,
            "background_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Background Color",
            C.dqb.questlog,
            "background_color"
        )

        CreateConfig(
            nil,
            "Background Alpha",
            C.dqb.questlog,
            "background_alpha"
        )

        CreateConfig(
            nil,
            "Enable Text",
            C.dqb.questlog,
            "text_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Text Font",
            C.dqb.questlog,
            "text_font"
        )

        CreateConfig(
            nil,
            "Text Size",
            C.dqb.questlog,
            "text_size"
        )

        CreateConfig(
            nil,
            "Text Style",
            C.dqb.questlog,
            "text_style"
        )

        CreateConfig(
            nil,
            "Text Color",
            C.dqb.questlog,
            "text_color"
        )

    end)


    --------------------------------------------------------
    -- Item Text
    --------------------------------------------------------

    CreateGUIEntry("DQB", "Item Text", function()

        CreateConfig(
            nil,
            "Enable Background",
            C.dqb.itemtext,
            "background_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Background Color",
            C.dqb.itemtext,
            "background_color"
        )

        CreateConfig(
            nil,
            "Background Alpha",
            C.dqb.itemtext,
            "background_alpha"
        )

        CreateConfig(
            nil,
            "Enable Text",
            C.dqb.itemtext,
            "text_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Text Font",
            C.dqb.itemtext,
            "text_font"
        )

        CreateConfig(
            nil,
            "Text Size",
            C.dqb.itemtext,
            "text_size"
        )

        CreateConfig(
            nil,
            "Text Style",
            C.dqb.itemtext,
            "text_style"
        )

        CreateConfig(
            nil,
            "Text Color",
            C.dqb.itemtext,
            "text_color"
        )

    end)


    --------------------------------------------------------
    -- Merchant
    --------------------------------------------------------

    CreateGUIEntry("DQB", "Merchant", function()

        CreateConfig(
            nil,
            "Enable Background",
            C.dqb.merchant,
            "background_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Background Color",
            C.dqb.merchant,
            "background_color"
        )

        CreateConfig(
            nil,
            "Background Alpha",
            C.dqb.merchant,
            "background_alpha"
        )

        CreateConfig(
            nil,
            "Enable Text",
            C.dqb.merchant,
            "text_global",
            "checkbox"
        )

        CreateConfig(
            nil,
            "Text Font",
            C.dqb.merchant,
            "text_font"
        )

        CreateConfig(
            nil,
            "Text Size",
            C.dqb.merchant,
            "text_size"
        )

        CreateConfig(
            nil,
            "Text Style",
            C.dqb.merchant,
            "text_style"
        )

        CreateConfig(
            nil,
            "Text Color",
            C.dqb.merchant,
            "text_color"
        )

    end)

end)
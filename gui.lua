```lua
------------------------------------------------------------
-- pfUI-DQB
-- GUI.lua
--
-- Registers the DQB configuration inside pfUI's GUI.
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


------------------------------------------------------------
-- Create DQB configuration menu
------------------------------------------------------------

function DQB:CreateGUI()

    -- Make sure our configuration exists
    if self.InitializeConfig then
        self:InitializeConfig()
    end

    if not pfUI_config or not pfUI_config.dqb then
        return
    end

    --------------------------------------------------------
    -- Register DQB category
    --------------------------------------------------------

    pfUI:RegisterConfig(
        "DQB",
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
            -- Quest & Gossip
            ------------------------------------------------

            CreateConfig(
                nil,
                "Quest & Gossip",
                nil,
                nil,
                "header"
            )

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


            ------------------------------------------------
            -- Quest Log
            ------------------------------------------------

            CreateConfig(
                nil,
                "Quest Log",
                nil,
                nil,
                "header"
            )

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


            ------------------------------------------------
            -- Item Text
            ------------------------------------------------

            CreateConfig(
                nil,
                "Item Text",
                nil,
                nil,
                "header"
            )

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


            ------------------------------------------------
            -- Merchant
            ------------------------------------------------

            CreateConfig(
                nil,
                "Merchant",
                nil,
                nil,
                "header"
            )

            CreateConfig(
                nil,
                "Enable Background",
                pfUI_config.dqb.merchant,
                "background_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Background Color",
                pfUI_config.dqb.merchant,
                "background_color",
                "color"
            )

            CreateConfig(
                nil,
                "Background Opacity",
                pfUI_config.dqb.merchant,
                "background_alpha",
                "text"
            )

            CreateConfig(
                nil,
                "Enable Text",
                pfUI_config.dqb.merchant,
                "text_global",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Text Font",
                pfUI_config.dqb.merchant,
                "text_font",
                "text"
            )

            CreateConfig(
                nil,
                "Text Size",
                pfUI_config.dqb.merchant,
                "text_size",
                "text"
            )

            CreateConfig(
                nil,
                "Text Style",
                pfUI_config.dqb.merchant,
                "text_style",
                "text"
            )

            CreateConfig(
                nil,
                "Text Color",
                pfUI_config.dqb.merchant,
                "text_color",
                "color"
            )

        end
    )
end


------------------------------------------------------------
-- Initialize GUI after pfUI has loaded
------------------------------------------------------------

local event = CreateFrame("Frame")

event:RegisterEvent("ADDON_LOADED")

event:SetScript("OnEvent", function()
    if arg1 == "pfUI" then

        if DQB.CreateGUI then
            DQB:CreateGUI()
        end

        event:UnregisterEvent("ADDON_LOADED")
    end
end)
```

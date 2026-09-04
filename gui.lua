-- pfUI-DQB
-- gui.lua
-- Registers DQB configuration inside pfUI's GUI.
local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end

-- Create DQB configuration menu
function DQB:CreateGUI()
    
    -- Make sure pfUI GUI is available
    if not pfUI.gui then
        return
    end
    
    -- Makes sure that the configuration exists
    if self.InitializeConfig then
        self:InitializeConfig()
    end

    if not pfUI_config or not pfUI_config.dqb then
        return
    end
    
    -- pfUI GUI helpers
    local CreateConfig = pfUI.gui.CreateConfig
    local CreateGUIEntry = pfUI.gui.CreateGUIEntry

    if not CreateConfig or not CreateGUIEntry then
        return
    end
    
    -- CUSTOM OPACITY SLIDER    
    -- pfUI's CreateConfig does not provide a slider widget.
    -- Therefore it has to create the normal pfUI configuration row
    -- first and replace its EditBox with the Slider.
    -- This keeps the exact same positioning/layout used by
    -- the rest of pfUI's GUI.    
    local function CreateOpacitySlider(caption, category, config)
        
        -- Create the normal pfUI config row.
        local frame = CreateConfig(
            nil,
            caption,
            category,
            config,
            "text"
        )

        if not frame then
            return
        end
        
        -- Hide the normal text input.
        if frame.input then
            frame.input:Hide()
        end
        
        -- Create slider.
        local slider = CreateFrame(
            "Slider",
            nil,
            frame
        )

        slider:SetWidth(180)
        slider:SetHeight(10)

        slider:SetOrientation("HORIZONTAL")

        slider:SetMinMaxValues(0, 1)
        
        -- Set the thumb texture        
        if pfUI.media and pfUI.media["img:col"] then
            slider:SetThumbTexture(
                pfUI.media["img:col"]
            )
        end
        
        -- Position slider.
        slider:SetPoint(
            "RIGHT",
            frame,
            "RIGHT",
            -38,
            0
        )
        
        -- Try to apply pfUI slider skin.        
        -- SkinSlider expects a valid thumb texture.
        -- If anything is unavailable it will simply keep the
        -- normal slider instead of generating an error.
        if pfUI.api and pfUI.api.SkinSlider then
            local thumb = slider:GetThumbTexture()

            if thumb then
                pfUI.api.SkinSlider(slider)
            end
        end
        
        -- Current value.
        local value = tonumber(category[config])

        if not value then
            value = 0.85
        end

        if value < 0 then
            value = 0
        elseif value > 1 then
            value = 1
        end

        slider:SetValue(value)
        
        -- Value text.
        local valueText = frame:CreateFontString(
            nil,
            "OVERLAY"
        )

        valueText:SetFont(
            pfUI.font_default,
            pfUI_config.global.font_size - 1,
            "OUTLINE"
        )

        valueText:SetJustifyH("RIGHT")

        valueText:SetWidth(34)

        valueText:SetPoint(
            "RIGHT",
            frame,
            "RIGHT",
            0,
            0
        )

        valueText:SetText(
            math.floor(value * 100 + 0.5) .. "%"
        )
        
        -- Slider value changed.
        slider:SetScript(
            "OnValueChanged",
            function()

                local raw = this:GetValue()
                
                -- Round to 5%.
                -- Testing with 0.5 first, changing to 0.1 for more precise control later, maybe.
                local newValue =
                    math.floor(raw * 20 + 0.5) / 20

                if newValue < 0 then
                    newValue = 0
                elseif newValue > 1 then
                    newValue = 1
                end
                
                -- Prevent unnecessary recursion.
                if math.abs(raw - newValue) > 0.001 then

                    this:SetValue(newValue)

                    return
                end
                
                -- Save value.
                category[config] = string.format(
                    "%.2f",
                    newValue
                )
                
                -- Update visible percentage.
                -- if later changed the round value to 0.1 also change this
                if valueText then
                    valueText:SetText(
                        math.floor(newValue * 100 + 0.5)
                        .. "%"
                    )
                end
                
                -- Tell pfUI that configuration changed.
                if pfUI.events
                    and pfUI.events.TriggerEvent then

                    pfUI.events:TriggerEvent(
                        "config:changed",
                        category,
                        config
                    )

                else

                    pfUI.gui.settingChanged = true

                end

            end
        )
        
        -- Mouse wheel support.
        -- If round value changed to 0.1 also change this for the mousewheel
        slider:EnableMouseWheel(true)

        slider:SetScript(
            "OnMouseWheel",
            function()

                local current = this:GetValue()

                local step = 0.05

                if arg1 > 0 then
                    current = current + step
                else
                    current = current - step
                end

                if current < 0 then
                    current = 0
                elseif current > 1 then
                    current = 1
                end

                this:SetValue(current)

            end
        )
        
        -- Store references
        frame.input = slider
        frame.value = valueText

        return frame

    end
    
    -- GENERAL
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
    
    -- QUEST & GOSSIP
    CreateGUIEntry(
        "DQB",
        "Quest & Gossip",
        function()
            
            -- PRESETS
            -- PARA ALTERAR HOJE COMO VAI SER FEITO O GUI PARA IMPLEMENTAÇÃO DO NOVO ESTILO (ESTA PARTE + FIXFONTS
            -- A TRABALHAR EM CONJUNTO, APENAS 1 OPÇÃO.)
            CreateConfig(
                nil,
                "Remove Blizzard Skin and apply pfUI Style",
                pfUI_config.dqb.questgossip,
                "pfui_style",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Fix Fonts",
                pfUI_config.dqb.questgossip,
                "fix_fonts",
                "checkbox"
            )
            
            -- CUSTOM
            -- ALTERAR HOJE O COMPORTAMENTO ENTRE pfUI Style E Custom. ADD GREYOUT OPTIONS; ADD REVERT BACK TO DEFAULTS
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

            CreateOpacitySlider(
                "Background Opacity",
                pfUI_config.dqb.questgossip.custom,
                "background_alpha"
            )
            
            -- USE PFUI FONT DROPDOWN
            -- INCLUÍDO NO CUSTOM; PARA ALTERAR.
            CreateConfig(
                nil,
                "Fonts",
                pfUI_config.dqb.questgossip.custom,
                "font",
                "dropdown",
                pfUI.gui.dropdowns.fonts
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

        end
    )
    
    -- QUEST LOG
    CreateGUIEntry(
        "DQB",
        "Quest Log",
        function()
            
            -- PRESETS
            -- O MESMO DO QUE O QUEST & GOSSIP.
            CreateConfig(
                nil,
                "Remove Blizzard Skin and apply pfUI Style",
                pfUI_config.dqb.questlog,
                "pfui_style",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Fix Fonts",
                pfUI_config.dqb.questlog,
                "fix_fonts",
                "checkbox"
            )
            
            -- CUSTOM
            -- O MESMO DO QUE O QUEST & GOSSIP.
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

            CreateOpacitySlider(
                "Background Opacity",
                pfUI_config.dqb.questlog.custom,
                "background_alpha"
            )
            
            -- USE PFUI FONT DROPDOWN
            -- O MESMO DO QUE O QUEST & GOSSIP.
            CreateConfig(
                nil,
                "Fonts",
                pfUI_config.dqb.questlog.custom,
                "font",
                "dropdown",
                pfUI.gui.dropdowns.fonts
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

        end
    )
    
    -- BOOKS    
    -- Books corresponds to the original brues's pfUI itemtext.lua.
    CreateGUIEntry(
        "DQB",
        "Books",
        function()
            
            -- PRESETS
            -- O MESMO DO QUE O QUEST & GOSSIP.
            CreateConfig(
                nil,
                "Remove Blizzard Skin and apply pfUI Style",
                pfUI_config.dqb.books,
                "pfui_style",
                "checkbox"
            )

            CreateConfig(
                nil,
                "Fix Fonts",
                pfUI_config.dqb.books,
                "fix_fonts",
                "checkbox"
            )
            
            -- CUSTOM
            -- O MESMO DO QUE O QUEST & GOSSIP.
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

            CreateOpacitySlider(
                "Background Opacity",
                pfUI_config.dqb.books.custom,
                "background_alpha"
            )
            
            -- USE PFUI FONT DROPDOWN
            -- O MESMO DO QUE O QUEST & GOSSIP.
            CreateConfig(
                nil,
                "Fonts",
                pfUI_config.dqb.books.custom,
                "font",
                "dropdown",
                pfUI.gui.dropdowns.fonts
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

        end
    )
    
    -- MERCHANT    
    -- Intentionally not configured yet.
    -- Don't think Merchant is need to be customized with DQB, in case of, it will be here.
end

-- Compatibility with core.lua
function DQB:InitializeGUI()
    self:CreateGUI()
end

-- Initialize GUI after pfUI has loaded
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

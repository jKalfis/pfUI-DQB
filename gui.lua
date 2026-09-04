-- pfUI-DQB
-- gui.lua
--
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

    -- Make sure our configuration exists
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


    --------------------------------------------------------
    -- CUSTOM OPACITY SLIDER
    --------------------------------------------------------
    --
    -- pfUI's CreateConfig does not provide a slider widget.
    -- We create the normal pfUI configuration row first
    -- and replace its EditBox with our own Slider.
    --
    -- This is the same working slider implementation
    -- already used by DQB.
    --------------------------------------------------------

    local function CreateOpacitySlider(caption, category, config)

        ----------------------------------------------------
        -- Create the normal pfUI config row.
        ----------------------------------------------------

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

        ----------------------------------------------------
        -- Hide the normal text input.
        ----------------------------------------------------

        if frame.input then
            frame.input:Hide()
        end


        ----------------------------------------------------
        -- Create slider.
        ----------------------------------------------------

        local slider = CreateFrame(
            "Slider",
            nil,
            frame
        )

        slider:SetWidth(180)
        slider:SetHeight(10)

        slider:SetOrientation("HORIZONTAL")

        slider:SetMinMaxValues(0, 1)


        ----------------------------------------------------
        -- Thumb texture
        ----------------------------------------------------

        if pfUI.media and pfUI.media["img:col"] then

            slider:SetThumbTexture(
                pfUI.media["img:col"]
            )

        end


        ----------------------------------------------------
        -- Position slider.
        ----------------------------------------------------

        slider:SetPoint(
            "RIGHT",
            frame,
            "RIGHT",
            -38,
            0
        )


        ----------------------------------------------------
        -- Try to apply pfUI slider skin.
        ----------------------------------------------------

        if pfUI.api and pfUI.api.SkinSlider then

            local thumb = slider:GetThumbTexture()

            if thumb then
                pfUI.api.SkinSlider(slider)
            end

        end


        ----------------------------------------------------
        -- Current value.
        ----------------------------------------------------

        local value = tonumber(category[config])

        if not value then
            value = 0.75
        end

        if value < 0 then
            value = 0
        elseif value > 1 then
            value = 1
        end

        slider:SetValue(value)


        ----------------------------------------------------
        -- Value text.
        ----------------------------------------------------

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


        ----------------------------------------------------
        -- Slider value changed.
        ----------------------------------------------------

        slider:SetScript(
            "OnValueChanged",
            function()

                local raw = this:GetValue()

                ------------------------------------------------
                -- Round to 5%.
                ------------------------------------------------

                local newValue =
                    math.floor(raw * 20 + 0.5) / 20

                if newValue < 0 then
                    newValue = 0
                elseif newValue > 1 then
                    newValue = 1
                end


                ------------------------------------------------
                -- Prevent unnecessary recursion.
                ------------------------------------------------

                if math.abs(raw - newValue) > 0.001 then

                    this:SetValue(newValue)

                    return

                end


                ------------------------------------------------
                -- Save value.
                ------------------------------------------------

                category[config] = string.format(
                    "%.2f",
                    newValue
                )


                ------------------------------------------------
                -- Update visible percentage.
                ------------------------------------------------

                if valueText then

                    valueText:SetText(
                        math.floor(newValue * 100 + 0.5)
                        .. "%"
                    )

                end


                ------------------------------------------------
                -- Tell pfUI that configuration changed.
                ------------------------------------------------

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


        ----------------------------------------------------
        -- Mouse wheel support.
        ----------------------------------------------------

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


        ----------------------------------------------------
        -- Store references.
        ----------------------------------------------------

        frame.input = slider
        frame.value = valueText

        return frame

    end


    --------------------------------------------------------
    -- DEPENDENCY HELPERS
    --------------------------------------------------------

    local function SetFrameEnabled(frame, enabled)

        if not frame then
            return
        end


        ----------------------------------------------------
        -- Main input.
        ----------------------------------------------------

        if frame.input then

            if enabled then
                frame.input:Enable()
            else
                frame.input:Disable()
            end

        end


        ----------------------------------------------------
        -- Color picker.
        ----------------------------------------------------

        if frame.color then

            if enabled then
                frame.color:Enable()
            else
                frame.color:Disable()
            end

        end


        ----------------------------------------------------
        -- Button.
        ----------------------------------------------------

        if frame.button then

            if enabled then
                frame.button:Enable()
            else
                frame.button:Disable()
            end

        end


        ----------------------------------------------------
        -- Caption.
        ----------------------------------------------------

        if frame.caption then

            if enabled then

                frame.caption:SetTextColor(
                    1, 1, 1, 1
                )

            else

                frame.caption:SetTextColor(
                    0.5, 0.5, 0.5, 1
                )

            end

        end


        ----------------------------------------------------
        -- Slider value.
        ----------------------------------------------------

        if frame.value then

            if enabled then

                frame.value:SetTextColor(
                    1, 1, 1, 1
                )

            else

                frame.value:SetTextColor(
                    0.5, 0.5, 0.5, 1
                )

            end

        end

    end


    --------------------------------------------------------
    -- Find the main clickable input of a config frame.
    --------------------------------------------------------

    local function GetConfigInput(frame)

        if not frame then
            return nil
        end

        if frame.input then
            return frame.input
        end

        if frame.color then
            return frame.color
        end

        if frame.button then
            return frame.button
        end

        return nil

    end


    --------------------------------------------------------
    -- Reset PFUI STYLE
    --------------------------------------------------------

    local function ResetPFUIStyle(module)

        if not module then
            return
        end

        ----------------------------------------------------
        -- Get current pfUI global alpha.
        ----------------------------------------------------

        local value = nil

        if pfUI_config
            and pfUI_config.global
            and pfUI_config.global.background_alpha ~= nil then

            value = tostring(
                pfUI_config.global.background_alpha
            )

        end

        if not value then
            value = "0.75"
        end


        ----------------------------------------------------
        -- Save.
        ----------------------------------------------------

        module.pfui_background_alpha = value


        ----------------------------------------------------
        -- Notify DQB / pfUI.
        ----------------------------------------------------

        if pfUI.events
            and pfUI.events.TriggerEvent then

            pfUI.events:TriggerEvent(
                "config:changed",
                module,
                "pfui_background_alpha"
            )

        else

            pfUI.gui.settingChanged = true

        end

    end


    --------------------------------------------------------
    -- RESET CUSTOM STYLE
    --------------------------------------------------------

    local function ResetCustomStyle(module)

        if not module then
            return
        end

        if not module.custom then
            module.custom = {}
        end

        local custom = module.custom


        ----------------------------------------------------
        -- Parchment
        ----------------------------------------------------

        custom.remove_parchment = "1"


        ----------------------------------------------------
        -- Background color
        ----------------------------------------------------

        if pfUI_config
            and pfUI_config.global
            and pfUI_config.global.background_color then

            custom.background_color =
                pfUI_config.global.background_color

        else

            custom.background_color =
                "0,0,0,1"

        end


        ----------------------------------------------------
        -- Background opacity
        ----------------------------------------------------

        if pfUI_config
            and pfUI_config.global
            and pfUI_config.global.background_alpha ~= nil then

            custom.background_alpha =
                tostring(
                    pfUI_config.global.background_alpha
                )

        else

            custom.background_alpha =
                "0.75"

        end


        ----------------------------------------------------
        -- Font
        ----------------------------------------------------

        if pfUI.font_default then

            custom.font =
                pfUI.font_default

        elseif pfUI_config
            and pfUI_config.global
            and pfUI_config.global.font_default then

            custom.font =
                pfUI_config.global.font_default

        else

            custom.font =
                "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"

        end


        ----------------------------------------------------
        -- Title color
        ----------------------------------------------------

        custom.title_color =
            "1,0.82,0,1"


        ----------------------------------------------------
        -- Text color
        ----------------------------------------------------

        custom.text_color =
            "1,1,1,1"


        ----------------------------------------------------
        -- Notify.
        ----------------------------------------------------

        if pfUI.events
            and pfUI.events.TriggerEvent then

            pfUI.events:TriggerEvent(
                "config:changed",
                custom,
                "remove_parchment"
            )

            pfUI.events:TriggerEvent(
                "config:changed",
                custom,
                "background_color"
            )

            pfUI.events:TriggerEvent(
                "config:changed",
                custom,
                "background_alpha"
            )

            pfUI.events:TriggerEvent(
                "config:changed",
                custom,
                "font"
            )

            pfUI.events:TriggerEvent(
                "config:changed",
                custom,
                "title_color"
            )

            pfUI.events:TriggerEvent(
                "config:changed",
                custom,
                "text_color"
            )

        else

            pfUI.gui.settingChanged = true

        end

    end


    --------------------------------------------------------
    -- UPDATE MODULE DEPENDENCIES
    --------------------------------------------------------

    local function UpdateModuleState(module, refs)

        if not module or not refs then
            return
        end


        ----------------------------------------------------
        -- Current state.
        ----------------------------------------------------

        local usePFUI =
            module.use_pfui_style == "1"

        local useCustom =
            module.use_custom_style == "1"


        ----------------------------------------------------
        -- PFUI STYLE
        ----------------------------------------------------

        SetFrameEnabled(
            refs.pfuiAlpha,
            usePFUI
        )

        SetFrameEnabled(
            refs.resetPFUI,
            usePFUI
        )


        ----------------------------------------------------
        -- CUSTOM STYLE
        ----------------------------------------------------

        SetFrameEnabled(
            refs.custom.parchment,
            useCustom
        )

        SetFrameEnabled(
            refs.custom.backgroundColor,
            useCustom
        )

        SetFrameEnabled(
            refs.custom.backgroundAlpha,
            useCustom
        )

        SetFrameEnabled(
            refs.custom.font,
            useCustom
        )

        SetFrameEnabled(
            refs.custom.titleColor,
            useCustom
        )

        SetFrameEnabled(
            refs.custom.textColor,
            useCustom
        )

        SetFrameEnabled(
            refs.custom.reset,
            useCustom
        )

    end


    --------------------------------------------------------
    -- CREATE ONE MODULE CONFIGURATION
    --------------------------------------------------------

    local function CreateModuleConfig(
        module,
        CreateConfig
    )

        local refs = {
            custom = {}
        }


        ----------------------------------------------------
        -- USE PFUI STYLE
        ----------------------------------------------------

        refs.usePFUI = CreateConfig(
            nil,
            "Use pfUI Style",
            module,
            "use_pfui_style",
            "checkbox"
        )


        ----------------------------------------------------
        -- PFUI BACKGROUND OPACITY
        ----------------------------------------------------

        refs.pfuiAlpha = CreateOpacitySlider(
            "pfUI Background Opacity",
            module,
            "pfui_background_alpha"
        )


        ----------------------------------------------------
        -- RESET PFUI DEFAULT
        ----------------------------------------------------

        refs.resetPFUI = CreateConfig(
            nil,
            "Reset to pfUI Default",
            module,
            "reset_pfui",
            "button",
            function()

                ResetPFUIStyle(module)

                if refs.pfuiAlpha
                    and refs.pfuiAlpha.input then

                    local value =
                        tonumber(
                            module.pfui_background_alpha
                        )

                    if value then
                        refs.pfuiAlpha.input:SetValue(
                            value
                        )
                    end

                end

            end
        )


        ----------------------------------------------------
        -- USE CUSTOM STYLE
        ----------------------------------------------------

        refs.useCustom = CreateConfig(
            nil,
            "Use Custom Style",
            module,
            "use_custom_style",
            "checkbox"
        )


        ----------------------------------------------------
        -- CUSTOM:
        -- Remove Blizzard Parchment Texture
        ----------------------------------------------------

        refs.custom.parchment = CreateConfig(
            nil,
            "Remove Blizzard Parchment Texture",
            module.custom,
            "remove_parchment",
            "checkbox"
        )


        ----------------------------------------------------
        -- CUSTOM:
        -- Background Color
        ----------------------------------------------------

        refs.custom.backgroundColor = CreateConfig(
            nil,
            "Background Color",
            module.custom,
            "background_color",
            "color"
        )


        ----------------------------------------------------
        -- CUSTOM:
        -- Background Opacity
        ----------------------------------------------------

        refs.custom.backgroundAlpha =
            CreateOpacitySlider(
                "Background Opacity",
                module.custom,
                "background_alpha"
            )


        ----------------------------------------------------
        -- CUSTOM:
        -- Fonts
        ----------------------------------------------------

        refs.custom.font = CreateConfig(
            nil,
            "Fonts",
            module.custom,
            "font",
            "dropdown",
            pfUI.gui.dropdowns.fonts
        )


        ----------------------------------------------------
        -- CUSTOM:
        -- Title Color
        ----------------------------------------------------

        refs.custom.titleColor = CreateConfig(
            nil,
            "Title Color",
            module.custom,
            "title_color",
            "color"
        )


        ----------------------------------------------------
        -- CUSTOM:
        -- Text Color
        ----------------------------------------------------

        refs.custom.textColor = CreateConfig(
            nil,
            "Text Color",
            module.custom,
            "text_color",
            "color"
        )


        ----------------------------------------------------
        -- RESET CUSTOM VALUES
        ----------------------------------------------------

        refs.custom.reset = CreateConfig(
            nil,
            "Reset Custom Values",
            module.custom,
            "reset",
            "button",
            function()

                ResetCustomStyle(module)

            end
        )


        ----------------------------------------------------
        -- Initial state.
        ----------------------------------------------------

        UpdateModuleState(
            module,
            refs
        )


        ----------------------------------------------------
        -- Configuration changed callback.
        --
        -- We use pfUI's config:changed event so that the
        -- greyout state is refreshed whenever either
        -- checkbox changes.
        ----------------------------------------------------

        if pfUI.events
            and pfUI.events.RegisterCallback then

            pfUI.events:RegisterCallback(
                "config:changed",
                function(category, config)

                    if category ~= module then
                        return
                    end


                    if config == "use_pfui_style" then

                        if module.use_pfui_style == "1" then

                            module.use_custom_style = "0"

                        end

                        UpdateModuleState(
                            module,
                            refs
                        )

                    elseif config == "use_custom_style" then

                        if module.use_custom_style == "1" then

                            module.use_pfui_style = "0"

                        end

                        UpdateModuleState(
                            module,
                            refs
                        )

                    end

                end
            )

        end

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

            CreateModuleConfig(
                pfUI_config.dqb.questgossip,
                CreateConfig
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

            CreateModuleConfig(
                pfUI_config.dqb.questlog,
                CreateConfig
            )

        end
    )


    --------------------------------------------------------
    -- BOOKS
    --------------------------------------------------------
    --
    -- Books corresponds to the original pfUI itemtext.lua.
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Books",
        function()

            CreateModuleConfig(
                pfUI_config.dqb.books,
                CreateConfig
            )

        end
    )


    --------------------------------------------------------
    -- MERCHANT
    --------------------------------------------------------
    --
    -- Intentionally not configured yet.
    --------------------------------------------------------

end


------------------------------------------------------------
-- Compatibility with core.lua
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

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
    -- Set text enabled / disabled appearance
    --------------------------------------------------------

    local function SetTextEnabled(text, enabled)

        if not text then
            return
        end

        if enabled then

            text:SetTextColor(
                1, 1, 1, 1
            )

        else

            text:SetTextColor(
                0.5, 0.5, 0.5, 1
            )

        end

    end


    --------------------------------------------------------
    -- Enable / disable configuration row
    --
    -- Different pfUI controls use different objects:
    --
    -- checkbox / button:
    --     Enable() / Disable()
    --
    -- slider:
    --     EnableMouse()
    --
    -- color:
    --     EnableMouse() or Enable()/Disable()
    --
    --------------------------------------------------------

    local function SetFrameEnabled(frame, enabled)

        if not frame then
            return
        end


        ----------------------------------------------------
        -- Main input
        ----------------------------------------------------

        if frame.input then

            local input = frame.input

            if type(input.Enable) == "function"
            and type(input.Disable) == "function" then

                if enabled then
                    input:Enable()
                else
                    input:Disable()
                end

            elseif type(input.EnableMouse) == "function" then

                input:EnableMouse(enabled)

            end

        end


        ----------------------------------------------------
        -- Color picker
        ----------------------------------------------------

        if frame.color then

            local color = frame.color

            if type(color.Enable) == "function"
            and type(color.Disable) == "function" then

                if enabled then
                    color:Enable()
                else
                    color:Disable()
                end

            elseif type(color.EnableMouse) == "function" then

                color:EnableMouse(enabled)

            end

        end


        ----------------------------------------------------
        -- Button
        ----------------------------------------------------

        if frame.button then

            local button = frame.button

            if type(button.Enable) == "function"
            and type(button.Disable) == "function" then

                if enabled then
                    button:Enable()
                else
                    button:Disable()
                end

            elseif type(button.EnableMouse) == "function" then

                button:EnableMouse(enabled)

            end

        end


        ----------------------------------------------------
        -- Grey out the complete row
        ----------------------------------------------------

        if frame.SetAlpha then

            if enabled then
                frame:SetAlpha(1)
            else
                frame:SetAlpha(0.5)
            end

        end


        ----------------------------------------------------
        -- Caption
        ----------------------------------------------------

        SetTextEnabled(
            frame.caption,
            enabled
        )


        ----------------------------------------------------
        -- Slider value
        ----------------------------------------------------

        SetTextEnabled(
            frame.value,
            enabled
        )

    end


    --------------------------------------------------------
    -- Create opacity slider
    --
    -- pfUI CreateConfig does not provide the slider we need,
    -- so we create the normal configuration row and replace
    -- its text input with a real Slider.
    --------------------------------------------------------

    local function CreateOpacitySlider(
        caption,
        category,
        config
    )

        ----------------------------------------------------
        -- Create normal pfUI row
        ----------------------------------------------------

        local frame = CreateConfig(
            nil,
            caption,
            category,
            config,
            "text"
        )

        if not frame then
            return nil
        end


        ----------------------------------------------------
        -- Hide normal EditBox
        ----------------------------------------------------

        if frame.input then
            frame.input:Hide()
        end


        ----------------------------------------------------
        -- Create slider
        ----------------------------------------------------

        local slider = CreateFrame(
            "Slider",
            nil,
            frame
        )

        slider:SetWidth(180)
        slider:SetHeight(10)

        slider:SetOrientation(
            "HORIZONTAL"
        )

        slider:SetMinMaxValues(
            0,
            1
        )


        ----------------------------------------------------
        -- Slider thumb
        ----------------------------------------------------

        if pfUI.media
        and pfUI.media["img:col"] then

            slider:SetThumbTexture(
                pfUI.media["img:col"]
            )

        end


        ----------------------------------------------------
        -- Slider position
        ----------------------------------------------------

        slider:SetPoint(
            "RIGHT",
            frame,
            "RIGHT",
            -38,
            0
        )


        ----------------------------------------------------
        -- Apply pfUI slider skin
        ----------------------------------------------------

        if pfUI.api
        and pfUI.api.SkinSlider then

            local thumb =
                slider:GetThumbTexture()

            if thumb then
                pfUI.api.SkinSlider(slider)
            end

        end


        ----------------------------------------------------
        -- Get current value
        ----------------------------------------------------

        local value =
            tonumber(category[config])

        if not value then
            value = 0.75
        end

        if value < 0 then
            value = 0
        elseif value > 1 then
            value = 1
        end


        ----------------------------------------------------
        -- Set initial slider value
        ----------------------------------------------------

        slider:SetValue(value)


        ----------------------------------------------------
        -- Value text
        ----------------------------------------------------

        local valueText =
            frame:CreateFontString(
                nil,
                "OVERLAY"
            )

        valueText:SetFont(
            pfUI.font_default,
            pfUI_config.global.font_size - 1,
            "OUTLINE"
        )

        valueText:SetJustifyH(
            "RIGHT"
        )

        valueText:SetWidth(34)

        valueText:SetPoint(
            "RIGHT",
            frame,
            "RIGHT",
            0,
            0
        )

        valueText:SetText(
            math.floor(value * 100 + 0.5)
            .. "%"
        )


        ----------------------------------------------------
        -- Slider value changed
        ----------------------------------------------------

        slider:SetScript(
            "OnValueChanged",
            function()

                local raw =
                    this:GetValue()

                ------------------------------------------------
                -- Round to 5%
                ------------------------------------------------

                local newValue =
                    math.floor(
                        raw * 20 + 0.5
                    ) / 20

                if newValue < 0 then
                    newValue = 0
                elseif newValue > 1 then
                    newValue = 1
                end


                ------------------------------------------------
                -- Prevent recursion
                ------------------------------------------------

                if math.abs(
                    raw - newValue
                ) > 0.001 then

                    this:SetValue(
                        newValue
                    )

                    return
                end


                ------------------------------------------------
                -- Save value
                ------------------------------------------------

                category[config] =
                    string.format(
                        "%.2f",
                        newValue
                    )


                ------------------------------------------------
                -- Update visible percentage
                ------------------------------------------------

                if valueText then

                    valueText:SetText(
                        math.floor(
                            newValue * 100 + 0.5
                        )
                        .. "%"
                    )

                end


                ------------------------------------------------
                -- Tell pfUI configuration changed
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
        -- Mouse wheel
        ----------------------------------------------------

        slider:EnableMouseWheel(
            true
        )

        slider:SetScript(
            "OnMouseWheel",
            function()

                local current =
                    this:GetValue()

                if arg1 > 0 then

                    current =
                        current + 0.05

                else

                    current =
                        current - 0.05

                end

                if current < 0 then
                    current = 0
                elseif current > 1 then
                    current = 1
                end

                this:SetValue(
                    current
                )

            end
        )


        ----------------------------------------------------
        -- Store references
        ----------------------------------------------------

        frame.input = slider
        frame.value = valueText

        return frame

    end


    --------------------------------------------------------
    -- Reset pfUI style
    --------------------------------------------------------

    local function ResetPFUIStyle(
        module,
        refs
    )

        if not module then
            return
        end

        local value = nil


        ----------------------------------------------------
        -- Get pfUI global background alpha
        ----------------------------------------------------

        if pfUI_config
        and pfUI_config.global
        and pfUI_config.global.background_alpha
            ~= nil then

            value =
                tostring(
                    pfUI_config.global.background_alpha
                )

        end


        ----------------------------------------------------
        -- Fallback
        ----------------------------------------------------

        if not value then
            value = "0.75"
        end


        ----------------------------------------------------
        -- Save
        ----------------------------------------------------

        module.pfui_background_alpha =
            value


        ----------------------------------------------------
        -- Update slider
        ----------------------------------------------------

        if refs
        and refs.pfuiAlpha
        and refs.pfuiAlpha.input then

            local number =
                tonumber(value)

            if number then

                refs.pfuiAlpha.input:SetValue(
                    number
                )

            end

        end


        ----------------------------------------------------
        -- Mark configuration changed
        ----------------------------------------------------

        if pfUI.gui then
            pfUI.gui.settingChanged = true
        end

    end


    --------------------------------------------------------
    -- Reset custom values
    --------------------------------------------------------

    local function ResetCustomStyle(
        module,
        refs
    )

        if not module then
            return
        end

        if not module.custom then
            module.custom = {}
        end

        local custom =
            module.custom


        ----------------------------------------------------
        -- Remove parchment
        ----------------------------------------------------

        custom.remove_parchment =
            "1"


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
        and pfUI_config.global.background_alpha
            ~= nil then

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
        -- DQB visual defaults
        ----------------------------------------------------

        custom.title_color =
            "1,0.82,0,1"

        custom.text_color =
            "1,1,1,1"


        ----------------------------------------------------
        -- Update custom opacity slider
        ----------------------------------------------------

        if refs
        and refs.custom
        and refs.custom.backgroundAlpha
        and refs.custom.backgroundAlpha.input then

            local number =
                tonumber(
                    custom.background_alpha
                )

            if number then

                refs.custom.backgroundAlpha.input:SetValue(
                    number
                )

            end

        end


        ----------------------------------------------------
        -- Mark configuration changed
        ----------------------------------------------------

        if pfUI.gui then
            pfUI.gui.settingChanged = true
        end

    end


    --------------------------------------------------------
    -- Update module state
    --------------------------------------------------------

    local function UpdateModuleState(
        module,
        refs
    )

        if not module
        or not refs then
            return
        end


        ----------------------------------------------------
        -- Current state
        ----------------------------------------------------

        local usePFUI =
            module.use_pfui_style == "1"

        local useCustom =
            module.use_custom_style == "1"


        ----------------------------------------------------
        -- Style selectors
        --
        -- The currently selected style remains usable.
        -- The other selector is disabled and greyed out.
        ----------------------------------------------------

        SetFrameEnabled(
            refs.usePFUI,
            not useCustom
        )

        SetFrameEnabled(
            refs.useCustom,
            not usePFUI
        )


        ----------------------------------------------------
        -- pfUI Style block
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
        -- Custom Style block
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
    -- Create one module configuration
    --------------------------------------------------------

    local function CreateModuleConfig(
        module
    )

        local refs = {
            custom = {}
        }


        ----------------------------------------------------
        -- Repair invalid old state
        --
        -- If both styles were saved as enabled by the
        -- previous broken version, keep pfUI and disable
        -- Custom.
        ----------------------------------------------------

        if module.use_pfui_style == "1"
        and module.use_custom_style == "1" then

            module.use_custom_style =
                "0"

        end


        ----------------------------------------------------
        -- USE PFUI STYLE
        ----------------------------------------------------

        refs.usePFUI = CreateConfig(
            function()

                if module.use_pfui_style == "1" then

                    ------------------------------------------------
                    -- Disable Custom
                    ------------------------------------------------

                    module.use_custom_style =
                        "0"


                    ------------------------------------------------
                    -- Update checkbox visually
                    ------------------------------------------------

                    if refs.useCustom
                    and refs.useCustom.input then

                        refs.useCustom.input:SetChecked(
                            false
                        )

                    end

                end


                ------------------------------------------------
                -- Refresh GUI state
                ------------------------------------------------

                UpdateModuleState(
                    module,
                    refs
                )

            end,
            "Use pfUI Style",
            module,
            "use_pfui_style",
            "checkbox"
        )


        ----------------------------------------------------
        -- PFUI BACKGROUND OPACITY
        ----------------------------------------------------

        refs.pfuiAlpha =
            CreateOpacitySlider(
                "pfUI Background Opacity",
                module,
                "pfui_background_alpha"
            )


        ----------------------------------------------------
        -- RESET TO PFUI DEFAULT
        ----------------------------------------------------

        refs.resetPFUI = CreateConfig(
            nil,
            "Reset to pfUI Default",
            module,
            "reset_pfui",
            "button",
            function()

                ResetPFUIStyle(
                    module,
                    refs
                )

            end
        )


        ----------------------------------------------------
        -- USE CUSTOM STYLE
        ----------------------------------------------------

        refs.useCustom = CreateConfig(
            function()

                if module.use_custom_style == "1" then

                    ------------------------------------------------
                    -- Disable pfUI
                    ------------------------------------------------

                    module.use_pfui_style =
                        "0"


                    ------------------------------------------------
                    -- Update checkbox visually
                    ------------------------------------------------

                    if refs.usePFUI
                    and refs.usePFUI.input then

                        refs.usePFUI.input:SetChecked(
                            false
                        )

                    end

                end


                ------------------------------------------------
                -- Refresh GUI state
                ------------------------------------------------

                UpdateModuleState(
                    module,
                    refs
                )

            end,
            "Use Custom Style",
            module,
            "use_custom_style",
            "checkbox"
        )


        ----------------------------------------------------
        -- CUSTOM:
        -- Remove Blizzard Parchment Texture
        ----------------------------------------------------

        refs.custom.parchment =
            CreateConfig(
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

        refs.custom.backgroundColor =
            CreateConfig(
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

        refs.custom.font =
            CreateConfig(
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

        refs.custom.titleColor =
            CreateConfig(
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

        refs.custom.textColor =
            CreateConfig(
                nil,
                "Text Color",
                module.custom,
                "text_color",
                "color"
            )


        ----------------------------------------------------
        -- RESET CUSTOM VALUES
        ----------------------------------------------------

        refs.custom.reset =
            CreateConfig(
                nil,
                "Reset Custom Values",
                module.custom,
                "reset",
                "button",
                function()

                    ResetCustomStyle(
                        module,
                        refs
                    )

                end
            )


        ----------------------------------------------------
        -- Initial state
        ----------------------------------------------------

        UpdateModuleState(
            module,
            refs
        )

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
                pfUI_config.dqb.questgossip
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
                pfUI_config.dqb.questlog
            )

        end
    )


    --------------------------------------------------------
    -- BOOKS
    --------------------------------------------------------

    CreateGUIEntry(
        "DQB",
        "Books",
        function()

            CreateModuleConfig(
                pfUI_config.dqb.books
            )

        end
    )

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

local event =
    CreateFrame("Frame")

event:RegisterEvent(
    "ADDON_LOADED"
)

event:SetScript(
    "OnEvent",
    function()

        if arg1 == "pfUI" then

            if DQB.InitializeConfig then
                DQB:InitializeConfig()
            end

            if DQB.CreateGUI then
                DQB:CreateGUI()
            end

            event:UnregisterEvent(
                "ADDON_LOADED"
            )

        end

    end
)

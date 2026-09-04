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
-- Helpers
------------------------------------------------------------

local function GetPFUIFont()
    if pfUI and pfUI.font_default then
        return pfUI.font_default
    end

    if pfUI_config
    and pfUI_config.global
    and pfUI_config.global.font_default then
        return pfUI_config.global.font_default
    end

    return "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"
end

local function GetPFUIBackgroundColor()
    if pfUI_config
    and pfUI_config.global
    and pfUI_config.global.background_color then
        return pfUI_config.global.background_color
    end

    return "0,0,0,1"
end

local function GetPFUIBackgroundAlpha()
    if pfUI_config
    and pfUI_config.global
    and pfUI_config.global.background_alpha ~= nil then
        return tostring(pfUI_config.global.background_alpha)
    end

    return "0.75"
end

------------------------------------------------------------
-- Reset pfUI Style
------------------------------------------------------------

local function ResetPFUIStyle(module)

    if not module then
        return
    end

    module.pfui_background_alpha = GetPFUIBackgroundAlpha()

    if pfUI
    and pfUI.events
    and pfUI.events.TriggerEvent then
        pfUI.events:TriggerEvent(
            "config:changed",
            module,
            "pfui_background_alpha"
        )
    end

    if pfUI.gui then
        pfUI.gui.settingChanged = true
    end

end

------------------------------------------------------------
-- Reset Custom Style
------------------------------------------------------------

local function ResetCustomStyle(module)

    if not module then
        return
    end

    if not module.custom then
        module.custom = {}
    end

    local custom = module.custom

    custom.remove_parchment = "1"
    custom.background_color = GetPFUIBackgroundColor()
    custom.background_alpha = GetPFUIBackgroundAlpha()
    custom.font = GetPFUIFont()

    custom.title_color = "1,0.82,0,1"
    custom.text_color = "1,1,1,1"

    if pfUI
    and pfUI.events
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
    end

    if pfUI.gui then
        pfUI.gui.settingChanged = true
    end

end

------------------------------------------------------------
-- Update dependency states
------------------------------------------------------------

local function UpdateModuleState(module, frameRefs)

    if not module or not frameRefs then
        return
    end

    local usePFUI = module.use_pfui_style == "1"
    local useCustom = module.use_custom_style == "1"

    --------------------------------------------------------
    -- pfUI Style controls
    --------------------------------------------------------

    if frameRefs.pfuiAlpha then

        if usePFUI then
            frameRefs.pfuiAlpha.input:Enable()
            frameRefs.pfuiAlpha.caption:SetTextColor(
                1, 1, 1, 1
            )
        else
            frameRefs.pfuiAlpha.input:Disable()
            frameRefs.pfuiAlpha.caption:SetTextColor(
                0.5, 0.5, 0.5, 1
            )
        end

    end

    if frameRefs.resetPFUI then

        if usePFUI then
            frameRefs.resetPFUI.button:Enable()
            frameRefs.resetPFUI.caption:SetTextColor(
                1, 1, 1, 1
            )
        else
            frameRefs.resetPFUI.button:Disable()
            frameRefs.resetPFUI.caption:SetTextColor(
                0.5, 0.5, 0.5, 1
            )
        end

    end

    --------------------------------------------------------
    -- Custom Style controls
    --------------------------------------------------------

    if frameRefs.custom then

        local enabled = useCustom

        for _, frame in pairs(frameRefs.custom) do

            if frame and frame.input then

                if enabled then
                    frame.input:Enable()
                else
                    frame.input:Disable()
                end

            elseif frame and frame.color then

                if enabled then
                    frame.color:Enable()
                else
                    frame.color:Disable()
                end

            elseif frame and frame.button then

                if enabled then
                    frame.button:Enable()
                else
                    frame.button:Disable()
                end

            end

            if frame and frame.caption then

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

        end

    end

end

------------------------------------------------------------
-- Create one module configuration page
------------------------------------------------------------

local function CreateModuleConfig(
    moduleName,
    module,
    CreateConfig
)

    local refs = {
        custom = {}
    }

    --------------------------------------------------------
    -- Use pfUI Style
    --------------------------------------------------------

    refs.usePFUI = CreateConfig(
        nil,
        "Use pfUI Style",
        module,
        "use_pfui_style",
        "checkbox",
        function()

            if module.use_pfui_style == "1" then

                module.use_custom_style = "0"

            end

            UpdateModuleState(module, refs)

        end
    )

    --------------------------------------------------------
    -- pfUI Background Opacity
    --------------------------------------------------------

    refs.pfuiAlpha = CreateConfig(
        nil,
        "pfUI Background Opacity",
        module,
        "pfui_background_alpha",
        "slider"
    )

    --------------------------------------------------------
    -- Reset pfUI Default
    --------------------------------------------------------

    refs.resetPFUI = CreateConfig(
        nil,
        "Reset to pfUI Default",
        module,
        "reset_pfui",
        "button",
        function()

            ResetPFUIStyle(module)

        end
    )

    --------------------------------------------------------
    -- Use Custom Style
    --------------------------------------------------------

    refs.useCustom = CreateConfig(
        nil,
        "Use Custom Style",
        module,
        "use_custom_style",
        "checkbox",
        function()

            if module.use_custom_style == "1" then

                module.use_pfui_style = "0"

            end

            UpdateModuleState(module, refs)

        end
    )

    --------------------------------------------------------
    -- Custom:
    -- Remove Blizzard Parchment Texture
    --------------------------------------------------------

    refs.custom.parchment = CreateConfig(
        nil,
        "Remove Blizzard Parchment Texture",
        module.custom,
        "remove_parchment",
        "checkbox"
    )

    --------------------------------------------------------
    -- Custom:
    -- Background Color
    --------------------------------------------------------

    refs.custom.backgroundColor = CreateConfig(
        nil,
        "Background Color",
        module.custom,
        "background_color",
        "color"
    )

    --------------------------------------------------------
    -- Custom:
    -- Background Opacity
    --------------------------------------------------------

    refs.custom.backgroundAlpha = CreateConfig(
        nil,
        "Background Opacity",
        module.custom,
        "background_alpha",
        "slider"
    )

    --------------------------------------------------------
    -- Custom:
    -- Fonts
    --------------------------------------------------------

    refs.custom.font = CreateConfig(
        nil,
        "Fonts",
        module.custom,
        "font",
        "font"
    )

    --------------------------------------------------------
    -- Custom:
    -- Title Color
    --------------------------------------------------------

    refs.custom.titleColor = CreateConfig(
        nil,
        "Title Color",
        module.custom,
        "title_color",
        "color"
    )

    --------------------------------------------------------
    -- Custom:
    -- Text Color
    --------------------------------------------------------

    refs.custom.textColor = CreateConfig(
        nil,
        "Text Color",
        module.custom,
        "text_color",
        "color"
    )

    --------------------------------------------------------
    -- Reset Custom Values
    --------------------------------------------------------

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

    --------------------------------------------------------
    -- Initial dependency state
    --------------------------------------------------------

    UpdateModuleState(module, refs)

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

            CreateModuleConfig(
                "questgossip",
                pfUI_config.dqb.questgossip,
                CreateConfig
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

            CreateModuleConfig(
                "questlog",
                pfUI_config.dqb.questlog,
                CreateConfig
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

            CreateModuleConfig(
                "books",
                pfUI_config.dqb.books,
                CreateConfig
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

------------------------------------------------------------
-- pfUI-DQB
-- modules/gossipquest.lua
--
-- DQB Quest & Gossip module.
--
-- This module is based on the original pfUI
-- "Gossip and Quest" skin, but is completely controlled
-- by pfUI-DQB configuration.
--
-- The original pfUI files are NOT modified.
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


DQB:RegisterModule("GossipQuest", function()

    --------------------------------------------------------
    -- Make sure pfUI API is available
    --------------------------------------------------------

    if not pfUI or not pfUI.api then
        return
    end

    local API = pfUI.api

    local SkinButton         = API.SkinButton
    local SkinCloseButton    = API.SkinCloseButton
    local SkinScrollbar      = API.SkinScrollbar
    local StripTextures      = API.StripTextures
    local CreateBackdrop     = API.CreateBackdrop
    local SetHighlight       = API.SetHighlight
    local SetAllPointsOffset = API.SetAllPointsOffset


    --------------------------------------------------------
    -- Configuration
    --------------------------------------------------------

    local config =
        pfUI_config
        and pfUI_config.dqb
        and pfUI_config.dqb.questgossip

    if not config then
        return
    end

    local custom = config.custom or {}


    --------------------------------------------------------
    -- Active styles
    --------------------------------------------------------

    local usePfUIStyle =
        config.pfui_style == "1"

    local useCustomStyle =
        custom.enable == "1"


    --------------------------------------------------------
    -- pfUI opacity
    --------------------------------------------------------

    local pfuiAlpha =
        tonumber(config.pfui_alpha)

    if not pfuiAlpha then
        pfuiAlpha = 0.50
    end

    if pfuiAlpha < 0 then
        pfuiAlpha = 0
    elseif pfuiAlpha > 1 then
        pfuiAlpha = 1
    end


    --------------------------------------------------------
    -- Custom settings
    --------------------------------------------------------

    local removeParchment =
        custom.remove_parchment == "1"

    local backgroundColor =
        custom.background_color or "000000"

    local backgroundAlpha =
        tonumber(custom.background_alpha) or 0.50

    if backgroundAlpha < 0 then
        backgroundAlpha = 0
    elseif backgroundAlpha > 1 then
        backgroundAlpha = 1
    end

    local customFont =
        custom.font

    local titleColor =
        custom.title_color or "ffd700"

    local textColor =
        custom.text_color or "ffffff"


    --------------------------------------------------------
    -- Determine active style
    --------------------------------------------------------

    local styleEnabled =
        usePfUIStyle or useCustomStyle

    local activeAlpha
    local activeBackgroundColor
    local activeFont
    local activeTitleColor
    local activeTextColor


    if usePfUIStyle then

        activeAlpha = pfuiAlpha

        ----------------------------------------------------
        -- Use pfUI background color
        ----------------------------------------------------

        if pfUI_config
        and pfUI_config.appearance
        and pfUI_config.appearance.background
        and pfUI_config.appearance.background.color then

            activeBackgroundColor =
                pfUI_config.appearance.background.color

        else
            activeBackgroundColor = "000000"
        end

        activeFont =
            pfUI.font_default

        activeTitleColor =
            "ffd700"

        activeTextColor =
            "ffffff"


    elseif useCustomStyle then

        activeAlpha =
            backgroundAlpha

        activeBackgroundColor =
            backgroundColor

        activeFont =
            customFont

        activeTitleColor =
            titleColor

        activeTextColor =
            textColor

    else

        styleEnabled = false

    end


    --------------------------------------------------------
    -- Convert hexadecimal color
    --------------------------------------------------------

    local function HexToRGB(hex)

        if not hex then
            return 1, 1, 1
        end

        hex =
            string.gsub(
                hex,
                "#",
                ""
            )

        if string.len(hex) ~= 6 then
            return 1, 1, 1
        end

        local r =
            tonumber(
                string.sub(hex, 1, 2),
                16
            )

        local g =
            tonumber(
                string.sub(hex, 3, 4),
                16
            )

        local b =
            tonumber(
                string.sub(hex, 5, 6),
                16
            )

        if not r or not g or not b then
            return 1, 1, 1
        end

        return
            r / 255,
            g / 255,
            b / 255
    end


    --------------------------------------------------------
    -- Colors
    --------------------------------------------------------

    local titleR,
          titleG,
          titleB =
        HexToRGB(activeTitleColor)

    local textR,
          textG,
          textB =
        HexToRGB(activeTextColor)

    local bgR,
          bgG,
          bgB =
        HexToRGB(activeBackgroundColor)


    --------------------------------------------------------
    -- Frames and panels
    --------------------------------------------------------

    local frames = {
        "Quest",
        "Gossip"
    }

    local panels = {
        "Greeting",
        "Detail",
        "Progress",
        "Reward"
    }


    --------------------------------------------------------
    -- Buttons
    --------------------------------------------------------

    local buttons = {
        QuestFrameGreetingGoodbyeButton,
        GossipFrameGreetingGoodbyeButton,
        QuestFrameDeclineButton,
        QuestFrameAcceptButton,
        QuestFrameGoodbyeButton,
        QuestFrameCompleteButton,
        QuestFrameCancelButton,
        QuestFrameCompleteQuestButton
    }


    --------------------------------------------------------
    -- Text helpers
    --------------------------------------------------------

    local function SetTextColor(text, r, g, b)

        if not text then
            return
        end

        text:SetTextColor(
            r,
            g,
            b,
            1
        )

        text:SetShadowColor(
            0,
            0,
            0,
            1
        )

        text:SetShadowOffset(
            1,
            -1
        )
    end


    local function SetWhite(text)

        SetTextColor(
            text,
            textR,
            textG,
            textB
        )
    end


    local function SetGold(text)

        SetTextColor(
            text,
            titleR,
            titleG,
            titleB
        )
    end


    --------------------------------------------------------
    -- Font
    --------------------------------------------------------

    local function SetFont(text)

        if not text then
            return
        end

        if not activeFont
        or activeFont == "" then
            return
        end

        if not text.GetFont
        or not text.SetFont then
            return
        end

        local font,
              size,
              flags =
            text:GetFont()

        if not size then
            size = 12
        end

        text:SetFont(
            activeFont,
            size,
            flags or ""
        )
    end


    --------------------------------------------------------
    -- Configured text
    --------------------------------------------------------

    local function SetConfiguredText(text)

        if not text then
            return
        end

        SetWhite(text)
        SetFont(text)
    end


    --------------------------------------------------------
    -- Button text
    --------------------------------------------------------

    local function SetButtonText(button)

        if not button then
            return
        end

        local text =
            button:GetFontString()

        if text then
            SetConfiguredText(text)
        end

        if button.normalText then
            SetConfiguredText(
                button.normalText
            )
        end

        if button.highlightText then
            SetConfiguredText(
                button.highlightText
            )
        end

        if button.disabledText then
            SetConfiguredText(
                button.disabledText
            )
        end

        local regions = {
            button:GetRegions()
        }

        for _, region in pairs(regions) do

            if region
            and region:GetObjectType()
                == "FontString" then

                SetConfiguredText(region)

            end
        end
    end


    --------------------------------------------------------
    -- Gossip / Quest option buttons
    --------------------------------------------------------

    local function SetGossipButtons()

        for i = 1, 32 do

            SetButtonText(
                _G["GossipTitleButton" .. i]
            )

            SetButtonText(
                _G["QuestTitleButton" .. i]
            )

        end
    end


    --------------------------------------------------------
    -- Quest Objectives title
    --------------------------------------------------------

    local function SetObjectivesTitle(frame)

        if not frame then
            return
        end

        local regions = {
            frame:GetRegions()
        }

        for _, region in pairs(regions) do

            if region
            and region:GetObjectType()
                == "FontString" then

                local text =
                    region:GetText()

                if text then

                    local lower =
                        string.lower(text)

                    if string.find(
                        lower,
                        "quest objectives"
                    )
                    or lower == "objectives:"
                    or lower == "objectives" then

                        SetGold(region)
                        SetFont(region)

                    end
                end
            end
        end

        local children = {
            frame:GetChildren()
        }

        for _, child in pairs(children) do
            SetObjectivesTitle(child)
        end
    end


    --------------------------------------------------------
    -- Rewards title
    --------------------------------------------------------

    local function SetRewardsTitle(frame)

        if not frame then
            return
        end

        local regions = {
            frame:GetRegions()
        }

        for _, region in pairs(regions) do

            if region
            and region:GetObjectType()
                == "FontString" then

                local text =
                    region:GetText()

                if text then

                    local lower =
                        string.lower(text)

                    if lower == "rewards"
                    or lower == "rewards:" then

                        SetGold(region)
                        SetFont(region)

                    end
                end
            end
        end

        local children = {
            frame:GetChildren()
        }

        for _, child in pairs(children) do
            SetRewardsTitle(child)
        end
    end


    --------------------------------------------------------
    -- Apply quest / gossip text
    --------------------------------------------------------

    local function SetQuestText()

        if not styleEnabled then
            return
        end

        ----------------------------------------------------
        -- Titles
        ----------------------------------------------------

        SetGold(
            QuestTitleText
        )

        SetGold(
            QuestProgressTitleText
        )

        SetGold(
            QuestRewardTitleText
        )

        SetGold(
            QuestProgressRequiredItemsText
        )


        ----------------------------------------------------
        -- Normal text
        ----------------------------------------------------

        SetConfiguredText(
            QuestDescriptionText
        )

        SetConfiguredText(
            QuestProgressText
        )

        SetConfiguredText(
            QuestProgressRequiredMoneyText
        )

        SetConfiguredText(
            QuestRewardText
        )

        SetConfiguredText(
            QuestRewardRewardTitleText
        )

        SetConfiguredText(
            QuestRewardItemChooseText
        )

        SetConfiguredText(
            QuestRewardItemReceiveText
        )

        SetConfiguredText(
            QuestRewardSpellLearnText
        )

        SetConfiguredText(
            QuestDetailItemReceiveText
        )

        SetConfiguredText(
            QuestDetailSpellLearnText
        )

        SetConfiguredText(
            GreetingText
        )

        SetConfiguredText(
            GossipGreetingText
        )

        SetConfiguredText(
            CurrentQuestsText
        )

        SetConfiguredText(
            AvailableQuestsText
        )

        SetConfiguredText(
            QuestObjectiveText
        )

        SetConfiguredText(
            QuestObjectivesText
        )

        SetConfiguredText(
            QuestObjectiveTitleText
        )

        SetConfiguredText(
            QuestObjectivesTitleText
        )

        SetConfiguredText(
            QuestFrameNpcNameText
        )

        SetConfiguredText(
            GossipFrameNpcNameText
        )


        ----------------------------------------------------
        -- Gossip / Quest buttons
        ----------------------------------------------------

        SetGossipButtons()


        ----------------------------------------------------
        -- Dynamic titles
        ----------------------------------------------------

        SetObjectivesTitle(
            QuestFrame
        )

        SetObjectivesTitle(
            GossipFrame
        )

        SetRewardsTitle(
            QuestFrame
        )

        SetRewardsTitle(
            GossipFrame
        )
    end


    --------------------------------------------------------
    -- Stop if no style is selected
    --------------------------------------------------------

    if not styleEnabled then

        if DQB.Debug then
            DQB:Debug(
                "GossipQuest disabled: no style selected"
            )
        end

        return
    end


    --------------------------------------------------------
    -- pfUI button skin
    --------------------------------------------------------

    if usePfUIStyle then

        for _, button in pairs(buttons) do

            if button
            and SkinButton then

                SkinButton(button)

            end
        end
    end


    --------------------------------------------------------
    -- Quest reward highlight
    --------------------------------------------------------

    local QuestRewardItemHighlight


    if usePfUIStyle
    and QuestRewardScrollChildFrame then

        if _G["QuestRewardItemHighlight"] then

            StripTextures(
                _G["QuestRewardItemHighlight"]
            )

        end

        QuestRewardItemHighlight =
            CreateFrame(
                "Frame",
                nil,
                QuestRewardScrollChildFrame
            )

        local bg =
            QuestRewardItemHighlight:CreateTexture(
                nil,
                "OVERLAY"
            )

        bg:SetTexture(
            1,
            1,
            1,
            0.2
        )

        bg:SetAllPoints()

        QuestRewardItemHighlight.bg =
            bg

        QuestRewardItemHighlight:Hide()
    end


    --------------------------------------------------------
    -- Quest reward update
    --------------------------------------------------------

    if QuestRewardItemHighlight then

        hooksecurefunc(
            "QuestFrameItems_Update",
            function()

                QuestRewardItemHighlight:Hide()

                SetQuestText()

            end
        )

    else

        hooksecurefunc(
            "QuestFrameItems_Update",
            function()

                SetQuestText()

            end
        )
    end


    --------------------------------------------------------
    -- Quest reward item selection
    --------------------------------------------------------

    if QuestRewardItemHighlight then

        hooksecurefunc(
            "QuestRewardItem_OnClick",
            function()

                if this
                and this.type == "choice"
                and this.backdrop then

                    QuestRewardItemHighlight:SetAllPoints(
                        this.backdrop
                    )

                    QuestRewardItemHighlight:Show()

                end
            end
        )
    end


    --------------------------------------------------------
    -- Quest text color hooks
    --------------------------------------------------------

    if QuestFrame_SetTextColor then

        hooksecurefunc(
            "QuestFrame_SetTextColor",
            function(text)

                SetConfiguredText(text)

            end
        )
    end


    --------------------------------------------------------
    -- Quest title color hooks
    --------------------------------------------------------

    if QuestFrame_SetTitleTextColor then

        hooksecurefunc(
            "QuestFrame_SetTitleTextColor",
            function(text)

                SetGold(text)
                SetFont(text)

            end
        )
    end


    --------------------------------------------------------
    -- Quest info
    --------------------------------------------------------

    if QuestInfo_Display then

        hooksecurefunc(
            "QuestInfo_Display",
            function()

                SetQuestText()

            end
        )
    end


    --------------------------------------------------------
    -- Gossip update
    --------------------------------------------------------

    if GossipFrameUpdate then

        hooksecurefunc(
            "GossipFrameUpdate",
            function()

                SetQuestText()
                SetGossipButtons()

            end
        )
    end


    --------------------------------------------------------
    -- Gossip available quests
    --------------------------------------------------------

    if GossipFrameAvailableQuestsUpdate then

        hooksecurefunc(
            "GossipFrameAvailableQuestsUpdate",
            function()

                SetGossipButtons()

            end
        )
    end


    --------------------------------------------------------
    -- Gossip active quests
    --------------------------------------------------------

    if GossipFrameActiveQuestsUpdate then

        hooksecurefunc(
            "GossipFrameActiveQuestsUpdate",
            function()

                SetGossipButtons()

            end
        )
    end


    --------------------------------------------------------
    -- Gossip options
    --------------------------------------------------------

    if GossipFrameOptionsUpdate then

        hooksecurefunc(
            "GossipFrameOptionsUpdate",
            function()

                SetGossipButtons()

            end
        )
    end


    --------------------------------------------------------
    -- Greeting panel
    --------------------------------------------------------

    if QuestFrameGreetingPanel_OnShow then

        hooksecurefunc(
            "QuestFrameGreetingPanel_OnShow",
            function()

                SetQuestText()
                SetGossipButtons()

            end
        )
    end


    --------------------------------------------------------
    -- Detail panel
    --------------------------------------------------------

    if QuestFrameDetailPanel_OnShow then

        hooksecurefunc(
            "QuestFrameDetailPanel_OnShow",
            function()

                SetQuestText()

            end
        )
    end


    --------------------------------------------------------
    -- Progress panel
    --------------------------------------------------------

    if QuestFrameProgressPanel_OnShow then

        hooksecurefunc(
            "QuestFrameProgressPanel_OnShow",
            function()

                SetQuestText()

            end
        )
    end


    --------------------------------------------------------
    -- Reward panel
    --------------------------------------------------------

    if QuestFrameRewardPanel_OnShow then

        hooksecurefunc(
            "QuestFrameRewardPanel_OnShow",
            function()

                SetQuestText()

                SetRewardsTitle(
                    QuestRewardScrollChildFrame
                )

                SetRewardsTitle(
                    QuestFrameRewardPanel
                )

            end
        )
    end


    --------------------------------------------------------
    -- pfUI item frames
    --------------------------------------------------------

    if usePfUIStyle then

        for _, baseName in pairs({
            "QuestProgressItem",
            "QuestDetailItem",
            "QuestRewardItem"
        }) do

            for i = 1, 6 do

                local name =
                    baseName .. i

                local item =
                    _G[name]

                local icon =
                    _G[name .. "IconTexture"]

                local count =
                    _G[name .. "Count"]

                local title =
                    _G[name .. "Name"]


                if item
                and icon
                and count
                and title then

                    local xsize =
                        item:GetWidth() - 12

                    local ysize =
                        item:GetHeight() - 12


                    item:SetWidth(
                        xsize
                    )

                    StripTextures(
                        item
                    )


                    CreateBackdrop(
                        item,
                        nil,
                        nil,
                        0.75
                    )


                    SetAllPointsOffset(
                        item.backdrop,
                        item,
                        4
                    )


                    SetHighlight(
                        item
                    )


                    icon:SetWidth(
                        ysize
                    )

                    icon:SetHeight(
                        ysize
                    )

                    icon:ClearAllPoints()

                    icon:SetPoint(
                        "LEFT",
                        6,
                        0
                    )

                    icon:SetTexCoord(
                        0.08,
                        0.92,
                        0.08,
                        0.92
                    )

                    icon:SetParent(
                        item.backdrop
                    )

                    icon:SetDrawLayer(
                        "OVERLAY"
                    )


                    count:SetParent(
                        item.backdrop
                    )

                    count:SetDrawLayer(
                        "OVERLAY"
                    )


                    title:SetParent(
                        item.backdrop
                    )

                    title:SetDrawLayer(
                        "OVERLAY"
                    )


                    SetConfiguredText(
                        title
                    )

                end
            end
        end
    end


    --------------------------------------------------------
    -- Remove Blizzard parchment textures
    --
    -- This is ALWAYS done for pfUI Style.
    --------------------------------------------------------

    local function RemoveParchment(panel)

        if not panel then
            return
        end

        local panelName =
            panel:GetName()

        if not panelName then
            return
        end


        local materialNames = {
            panelName .. "MaterialTopLeft",
            panelName .. "MaterialTopRight",
            panelName .. "MaterialBotLeft",
            panelName .. "MaterialBotRight"
        }


        for _, name in pairs(materialNames) do

            local texture =
                _G[name]

            if texture then
                texture:Hide()
            end
        end
    end


    --------------------------------------------------------
    -- Create background inside panel
    --
    -- IMPORTANT:
    -- We do NOT create a backdrop around QuestFrame or
    -- GossipFrame. The original Blizzard frame geometry
    -- remains untouched.
    --------------------------------------------------------

    local function ApplyPanelBackground(
        panel,
        alpha
    )

        if not panel then
            return
        end


        if panel.dqbBackground then

            panel.dqbBackground:SetTexture(
                bgR,
                bgG,
                bgB,
                alpha
            )

            panel.dqbBackground:Show()

            return
        end


        local bg =
            panel:CreateTexture(
                nil,
                "BACKGROUND"
            )

        bg:SetAllPoints(
            panel
        )

        bg:SetTexture(
            bgR,
            bgG,
            bgB,
            alpha
        )

        panel.dqbBackground =
            bg
    end


    --------------------------------------------------------
    -- Apply visual styling
    --------------------------------------------------------

    for _, frameName in pairs(frames) do

        local frame =
            _G[frameName .. "Frame"]


        if frame then

            ------------------------------------------------
            -- IMPORTANT:
            -- No CreateBackdrop(frame)
            -- No CreateBackdropShadow(frame)
            --
            -- The original frame geometry stays intact.
            ------------------------------------------------


            ------------------------------------------------
            -- Close button
            ------------------------------------------------

            local closeButton =
                _G[
                    frame:GetName()
                    .. "CloseButton"
                ]

            if closeButton
            and SkinCloseButton then

                -- Do not pass the parent frame.
                -- This keeps Blizzard's original position.

                SkinCloseButton(
                    closeButton
                )

            end


            ------------------------------------------------
            -- Portrait
            ------------------------------------------------

            local portrait =
                _G[
                    frame:GetName()
                    .. "Portrait"
                ]

            if portrait then
                portrait:Hide()
            end


            ------------------------------------------------
            -- NPC name
            ------------------------------------------------

            local NPCName =
                _G[
                    frame:GetName()
                    .. "NpcNameText"
                ]

            if NPCName then

                SetConfiguredText(
                    NPCName
                )

            end


            ------------------------------------------------
            -- Panels
            ------------------------------------------------

            for _, panelName in pairs(panels) do

                ------------------------------------------------
                -- Gossip only uses Greeting
                ------------------------------------------------

                if frameName == "Gossip"
                and panelName ~= "Greeting" then

                    break

                end


                local fname =
                    frame:GetName()
                    .. panelName
                    .. "Panel"


                local panel =
                    _G[fname]


                if panel then

                    ------------------------------------------------
                    -- Remove Blizzard panel textures
                    ------------------------------------------------

                    StripTextures(
                        panel
                    )


                    ------------------------------------------------
                    -- pfUI style
                    ------------------------------------------------

                    if usePfUIStyle then

                        -- pfUI Style ALWAYS removes parchment.

                        RemoveParchment(
                            panel
                        )


                        -- Background is applied directly
                        -- inside the original panel.

                        ApplyPanelBackground(
                            panel,
                            activeAlpha
                        )

                    elseif useCustomStyle then

                        ------------------------------------------------
                        -- Custom Style
                        --
                        -- Keep existing Custom behavior.
                        ------------------------------------------------

                        if removeParchment then

                            RemoveParchment(
                                panel
                            )

                        end


                        ApplyPanelBackground(
                            panel,
                            activeAlpha
                        )
                    end


                    ------------------------------------------------
                    -- Scroll frame
                    ------------------------------------------------

                    local scroll =
                        _G[
                            frameName
                            .. panelName
                            .. "ScrollFrame"
                        ]


                    if scroll then

                        scroll:SetHeight(
                            330
                        )


                        local scrollbar =
                            _G[
                                scroll:GetName()
                                .. "ScrollBar"
                            ]


                        if scrollbar
                        and SkinScrollbar then

                            SkinScrollbar(
                                scrollbar
                            )

                        end
                    end
                end
            end
        end
    end


    --------------------------------------------------------
    -- Final text pass
    --------------------------------------------------------

    SetQuestText()


    --------------------------------------------------------
    -- Debug
    --------------------------------------------------------

    if DQB.Debug then

        DQB:Debug(
            "GossipQuest module applied"
        )

    end

end)

```lua
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


------------------------------------------------------------
-- Register module
------------------------------------------------------------

DQB:RegisterModule("GossipQuest", function()

    --------------------------------------------------------
    -- Make sure pfUI is available
    --------------------------------------------------------

    if not pfUI then
        return
    end


    --------------------------------------------------------
    -- Configuration
    --------------------------------------------------------

    local config = pfUI_config
        and pfUI_config.dqb
        and pfUI_config.dqb.questgossip


    if not config then
        return
    end


    --------------------------------------------------------
    -- Custom configuration
    --------------------------------------------------------

    local custom = config.custom or {}


    --------------------------------------------------------
    -- Presets
    --------------------------------------------------------

    local usePfUIStyle =
        config.pfui_style == "1"

    local fixFonts =
        config.fix_fonts == "1"


    --------------------------------------------------------
    -- Custom options
    --------------------------------------------------------

    local removeParchment =
        custom.remove_parchment == "1"

    local backgroundColor =
        custom.background_color or "000000"

    local backgroundAlpha =
        tonumber(custom.background_alpha) or 0.85

    local customFont =
        custom.font

    local titleColor =
        custom.title_color or "ffd700"

    local textColor =
        custom.text_color or "ffffff"


    --------------------------------------------------------
    -- Convert hex color to RGB
    --------------------------------------------------------

    local function HexToRGB(hex)

        if not hex then
            return 1, 1, 1
        end

        hex = string.gsub(hex, "#", "")

        if string.len(hex) ~= 6 then
            return 1, 1, 1
        end

        local r = tonumber(
            string.sub(hex, 1, 2),
            16
        )

        local g = tonumber(
            string.sub(hex, 3, 4),
            16
        )

        local b = tonumber(
            string.sub(hex, 5, 6),
            16
        )

        if not r or not g or not b then
            return 1, 1, 1
        end

        return r / 255,
            g / 255,
            b / 255

    end


    --------------------------------------------------------
    -- Colors
    --------------------------------------------------------

    local titleR,
        titleG,
        titleB =
        HexToRGB(titleColor)


    local textR,
        textG,
        textB =
        HexToRGB(textColor)


    local bgR,
        bgG,
        bgB =
        HexToRGB(backgroundColor)


    --------------------------------------------------------
    -- Frames
    --------------------------------------------------------

    local frames = {
        "Quest",
        "Gossip"
    }


    --------------------------------------------------------
    -- Panels
    --------------------------------------------------------

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

    local function SetTextColor(
        text,
        r,
        g,
        b
    )

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


    --------------------------------------------------------
    -- White text
    --------------------------------------------------------

    local function SetWhite(text)

        SetTextColor(
            text,
            textR,
            textG,
            textB
        )

    end


    --------------------------------------------------------
    -- Gold/title text
    --------------------------------------------------------

    local function SetGold(text)

        SetTextColor(
            text,
            titleR,
            titleG,
            titleB
        )

    end


    --------------------------------------------------------
    -- Apply configured font
    --------------------------------------------------------

    local function SetFont(text)

        if not text then
            return
        end

        if not customFont
        or customFont == "" then

            return
        end

        local currentSize

        if text.GetFont then

            local font,
                size,
                flags =
                text:GetFont()

            currentSize = size

            if not currentSize then
                currentSize = 12
            end

            text:SetFont(
                customFont,
                currentSize,
                flags or ""
            )

        end

    end


    --------------------------------------------------------
    -- Apply font + text color
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
    -- Gossip / Quest buttons
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
    -- Detect "Objectives" title
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

                        if fixFonts then
                            SetFont(region)
                        end

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
    -- Detect "Rewards" title
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

                        if fixFonts then
                            SetFont(region)
                        end

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
    -- Quest text
    --------------------------------------------------------

    local function SetQuestText()

        ----------------------------------------------------
        -- Titles
        ----------------------------------------------------

        SetGold(QuestTitleText)
        SetGold(QuestProgressTitleText)
        SetGold(QuestRewardTitleText)

        SetGold(QuestProgressRequiredItemsText)


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


        ----------------------------------------------------
        -- NPC names
        ----------------------------------------------------

        SetConfiguredText(
            QuestFrameNpcNameText
        )

        SetConfiguredText(
            GossipFrameNpcNameText
        )


        ----------------------------------------------------
        -- Gossip buttons
        ----------------------------------------------------

        SetGossipButtons()


        ----------------------------------------------------
        -- Special titles
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
    -- Skin buttons
    --------------------------------------------------------

    if usePfUIStyle then

        for _, button in pairs(buttons) do

            if button then
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

        if QuestRewardItemHighlight then
            QuestRewardItemHighlight:Hide()
        end


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
    -- Quest update hook
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
    -- Quest reward click
    --------------------------------------------------------

    if QuestRewardItemHighlight then

        hooksecurefunc(
            "QuestRewardItem_OnClick",
            function()

                if this
                and this.type == "choice" then

                    if this.backdrop then

                        QuestRewardItemHighlight:SetAllPoints(
                            this.backdrop
                        )

                        QuestRewardItemHighlight:Show()

                    end

                end

            end
        )

    end


    --------------------------------------------------------
    -- Blizzard quest color hooks
    --------------------------------------------------------

    if QuestFrame_SetTextColor then

        hooksecurefunc(
            "QuestFrame_SetTextColor",
            function(text)

                SetConfiguredText(text)

            end
        )

    end


    if QuestFrame_SetTitleTextColor then

        hooksecurefunc(
            "QuestFrame_SetTitleTextColor",
            function(text)

                SetConfiguredText(text)

            end
        )

    end


    --------------------------------------------------------
    -- Quest information update
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
    -- Gossip updates
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


    if GossipFrameAvailableQuestsUpdate then

        hooksecurefunc(
            "GossipFrameAvailableQuestsUpdate",
            function()

                SetGossipButtons()

            end
        )

    end


    if GossipFrameActiveQuestsUpdate then

        hooksecurefunc(
            "GossipFrameActiveQuestsUpdate",
            function()

                SetGossipButtons()

            end
        )

    end


    if GossipFrameOptionsUpdate then

        hooksecurefunc(
            "GossipFrameOptionsUpdate",
            function()

                SetGossipButtons()

            end
        )

    end


    --------------------------------------------------------
    -- Quest panel hooks
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


    if QuestFrameDetailPanel_OnShow then

        hooksecurefunc(
            "QuestFrameDetailPanel_OnShow",
            function()

                SetQuestText()

            end
        )

    end


    if QuestFrameProgressPanel_OnShow then

        hooksecurefunc(
            "QuestFrameProgressPanel_OnShow",
            function()

                SetQuestText()

            end
        )

    end


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
    -- Quest item frames
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


                    item:SetWidth(xsize)


                    StripTextures(item)


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


                    SetHighlight(item)


                    icon:SetWidth(ysize)
                    icon:SetHeight(ysize)


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


                    SetConfiguredText(title)

                end

            end

        end

    end


    --------------------------------------------------------
    -- Frame styling
    --------------------------------------------------------

    if usePfUIStyle then

        for _, frameName in pairs(frames) do

            local frame =
                _G[frameName .. "Frame"]


            if frame then

                local NPCName =
                    _G[
                        frame:GetName()
                        .. "NpcNameText"
                    ]


                ------------------------------------------------
                -- Main frame
                ------------------------------------------------

                CreateBackdrop(
                    frame,
                    nil,
                    nil,
                    0.75
                )


                CreateBackdropShadow(frame)


                frame.backdrop:SetPoint(
                    "TOPLEFT",
                    12,
                    -18
                )


                frame.backdrop:SetPoint(
                    "BOTTOMRIGHT",
                    -28,
                    66
                )


                frame:SetHitRectInsets(
                    12,
                    28,
                    18,
                    66
                )


                EnableMovable(frame)


                ------------------------------------------------
                -- Close button
                ------------------------------------------------

                local closeButton =
                    _G[
                        frame:GetName()
                        .. "CloseButton"
                    ]


                if closeButton then

                    SkinCloseButton(
                        closeButton,
                        frame.backdrop,
                        -6,
                        -6
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

                if NPCName then

                    NPCName:ClearAllPoints()


                    NPCName:SetPoint(
                        "TOP",
                        frame.backdrop,
                        "TOP",
                        0,
                        -10
                    )


                    SetConfiguredText(
                        NPCName
                    )

                end


                ------------------------------------------------
                -- Panels
                ------------------------------------------------

                for _, panelName in pairs(panels) do

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

                        StripTextures(panel)


                        local scroll =
                            _G[
                                frameName
                                .. panelName
                                .. "ScrollFrame"
                            ]


                        if scroll then

                            scroll:SetHeight(330)


                            local scrollbar =
                                _G[
                                    scroll:GetName()
                                    .. "ScrollBar"
                                ]


                            if scrollbar then

                                SkinScrollbar(
                                    scrollbar
                                )

                            end


                            CreateBackdrop(
                                scroll,
                                nil,
                                true,
                                0
                            )


                            ------------------------------------------------
                            -- Custom background
                            ------------------------------------------------

                            local bg =
                                scroll:CreateTexture(
                                    nil,
                                    "LOW"
                                )


                            bg:SetAllPoints()


                            if removeParchment then

                                bg:SetTexture(
                                    bgR,
                                    bgG,
                                    bgB,
                                    backgroundAlpha
                                )

                            else

                                bg:SetTexture(
                                    0,
                                    0,
                                    0,
                                    backgroundAlpha
                                )

                            end


                            scroll.dqbBackground =
                                bg


                            ------------------------------------------------
                            -- Remove Blizzard parchment pieces
                            ------------------------------------------------

                            local topLeft =
                                _G[
                                    fname
                                    .. "MaterialTopLeft"
                                ]

                            local topRight =
                                _G[
                                    fname
                                    .. "MaterialTopRight"
                                ]

                            local botLeft =
                                _G[
                                    fname
                                    .. "MaterialBotLeft"
                                ]

                            local botRight =
                                _G[
                                    fname
                                    .. "MaterialBotRight"
                                ]


                            if removeParchment then

                                if topLeft then
                                    topLeft:Hide()
                                end

                                if topRight then
                                    topRight:Hide()
                                end

                                if botLeft then
                                    botLeft:Hide()
                                end

                                if botRight then
                                    botRight:Hide()
                                end

                            end

                        end

                    end

                end

            end

        end

    end


    --------------------------------------------------------
    -- Initial text pass
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
```

------------------------------------------------------------
-- pfUI-DQB
-- modules/questlog.lua
--
-- DQB customization for the pfUI Quest Log.
--
-- The original pfUI Quest Log remains responsible for:
--   - Main frame
--   - Frame backdrop
--   - Close button
--   - General pfUI appearance
--
-- DQB changes:
--   - Quest Log layout
--   - Quest Log text colors
--   - Quest detail background
--   - Quest item appearance
--   - Quest level display
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


------------------------------------------------------------
-- Register module
------------------------------------------------------------

DQB:RegisterModule("questlog", function()

    --------------------------------------------------------
    -- Check configuration
    --------------------------------------------------------

    if not DQB:IsModuleEnabled("questlog") then
        return
    end


    --------------------------------------------------------
    -- Make sure pfUI is available
    --------------------------------------------------------

    if not pfUI then
        return
    end


    --------------------------------------------------------
    -- pfUI API
    --------------------------------------------------------

    local API = pfUI.api

    if not API then
        return
    end


    --------------------------------------------------------
    -- Local helpers
    --------------------------------------------------------

    local function SetWhite(text)

        if not text then
            return
        end

        text:SetTextColor(
            1,
            1,
            1,
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


    local function SetGold(text)

        if not text then
            return
        end

        text:SetTextColor(
            1,
            0.82,
            0,
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
    -- Quest Log text
    --------------------------------------------------------

    local function SetQuestLogTextWhite()

        ----------------------------------------------------
        -- Titles
        ----------------------------------------------------

        SetGold(
            QuestLogQuestTitle
        )

        SetGold(
            QuestLogDescriptionTitle
        )

        SetGold(
            QuestLogRewardTitleText
        )


        ----------------------------------------------------
        -- Main text
        ----------------------------------------------------

        SetWhite(
            QuestLogObjectivesText
        )

        SetWhite(
            QuestLogQuestDescription
        )

        SetWhite(
            QuestLogRequiredMoneyText
        )

        SetWhite(
            QuestLogItemChooseText
        )

        SetWhite(
            QuestLogItemReceiveText
        )

        SetWhite(
            QuestLogSpellLearnText
        )

        SetWhite(
            QuestLogTimerText
        )


        ----------------------------------------------------
        -- Objectives
        ----------------------------------------------------

        for i = 1, MAX_OBJECTIVES do

            SetWhite(
                _G[
                    "QuestLogObjective" .. i
                ]
            )

        end


        ----------------------------------------------------
        -- Quest reward items
        ----------------------------------------------------

        for i = 1, MAX_NUM_ITEMS do

            SetWhite(
                _G[
                    "QuestLogItem"
                    .. i
                    .. "Name"
                ]
            )

            SetWhite(
                _G[
                    "QuestLogItem"
                    .. i
                    .. "Count"
                ]
            )

        end

    end


    --------------------------------------------------------
    -- Quest Log frame
    --------------------------------------------------------

    do

        ----------------------------------------------------
        -- Quest counter
        ----------------------------------------------------

        if QuestLogQuestCount then

            QuestLogQuestCount:ClearAllPoints()

            QuestLogQuestCount:SetPoint(
                "TOPRIGHT",
                -10,
                -30
            )

        end


        ----------------------------------------------------
        -- Position when shown
        ----------------------------------------------------

        if QuestLog_OnShow then

            hooksecurefunc(
                "QuestLog_OnShow",
                function()

                    QuestLogFrame:ClearAllPoints()

                    QuestLogFrame:SetPoint(
                        "TOPLEFT",
                        10,
                        -104
                    )

                end
            )

        end


        ----------------------------------------------------
        -- Size
        ----------------------------------------------------

        QuestLogFrame:SetSize(
            676,
            440
        )


        ----------------------------------------------------
        -- Remove Blizzard background layer
        ----------------------------------------------------

        QuestLogFrame:DisableDrawLayer(
            "BACKGROUND"
        )


        ----------------------------------------------------
        -- pfUI frame styling
        ----------------------------------------------------

        API.StripTextures(
            QuestLogFrame,
            true
        )

        API.CreateBackdrop(
            QuestLogFrame,
            nil,
            nil,
            0.75
        )

        API.CreateBackdropShadow(
            QuestLogFrame
        )


        ----------------------------------------------------
        -- Keep Quest Log movable
        ----------------------------------------------------

        API.EnableMovable(
            QuestLogFrame
        )


        ----------------------------------------------------
        -- Title
        ----------------------------------------------------

        QuestLogTitleText:ClearAllPoints()

        QuestLogTitleText:SetPoint(
            "TOP",
            0,
            -10
        )


        ----------------------------------------------------
        -- Close button
        ----------------------------------------------------

        API.SkinCloseButton(
            QuestLogFrameCloseButton,
            QuestLogFrame,
            -6,
            -6
        )


        ----------------------------------------------------
        -- No quests message
        ----------------------------------------------------

        if QuestLogNoQuestsText then

            QuestLogNoQuestsText:ClearAllPoints()

            QuestLogNoQuestsText:SetPoint(
                "TOP",
                QuestLogFrame,
                0,
                -100
            )

        end


        ----------------------------------------------------
        -- Quest level checkbox
        ----------------------------------------------------

        local QuestLogFrameLevelsCheckButton =
            CreateFrame(
                "CheckButton",
                "QuestLogFrameLevelsCheckButton",
                QuestLogFrame,
                "UICheckButtonTemplate"
            )


        if C
        and C.questlog
        and C.questlog.showQuestLevels then

            QuestLogFrameLevelsCheckButton:SetChecked(
                C.questlog.showQuestLevels == "1"
                and true
                or nil
            )

        end


        QuestLogFrameLevelsCheckButton:SetPoint(
            "LEFT",
            QuestLogCollapseAllButton,
            "RIGHT",
            0,
            1
        )


        QuestLogFrameLevelsCheckButton:SetScript(
            "OnClick",
            function()

                if not C.questlog then
                    return
                end

                C.questlog.showQuestLevels =
                    C.questlog.showQuestLevels == "1"
                    and "0"
                    or "1"


                ------------------------------------------------
                -- Update pfQuest configuration
                ------------------------------------------------

                if pfQuest_config
                and pfQuestConfig
                and pfQuestConfig.UpdateConfigEntries then

                    pfQuest_config["questloglevel"] =
                        C.questlog.showQuestLevels

                    pfQuestConfig:UpdateConfigEntries()

                end


                QuestLog_Update()

            end
        )


        API.SkinCheckbox(
            QuestLogFrameLevelsCheckButton,
            23
        )


        if QuestLogFrameLevelsCheckButtonText then

            QuestLogFrameLevelsCheckButtonText:SetText(
                "Quest Levels"
            )

        end


        ----------------------------------------------------
        -- Tracking button
        ----------------------------------------------------

        if QuestLogTrack then

            API.CreateBackdrop(
                QuestLogTrack
            )

            QuestLogTrack:SetSize(
                8,
                8
            )

            QuestLogTrack:ClearAllPoints()

            QuestLogTrack:SetPoint(
                "RIGHT",
                QuestLogQuestCount,
                "LEFT",
                -5,
                0
            )

            API.StripTextures(
                QuestLogTrack
            )

            if QuestLogTrackTracking then

                QuestLogTrackTracking:SetTexture(
                    0.8,
                    0.8,
                    0.8,
                    1
                )

            end

            if QuestLogTrackTitle then
                QuestLogTrackTitle:Hide()
            end

        end


        ----------------------------------------------------
        -- Abandon button
        ----------------------------------------------------

        API.SkinButton(
            QuestLogFrameAbandonButton
        )

        QuestLogFrameAbandonButton:ClearAllPoints()

        QuestLogFrameAbandonButton:SetPoint(
            "BOTTOMLEFT",
            QuestLogFrame,
            "BOTTOMLEFT",
            5,
            5
        )

        QuestLogFrameAbandonButton:SetWidth(
            98
        )


        ----------------------------------------------------
        -- Push quest button
        ----------------------------------------------------

        API.SkinButton(
            QuestFramePushQuestButton
        )

        QuestFramePushQuestButton:ClearAllPoints()

        QuestFramePushQuestButton:SetPoint(
            "LEFT",
            QuestLogFrameAbandonButton,
            "RIGHT",
            5,
            0
        )

        QuestFramePushQuestButton:SetWidth(
            98
        )


        ----------------------------------------------------
        -- Exit button
        ----------------------------------------------------

        API.SkinButton(
            QuestFrameExitButton
        )

        QuestFrameExitButton:ClearAllPoints()

        QuestFrameExitButton:SetPoint(
            "LEFT",
            QuestFramePushQuestButton,
            "RIGHT",
            5,
            0
        )

        QuestFrameExitButton:SetWidth(
            99
        )


        ----------------------------------------------------
        -- Expand button
        ----------------------------------------------------

        local QuestLogFrameExpandButton =
            CreateFrame(
                "Button",
                "QuestLogFrameExpandButton",
                QuestLogFrame,
                "UIPanelButtonTemplate"
            )


        API.SkinArrowButton(
            QuestLogFrameExpandButton,
            "LEFT",
            21
        )


        API.SetAllPointsOffset(
            QuestLogFrameExpandButton.icon,
            QuestLogFrameExpandButton,
            6
        )


        QuestLogFrameExpandButton:SetPoint(
            "LEFT",
            QuestFrameExitButton,
            "RIGHT",
            5,
            0
        )


        QuestLogFrameExpandButton:SetScript(
            "OnClick",
            function()

                if QuestLogDetailScrollFrame:IsShown() then

                    QuestLogDetailScrollFrame:Hide()

                    QuestLogDetailScrollFrame.hidden =
                        true

                else

                    QuestLogDetailScrollFrame:Show()

                    QuestLogDetailScrollFrame.hidden =
                        nil

                end

            end
        )


        ----------------------------------------------------
        -- Detail panel hidden
        ----------------------------------------------------

        QuestLogDetailScrollFrame:HookScript(
            "OnHide",
            function()

                API.SkinArrowButton(
                    QuestLogFrameExpandButton,
                    "RIGHT",
                    21
                )

                QuestLogDetailScrollFrame:Hide()

                QuestLogFrame:SetWidth(
                    340
                )

            end
        )


        ----------------------------------------------------
        -- Detail panel shown
        ----------------------------------------------------

        QuestLogDetailScrollFrame:HookScript(
            "OnShow",
            function()

                API.SkinArrowButton(
                    QuestLogFrameExpandButton,
                    "LEFT",
                    21
                )

                QuestLogDetailScrollFrame:Show()

                QuestLogFrame:SetWidth(
                    676
                )

                QuestLog_UpdateQuestDetails()

                SetQuestLogTextWhite()

            end
        )


        ----------------------------------------------------
        -- Empty quest log
        ----------------------------------------------------

        EmptyQuestLogFrame:SetScript(
            "OnShow",
            function()

                if QuestLogDetailScrollFrame:IsShown() then

                    QuestLogDetailScrollFrame:Hide()

                else

                    QuestLogDetailScrollFrame:GetScript(
                        "OnHide"
                    )()

                end

                QuestLogFrameExpandButton:Disable()

            end
        )


        EmptyQuestLogFrame:SetScript(
            "OnHide",
            function()

                QuestLogFrameExpandButton:Enable()

            end
        )

    end


    --------------------------------------------------------
    -- Left pane
    --------------------------------------------------------

    do

        ----------------------------------------------------
        -- Quest list scrollbar
        ----------------------------------------------------

        API.StripTextures(
            QuestLogListScrollFrame
        )

        API.SkinScrollbar(
            QuestLogListScrollFrameScrollBar
        )


        ----------------------------------------------------
        -- Expand / collapse area
        ----------------------------------------------------

        API.StripTextures(
            QuestLogExpandButtonFrame
        )

        API.StripTextures(
            QuestLogCollapseAllButton
        )

        API.SkinCollapseButton(
            QuestLogCollapseAllButton,
            true
        )


        QuestLogCollapseAllButton:ClearAllPoints()

        QuestLogCollapseAllButton:SetPoint(
            "BOTTOMLEFT",
            QuestLogTitle1,
            "TOPLEFT",
            -6,
            4
        )


        ----------------------------------------------------
        -- Quest buttons
        ----------------------------------------------------

        for i = 1, QUESTS_DISPLAYED do

            API.SkinCollapseButton(
                _G[
                    "QuestLogTitle" .. i
                ]
            )

        end


        ----------------------------------------------------
        -- Left pane background
        ----------------------------------------------------

        local backdrop =
            CreateFrame(
                "Frame",
                nil,
                QuestLogFrame
            )


        API.CreateBackdrop(
            backdrop,
            nil,
            nil,
            0.75
        )


        backdrop.backdrop:SetPoint(
            "TOPLEFT",
            QuestLogListScrollFrame,
            "TOPLEFT",
            -5,
            5
        )


        backdrop.backdrop:SetPoint(
            "BOTTOMRIGHT",
            QuestLogListScrollFrame,
            "BOTTOMRIGHT",
            26,
            -5
        )


        ----------------------------------------------------
        -- First quest entry
        ----------------------------------------------------

        QuestLogTitle1:ClearAllPoints()

        QuestLogTitle1:SetPoint(
            "TOPLEFT",
            QuestLogListScrollFrame,
            "TOPLEFT",
            0,
            0
        )


        ----------------------------------------------------
        -- Additional quest entries
        ----------------------------------------------------

        for i = 7, QUESTS_DISPLAYED do

            local b =
                _G[
                    "QuestLogTitle" .. i
                ]


            if not b then

                b =
                    CreateFrame(
                        "Button",
                        "QuestLogTitle" .. i,
                        QuestLogFrame,
                        "QuestLogTitleButtonTemplate"
                    )

            end


            b:SetID(
                i
            )


            b:SetPoint(
                "TOPLEFT",
                _G[
                    "QuestLogTitle"
                    .. (i - 1)
                ],
                "BOTTOMLEFT",
                0,
                1
            )


            API.SkinCollapseButton(
                b
            )

        end


        ----------------------------------------------------
        -- Left pane position
        ----------------------------------------------------

        QuestLogListScrollFrame:SetPoint(
            "TOPLEFT",
            10,
            -54
        )


        QuestLogListScrollFrame:SetHeight(
            350
        )


        ----------------------------------------------------
        -- Quest log update
        ----------------------------------------------------

        if QuestLog_Update then

            hooksecurefunc(
                "QuestLog_Update",
                function()

                    local numEntries =
                        GetNumQuestLogEntries()


                    local questIndex
                    local text
                    local level
                    local questTag
                    local isHeader


                    ------------------------------------------------
                    -- Keep detail panel hidden when required
                    ------------------------------------------------

                    if QuestLogDetailScrollFrame.hidden then

                        QuestLogDetailScrollFrame:Hide()

                    end


                    ------------------------------------------------
                    -- Quest list
                    ------------------------------------------------

                    for i = 1, QUESTS_DISPLAYED do

                        local check =
                            _G[
                                "QuestLogTitle"
                                .. i
                                .. "Check"
                            ]


                        local title =
                            _G[
                                "QuestLogTitle"
                                .. i
                            ]


                        if check and title then

                            check:ClearAllPoints()

                            check:SetPoint(
                                "RIGHT",
                                title,
                                "LEFT",
                                24,
                                0
                            )

                        end


                        if C
                        and C.questlog
                        and C.questlog.showQuestLevels == "1" then

                            questIndex =
                                i
                                + FauxScrollFrame_GetOffset(
                                    QuestLogListScrollFrame
                                )


                            if questIndex <= numEntries then

                                text,
                                level,
                                questTag,
                                isHeader =
                                    GetQuestLogTitle(
                                        questIndex
                                    )


                                if not isHeader
                                and title then

                                    title:SetText(
                                        " "
                                        .. "["
                                        .. (
                                            questTag
                                            and level .. "+"
                                            or level
                                        )
                                        .. "] "
                                        .. text
                                    )

                                end

                            end

                        end

                    end


                    SetQuestLogTextWhite()

                end
            )

        end

    end


    --------------------------------------------------------
    -- Right pane
    --------------------------------------------------------

    do

        ----------------------------------------------------
        -- Remove Blizzard parchment textures
        ----------------------------------------------------

        API.StripTextures(
            QuestLogDetailScrollFrame
        )


        ----------------------------------------------------
        -- Scrollbar
        ----------------------------------------------------

        API.SkinScrollbar(
            QuestLogDetailScrollFrameScrollBar
        )


        ----------------------------------------------------
        -- Detail scroll position
        ----------------------------------------------------

        QuestLogDetailScrollFrame:ClearAllPoints()

        QuestLogDetailScrollFrame:SetPoint(
            "TOPLEFT",
            QuestLogListScrollFrame,
            "TOPRIGHT",
            35,
            0
        )


        QuestLogDetailScrollFrame:SetHeight(
            376
        )


        QuestLogDetailScrollChildFrame:SetHeight(
            376
        )


        ----------------------------------------------------
        -- Black translucent background
        ----------------------------------------------------

        local bg =
            QuestLogDetailScrollFrame.dqbBackground


        if not bg then

            bg =
                QuestLogDetailScrollFrame:CreateTexture(
                    nil,
                    "BACKGROUND"
                )


            bg:SetAllPoints()

            QuestLogDetailScrollFrame.dqbBackground =
                bg

        end


        bg:SetTexture(
            0,
            0,
            0,
            0.50
        )


        ----------------------------------------------------
        -- pfUI border around detail area
        ----------------------------------------------------

        API.CreateBackdrop(
            QuestLogDetailScrollFrame,
            nil,
            nil,
            0
        )


        QuestLogDetailScrollFrame.backdrop:SetPoint(
            "TOPLEFT",
            -5,
            5
        )


        QuestLogDetailScrollFrame.backdrop:SetPoint(
            "BOTTOMRIGHT",
            26,
            -5
        )


        ----------------------------------------------------
        -- Quest reward items
        ----------------------------------------------------

        for i = 1, MAX_NUM_ITEMS do

            local name =
                "QuestLogItem" .. i


            local item =
                _G[name]


            if item then

                local icon =
                    _G[
                        name
                        .. "IconTexture"
                    ]


                local count =
                    _G[
                        name
                        .. "Count"
                    ]


                local title =
                    _G[
                        name
                        .. "Name"
                    ]


                local xsize =
                    item:GetWidth()
                    - 12


                local ysize =
                    item:GetHeight()
                    - 12


                item:SetWidth(
                    xsize
                )


                API.StripTextures(
                    item
                )


                API.CreateBackdrop(
                    item,
                    nil,
                    nil,
                    0.75
                )


                API.SetAllPointsOffset(
                    item.backdrop,
                    item,
                    4
                )


                API.SetHighlight(
                    item
                )


                ------------------------------------------------
                -- Icon
                ------------------------------------------------

                if icon then

                    icon:SetSize(
                        ysize,
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

                end


                ------------------------------------------------
                -- Count
                ------------------------------------------------

                if count then

                    count:SetParent(
                        item.backdrop
                    )

                    count:SetDrawLayer(
                        "OVERLAY"
                    )

                    SetWhite(
                        count
                    )

                end


                ------------------------------------------------
                -- Item name
                ------------------------------------------------

                if title then

                    title:SetParent(
                        item.backdrop
                    )

                    title:SetDrawLayer(
                        "OVERLAY"
                    )

                    SetWhite(
                        title
                    )

                end

            end

        end


        ----------------------------------------------------
        -- Quest detail update
        ----------------------------------------------------

        if QuestLog_UpdateQuestDetails then

            hooksecurefunc(
                "QuestLog_UpdateQuestDetails",
                function()

                    SetQuestLogTextWhite()

                end
            )

        end

    end


    --------------------------------------------------------
    -- Initial state
    --------------------------------------------------------

    SetQuestLogTextWhite()


    --------------------------------------------------------
    -- Debug
    --------------------------------------------------------

    if DQB.Debug then

        DQB:Debug(
            "questlog module applied"
        )

    end

end)
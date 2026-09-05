------------------------------------------------------------
-- pfUI-DQB
-- modules/gossipquest.lua
--
-- DQB customization for pfUI Gossip & Quest dialogs.
--
-- pfUI remains responsible for:
--   - Main frame
--   - Frame backdrop
--   - Close button
--   - Movement
--   - Buttons
--   - General pfUI appearance
--
-- DQB changes:
--   - Text colors
--   - Gossip option colors
--   - Quest text colors
--   - Quest/Gossip parchment background
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


DQB:RegisterModule("gossipquest", function()

    --------------------------------------------------------
    -- Configuration
    --------------------------------------------------------

    if not DQB:IsModuleEnabled("gossipquest") then
        return
    end


    --------------------------------------------------------
    -- Helpers
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
    -- Gossip / Quest option buttons
    --------------------------------------------------------

    local function SetButtonWhite(button)

        if not button then
            return
        end


        local text = button:GetFontString()

        if text then
            SetWhite(text)
        end


        if button.normalText then
            SetWhite(button.normalText)
        end


        if button.highlightText then
            SetWhite(button.highlightText)
        end


        if button.disabledText then
            SetWhite(button.disabledText)
        end


        local regions = {
            button:GetRegions()
        }


        for _, region in pairs(regions) do

            if region
            and region:GetObjectType() == "FontString" then

                SetWhite(region)

            end

        end

    end


    local function SetGossipButtonsWhite()

        for i = 1, 32 do

            SetButtonWhite(
                _G["GossipTitleButton" .. i]
            )

            SetButtonWhite(
                _G["QuestTitleButton" .. i]
            )

        end

    end


    --------------------------------------------------------
    -- Dynamic quest section titles
    --------------------------------------------------------

    local function SetQuestObjectivesTitleGold(frame)

        if not frame then
            return
        end


        local regions = {
            frame:GetRegions()
        }


        for _, region in pairs(regions) do

            if region
            and region:GetObjectType() == "FontString" then

                local text = region:GetText()

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

                    end

                end

            end

        end


        local children = {
            frame:GetChildren()
        }


        for _, child in pairs(children) do
            SetQuestObjectivesTitleGold(child)
        end

    end


    local function SetQuestRewardsTitleGold(frame)

        if not frame then
            return
        end


        local regions = {
            frame:GetRegions()
        }


        for _, region in pairs(regions) do

            if region
            and region:GetObjectType() == "FontString" then

                local text = region:GetText()

                if text then

                    local lower =
                        string.lower(text)


                    if lower == "rewards"
                    or lower == "rewards:" then

                        SetGold(region)

                    end

                end

            end

        end


        local children = {
            frame:GetChildren()
        }


        for _, child in pairs(children) do
            SetQuestRewardsTitleGold(child)
        end

    end


    --------------------------------------------------------
    -- Quest text
    --------------------------------------------------------

    local function SetQuestTextWhite()

        SetGold(QuestTitleText)
        SetGold(QuestProgressTitleText)
        SetGold(QuestRewardTitleText)
        SetGold(QuestProgressRequiredItemsText)

        SetWhite(QuestDescriptionText)
        SetWhite(QuestProgressText)
        SetWhite(QuestProgressRequiredMoneyText)
        SetWhite(QuestRewardText)
        SetWhite(QuestRewardRewardTitleText)
        SetWhite(QuestRewardItemChooseText)
        SetWhite(QuestRewardItemReceiveText)
        SetWhite(QuestRewardSpellLearnText)
        SetWhite(QuestDetailItemReceiveText)
        SetWhite(QuestDetailSpellLearnText)

        SetWhite(GreetingText)
        SetWhite(GossipGreetingText)
        SetWhite(CurrentQuestsText)
        SetWhite(AvailableQuestsText)

        SetWhite(QuestObjectiveText)
        SetWhite(QuestObjectivesText)
        SetWhite(QuestObjectiveTitleText)
        SetWhite(QuestObjectivesTitleText)

        SetWhite(QuestFrameNpcNameText)
        SetWhite(GossipFrameNpcNameText)

        SetGossipButtonsWhite()

        SetQuestObjectivesTitleGold(QuestFrame)
        SetQuestObjectivesTitleGold(GossipFrame)

        SetQuestRewardsTitleGold(QuestFrame)
        SetQuestRewardsTitleGold(GossipFrame)

    end


    --------------------------------------------------------
    -- Parchment replacement
    --
    -- This is intentionally based on the working pfUI
    -- Gossip & Quest skin.
    --
    -- We do NOT modify the main frame.
    --------------------------------------------------------

    local function ApplyParchment(frameName, panelName)

        local frame =
            _G[frameName .. "Frame"]


        if not frame then
            return
        end


        local frameNameFull =
            frame:GetName()


        local panel =
            _G[
                frameNameFull
                .. panelName
                .. "Panel"
            ]


        if not panel then
            return
        end


        local fname =
            frameNameFull
            .. panelName
            .. "Panel"


        local scroll =
            _G[
                frameName
                .. panelName
                .. "ScrollFrame"
            ]


        if not scroll then
            return
        end


        ----------------------------------------------------
        -- Use the exact pfUI API.
        ----------------------------------------------------

        if pfUI.api
        and pfUI.api.StripTextures then

            pfUI.api.StripTextures(
                panel
            )

        end


        ----------------------------------------------------
        -- Black background
        ----------------------------------------------------

        local bg =
            scroll.dqbParchmentBackground


        if not bg then

            bg =
                scroll:CreateTexture(
                    nil,
                    "LOW"
                )


            bg:SetAllPoints()

            scroll.dqbParchmentBackground =
                bg

        end


        bg:SetTexture(
            0,
            0,
            0,
            0.10
        )


        ----------------------------------------------------
        -- Blizzard parchment material textures
        ----------------------------------------------------

        local topLeft =
            _G[fname .. "MaterialTopLeft"]

        local topRight =
            _G[fname .. "MaterialTopRight"]

        local botLeft =
            _G[fname .. "MaterialBotLeft"]

        local botRight =
            _G[fname .. "MaterialBotRight"]


        ----------------------------------------------------
        -- Top left
        ----------------------------------------------------

        if topLeft then

            topLeft.SetTexture =
                function()

                    bg:SetTexture(
                        0,
                        0,
                        0,
                        0.10
                    )

                end


            topLeft.Hide =
                function()

                    bg:SetTexture(
                        0,
                        0,
                        0,
                        0.10
                    )

                end


            topLeft.Show =
                function()
                    return
                end


            topLeft:Hide()

        end


        ----------------------------------------------------
        -- Top right
        ----------------------------------------------------

        if topRight then

            topRight.Show =
                function()
                    return
                end


            topRight:Hide()

        end


        ----------------------------------------------------
        -- Bottom left
        ----------------------------------------------------

        if botLeft then

            botLeft.Show =
                function()
                    return
                end


            botLeft:Hide()

        end


        ----------------------------------------------------
        -- Bottom right
        ----------------------------------------------------

        if botRight then

            botRight.Show =
                function()
                    return
                end


            botRight:Hide()

        end

    end


    --------------------------------------------------------
    -- Apply all parchment panels
    --------------------------------------------------------

    local function ApplyAllParchment()

        ApplyParchment(
            "Quest",
            "Greeting"
        )

        ApplyParchment(
            "Quest",
            "Detail"
        )

        ApplyParchment(
            "Quest",
            "Progress"
        )

        ApplyParchment(
            "Quest",
            "Reward"
        )

        ApplyParchment(
            "Gossip",
            "Greeting"
        )

    end


    --------------------------------------------------------
    -- Quest reward highlight
    --------------------------------------------------------

    local QuestRewardItemHighlight


    if QuestRewardScrollChildFrame then

        QuestRewardItemHighlight =
            CreateFrame(
                "Frame",
                nil,
                QuestRewardScrollChildFrame
            )


        local highlight =
            QuestRewardItemHighlight:CreateTexture(
                nil,
                "OVERLAY"
            )


        highlight:SetTexture(
            1,
            1,
            1,
            0.20
        )


        highlight:SetAllPoints()


        QuestRewardItemHighlight.bg =
            highlight


        QuestRewardItemHighlight:Hide()

    end


    --------------------------------------------------------
    -- Quest reward updates
    --------------------------------------------------------

    if QuestFrameItems_Update then

        hooksecurefunc(
            "QuestFrameItems_Update",
            function()

                if QuestRewardItemHighlight then
                    QuestRewardItemHighlight:Hide()
                end

                SetQuestTextWhite()
                ApplyAllParchment()

            end
        )

    end


    --------------------------------------------------------
    -- Quest reward item click
    --------------------------------------------------------

    if QuestRewardItem_OnClick then

        hooksecurefunc(
            "QuestRewardItem_OnClick",
            function()

                if this
                and this.type == "choice"
                and this.backdrop
                and QuestRewardItemHighlight then

                    QuestRewardItemHighlight:SetAllPoints(
                        this.backdrop
                    )

                    QuestRewardItemHighlight:Show()

                end

            end
        )

    end


    --------------------------------------------------------
    -- Blizzard text color hooks
    --------------------------------------------------------

    if QuestFrame_SetTextColor then

        hooksecurefunc(
            "QuestFrame_SetTextColor",
            function(text)

                SetWhite(text)

            end
        )

    end


    if QuestFrame_SetTitleTextColor then

        hooksecurefunc(
            "QuestFrame_SetTitleTextColor",
            function(text)

                SetGold(text)

            end
        )

    end


    --------------------------------------------------------
    -- Quest information
    --------------------------------------------------------

    if QuestInfo_Display then

        hooksecurefunc(
            "QuestInfo_Display",
            function()

                SetQuestTextWhite()
                ApplyAllParchment()

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

                SetQuestTextWhite()
                SetGossipButtonsWhite()
                ApplyAllParchment()

            end
        )

    end


    if GossipFrameAvailableQuestsUpdate then

        hooksecurefunc(
            "GossipFrameAvailableQuestsUpdate",
            function()

                SetGossipButtonsWhite()

            end
        )

    end


    if GossipFrameActiveQuestsUpdate then

        hooksecurefunc(
            "GossipFrameActiveQuestsUpdate",
            function()

                SetGossipButtonsWhite()

            end
        )

    end


    if GossipFrameOptionsUpdate then

        hooksecurefunc(
            "GossipFrameOptionsUpdate",
            function()

                SetGossipButtonsWhite()

            end
        )

    end


    --------------------------------------------------------
    -- Quest panels
    --------------------------------------------------------

    if QuestFrameGreetingPanel_OnShow then

        hooksecurefunc(
            "QuestFrameGreetingPanel_OnShow",
            function()

                SetQuestTextWhite()
                SetGossipButtonsWhite()
                ApplyAllParchment()

            end
        )

    end


    if QuestFrameDetailPanel_OnShow then

        hooksecurefunc(
            "QuestFrameDetailPanel_OnShow",
            function()

                SetQuestTextWhite()
                ApplyAllParchment()

            end
        )

    end


    if QuestFrameProgressPanel_OnShow then

        hooksecurefunc(
            "QuestFrameProgressPanel_OnShow",
            function()

                SetQuestTextWhite()
                ApplyAllParchment()

            end
        )

    end


    if QuestFrameRewardPanel_OnShow then

        hooksecurefunc(
            "QuestFrameRewardPanel_OnShow",
            function()

                SetQuestTextWhite()

                SetQuestRewardsTitleGold(
                    QuestRewardScrollChildFrame
                )

                SetQuestRewardsTitleGold(
                    QuestFrameRewardPanel
                )

                ApplyAllParchment()

            end
        )

    end


    --------------------------------------------------------
    -- Frame OnShow hooks
    --
    -- These are important because pfUI can recreate/show
    -- its material textures after the dialog is opened.
    --------------------------------------------------------

    if QuestFrame then

        QuestFrame:HookScript(
            "OnShow",
            function()

                ApplyAllParchment()
                SetQuestTextWhite()

            end
        )

    end


    if GossipFrame then

        GossipFrame:HookScript(
            "OnShow",
            function()

                ApplyAllParchment()
                SetQuestTextWhite()
                SetGossipButtonsWhite()

            end
        )

    end


    --------------------------------------------------------
    -- Initial application
    --------------------------------------------------------

    SetQuestTextWhite()
    SetGossipButtonsWhite()


    --------------------------------------------------------
    -- Debug
    --------------------------------------------------------

    if DQB.Debug then

        DQB:Debug(
            "gossipquest module applied"
        )

    end

end)
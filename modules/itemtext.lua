-- pfUI-DQB
-- modules/itemtext.lua
--
-- DQB customization for pfUI Books / Item Text.
--
-- The original pfUI skin remains responsible for:
--   - Main frame
--   - Frame backdrop
--   - Close button
--   - Movement
--   - General pfUI appearance
--
-- DQB only changes:
--   - Text colors
--   - Parchment background
--   - Page controls
--   - Scrollbar presentation


local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


DQB:RegisterModule("itemtext", function()

    --------------------------------------------------------
    -- Check configuration
    --------------------------------------------------------

    if not DQB:IsModuleEnabled("itemtext") then
        return
    end


    --------------------------------------------------------
    -- pfUI API
    --------------------------------------------------------

    local API = pfUI.api

    if not API then
        return
    end


    local StripTextures = API.StripTextures
    local CreateBackdrop = API.CreateBackdrop
    local CreateBackdropShadow = API.CreateBackdropShadow
    local SkinCloseButton = API.SkinCloseButton
    local SkinScrollbar = API.SkinScrollbar
    local SkinArrowButton = API.SkinArrowButton


    --------------------------------------------------------
    -- Text colors
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
    -- Apply text colors
    --------------------------------------------------------

    local function SetItemTextColors()

        SetGold(
            ItemTextTitleText
        )

        SetWhite(
            ItemTextPageText
        )

        SetWhite(
            ItemTextCurrentPage
        )

    end


    --------------------------------------------------------
    -- Main frame
    --------------------------------------------------------

    if not ItemTextFrame then
        return
    end


    StripTextures(
        ItemTextFrame
    )


    CreateBackdrop(
        ItemTextFrame,
        nil,
        nil,
        0.75
    )


    CreateBackdropShadow(
        ItemTextFrame
    )


    ItemTextFrame.backdrop:SetPoint(
        "TOPLEFT",
        12,
        -12
    )


    ItemTextFrame.backdrop:SetPoint(
        "BOTTOMRIGHT",
        -30,
        72
    )


    ItemTextFrame:SetHitRectInsets(
        12,
        30,
        12,
        72
    )


    if API.EnableMovable then

        API.EnableMovable(
            ItemTextFrame
        )

    end


    --------------------------------------------------------
    -- Close button
    --------------------------------------------------------

    if ItemTextCloseButton then

        SkinCloseButton(
            ItemTextCloseButton,
            ItemTextFrame.backdrop,
            -6,
            -6
        )

    end


    --------------------------------------------------------
    -- Text area
    --------------------------------------------------------

    if ItemTextScrollFrame then

        ItemTextScrollFrame:SetWidth(
            292
        )

    end


    if ItemTextPageText then

        ItemTextPageText:SetWidth(
            282
        )

        ItemTextPageText:ClearAllPoints()

        ItemTextPageText:SetPoint(
            "TOPLEFT",
            4,
            -15
        )

    end


    if ItemTextTitleText then

        ItemTextTitleText:ClearAllPoints()

        ItemTextTitleText:SetPoint(
            "TOP",
            ItemTextFrame.backdrop,
            "TOP",
            0,
            -10
        )

    end


    --------------------------------------------------------
    -- Scroll frame
    --------------------------------------------------------

    if ItemTextScrollFrame then

        StripTextures(
            ItemTextScrollFrame
        )


        CreateBackdrop(
            ItemTextScrollFrame,
            nil,
            true,
            0
        )


        SkinScrollbar(
            ItemTextScrollFrameScrollBar
        )


        ItemTextScrollFrame:ClearAllPoints()

        ItemTextScrollFrame:SetPoint(
            "TOPRIGHT",
            -66,
            -46
        )

    end


    --------------------------------------------------------
    -- Replace parchment with black translucent background
    --------------------------------------------------------

    local bg


    if ItemTextScrollFrame then

        bg =
            ItemTextScrollFrame.dqbBackground


        if not bg then

            bg =
                ItemTextScrollFrame:CreateTexture(
                    nil,
                    "LOW"
                )


            bg:SetAllPoints()


            ItemTextScrollFrame.dqbBackground =
                bg

        end


        bg:SetTexture(
            0,
            0,
            0,
            0.50
        )

    end


    --------------------------------------------------------
    -- Disable Blizzard parchment material
    --------------------------------------------------------

    if ItemTextMaterialTopLeft then

        ItemTextMaterialTopLeft.SetTexture =
            function()

                bg:SetTexture(
                    0,
                    0,
                    0,
                    0.50
                )

            end


        ItemTextMaterialTopLeft.Hide =
            function()

                bg:SetTexture(
                    0,
                    0,
                    0,
                    0.50
                )

            end


        ItemTextMaterialTopLeft.Show =
            function()
                return
            end


        ItemTextMaterialTopLeft:Hide()

    end


    if ItemTextMaterialTopRight then

        ItemTextMaterialTopRight.Show =
            function()
                return
            end


        ItemTextMaterialTopRight:Hide()

    end


    if ItemTextMaterialBotLeft then

        ItemTextMaterialBotLeft.Show =
            function()
                return
            end


        ItemTextMaterialBotLeft:Hide()

    end


    if ItemTextMaterialBotRight then

        ItemTextMaterialBotRight.Show =
            function()
                return
            end


        ItemTextMaterialBotRight:Hide()

    end


    --------------------------------------------------------
    -- Current page
    --------------------------------------------------------

    if ItemTextCurrentPage
    and ItemTextScrollFrame then

        ItemTextCurrentPage:ClearAllPoints()

        ItemTextCurrentPage:SetPoint(
            "TOP",
            ItemTextScrollFrame,
            "BOTTOM",
            0,
            -10
        )

        ItemTextCurrentPage:SetFontObject(
            "GameFontWhite"
        )

    end


    --------------------------------------------------------
    -- Previous page button
    --------------------------------------------------------

    if ItemTextPrevPageButton
    and ItemTextScrollFrame then

        SkinArrowButton(
            ItemTextPrevPageButton,
            "left",
            18
        )


        ItemTextPrevPageButton:ClearAllPoints()

        ItemTextPrevPageButton:SetPoint(
            "TOPLEFT",
            ItemTextScrollFrame,
            "BOTTOMLEFT",
            0,
            -6
        )


        ItemTextPrevPageButton.Show =
            function(self)

                self:Enable()

            end


        ItemTextPrevPageButton.Hide =
            function(self)

                self:Disable()

            end

    end


    --------------------------------------------------------
    -- Next page button
    --------------------------------------------------------

    if ItemTextNextPageButton
    and ItemTextScrollFrame then

        SkinArrowButton(
            ItemTextNextPageButton,
            "right",
            18
        )


        ItemTextNextPageButton:ClearAllPoints()

        ItemTextNextPageButton:SetPoint(
            "TOPRIGHT",
            ItemTextScrollFrame,
            "BOTTOMRIGHT",
            0,
            -6
        )


        ItemTextNextPageButton.Show =
            function(self)

                self:Enable()

            end


        ItemTextNextPageButton.Hide =
            function(self)

                self:Disable()

            end

    end


    --------------------------------------------------------
    -- Keep scrollbar visible
    --------------------------------------------------------

    if ItemTextScrollFrame
    and ItemTextScrollFrameScrollBar then

        ItemTextScrollFrame:Show()

        ItemTextScrollFrameScrollBar:Show()


        if ItemTextScrollFrameScrollBarScrollUpButton then

            ItemTextScrollFrameScrollBarScrollUpButton:Show()

        end


        if ItemTextScrollFrameScrollBarScrollDownButton then

            ItemTextScrollFrameScrollBarScrollDownButton:Show()

        end


        ItemTextScrollFrame.Show =
            function(self)
            end


        ItemTextScrollFrame.Hide =
            function(self)
            end


        ItemTextScrollFrameScrollBar.Show =
            function(self)

                if self.thumb then
                    self.thumb:Show()
                end

            end


        ItemTextScrollFrameScrollBar.Hide =
            function(self)

                if self.thumb then
                    self.thumb:Hide()
                end

            end


        if ItemTextScrollFrameScrollBarScrollUpButton then

            ItemTextScrollFrameScrollBarScrollUpButton.Show =
                function(self)

                    if self:GetParent():GetValue() ~= 0 then
                        self:Enable()
                    end

                end


            ItemTextScrollFrameScrollBarScrollUpButton.Hide =
                function(self)

                    self:Disable()

                end

        end


        if ItemTextScrollFrameScrollBarScrollDownButton then

            ItemTextScrollFrameScrollBarScrollDownButton.Show =
                function(self)

                    self:Enable()

                end


            ItemTextScrollFrameScrollBarScrollDownButton.Hide =
                function(self)

                    self:Disable()

                end

        end

    end


    --------------------------------------------------------
    -- Update colors when the book opens
    --------------------------------------------------------

    ItemTextFrame:HookScript(
        "OnShow",
        function()

            SetItemTextColors()

            if bg then

                bg:SetTexture(
                    0,
                    0,
                    0,
                    0.50
                )

            end

            if ItemTextMaterialTopLeft then
                ItemTextMaterialTopLeft:Hide()
            end

            if ItemTextMaterialTopRight then
                ItemTextMaterialTopRight:Hide()
            end

            if ItemTextMaterialBotLeft then
                ItemTextMaterialBotLeft:Hide()
            end

            if ItemTextMaterialBotRight then
                ItemTextMaterialBotRight:Hide()
            end

        end
    )


    --------------------------------------------------------
    -- Initial colors
    --------------------------------------------------------

    SetItemTextColors()


    --------------------------------------------------------
    -- Debug
    --------------------------------------------------------

    if DQB.Debug then

        DQB:Debug(
            "itemtext module applied"
        )

    end

end)
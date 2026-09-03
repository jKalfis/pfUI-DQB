------------------------------------------------------------
-- pfUI-DQB
-- Quest & Gossip module
--
-- Controls the visual appearance of Blizzard Quest/Gossip
-- frames without modifying pfUI itself.
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


------------------------------------------------------------
-- Helpers
------------------------------------------------------------

local function GetConfig()
    return pfUI_config
        and pfUI_config.dqb
        and pfUI_config.dqb.questgossip
end


local function IsModuleEnabled()
    if not DQB:IsEnabled() then
        return false
    end

    local config = GetConfig()

    return config ~= nil
end


------------------------------------------------------------
-- Color
------------------------------------------------------------

local function HexToRGB(hex)
    if not hex then
        return 1, 1, 1
    end

    hex = tostring(hex)

    hex = string.gsub(hex, "#", "")

    if string.len(hex) ~= 6 then
        return 1, 1, 1
    end

    local r = tonumber(string.sub(hex, 1, 2), 16)
    local g = tonumber(string.sub(hex, 3, 4), 16)
    local b = tonumber(string.sub(hex, 5, 6), 16)

    if not r or not g or not b then
        return 1, 1, 1
    end

    return r / 255, g / 255, b / 255
end


local function GetBackgroundColor()
    local config = GetConfig()

    if not config then
        return 0, 0, 0, 0.85
    end

    local r, g, b = HexToRGB(config.background_color)

    local alpha = tonumber(config.background_alpha)

    if not alpha then
        alpha = 0.85
    end

    if alpha < 0 then
        alpha = 0
    elseif alpha > 1 then
        alpha = 1
    end

    return r, g, b, alpha
end


local function GetTextColor()
    local config = GetConfig()

    if not config then
        return 1, 1, 1, 1
    end

    local r, g, b = HexToRGB(config.text_color)

    return r, g, b, 1
end


------------------------------------------------------------
-- Font
------------------------------------------------------------

local function GetTextFont()
    local config = GetConfig()

    if not config then
        return pfUI.font_default or STANDARD_TEXT_FONT
    end

    local font = config.text_font

    if not font or font == "" then
        return pfUI.font_default or STANDARD_TEXT_FONT
    end

    --------------------------------------------------------
    -- "Arial" is kept as a friendly default value.
    -- WoW does not normally expose an Arial path, so use
    -- pfUI's configured default font in that case.
    --------------------------------------------------------

    if string.lower(font) == "arial" then
        return pfUI.font_default or STANDARD_TEXT_FONT
    end

    --------------------------------------------------------
    -- pfUI media path
    --
    -- Example:
    -- font:default
    --------------------------------------------------------

    if string.find(font, "font:") then
        return pfUI.media[font]
    end

    --------------------------------------------------------
    -- Direct font path
    --------------------------------------------------------

    if string.find(font, "\\") then
        return font
    end

    if string.find(font, "/") then
        return font
    end

    --------------------------------------------------------
    -- Unknown short name.
    -- Fall back to pfUI default.
    --------------------------------------------------------

    return pfUI.font_default or STANDARD_TEXT_FONT
end


local function GetTextSize()
    local config = GetConfig()

    if not config then
        return 12
    end

    local size = tonumber(config.text_size)

    if not size then
        size = 12
    end

    if size < 1 then
        size = 1
    end

    return size
end


local function GetTextStyle()
    local config = GetConfig()

    if not config then
        return ""
    end

    local style = config.text_style

    if not style then
        return ""
    end

    style = tostring(style)

    if style == "" then
        return ""
    end

    return style
end


------------------------------------------------------------
-- Text styling
------------------------------------------------------------

local function ApplyText(text)
    if not text then
        return
    end

    if not IsModuleEnabled() then
        return
    end

    local config = GetConfig()

    if not config or config.text_global ~= "1" then
        return
    end

    local r, g, b, a = GetTextColor()
    local font = GetTextFont()
    local size = GetTextSize()
    local style = GetTextStyle()

    --------------------------------------------------------
    -- Text colour
    --------------------------------------------------------

    text:SetTextColor(r, g, b, a)

    --------------------------------------------------------
    -- Shadow
    --------------------------------------------------------

    text:SetShadowColor(0, 0, 0, 1)
    text:SetShadowOffset(1, -1)

    --------------------------------------------------------
    -- Font
    --------------------------------------------------------

    if font then
        text:SetFont(font, size, style)
    end
end


------------------------------------------------------------
-- Apply to all FontStrings belonging to a frame
------------------------------------------------------------

local function ApplyFrameText(frame)
    if not frame then
        return
    end

    --------------------------------------------------------
    -- Regions
    --------------------------------------------------------

    local regions = { frame:GetRegions() }

    for _, region in pairs(regions) do
        if region and region:GetObjectType() == "FontString" then
            ApplyText(region)
        end
    end

    --------------------------------------------------------
    -- Children
    --------------------------------------------------------

    local children = { frame:GetChildren() }

    for _, child in pairs(children) do
        ApplyFrameText(child)
    end
end


------------------------------------------------------------
-- Gossip / Quest option buttons
------------------------------------------------------------

local function ApplyOptionButtons()
    if not IsModuleEnabled() then
        return
    end

    --------------------------------------------------------
    -- Gossip options
    --------------------------------------------------------

    for i = 1, 32 do

        local gossipButton = _G["GossipTitleButton" .. i]

        if gossipButton then
            ApplyFrameText(gossipButton)
        end

        ----------------------------------------------------
        -- Quest options in greeting
        ----------------------------------------------------

        local questButton = _G["QuestTitleButton" .. i]

        if questButton then
            ApplyFrameText(questButton)
        end
    end
end


------------------------------------------------------------
-- Main Quest/Gossip text
------------------------------------------------------------

local function ApplyQuestGossipText()
    if not IsModuleEnabled() then
        return
    end

    local texts = {

        ----------------------------------------------------
        -- Quest
        ----------------------------------------------------

        QuestTitleText,
        QuestDescriptionText,

        QuestProgressTitleText,
        QuestProgressText,
        QuestProgressRequiredItemsText,
        QuestProgressRequiredMoneyText,

        QuestRewardTitleText,
        QuestRewardText,
        QuestRewardRewardTitleText,
        QuestRewardItemChooseText,
        QuestRewardItemReceiveText,
        QuestRewardSpellLearnText,

        QuestDetailItemReceiveText,
        QuestDetailSpellLearnText,

        ----------------------------------------------------
        -- Greeting / Gossip
        ----------------------------------------------------

        GreetingText,
        GossipGreetingText,
        CurrentQuestsText,
        AvailableQuestsText,

        ----------------------------------------------------
        -- Objectives
        ----------------------------------------------------

        QuestObjectiveText,
        QuestObjectivesText,
        QuestObjectiveTitleText,
        QuestObjectivesTitleText,

        ----------------------------------------------------
        -- NPC names
        ----------------------------------------------------

        QuestFrameNpcNameText,
        GossipFrameNpcNameText,
    }

    for _, text in pairs(texts) do
        ApplyText(text)
    end

    --------------------------------------------------------
    -- Apply recursively as a safety net.
    --
    -- This catches text fields that Blizzard creates
    -- dynamically or which are not present in the static
    -- list above.
    --------------------------------------------------------

    if QuestFrame then
        ApplyFrameText(QuestFrame)
    end

    if GossipFrame then
        ApplyFrameText(GossipFrame)
    end

    ApplyOptionButtons()
end


------------------------------------------------------------
-- Background
------------------------------------------------------------

local backgroundFrames = {}


local function CreateBackground(frame)
    if not frame then
        return nil
    end

    if frame.dqbBackground then
        return frame.dqbBackground
    end

    local background = frame:CreateTexture(nil, "BACKGROUND")

    background:SetAllPoints()

    frame.dqbBackground = background

    table.insert(backgroundFrames, {
        frame = frame,
        background = background,
    })

    return background
end


local function ApplyBackground(frame)
    if not frame then
        return
    end

    local config = GetConfig()

    if not config then
        return
    end

    local background = CreateBackground(frame)

    if not background then
        return
    end

    --------------------------------------------------------
    -- DQB background disabled
    --------------------------------------------------------

    if config.background_global ~= "1" then
        background:Hide()
        return
    end

    --------------------------------------------------------
    -- DQB background enabled
    --------------------------------------------------------

    local r, g, b, a = GetBackgroundColor()

    background:SetTexture(1, 1, 1, 1)
    background:SetVertexColor(r, g, b, a)
    background:Show()
end


local function ApplyScrollBackground(scroll)
    if not scroll then
        return
    end

    local config = GetConfig()

    if not config then
        return
    end

    local background = scroll.dqbBackground

    if not background then
        background = scroll:CreateTexture(nil, "BACKGROUND")
        background:SetAllPoints()
        scroll.dqbBackground = background
    end

    --------------------------------------------------------
    -- Disabled
    --------------------------------------------------------

    if config.background_global ~= "1" then
        background:Hide()
        return
    end

    --------------------------------------------------------
    -- Enabled
    --------------------------------------------------------

    local r, g, b, a = GetBackgroundColor()

    background:SetTexture(1, 1, 1, 1)
    background:SetVertexColor(r, g, b, a)
    background:Show()
end


local function ApplyAllBackgrounds()
    if not IsModuleEnabled() then
        return
    end

    --------------------------------------------------------
    -- Main frames
    --------------------------------------------------------

    ApplyBackground(QuestFrame)
    ApplyBackground(GossipFrame)

    --------------------------------------------------------
    -- Quest panels
    --------------------------------------------------------

    ApplyScrollBackground(QuestGreetingScrollFrame)
    ApplyScrollBackground(QuestDetailScrollFrame)
    ApplyScrollBackground(QuestProgressScrollFrame)
    ApplyScrollBackground(QuestRewardScrollFrame)

    --------------------------------------------------------
    -- Gossip
    --------------------------------------------------------

    ApplyScrollBackground(GossipGreetingScrollFrame)
end


------------------------------------------------------------
-- Hooks
------------------------------------------------------------

local function HookFunction(name, func)
    if _G[name] then
        hooksecurefunc(name, func)
    end
end


local function InstallHooks()

    --------------------------------------------------------
    -- Quest updates
    --------------------------------------------------------

    HookFunction("QuestFrameItems_Update", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)


    HookFunction("QuestFrameProgressItems_Update", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)


    HookFunction("QuestRewardItem_OnClick", function()
        ApplyQuestGossipText()
    end)


    HookFunction("QuestFrame_SetTextColor", function(text)
        ApplyText(text)
    end)


    HookFunction("QuestFrame_SetTitleTextColor", function(text)
        ApplyText(text)
    end)


    HookFunction("QuestInfo_Display", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)


    --------------------------------------------------------
    -- Gossip updates
    --------------------------------------------------------

    HookFunction("GossipFrameUpdate", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)


    HookFunction("GossipFrameAvailableQuestsUpdate", function()
        ApplyOptionButtons()
        ApplyQuestGossipText()
    end)


    HookFunction("GossipFrameActiveQuestsUpdate", function()
        ApplyOptionButtons()
        ApplyQuestGossipText()
    end)


    HookFunction("GossipFrameOptionsUpdate", function()
        ApplyOptionButtons()
        ApplyQuestGossipText()
    end)


    --------------------------------------------------------
    -- Quest panels
    --------------------------------------------------------

    HookFunction("QuestFrameGreetingPanel_OnShow", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)


    HookFunction("QuestFrameDetailPanel_OnShow", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)


    HookFunction("QuestFrameProgressPanel_OnShow", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)


    HookFunction("QuestFrameRewardPanel_OnShow", function()
        ApplyQuestGossipText()
        ApplyAllBackgrounds()
    end)
end


------------------------------------------------------------
-- Apply current configuration
------------------------------------------------------------

local function Apply()
    if not IsModuleEnabled() then
        return
    end

    ApplyQuestGossipText()
    ApplyAllBackgrounds()
end


------------------------------------------------------------
-- Register module
------------------------------------------------------------

DQB:RegisterModule("questgossip", function()

    --------------------------------------------------------
    -- Install hooks only once
    --------------------------------------------------------

    if DQB.questGossipHooksInstalled then
        Apply()
        return
    end

    DQB.questGossipHooksInstalled = true

    InstallHooks()

    --------------------------------------------------------
    -- Initial application
    --------------------------------------------------------

    Apply()
end)
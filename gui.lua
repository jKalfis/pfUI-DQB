-- pfUI-DQB
-- gui.lua
--
-- Adds DQB configuration to the pfUI GUI.

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


-- Create DQB configuration menu

function DQB:CreateGUI()

    if self.InitializeConfig then
        self:InitializeConfig()
    end

    if not pfUI
    or not pfUI.gui
    or not pfUI.gui.CreateGUIEntry
    or not pfUI.gui.CreateConfig then

        return
    end


    -- Avoid creating the menu more than once

    if self.guiCreated then
        return
    end


    local CreateGUIEntry =
        pfUI.gui.CreateGUIEntry

    local CreateConfig =
        pfUI.gui.CreateConfig


    -- DQB main menu entry

    CreateGUIEntry(
        "DQB",
        nil,
        function()

            -- Dialogs & Quest Log

            CreateConfig(
                nil,
                "Use pfUI Style: Dialogs & Quest Log",
                pfUI_config.dqb.dialogs_questlog,
                "enable",
                "checkbox"
            )


            -- Books

            CreateConfig(
                nil,
                "Use pfUI Style: Books",
                pfUI_config.dqb.books,
                "enable",
                "checkbox"
            )

        end
    )


    self.guiCreated = true

end


-- Wait until pfUI has created its GUI

local event = CreateFrame("Frame")

event:RegisterEvent("ADDON_LOADED")

event:SetScript(
    "OnEvent",
    function()

        if arg1 ~= "pfUI" then
            return
        end


        if not DQB.InitializeConfig then
            return
        end


        DQB:InitializeConfig()


        -- pfUI GUI must already exist

        if pfUI.gui
        and pfUI.gui.CreateGUIEntry then

            DQB:CreateGUI()

            event:UnregisterAllEvents()

        end

    end
)
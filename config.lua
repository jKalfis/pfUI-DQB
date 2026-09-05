------------------------------------------------------------
-- pfUI-DQB
-- config.lua
--
-- Default configuration for pfUI-DQB v0.2.0
------------------------------------------------------------

local DQB = pfUI and pfUI.dqb

if not DQB then
    return
end


-- Initialize DQB configuration

function DQB:InitializeConfig()

    -- Root configuration

    if not pfUI_config then
        pfUI_config = {}
    end

    if not pfUI_config.dqb then
        pfUI_config.dqb = {}
    end


    -- Dialogs & Quest Log
    --
    -- Controls:
    --   gossipquest.lua
    --   questlog.lua

    if pfUI_config.dqb.dialogs_questlog == nil then
        pfUI_config.dqb.dialogs_questlog = {}
    end

    local dialogsQuestLog =
        pfUI_config.dqb.dialogs_questlog

    if dialogsQuestLog.enable == nil then
        dialogsQuestLog.enable = "0"
    end


    -- Books
    --
    -- Controls:
    --   itemtext.lua

    if pfUI_config.dqb.books == nil then
        pfUI_config.dqb.books = {}
    end

    local books =
        pfUI_config.dqb.books

    if books.enable == nil then
        books.enable = "0"
    end

end
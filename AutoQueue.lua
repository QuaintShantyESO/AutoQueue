-- AutoQueue namespace
local AutoQueue = _G['AutoQueue']

-- Addon details
AutoQueue.name = 'AutoQueue'
AutoQueue.version = '1.0.00'
AutoQueue.slash = '/autoqueue'

-- Addon initialization
function AutoQueue.Initialize(code, addon)
  if addon ~= AutoQueue.name then return end

  EVENT_MANAGER:UnregisterForEvent(AutoQueue.name, EVENT_ADD_ON_LOADED)
  SLASH_COMMANDS[AutoQueue.slash] = AutoQueue.SlashCommand

  AutoQueue.Handler.Initialize()
end

function AutoQueue.SlashCommand(params)
  AutoQueue.Settings.SetAutoQueue(not Settings.autoQueue)
end

EVENT_MANAGER:RegisterForEvent(AutoQueue.name, EVENT_ADD_ON_LOADED, AutoQueue.Initialize)

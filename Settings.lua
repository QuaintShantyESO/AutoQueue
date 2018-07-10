local AutoQueue = _G['AutoQueue']
AutoQueue.Settings = {}

local Settings = AutoQueue.Settings

Settings.autoQueue = true

function SetAutoQueue(bool)
  Settings.autoQueue = bool
  d('Auto queue is has been set to ' .. bool)
end
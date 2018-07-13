-- AutoQueue namespace
local AutoQueue = _G['AutoQueue']
AutoQueue.Handler = {}

local Handler = AutoQueue.Handler
local Settings = AutoQueue.Settings

function Handler.Initialize()
  EVENT_MANAGER:RegisterForEvent(AutoQueue.name, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, Handler.AutoAcceptActivity)
end

function Handler.AutoAcceptActivity(eventCode, status)
  if status ~= ACTIVITY_FINDER_STATUS_READY_CHECK then
    return
  end

  if IsActiveWorldBattleground() then
    return
  end

  if HasLFGReadyCheckNotification() then
    if not Settings.vars.autoQueue then
      if not Settings.vars.muted then
        d('This queue was not automatically accepted. To change that, type /autoqueue')
      end
      return
    end

    if not Settings.vars.muted then
      d('Automatically accepted the queue. To change that, type /autoqueue')
    end
    AcceptLFGReadyCheckNotification()
  end
end

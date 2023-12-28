-- AutoQueue namespace
local AutoQueue = _G['AutoQueue']
AutoQueue.Handler = {}

local Handler = AutoQueue.Handler
local Settings = AutoQueue.Settings

function AutoQueue.GetGroupQueue()
  local groupQueue = false
  if (IsUnitGrouped('player') == true) and (IsUnitGroupLeader("player") == true) then groupQueue = TVS.SV.GroupQueue end
  return groupQueue
end

function Handler.Initialize()
  EVENT_MANAGER:RegisterForEvent(AutoQueue.name, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, Handler.AutoAcceptActivity)
  EVENT_MANAGER:RegisterForEvent(AutoQueue.name, EVENT_CAMPAIGN_QUEUE_STATE_CHANGED,Handler.AutoAcceptPVP)
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
        d('This queue was not automatically accepted. Turn it off with /autoqueue.')
      end
      return
    end
    AcceptLFGReadyCheckNotification()
  end
end

function Handler.GetGroupQueue()
  local groupQueue = false
  -- if (IsUnitGrouped('player') == true) and (IsUnitGroupLeader("player") == true) then groupQueue = true end -- lifted from TelVar Saver
  -- accept queue as group only if in a group, not if lead like TVS did
  if (IsUnitGrouped('player') == true) then groupQueue = true end -- lifted from TelVar Saver
  return groupQueue
end

function Handler.AutoAcceptPVP(eventCode, id, isGroup, state)
  local groupQueue = Handler.GetGroupQueue()
  if (state == CAMPAIGN_QUEUE_REQUEST_STATE_CONFIRMING) then
      if not Settings.vars.autoQueue then
        if not Settings.vars.muted then
          d('This queue was not automatically accepted. Turn it off with /autoqueue.')
        end
        return
      end
      ConfirmCampaignEntry(id, groupQueue, true)
  end
end

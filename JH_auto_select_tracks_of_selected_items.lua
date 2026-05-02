-- Auto-select tracks that contain selected media items.
-- Run this script once, or add it to REAPER startup actions.

local _, _, section_id, command_id = reaper.get_action_context()

local last_signature = ""
local last_tracks = {}

local function selected_items_signature()
  local count = reaper.CountSelectedMediaItems(0)
  local parts = { tostring(count) }

  for i = 0, count - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    parts[#parts + 1] = tostring(item)
  end

  return table.concat(parts, "|")
end

local function select_tracks_for_selected_items()
  local item_count = reaper.CountSelectedMediaItems(0)
  local tracks = {}

  for i = 0, item_count - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local track = reaper.GetMediaItem_Track(item)
    if track then
      tracks[track] = true
    end
  end

  local changed = false
  reaper.PreventUIRefresh(1)

  for track in pairs(last_tracks) do
    if not tracks[track] and reaper.GetMediaTrackInfo_Value(track, "I_SELECTED") ~= 0 then
      reaper.SetTrackSelected(track, false)
      changed = true
    end
  end

  for track in pairs(tracks) do
    if reaper.GetMediaTrackInfo_Value(track, "I_SELECTED") == 0 then
      reaper.SetTrackSelected(track, true)
      changed = true
    end
  end

  reaper.PreventUIRefresh(-1)

  if changed then
    reaper.UpdateArrange()
  end

  last_tracks = tracks
end

local function loop()
  local signature = selected_items_signature()

  if signature ~= last_signature then
    last_signature = signature
    select_tracks_for_selected_items()
  end

  reaper.defer(loop)
end

reaper.SetToggleCommandState(section_id, command_id, 1)
reaper.RefreshToolbar2(section_id, command_id)

local function on_exit()
  reaper.SetToggleCommandState(section_id, command_id, 0)
  reaper.RefreshToolbar2(section_id, command_id)
end

reaper.atexit(on_exit)
loop()

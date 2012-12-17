-- Open a temporary file created by my IRSSI plugin (TODO: link?), with the
-- following format:
-- windownumber  datalevel
--
-- If datalevel is 1 or 2, it is normal activity, if it is 3, it is highlighted.
--
-- Consolidates information and show in the statusbar.
--
-- TODO: I should check if irssi is running or the notify file is not too
-- outdated, in which case notion will still show the outdated information.

local irssi_timer = statusd.create_timer()

local function update_irssi()
    local f = io.open('/tmp/.irssi-notify', 'r')
    if f == nil then
	statusd.inform("irssi_hint", "normal")
	statusd.inform("irssi", "--")
	irssi_timer:set(1000, update_irssi)
	return nil
    end

    local win_hi = {}  -- Windows with highlight events
    local win_act = {} -- Windows with normal events
    for line in f:lines() do
	local _, _, win, lvl = line:find("(%d+) (%d+)")
	if lvl == "1" or lvl == "2" then
	    table.insert(win_act, win)
	elseif lvl >= "3" then
	    table.insert(win_hi, win)
	end
    end
    -- If there is any windows with highlight events, show only them with
    -- important hint.  If not, show all windows with normal event.
    local windows
    if table.getn(win_hi) > 0 then
	hint = "important"
	windows = table.concat(win_hi, ",")
    else
	hint = "normal"
	windows = table.concat(win_act, ",")
    end
    statusd.inform("irssi_hint", hint)
    statusd.inform("irssi", windows)
    irssi_timer:set(2000, update_irssi)
end

update_irssi()

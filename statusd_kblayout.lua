-- $Id: statusd_kblayout.lua,v 1.1 2009/03/06 19:47:27 silas Exp $

-- Shows current keyboard layout

local function inform_kblayout(s)
	statusd.inform("kblayout", s)
end

local kblayout_timer = statusd.create_timer()

local function update_kblayout()
	-- TODO: is it too expensive to call various programs linked by
	-- pipelines?
	local cmd = "setxkbmap -print | grep xkb_symbols | awk '{ print $4 }' | sed 's/\"//g' | sed 's/^[^+]*+//g'"
	local f = io.popen(cmd, 'r')

	local s = f:read('*line')
	f:close()
	inform_kblayout(s)
	kblayout_timer:set(0.5 * 1000, update_kblayout)
end

update_kblayout()

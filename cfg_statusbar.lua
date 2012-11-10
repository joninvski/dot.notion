-- $Id: cfg_statusbar.lua,v 1.2 2009/03/17 22:59:52 silas Exp $

local f = io.popen('hostname', 'r')
-- Ugly way to make it work under NetBSD.  For any reason, there happen errors
-- when I execute command above and try to read everything ("*a") with f:read().
-- It looks like a bug in Lua in NetBSD.  TODO: can I catch and report it?
os.execute("sleep 0.1")
local hostname = f:read("*a")
local inboxw = ""
if hostname:find("auron") then
	inboxw = " || work mail: %maildir_Work_INBOX_new"
end

-- Create a statusbar
mod_statusbar.create{
	-- First screen, bottom left corner
	screen=0,
	pos='bl',

	fullsize=false,
	systray=true,

	template = "[ %date || load: %load || %df "
	    .. "|| mail: %maildir_Home_INBOX_new"
	    .. inboxw .. " ]"
}

mod_statusbar.launch_statusd{
	-- Date
	date={
		date_format='%a %Y-%m-%d %H:%M',
	},

	-- Load meter
	load={
		--update_interval=10*1000,
		--important_threshold=1.5,
		--critical_threshold=4.0,
	},
}

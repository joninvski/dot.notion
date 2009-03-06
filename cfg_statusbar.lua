-- $Id: cfg_statusbar.lua,v 1.1 2009/03/06 19:47:27 silas Exp $

-- Create a statusbar
mod_statusbar.create{
	-- First screen, bottom left corner
	screen=0,
	pos='bl',

	fullsize=false,
	systray=true,

	template = "[ %date || load: %load || kblayout: %kblayout ]"
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

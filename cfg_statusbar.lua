-- $Id: cfg_statusbar.lua,v 1.2 2009/03/17 22:59:52 silas Exp $

-- Create a statusbar
mod_statusbar.create{
	-- First screen, bottom left corner
	screen=0,
	pos='bl',

	fullsize=false,
	systray=true,

	template = "[ %date || load: %load ]"
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

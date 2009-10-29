--
-- Ion main configuration file
--

META="Mod1+"	-- Alt
SUBMETA="U"	-- "Submeta" variable, to be used as a prefix for some commands
ALTMETA=""	-- No modifier for ALTMETA variable

XTERM="xterm"	-- Default terminal emulator

-- Some basic settings
ioncore.set{
	-- Maximum delay between clicks in milliseconds to be considered a
	-- double click.
	--dblclick_delay=250,

	-- For keyboard resize, time (in milliseconds) to wait after latest
	-- key press before automatically leaving resize mode (and doing
	-- the resize in case of non-opaque move).
	--kbresize_delay=1500,

	-- Opaque resize?
	--opaque_resize=false,

	-- Movement commands warp the pointer to frames instead of just
	-- changing focus. Enabled by default.
	--warp=true,

	-- Switch frames to display newly mapped windows
	--switchto=true,

	-- Default index for windows in frames: one of 'last', 'next' (for
	-- after current), or 'next-act' (for after current and anything with
	-- activity right after it).
	--frame_default_index='next',

	-- Auto-unsqueeze transients/menus/queries.
	--unsqueeze=true,

	-- Display notification tooltips for activity on hidden workspace.
	--screen_notify=true,
}


-- Load configuration.
dopath("cfg_bindings")
dopath("cfg_kludges")
dopath("cfg_layouts")

-- Load modules.
dopath("mod_query")
dopath("mod_menu")
dopath("mod_tiling")
dopath("mod_statusbar")
dopath("mod_sp")

dopath("vim_bindings")

-- mod_dock look useless for my purposes.
-- dopath("mod_dock")

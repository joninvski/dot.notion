-- $Id: cfg_sp.lua,v 1.1 2009/03/06 19:47:27 silas Exp $
--
-- Ion mod_sp configuration file

defbindings("WScreen", {
	bdoc("Toggle scratchpad."),
	kpress(META.."space", "mod_sp.set_shown_on(_, 'toggle')"),
})


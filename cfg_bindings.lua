-- $Id: cfg_bindings.lua,v 1.2 2009/03/17 22:59:52 silas Exp $
--
-- Bindings.

-- WScreen context bindings
--
-- The bindings in this context are available all the time.
--
-- The variable META should contain a string of the form 'Mod1+'
-- where Mod1 maybe replaced with the modifier you want to use for most
-- of the bindings. Similarly ALTMETA may be redefined to add a 
-- modifier to some of the F-key bindings.

defbindings("WScreen", {
	bdoc("Switch to n:th object (workspace, full screen client window) " ..
	     "within current screen."),
	kpress(META.."1", "WScreen.switch_nth(_, 0)"),
	kpress(META.."2", "WScreen.switch_nth(_, 1)"),
	kpress(META.."3", "WScreen.switch_nth(_, 2)"),
	kpress(META.."4", "WScreen.switch_nth(_, 3)"),
	kpress(META.."5", "WScreen.switch_nth(_, 4)"),
	kpress(META.."6", "WScreen.switch_nth(_, 5)"),
	kpress(META.."7", "WScreen.switch_nth(_, 6)"),
	kpress(META.."8", "WScreen.switch_nth(_, 7)"),
	kpress(META.."9", "WScreen.switch_nth(_, 8)"),
	kpress(META.."0", "WScreen.switch_nth(_, 9)"),

	bdoc("Switch to next/previous object within current screen."),
	kpress(META.."comma", "WScreen.switch_prev(_)"),
	kpress(META.."period", "WScreen.switch_next(_)"),

	submap(META..SUBMETA, {
		bdoc("Go to first region demanding attention or previously " ..
		     "active one."),
		kpress(SUBMETA, "mod_menu.grabmenu(_, _sub, 'focuslist')"),

		-- Some alternatives to command above:

		--kpress("K", "ioncore.goto_activity() or ..
		--	 "ioncore.goto_previous()"),

		--bdoc("Go to previous active object."),
		--kpress("K", "ioncore.goto_previous()"),

		--bdoc("Go to first object on activity/urgency list."),
		--kpress("I", "ioncore.goto_activity()"),

		bdoc("Clear all tags."),
		kpress("Y", "ioncore.tagged_clear()"),
	}),
	submap(META..SUBMETA_MOVE, {
		bdoc("Move current object within the frame left/right."),
		kpress("comma", "WFrame.dec_index(_, _sub)", "_sub:non-nil"),
		kpress("period", "WFrame.inc_index(_, _sub)", "_sub:non-nil"),
	}),

	-- XXX: For Xinerama-like setups?
	-- bdoc("Go to n:th screen on multihead setup."),
	-- kpress(META.."Shift+1", "ioncore.goto_nth_screen(0)"),
	-- kpress(META.."Shift+2", "ioncore.goto_nth_screen(1)"),

	-- bdoc("Go to next/previous screen on multihead setup."),
	-- kpress(META.."Shift+comma", "ioncore.goto_prev_screen()"),
	-- kpress(META.."Shift+period", "ioncore.goto_next_screen()"),

	bdoc("Create a new workspace of chosen default type."),
	kpress(META.."F9", "ioncore.create_ws(_)"),

	bdoc("Display the main menu."),
	kpress(ALTMETA.."F12",
	       "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"),
	-- Alternative, showing big menu.
	-- kpress(ALTMETA.."F12", "mod_menu.menu(_, _sub, 'mainmenu', {big=true})"),

	-- '_chld' used here stands to for an actual child window that may not
	-- be managed by the screen itself, unlike '_sub', that is likely to be
	-- the managing group of that window.
	bdoc("Forward-circulate focus."),
	kpress(META.."Tab", "ioncore.goto_next(_chld, 'right')",
	   "_chld:non-nil"),
	bdoc("Backward-circulate focus."),
	kpress(META.."Shift+Tab", "ioncore.goto_next(_chld, 'left')",
	   "_chld:non-nil"),
	submap(META..SUBMETA, {
	bdoc("Raise focused object, if possible."),
	kpress("AnyModifier+R", "WRegion.rqorder(_chld, 'front')",
	       "_chld:non-nil"),
	}),

	-- Mouse bindings in workspace.
	mpress("Button3", "mod_menu.pmenu(_, _sub, 'mainmenu')"),

	bdoc("Display the window list menu."),
	mpress("Button2", "mod_menu.pmenu(_, _sub, 'windowlist')"),

})


-- Client window bindings

defbindings("WClientWin", {
	submap(META..SUBMETA, {
		bdoc("Kill client owning the client window."),
		kpress("F4", "WClientWin.kill(_)"),

		bdoc("Nudge the client window. This might help with some "..
		 "programs' resizing problems."),
		kpress_wait("N", "WClientWin.nudge(_)"),

		bdoc("Send next key press to the client window. "..
		    "Some programs may not allow this by default."),
		kpress("Q", "WClientWin.quote_next(_)"),
	}),
})


-- Client window group bindings

defbindings("WGroupCW", {
	bdoc("Toggle client window group full-screen mode"),
	kpress_wait(META.."Return", "WGroup.set_fullscreen(_, 'toggle')"),
})


-- WMPlex context bindings. Bindings for frames and screens.
--
-- These bindings work in frames and on screens. The innermost of such
-- contexts/objects always gets to handle the key press. 

defbindings("WMPlex", {
	bdoc("Close current object."),
	kpress_wait(META.."F4", "WRegion.rqclose_propagate(_, _sub)"),

	submap(META..SUBMETA, {
		bdoc("Detach (float) or reattach an object to its previous " ..
		     "location."),
		-- By using _chld instead of _sub, we can detach/reattach
		-- queries attached to a group. The detach code checks if the
		-- parameter (_chld) is a group 'bottom' and detaches the whole
		-- group in that case.
		kpress("D", "ioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
	}),
})

-- Most common bindings, which are usually attached to function keys.
-- Frames for transient windows ignore this bindmap

defbindings("WMPlex.toplevel", {
	bdoc("Query for manual page to be displayed."),
	kpress(ALTMETA.."F1", "mod_query.query_man(_, '::man')"),

	bdoc("Show the Ion manual page."),
	kpress(META.."F1", "ioncore.exec_on(_, '::man ion3')"),

	-- TODO:  I should check whether or not tmux is available.  What about
	-- if screen is and tmux is not?
	bdoc("Run a terminal emulator with terminal multiplexer."),
	kpress(ALTMETA.."F2", "ioncore.exec_on(_, 'xterm')"),

	bdoc("Run a terminal emulator."),
	kpress(META.."F2", "ioncore.exec_on(_, 'xterm')"),

	bdoc("Query for command line to execute."),
	kpress(ALTMETA.."F3", "mod_query.query_exec(_)"),

	bdoc("Query for Lua code to execute."),
	kpress(META.."F3", "mod_query.query_lua(_)"),

	bdoc("Query for host to connect to with SSH."),
	kpress(ALTMETA.."F4", "mod_query.query_ssh(_, ':ssh')"),

	-- TODO
	-- bdoc("Query for file to edit."),
	-- kpress(ALTMETA.."F5",
	--   "mod_query.query_editfile(_, 'run-mailcap --action=edit')"),

	-- TODO
	-- bdoc("Query for file to view."),
	-- kpress(ALTMETA.."F6",
	--   "mod_query.query_runfile(_, 'run-mailcap --action=view')"),

	bdoc("Query for workspace to go to or create a new one."),
	kpress(ALTMETA.."F9", "mod_query.query_workspace(_)"),


	submap(META..SUBMETA, {
		bdoc("Toggle tag of current object."),
		kpress("T", "WRegion.set_tagged(_sub, 'toggle')", "_sub:non-nil"),

		bdoc("Query for a client window to go to."),
		kpress("G", "mod_query.query_gotoclient(_)"),

		bdoc("Display context menu."),
		kpress("C", "mod_query.query_menu(_, _sub, 'ctxmenu', 'Context menu:')"),
	}),
})


-- WFrame context bindings
--
-- These bindings are common to all types of frames. Some additional
-- frame bindings are found in some modules' configuration files.

defbindings("WFrame", {
	submap(META..SUBMETA, {
		bdoc("Maximize the frame horizontally/vertically."),
		kpress("X", "WFrame.maximize_horiz(_)"),
		kpress("Y", "WFrame.maximize_vert(_)"),

		bdoc("Show information about selected frame/window."),
		kpress("W", "mod_query.show_tree(_, _sub)"),

		bdoc("Begin move/resize mode."),
		kpress("R", "WFrame.begin_kbresize(_)"),
	}),

	-- Mouse binding.
	bdoc("Show the frame the user clicked on."),
	mclick("Button1@tab", "WFrame.p_switch_tab(_)"),
	mclick("Button2@tab", "WFrame.p_switch_tab(_)"),

	bdoc("Display context menu."),
	mpress("Button3", "mod_menu.pmenu(_, _sub, 'ctxmenu')"),

	bdoc("Resize the frame."),
	mdrag("Button1@border", "WFrame.p_resize(_)"),
	mdrag(META.."Button3", "WFrame.p_resize(_)"),

	bdoc("Move the frame."),
	mdrag(META.."Button1", "WFrame.p_move(_)"),

	bdoc("Move objects between frames by dragging and dropping the tab."),
	mdrag("Button1@tab", "WFrame.p_tabdrag(_)"),
	mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),
})

-- Frames for transient windows ignore this bindmap

defbindings("WFrame.toplevel", {
	submap(META..SUBMETA, {
		bdoc("Query for a client window to attach."),
		kpress("W", "mod_query.query_attachclient(_)"),

		-- Display tab numbers when modifiers are released
		submap_wait("ioncore.tabnum.show(_)"),

		bdoc("Switch to n:th object within the frame."),
		kpress("1", "WFrame.switch_nth(_, 0)"),
		kpress("2", "WFrame.switch_nth(_, 1)"),
		kpress("3", "WFrame.switch_nth(_, 2)"),
		kpress("4", "WFrame.switch_nth(_, 3)"),
		kpress("5", "WFrame.switch_nth(_, 4)"),
		kpress("6", "WFrame.switch_nth(_, 5)"),
		kpress("7", "WFrame.switch_nth(_, 6)"),
		kpress("8", "WFrame.switch_nth(_, 7)"),
		kpress("9", "WFrame.switch_nth(_, 8)"),
		kpress("0", "WFrame.switch_nth(_, 9)"),

		bdoc("Switch to next/previous object within the frame."),
		kpress("L", "WFrame.switch_next(_)"),
		kpress("H", "WFrame.switch_prev(_)"),

		bdoc("Attach tagged objects to this frame."),
		kpress("A", "ioncore.tagged_attach(_)"),
	}),
	submap(META..SUBMETA_MOVE, {
		bdoc("Move current object within the frame left/right."),
		kpress("H", "WFrame.dec_index(_, _sub)", "_sub:non-nil"),
		kpress("L", "WFrame.inc_index(_, _sub)", "_sub:non-nil"),
	}),
})

-- Bindings for floating frames.

defbindings("WFrame.floating", {
	bdoc("Toggle shade mode"),
	mdblclick("Button1@tab", "WFrame.set_shaded(_, 'toggle')"),

	bdoc("Raise the frame."),
	mpress("Button1@tab", "WRegion.rqorder(_, 'front')"),
	mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
	mclick(META.."Button1", "WRegion.rqorder(_, 'front')"),

	bdoc("Lower the frame."),
	mclick(META.."Button3", "WRegion.rqorder(_, 'back')"),

	bdoc("Move the frame."),
	mdrag("Button1@tab", "WFrame.p_move(_)"),
})


-- WMoveresMode context bindings
-- 
-- These bindings are available keyboard move/resize mode. The mode
-- is activated on frames with the command begin_kbresize (bound to
-- META.."R" above).

defbindings("WMoveresMode", {
	bdoc("Cancel the resize mode."),
	kpress("AnyModifier+Escape","WMoveresMode.cancel(_)"),

	bdoc("End the resize mode."),
	kpress("AnyModifier+Return","WMoveresMode.finish(_)"),

	bdoc("Grow in specified direction."),
	kpress("H",  "WMoveresMode.resize(_, 1, 0, 0, 0)"),
	kpress("L", "WMoveresMode.resize(_, 0, 1, 0, 0)"),
	kpress("K",    "WMoveresMode.resize(_, 0, 0, 1, 0)"),
	kpress("J",  "WMoveresMode.resize(_, 0, 0, 0, 1)"),

	bdoc("Shrink in specified direction."),
	kpress("Shift+H",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
	kpress("Shift+L", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
	kpress("Shift+K",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
	kpress("Shift+J",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),

	bdoc("Move in specified direction."),
	kpress(META.."H",     "WMoveresMode.move(_,-1, 0)"),
	kpress(META.."L",     "WMoveresMode.move(_, 1, 0)"),
	kpress(META.."K",     "WMoveresMode.move(_, 0,-1)"),
	kpress(META.."J",     "WMoveresMode.move(_, 0, 1)"),
})


--
-- Menus.
--


-- Main menu
defmenu("mainmenu", {
	menuentry("Run...",         "mod_query.query_exec(_)"),
	-- TODO:  I should check whether or not tmux is available.  What about
	-- if screen is and tmux is not?
	menuentry("Terminal",       "ioncore.exec_on(_, 'xterm -e tmux')"),
	menuentry("Lock screen",    "ioncore.exec_on(_, 'xlock -mode space')"),
	menuentry("Help",           "mod_query.query_man(_)"),
	menuentry("About Ion",      "mod_query.show_about_ion(_)"),
	submenu("Styles",           "stylemenu"),
	submenu("Session",          "sessionmenu"),
})

-- Session control menu
defmenu("sessionmenu", {
	menuentry("Save",           "ioncore.snapshot()"),
	menuentry("Restart",        "ioncore.restart()"),
	menuentry("Restart TWM",    "ioncore.restart_other('twm')"),
	menuentry("Exit",           "ioncore.shutdown()"),
})

-- Context menu (frame actions etc.)
defctxmenu("WFrame", "Frame", {
	-- Note: this propagates the close to any subwindows; it does not
	-- destroy the frame itself, unless empty. An entry to destroy tiled
	-- frames is configured in cfg_tiling.lua.
	menuentry("Close",          "WRegion.rqclose_propagate(_, _sub)"),
	-- Low-priority entries
	menuentry("Attach tagged", "ioncore.tagged_attach(_)", { priority = 0 }),
	menuentry("Clear tags",    "ioncore.tagged_clear()", { priority = 0 }),
	menuentry("Window info",   "mod_query.show_tree(_, _sub)", { priority = 0 }),
})

-- Context menu for groups (workspaces, client windows)
defctxmenu("WGroup", "Group", {
	menuentry("Toggle tag",     "WRegion.set_tagged(_, 'toggle')"),
	menuentry("De/reattach",    "ioncore.detach(_, 'toggle')"), 
})

-- Context menu for workspaces
defctxmenu("WGroupWS", "Workspace", {
	menuentry("Close",          "WRegion.rqclose(_)"),
	menuentry("Rename",         "mod_query.query_renameworkspace(nil, _)"),
	menuentry("Attach tagged",  "ioncore.tagged_attach(_)"),
})

-- Context menu for client windows
defctxmenu("WClientWin", "Client window", {
	menuentry("Kill",           "WClientWin.kill(_)"),
})

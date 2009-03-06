-- $Id: look.lua,v 1.1 2009/03/06 19:47:27 silas Exp $
--
-- Silas' look configuration file for Ion3 (based in original look_clean.lua
-- style.

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
	shadow_colour = "grey",
	highlight_colour = "grey",
	background_colour = "#0f1f4f",
	foreground_colour = "#9f9f9f",
	padding_pixels = 0,
	highlight_pixels = 1,
	shadow_pixels = 1,
	border_style = "elevated",
	font = "-misc-fixed-medium-r-*-*-12-*-*-*-*-60-*-*",
	text_align = "center",
})

de.defstyle("frame", {
	based_on = "*",
	padding_colour = "black",
	background_colour = "black",
	de.substyle("active", {
		shadow_colour = "#006699",
		highlight_colour = "#006699",
		padding_colour = "black",
		background_colour = "#ffffff",
	}),
	de.substyle("inactive", {
		shadow_colour = "black",
		highlight_colour = "black",
		padding_colour = "black",
		background_colour = "#ffffff",
	}),
})

de.defstyle("frame-tiled", {
	based_on = "frame",
	padding_pixels = 1,
	highlight_pixels = 0,
	shadow_pixels = 0,
	spacing = 0,
})

de.defstyle("tab", {
	based_on = "*",
	font = "-misc-fixed-medium-r-*-*-12-*-*-*-*-60-*-*",
	de.substyle("active-selected", {
		shadow_colour = "#006699",
		highlight_colour = "#006699",
		background_colour = "#003366",
		foreground_colour = "#ffffff",
	}),
	de.substyle("active-unselected", {
	shadow_colour = "#003366",
	highlight_colour = "#003366",
	background_colour = "#0f1f4f",
	foreground_colour = "#9f9f9f",
	}),
	de.substyle("inactive-selected", {
		shadow_colour = "#444444",
		highlight_colour = "#444444",
		background_colour = "#222222",
		foreground_colour = "#999999",
	}),
	de.substyle("inactive-unselected", {
		shadow_colour = "#333333",
		highlight_colour = "#333333",
		background_colour = "#111111",
		foreground_colour = "#999999",
	}),
	text_align = "center",
})

de.defstyle("tab-menuentry", {
	based_on = "tab",
	text_align = "left",
})

de.defstyle("tab-menuentry-big", {
	based_on = "tab-menuentry",
	font = "-misc-fixed-medium-r-*-*-12-*-*-*-*-60-*-*",
	padding_pixels = 7,
})

-- Defines style for input queries. In will be "blue" for queries in insert
-- mode and "green" for queries in normal (command) mode.
--
-- mode parameter is string: "insert" or "normal"
function inputstyle(mode)
	local t = {
		based_on = "*",
		shadow_colour = "", -- To be defined below
		highlight_colour = "", -- To be defined below
		background_colour = "", -- To be defined below
		foreground_colour = "#ffffff",
		padding_pixels = 1,
		highlight_pixels = 1,
		shadow_pixels = 1,
		border_style = "elevated",
		de.substyle("*-cursor", {
			background_colour = "white",
			foreground_colour = "#3f3f3f",
		}),
		de.substyle("*-selection", {
			background_colour = "black",
			foreground_colour = "white",
		}),
		font = "-misc-fixed-medium-r-*-*-12-*-*-*-*-60-*-*",
	}

	if mode == "insert" then
		-- Blue
		t.shadow_colour = "#006699"
		t.highlight_colour = "#006699"
		t.background_colour = "#003366"
	else
		-- Green
		t.shadow_colour = "#009966"
		t.highlight_colour = "#009966"
		t.background_colour = "#006633"
	end

	de.defstyle("input", t);
	gr.refresh()
end

dopath("lookcommon_clean")

gr.refresh()

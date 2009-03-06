-- $Id: cfg_kludges.lua,v 1.1 2009/03/06 19:47:27 silas Exp $
--
-- Options to get some programs work more nicely (or at all)

defwinprop {
	class = "AcroRead",
	instance = "documentShell",
	acrobatic = true
}

defwinprop {
	class = "Xpdf",
	instance = "openDialog_popup",
	ignore_cfgrq = true,
}

-- Some applications that work better when they float.

defwinprop {
	class = "XEyes",
	float = true,
}

-- Define some additional title shortening rules to use when the full
-- title doesn't fit in the available space. The first-defined matching
-- rule that succeeds in making the title short enough is used.
ioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*) - Mozilla", "$1$|$1$<...")
ioncore.defshortening("XMMS - (.*)", "$1$|...$>$1")
ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<...")
ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*)", "$1$|$1$<...")

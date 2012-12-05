TARGETS  = lib/statusd_apm.lua
TARGETS += lib/statusd_df.lua
TARGETS += lib/statusd_maildir.lua
TARGETS += lib/vim_bindings.lua

all: ${TARGETS}

lib/statusd_apm.lua: lib
	wget 'http://notion.git.sourceforge.net/git/gitweb.cgi?p=notion/contrib;a=blob_plain;f=statusd/statusd_apm2.lua;hb=HEAD' -O $@.tmp
	patch -p0 $@.tmp patches/statusd_apm2.lua.patch
	mv $@.tmp $@

lib/statusd_df.lua: lib
	wget 'http://notion.git.sourceforge.net/git/gitweb.cgi?p=notion/contrib;a=blob_plain;f=statusd/statusd_df.lua;hb=HEAD' -O $@.tmp
	patch -p0 $@.tmp patches/`basename $@`.patch
	mv $@.tmp $@

lib/statusd_maildir.lua: lib
	wget 'http://notion.git.sourceforge.net/git/gitweb.cgi?p=notion/contrib;a=blob_plain;f=statusd/statusd_maildir.lua;hb=HEAD' -O $@.tmp
	patch -p0 $@.tmp patches/`basename $@`.patch
	mv $@.tmp $@

lib/vim_bindings.lua: lib
	wget 'http://notion.git.sourceforge.net/git/gitweb.cgi?p=notion/contrib;a=blob_plain;f=keybindings/vim_bindings.lua;hb=HEAD' -O $@.tmp
	patch -p0 $@.tmp patches/`basename $@`.patch
	mv $@.tmp $@


lib:
	mkdir $@

.PHONY: clean
clean:
	rm -rf lib

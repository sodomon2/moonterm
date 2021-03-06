LUASTATIC ?= luastatic
LUA ?= lua5.1
LUA_INCLUDE ?= /usr/include/$(LUA)

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
DESKTOP_DIR ?= $(PREFIX)/share/applications

SRC = moonterm.lua src/moonterm-dialog.lua src/moonterm-app.lua  \
	src/moonterm-menu.lua src/moonterm-keybinds.lua libraries/LIP.lua \
	libraries/utils.lua

moonterm: 
	$(LUASTATIC) $(SRC) -l$(LUA) -I$(LUA_INCLUDE)
	@strip moonterm

install:
	install -Dm775 moonterm $(DESTDIR)$(BINDIR)/moonterm
	install -Dm775 data/moonterm.desktop $(DESTDIR)$(DESKTOP_DIR)/moonterm.desktop

uninstall:
	rm -rf $(DESTDIR)$(BINDIR)/moonterm
	rm -rf $(DESTDIR)$(DESKTOP_DIR)/moonterm.desktop

clean:
	rm -rf moonterm.luastatic.c
	rm -rf moonterm

.PHONY: moonterm
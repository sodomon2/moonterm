LUASTATIC ?= luastatic
LUA ?= lua5.1
LUA_INCLUDE ?= /usr/include/$(LUA)

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
DESKTOP_DIR ?= $(PREFIX)/share/applications

SRC = moonterm.lua src/moonterm-dialog.lua src/moonterm-app.lua  \
	src/moonterm-popover.lua libraries/LIP.lua libraries/utils.lua

moonterm: 
	$(LUASTATIC) $(SRC) -l$(LUA) -I$(LUA_INCLUDE)
	@strip moonterm

install:
	install -Dm644 moonterm $(DESTDIR)$(BINDIR)/moonterm
	install -Dm644 moonterm.desktop $(DESTDIR)$(DESKTOP_DIR)/moonterm.desktop

uninstall:
	rm -r $(DESTDIR)$(BINDIR)/moonterm
	rm -r $(DESTDIR)$(DESKTOP_DIR)/moonterm.desktop

clean:
	rm -r moonterm.luastatic.c
	rm -r moonterm

.PHONY: moonterm
LUASTATIC ?= luastatic
LUA ?= lua5.1
LUA_INCLUDE ?= /usr/include/$(LUA)

PREFIX ?= /usr/local
DESTDIR ?= $(PREFIX)/bin
DESKTOP_DIR ?= $(PREFIX)/share/applications

SRC = moonterm.lua src/moonterm-dialog.lua src/moonterm-app.lua  \
	src/moonterm-popover.lua libraries/LIP.lua libraries/utils.lua

moonterm: 
	$(LUASTATIC) $(SRC) -l$(LUA) -I$(LUA_INCLUDE)
	@strip moonterm

install:
	install -m775 moonterm $(DESTDIR)
	install -m775 moonterm.desktop $(DESKTOP_DIR)

uninstall:
	rm -r $(DESTDIR)/moonterm
	rm -r $(DESKTOP_DIR)/moonterm.desktop

clean:
	rm -r moonterm.luastatic.c
	rm -r moonterm

.PHONY: moonterm
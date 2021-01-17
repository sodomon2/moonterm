LUASTATIC ?= luastatic
LUA ?= lua5.1
LUA_INCLUDE ?= /usr/include/$(LUA)

PREFIX ?= /usr/local
DESTDIR ?= $(PREFIX)/bin

SRC = moonterm.lua moonterm-dialog.lua libraries/LIP.lua libraries/utils.lua

moonterm: 
	$(LUASTATIC) $(SRC) -l$(LUA) -I$(LUA_INCLUDE)
	@strip moonterm

install:
	install -m775 moonterm $(DESTDIR)

uninstall:
	rm -r $(DESTDIR)/moonterm

clean:
	rm -r moonterm.luastatic.c
	rm -r moonterm

.PHONY: moonterm
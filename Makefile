LUASTATIC ?= luastatic
LUA ?= lua5.1
LUA_INCLUDE ?= /usr/include/$(LUA)

PREFIX ?= /usr/local
DESTDIR ?= $(PREFIX)/bin

moonterm: 
	$(LUASTATIC) moonterm.lua -l$(LUA) -I$(LUA_INCLUDE)

install:
	install -m775 moonterm $(DESTDIR)

uninstall:
	rm -r $(DESTDIR)/moonterm

clean:
	rm -r moonterm.luastatic.c
	rm -r moonterm

.PHONY: moonterm
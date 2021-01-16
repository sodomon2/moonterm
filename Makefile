LUASTATIC ?= luastatic
LUA ?= lua5.1
LUA_INCLUDE ?= /usr/include/$(LUA)

PREFIX ?= /usr/local
INSTALL_DIR = $(PREFIX)/bin

moonterm: 
	$(LUASTATIC) moonterm.lua -l$(LUA) -I$(LUA_INCLUDE)

install:
	install -m775 moonterm $(INSTALL_DIR)

uninstall:
	rm -r $(INSTALL_DIR)/moonterm

clean:
	rm -r moonterm.luastatic.c
	rm -r moonterm

.PHONY: moonterm
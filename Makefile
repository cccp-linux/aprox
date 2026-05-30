# Makefile

PREFIX      ?= /usr/local
BINDIR      ?= $(PREFIX)/bin
SYSCONFDIR  ?= $(PREFIX)/etc
UNITDIR     ?= $(PREFIX)/lib/systemd/system
DESTDIR     ?=

BIN  = aprox aprox-clean
CONF = aprox.conf
UNIT = aprox.service aprox.socket aprox-clean.service aprox-clean.timer

GENERATED = $(patsubst %.in,%,$(wildcard *.in))

.PHONY: all install uninstall clean

all: $(GENERATED)

install: $(GENERATED)
	install -Dm755 -t $(DESTDIR)$(BINDIR)       $(BIN)
	install -Dm644 -t $(DESTDIR)$(SYSCONFDIR)   $(CONF)
	install -Dm644 -t $(DESTDIR)$(UNITDIR)      $(UNIT)

uninstall:
	rm -f $(addprefix $(DESTDIR)$(BINDIR)/,     $(BIN))
	rm -f $(addprefix $(DESTDIR)$(SYSCONFDIR)/, $(CONF))
	rm -f $(addprefix $(DESTDIR)$(UNITDIR)/,    $(UNIT))

clean:
	rm -f $(GENERATED)

%: %.in
	sed -e 's|@BINDIR@|$(BINDIR)|g' \
	    -e 's|@SYSCONFDIR@|$(SYSCONFDIR)|g' $< > $@

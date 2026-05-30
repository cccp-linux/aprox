# Makefile

PREFIX  ?= /usr/local
BINDIR  ?= $(PREFIX)/bin
UNITDIR ?= $(PREFIX)/lib/systemd/system
DESTDIR ?=

BIN = aprox aprox-clean
UNIT = aprox.service aprox.socket aprox-clean.service aprox-clean.timer

GENERATED = $(patsubst %.in,%,$(wildcard *.in))

.PHONY: all install uninstall clean

all: $(GENERATED)

install: $(GENERATED)
	install -Dm755 -t $(DESTDIR)$(BINDIR) $(BIN)
	install -Dm644 -t $(DESTDIR)$(UNITDIR) $(UNIT)

uninstall:
	rm -f $(addprefix $(DESTDIR)$(BINDIR)/, $(BIN))
	rm -f $(addprefix $(DESTDIR)$(UNITDIR)/, $(UNIT))

clean:
	rm -f $(GENERATED)

%: %.in
	sed -e 's|@BINDIR@|$(BINDIR)|g' $< > $@

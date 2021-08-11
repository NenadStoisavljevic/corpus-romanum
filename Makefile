.POSIX:

ifndef PREFIX
  PREFIX = /usr/local
endif
ifndef MANPREFIX
  MANPREFIX = $(PREFIX)/share/man
endif

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bin/latintag $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/latintag
	mkdir -p $(DESTDIR)$(PREFIX)/share/bibliotheca-latina
	chmod 755 $(DESTDIR)$(PREFIX)/share/bibliotheca-latina

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/latintag
	rm -rf $(DESTDIR)$(PREFIX)/share/bibliotheca-latina

.PHONY: install uninstall

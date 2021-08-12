.POSIX:

ifndef PREFIX
  PREFIX = /usr/local
endif
ifndef MANPREFIX
  MANPREFIX = $(PREFIX)/share/man
endif

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bin/bl $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/bl
	mkdir -p $(DESTDIR)$(PREFIX)/share/bibliotheca-latina
	chmod 755 $(DESTDIR)$(PREFIX)/share/bibliotheca-latina
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f bl.1 $(DESTDIR)$(MANPREFIX)/man1/bl.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/bl.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/bl
	rm -rf $(DESTDIR)$(PREFIX)/share/bibliotheca-latina
	rm -f $(DESTDIR)$(MANPREFIX)/man1/bl.1

.PHONY: install uninstall

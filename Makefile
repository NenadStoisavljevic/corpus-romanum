.POSIX:

ifndef PREFIX
  PREFIX = /usr/local
endif
ifndef MANPREFIX
  MANPREFIX = $(PREFIX)/share/man
endif

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bin/corpus $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/corpus
	mkdir -p $(DESTDIR)$(PREFIX)/share/corpus-romanum
	chmod 755 $(DESTDIR)$(PREFIX)/share/corpus-romanum
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f corpus.1 $(DESTDIR)$(MANPREFIX)/man1/corpus.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/corpus.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/corpus
	rm -rf $(DESTDIR)$(PREFIX)/share/corpus-romanum
	rm -f $(DESTDIR)$(MANPREFIX)/man1/corpus.1

.PHONY: install uninstall

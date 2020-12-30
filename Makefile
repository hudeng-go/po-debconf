
prefix 	= /usr

all:
	$(MAKE) -C doc
	$(MAKE) fix

fix: debconf-gettextize debconf-updatepo po2debconf

debconf-updatepo po2debconf: FORCE
	@sed \
   -e 's@\(: \$${PODEBCONF_LIB=\)[^}]*}@\1$(prefix)/share/intltool-debian}@' \
   -e 's@\(: \$${PODEBCONF_ENCODINGS=\)[^}]*}@\1$(prefix)/share/po-debconf/encodings}@' \
		$@ > $@.tmp && mv $@.tmp $@
	@chmod a+x $@

debconf-gettextize: FORCE
	@sed \
   -e 's@\(\$$ENV{PODEBCONF_LIB} ||= \)[^;]*;@\1"$(prefix)/share/intltool-debian";@' \
   -e 's@\(\$$ENV{PODEBCONF_ENCODINGS} ||= \)[^;]*;@\1"$(prefix)/share/po-debconf/encodings";@' \
   -e 's@\(\$$ENV{PODEBCONF_HEADER} ||= \)[^;]*;@\1"$(prefix)/share/po-debconf/pot-header";@' \
		$@ > $@.tmp && mv $@.tmp $@
	@chmod a+x $@

reset: FORCE
	@$(MAKE) all prefix=/usr

clean:
	@$(MAKE) -C doc clean
	-@rm -rf tests/tmp

deb:
	fakeroot debian/rules clean
	dh_clean
	dpkg-buildpackage -rfakeroot -ICVS -I.cvsignore -I.scvsrc -I.git -I.gitignore

.PHONY: FORCE fix reset


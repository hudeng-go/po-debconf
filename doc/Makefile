VERSION = $(shell cd ..; dpkg-parsechangelog | grep -m 1 Version | sed -e 's/Version: //' -e 's/-.*//' -e 's/[[:blank:]]*//g')

pod2man = pod2man -utf8 -r '' -c po-debconf

MANS = debconf-gettextize.1 debconf-updatepo.1 \
  po2debconf.1 podebconf-display-po.1 podebconf-report-po.1 \
  po-debconf.7

default:
	po4a -v --previous --rm-backups \
	     --package-name po-debconf \
	     --package-version $(VERSION) \
	     --msgid-bugs-address po-debconf@packages.debian.org \
	     po4a/po-debconf.cfg
	for l in de en es fr pt ru vi; do \
	  for m in $(MANS); do \
	    test -f $$l/$$m.pod || continue; \
	    s=`echo $$m | sed -e 's/.*\.//'`; \
	    p=`echo $$m | sed -e 's/\..//'`; \
	    cp $$l/$$m.pod $$p.pod; \
	    $(pod2man) --section=$$s $$p.pod > $$l/$$p.$$s; \
# Fix the POD quotes (--quotes is not sufficient for the French quotes) \
	    case $$l in \
	      de) \
	        sed -i -e 's/ds C` ""$$/ds C` »/' \
	               -e "s/ds C' \"\"$$/ds C' «/" \
	               $$l/$$p.$$s; \
	        ;; \
	      fr) \
	        sed -i -e 's/ds C` ""$$/ds C` «\\ /' \
	               -e "s/ds C' \"\"$$/ds C' \\\\ »/" \
	               $$l/$$p.$$s; \
	        ;; \
	    esac; \
	    rm -f $$p.pod; \
	    test $$l = en || mv $$l/$$p.$$s $$l/$$p.$$l.$$s; \
	  done; \
	done
	# groff does not support UTF-8 pages.
	@echo build the Vietnames HTML pages
	for m in $(MANS); do \
	    test -f vi/$$m.pod || continue; \
	    pod2html --quiet --noindex vi/$$m.pod > vi/$$m.html; \
	done

clean:
	po4a --previous --rm-translations --rm-backups po4a/po-debconf.cfg
	-rm -f de/*.? en/*.? fr/*.? pt/*.? ru/*.? vi/*.? vi/*.?.html pod2htmd.tmp pod2htmi.tmp


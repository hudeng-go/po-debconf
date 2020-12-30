#! /usr/bin/perl -w

use strict;
use Test;
use File::Path;
use File::Copy;

BEGIN { plan tests => 7 }

rmtree ("tmp");
mkdir ("tmp", 0755);
chdir ("tmp");
copy("../04/tmpl", "tmpl");
mkdir ("po", 0755);
copy("../04/po/POTFILES.in", "po/POTFILES.in");
copy("../04/po/fr.po", "po/fr.po");
ok(system("../../debconf-updatepo", "--podir=po"), 0);
ok(system("test `diff po/templates.pot ../results/04/po/templates.pot | wc -l` -eq 4"), 0);
ok(system("cmp po/fr.po ../04/po/fr.po"), 0);

ok(system("../../po2debconf", "--podir=po", "-o", "merged", "tmpl"), 0);
ok(system("cmp merged ../results/04/merged"), 0);

copy("../04/tmpl2", "tmpl");
ok(system("../../po2debconf", "--podir=po", "-o", "merged", "tmpl"), 0);
ok(system("cmp merged ../results/04/merged2"), 0);


#! /usr/bin/perl -w

use strict;
use Test;
use File::Path;
use File::Copy;

BEGIN { plan tests => 5 }

rmtree ("tmp");
mkdir ("tmp", 0755);
chdir ("tmp");
copy("../01/tmpl", "templates");
copy("../01/tmpl.fr", "templates.fr");
copy("../01/tmpl.pt_BR", "templates.pt_BR");

ok(system("../../debconf-gettextize", "templates"), 0);

ok(system("cmp", "po/POTFILES.in", "../results/01/po/POTFILES.in"), 0);
ok(system("cmp", "templates", "../results/01/tmpl"), 0);
#   POT-Creation-Date differ
ok(system("test `diff po/fr.po ../results/01/po/fr.po | wc -l` -eq 4"), 0);
ok(system("test `diff po/pt_BR.po ../results/01/po/pt_BR.po | wc -l` -eq 4"), 0);


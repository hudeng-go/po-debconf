#! /usr/bin/perl -w

use strict;
use Test;
use File::Path;
use File::Copy;

BEGIN { plan tests => 4 }

$ENV{XGETTEXT_ARGS} = '--omit-header';

rmtree ("tmp");
mkdir ("tmp", 0755);
chdir ("tmp");
copy("../02/tmpl1", "tmpl");
mkdir ("po", 0755);
copy("../02/po/POTFILES.in", "po/POTFILES.in");

ok(system("../../debconf-updatepo", "--skip-merge", "tmpl"), 0);
ok(system("cmp po/templates.pot ../results/02/po/templates.pot1"), 0);

copy("../02/tmpl2", "tmpl");

ok(system("../../debconf-updatepo", "--skip-merge", "tmpl"), 0);
ok(system("cmp po/templates.pot ../results/02/po/templates.pot2"), 0);


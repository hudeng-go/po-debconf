#! /usr/bin/perl -w

use strict;
use Test;
use File::Path;
use File::Copy;

BEGIN { plan tests => 6 }

rmtree ("tmp");
mkdir ("tmp", 0755);
chdir ("tmp");
copy("../03/tmpl1", "tmpl");
mkdir ("po", 0755);
copy("../03/po/POTFILES.in", "po/POTFILES.in");
copy("../03/po/fr.po", "po/fr.po");

#  Check for flag:translate
ok(system("../../po2debconf", "--podir=po", "-o", "merged", "tmpl"), 0);
ok(system("cmp merged ../results/03/merged1"), 0);

#  Check for flag:translate
copy("../03/tmpl2", "tmpl");
ok(system("../../po2debconf", "--podir=po", "-o", "merged", "tmpl"), 0);
ok(system("cmp merged ../results/03/merged2"), 0);

#  Check for flag:partial
copy("../03/tmpl3", "tmpl");
ok(system("../../po2debconf", "--podir=po", "-o", "merged", "tmpl"), 0);
ok(system("cmp merged ../results/03/merged3"), 0);


#! /usr/bin/perl -w

use strict;
use Test::Harness;
use Cwd 'abs_path';

my @test_files = qw(
        01a-debconf-gettextize-a.pl
        02-extract-flags.pl
        03-merge-flags.pl
        04-po2debconf.pl
);

my $root = abs_path('..');

$ENV{PODEBCONF_ENCODINGS} = "$root/encodings";
$ENV{PODEBCONF_HEADER} = "$root/pot-header";

$ENV{PATH} = $root.':'.$ENV{PATH};

runtests(@test_files);

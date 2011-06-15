# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

# Test.
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['a', '@import', 'file.css'],
);
my $ret = $obj->flush;
is($ret, '@import "file.css";');

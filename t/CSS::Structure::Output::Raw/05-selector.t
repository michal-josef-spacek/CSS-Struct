# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 3;

# Test.
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['s', 'body'],
);
my $ret = $obj->flush;
is($ret, '');

# Test.
$obj->reset;
$obj->put(
	['s', 'body'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body{}');

# Test.
$obj->reset;
$obj->put(
	['s', 'body'],
	['s', 'div'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body,div{}');

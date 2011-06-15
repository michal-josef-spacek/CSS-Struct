# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Raw;
use File::Object;
use Test::More 'tests' => 2;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

# Test.
my $obj = CSS::Structure::Output::Raw->new(
	'output_handler' => \*STDOUT,
);
my $ret = get_stdout(
	$obj, 1, 
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
is($ret, 'selector{attr:value;}');

# Test.
$obj = CSS::Structure::Output::Raw->new(
	'auto_flush' => 1,
	'output_handler' => \*STDOUT,
);
$ret = get_stdout(
	$obj, 1, 
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
is($ret, 'selector{attr:value;}');

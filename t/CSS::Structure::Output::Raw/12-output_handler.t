# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Raw;
use File::Object;
use Test::More 'tests' => 2;
use Test::Output;

# Test.
my $obj = CSS::Structure::Output::Raw->new(
	'output_handler' => \*STDOUT,
);
stdout_is(
	sub {
		$obj->put(
			['s', 'selector'],
			['d', 'attr', 'value'],
			['e'],
		);
		$obj->flush;
		return;
	},
	'selector{attr:value;}',
);

# Test.
$obj = CSS::Structure::Output::Raw->new(
	'auto_flush' => 1,
	'output_handler' => \*STDOUT,
);
stdout_is(
	sub {
		$obj->put(
			['s', 'selector'],
			['d', 'attr', 'value'],
			['e'],
		);
		return;
	},
	'selector{attr:value;}',
);

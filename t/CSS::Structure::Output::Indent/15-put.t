# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

# Test.
my $obj = CSS::Structure::Output::Indent->new(
	'skip_bad_types' => 1,
);
$obj->put(
	['x', 'bad selector'],
);
my $ret = $obj->flush;
is($ret, '');

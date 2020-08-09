use strict;
use warnings;

use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

# Test.
my $obj = CSS::Structure::Output::Raw->new(
	'skip_bad_types' => 1,
);
$obj->put(
	['x', 'bad selector'],
);
my $ret = $obj->flush;
is($ret, '');

# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: put() method.\n";

# Test.
$obj = CSS::Structure::Output::Raw->new(
	'skip_bad_types' => 1,
);
$obj->put(
	['x', 'bad selector'],
);
$ret = $obj->flush;
is($ret, '');

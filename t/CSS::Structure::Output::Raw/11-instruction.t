# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 2;

# Test.
my $obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 1,
);
$obj->put(
	['i', 'target', 'code'],
);
my $ret = $obj->flush;
is($ret, '');

# Test.
$obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 0,
);
$obj->put(
	['i', 'target', 'code'],
);
$ret = $obj->flush;
is($ret, '/*targetcode*/');

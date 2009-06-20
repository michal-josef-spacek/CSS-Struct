# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 2;

print "Testing: Instruction without comments.\n";
my $obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 1,
);
$obj->put(
	['i', 'target', 'code'],
);
my $ret = $obj->flush;
is($ret, '');

print "Testing: Instruction.\n";
$obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 0,
);
$obj->put(
	['i', 'target', 'code'],
);
$ret = $obj->flush;
is($ret, '/*targetcode*/');

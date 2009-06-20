# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

print "Testing: Instruction.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['i', 'target', 'code'],
);
my $ret = $obj->flush;
is($ret, '/*targetcode*/');

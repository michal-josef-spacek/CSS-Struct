# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

print "Testing: Raw data.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['r', 'raw'],
);
my $ret = $obj->flush;
is($ret, 'raw');

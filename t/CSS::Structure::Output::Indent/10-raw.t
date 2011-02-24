# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

print "Testing: Indent data.\n";
my $obj = CSS::Structure::Output::Indent->new;
$obj->put(
	['r', 'raw'],
);
my $ret = $obj->flush;
is($ret, 'raw');

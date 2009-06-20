# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 3;

print "Testing: Selector.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['s', 'body'],
);
my $ret = $obj->flush;
is($ret, '');

$obj->reset;
$obj->put(
	['s', 'body'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body{}');

$obj->reset;
$obj->put(
	['s', 'body'],
	['s', 'div'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body,div{}');

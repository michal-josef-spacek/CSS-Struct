# Modules.
use CSS::Structure::Output::Raw;
#use Test::More 'tests' => 0;
use Test::More 'skip_all' => 'Everything bad.';

print "Testing: Selector.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['s', 'body'],
);
my $ret = $obj->flush;
#is($ret, 'body{}');

$obj->reset;
$obj->put(
	['s', 'body'],
	['e'],
);
$ret = $obj->flush;
#is($ret, 'body{}');

$obj->reset;
$obj->put(
	['s', 'body', 'div'],
	['e'],
);
$ret = $obj->flush;
#is($ret, 'body,div{}');

# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 3;

print "Testing: Definition.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['s', 'body'],
	['d', 'attr', 'value'],
	['e'],
);
my $ret = $obj->flush;
is($ret, 'body{attr:value;}');

$obj->reset;
$obj->put(
	['s', 'body'],
	['d', 'attr1', 'value1'],
	['d', 'attr2', 'value2'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body{attr1:value1;attr2:value2;}');

$obj->reset;
$obj->put(
	['s', 'body'],
	['s', 'div'],
	['d', 'attr1', 'value1'],
	['d', 'attr2', 'value2'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body,div{attr1:value1;attr2:value2;}');

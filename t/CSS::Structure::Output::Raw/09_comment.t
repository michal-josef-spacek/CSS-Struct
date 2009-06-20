# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 4;

print "Testing: Without comment.\n";
my $obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 1,
);
$obj->put(
	['c', 'comment'],
);
my $ret = $obj->flush;
is($ret, '');

print "Testing: Comment.\n";
$obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 0,
);
$obj->put(
	['c', 'comment'],
);
$ret = $obj->flush;
is($ret, '/*comment*/');

$obj->reset;
$obj->put(
	['s', 'body'],
	['c', 'comment'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body{/*comment*/}');

$obj->reset;
$obj->put(
	['s', 'body'],
	['d', 'attr1', 'value1'],
	['c', 'comment'],
	['d', 'attr2', 'value2'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body{attr1:value1;/*comment*/attr2:value2;}');

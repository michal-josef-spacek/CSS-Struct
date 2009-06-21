# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 4;

print "Testing: flush() method.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
my $ret = $obj->flush;
my $right_ret = 'selector{attr:value;}';
is($ret, $right_ret);

$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush;
is($ret, $right_ret x 2);

$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush(1);
is($ret, $right_ret x 3);

$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush;
is($ret, $right_ret);

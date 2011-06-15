# Modules.
use CSS::Structure::Output::Raw;
use English qw(-no_match_vars);
use Test::More 'tests' => 2;

# Test.
my $obj = CSS::Structure::Output::Raw->new;
eval {
	$obj->put(
		['e'],
	);
};
is($EVAL_ERROR, "No opened selector.\n");

# Test.
$obj->reset;
$obj->put(
	['s', 'body'],
	['e'],
);
$ret = $obj->flush;
is($ret, 'body{}');

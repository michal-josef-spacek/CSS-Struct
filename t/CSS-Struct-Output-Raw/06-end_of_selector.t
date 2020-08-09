use strict;
use warnings;

use CSS::Struct::Output::Raw;
use English qw(-no_match_vars);
use Test::More 'tests' => 2;

# Test.
my $obj = CSS::Struct::Output::Raw->new;
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
my $ret = $obj->flush;
is($ret, 'body{}');

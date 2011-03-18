# Modules.
use CSS::Structure::Output::Indent;
use English qw(-no_match_vars);
use Test::More 'tests' => 4;

# Debug message.
print "Testing: Errors testing.\n";

# Test.
my $obj = CSS::Structure::Output::Indent->new;
eval {
	$obj->put('String');
};
is($EVAL_ERROR, "Bad data.\n");

# Test.
eval {
	$obj->put(
		['s'],
	);
};
is($EVAL_ERROR, "Bad number of arguments.\n");

# Test.
$obj->reset;
eval {
	$obj->put(
		['s', 'selector', 'bad_selector'],
	);
};
is($EVAL_ERROR, "Bad number of arguments.\n");

# Test.
$obj = CSS::Structure::Output::Indent->new(
	'skip_bad_types' => 0,
);
eval {
	$obj->put(
		['q', 'bad data'],
	);
};
is($EVAL_ERROR, "Bad type of data.\n");

# Modules.
use CSS::Structure::Output::Core;
use English qw(-no_match_vars);
use Test::More 'tests' => 4;

print "Testing: Errors testing.\n";
my $obj = CSS::Structure::Output::Core->new;
eval {
	$obj->put('String');
};
is($EVAL_ERROR, "Bad data.\n");

eval {
	$obj->put(
		['s'],
	);
};
is($EVAL_ERROR, "Bad number of arguments.\n");

$obj->reset;
eval {
	$obj->put(
		['s', 'selector', 'bad_selector'],
	);
};
is($EVAL_ERROR, "Bad number of arguments.\n");

$obj = CSS::Structure::Output::Core->new(
	'skip_bad_types' => 0,
);
eval {
	$obj->put(
		['q', 'bad data'],
	);
};
is($EVAL_ERROR, "Bad type of data.\n");

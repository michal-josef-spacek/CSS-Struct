# Modules.
use CSS::Structure::Output::Core;
use English qw(-no_match_vars);
use Test::More 'tests' => 9;

# Debug message.
print "Testing: Constructor.\n";

# Test.
eval {
	$obj = CSS::Structure::Output::Core->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

# Test.
eval {
	$obj = CSS::Structure::Output::Core->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");

# Test.
eval {
	$obj = CSS::Structure::Output::Core->new(
		'output_handler' => '',
	);
};
is($EVAL_ERROR, 'Output handler is bad file handler.'."\n");

# Test.
eval {
	$obj = CSS::Structure::Output::Core->new(
		'comment_delimeters' => 'x',
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

# Test.
eval {
	$obj = CSS::Structure::Output::Core->new(
		'comment_delimeters' => [q{/*}, 'x'],
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

# Test.
eval {
	$obj = CSS::Structure::Output::Core->new(
		'comment_delimeters' => ['x', 'x'],
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

# Test.
eval {
	$obj = CSS::Structure::Output::Core->new(
		'auto_flush' => 1,
	);
};
is($EVAL_ERROR, 'Auto-flush can\'t use without output handler.'."\n");

# Test.
my $obj = CSS::Structure::Output::Core->new;
ok(defined $obj);
ok($obj->isa('CSS::Structure::Output::Core'));

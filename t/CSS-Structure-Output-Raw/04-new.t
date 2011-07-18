# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Raw;
use English qw(-no_match_vars);
use Test::More 'tests' => 8;

# Test.
my $obj = CSS::Structure::Output::Raw->new;
ok(defined $obj);
ok($obj->isa('CSS::Structure::Output::Raw'));

# Test.
eval {
	CSS::Structure::Output::Raw->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

# Test.
eval {
	CSS::Structure::Output::Raw->new(
		'output_handler' => '',
	);
};
is($EVAL_ERROR, 'Output handler is bad file handler.'."\n");

# Test.
eval {
	CSS::Structure::Output::Raw->new(
		'comment_delimeters' => 'x',
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

# Test.
eval {
	CSS::Structure::Output::Raw->new(
		'comment_delimeters' => [q{/*}, 'x'],
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

# Test.
eval {
	CSS::Structure::Output::Raw->new(
		'comment_delimeters' => ['x', 'x'],
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

# Test.
eval {
	CSS::Structure::Output::Raw->new(
		'auto_flush' => 1,
	);
};
is($EVAL_ERROR, 'Auto-flush can\'t use without output handler.'."\n");

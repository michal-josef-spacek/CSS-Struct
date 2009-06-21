# Modules.
use CSS::Structure::Output::Indent;
use English qw(-no_match_vars);
use Test::More 'tests' => 8;

print "Testing: new() plain constructor.\n";
my $obj = CSS::Structure::Output::Indent->new;
ok(defined $obj);
ok($obj->isa('CSS::Structure::Output::Indent'));

print "Testing: new() empty constructor.\n";
eval {
	$obj = CSS::Structure::Output::Indent->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

print "Testing: new('output_handler' = '') bad constructor.\n";
eval {
	$obj = CSS::Structure::Output::Indent->new(
		'output_handler' => '',
	);
};
is($EVAL_ERROR, 'Output handler is bad file handler.'."\n");

print "Testing: new('comment_delimeters' => 'x']) bad constructor.\n";
eval {
	$obj = CSS::Structure::Output::Indent->new(
		'comment_delimeters' => 'x',
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

print "Testing: new('comment_delimeters' => [q{/*}, 'x']) bad constructor.\n";
eval {
	$obj = CSS::Structure::Output::Indent->new(
		'comment_delimeters' => [q{/*}, 'x'],
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

print "Testing: new('comment_delimeters' => ['x', 'x']) bad constructor.\n";
eval {
	$obj = CSS::Structure::Output::Indent->new(
		'comment_delimeters' => ['x', 'x'],
	);
};
is($EVAL_ERROR, "Bad comment delimeters.\n");

print "Testing: new('auto_flush' => 1) bad constructor.\n";
eval {
	$obj = CSS::Structure::Output::Indent->new(
		'auto_flush' => 1,
	);
};
is($EVAL_ERROR, 'Auto-flush can\'t use without output handler.'."\n");

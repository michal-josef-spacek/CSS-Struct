# Modules.
use CSS::Structure::Output::Core;
use English qw(-no_match_vars);
use Test::More 'tests' => 5;

print "Testing: new('') bad constructor.\n";
my $obj;
eval {
	$obj = CSS::Structure::Output::Core->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

print "Testing: new('something' => 'value') bad constructor.\n";
eval {
	$obj = CSS::Structure::Output::Core->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");

print "Testing: new('output_handler' = '') bad constructor.\n";
eval {
	$obj = CSS::Structure::Output::Core->new(
		'output_handler' => '',
	);
};
is($EVAL_ERROR, 'Output handler is bad file handler.'."\n");

print "Testing: new() right constructor.\n";
$obj = CSS::Structure::Output::Core->new;
ok(defined $obj);
ok($obj->isa('CSS::Structure::Output::Core'));

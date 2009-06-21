# Tests directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use CSS::Structure::Output::Core;
use Test::More 'tests' => 1;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: Output handler.\n";
my $obj = CSS::Structure::Output::Core->new(
	'output_handler' => \*STDOUT,
);
my $ret = get_stdout(
	$obj, 1, 
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
my $right_ret = <<'END';
Selector
Definition
End of selector
END
chomp $right_ret;
is($ret, $right_ret);

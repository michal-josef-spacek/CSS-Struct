# Modules.
use CSS::Structure::Output::Indent;
use File::Object;
use Test::More 'tests' => 2;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Output handler.\n";
my $obj = CSS::Structure::Output::Indent->new(
	'output_handler' => \*STDOUT,
);
my $ret = get_stdout(
	$obj, 1, 
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
my $right_ret = <<'END';
selector {
	attr: value;
}
END
chomp $right_ret;
is($ret, $right_ret);

$obj = CSS::Structure::Output::Indent->new(
	'auto_flush' => 1,
	'output_handler' => \*STDOUT,
);
$ret = get_stdout(
	$obj, 1, 
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
is($ret, $right_ret);

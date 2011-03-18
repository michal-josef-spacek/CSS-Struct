# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 2;

# Debug message.
print "Testing: Instruction without comments.\n";

# Test.
my $obj = CSS::Structure::Output::Indent->new(
	'skip_comments' => 1,
);
$obj->put(
	['i', 'target', 'code'],
);
my $ret = $obj->flush;
is($ret, '');

# Debug message.
print "Testing: Instruction.\n";

# Test.
$obj = CSS::Structure::Output::Indent->new(
	'skip_comments' => 0,
);
$obj->put(
	['i', 'target', 'code'],
);
$ret = $obj->flush;
is($ret, "/* targetcode */");

# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: At-rules.\n";

# Test.
my $obj = CSS::Structure::Output::Indent->new;
$obj->put(
	['a', '@import', 'file.css'],
);
my $ret = $obj->flush;
is($ret, '@import "file.css";');

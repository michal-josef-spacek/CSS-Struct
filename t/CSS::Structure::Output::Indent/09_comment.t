# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

print "Testing: Comment.\n";
my $obj = CSS::Structure::Output::Indent->new;
$obj->put(
	['c', 'comment'],
);
my $ret = $obj->flush;
is($ret, "/* comment */\n");

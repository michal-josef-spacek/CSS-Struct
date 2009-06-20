# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

print "Testing: Comment.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['c', 'comment'],
);
my $ret = $obj->flush;
is($ret, '/*comment*/');

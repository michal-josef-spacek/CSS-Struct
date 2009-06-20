# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 2;

print "Testing: Without comment.\n";
my $obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 1,
);
$obj->put(
	['c', 'comment'],
);
my $ret = $obj->flush;
is($ret, '');

print "Testing: Comment.\n";
$obj = CSS::Structure::Output::Raw->new(
	'skip_comments' => 0,
);
$obj->put(
	['c', 'comment'],
);
$ret = $obj->flush;
is($ret, '/*comment*/');

# TODO komentare mezi kodem.

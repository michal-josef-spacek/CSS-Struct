# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

print "Testing: At-rules.\n";
my $obj = CSS::Structure::Output::Raw->new;
$obj->put(
	['a', '@import', 'file.css'],
);
my $ret = $obj->flush;
is($ret, '@import "file.css";');

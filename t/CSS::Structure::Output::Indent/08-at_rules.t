# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

# Test.
my $obj = CSS::Structure::Output::Indent->new;
$obj->put(
	['a', '@import', 'file.css'],
);
my $ret = $obj->flush;
is($ret, '@import "file.css";');

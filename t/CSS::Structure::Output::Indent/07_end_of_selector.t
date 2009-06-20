# Modules.
use CSS::Structure::Output::Indent;
use English qw(-no_match_vars);
use Test::More 'tests' => 2;

print "Testing: End of selector.\n";
my $obj = CSS::Structure::Output::Indent->new;
eval {
	$obj->put(
		['e'],
	);
};
is($EVAL_ERROR, "Bad ending of selector.\n");

$obj->reset;
$obj = CSS::Structure::Output::Indent->new;
$obj->put(
	['s', 'body'],
	['e'],
);
$ret = $obj->flush;
my $right_ret = <<'END';
body {
}
END
is($ret, $right_ret);

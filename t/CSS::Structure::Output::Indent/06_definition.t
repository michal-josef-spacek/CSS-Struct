# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 2;

print "Testing: Definition.\n";
my $obj = CSS::Structure::Output::Indent->new;
$obj->put(
	['s', 'body'],
	['d', 'attr', 'value'],
	['e'],
);
my $ret = $obj->flush;
my $right_ret = <<'END';
body {
	attr: value;
}
END
is($ret, $right_ret);

$obj->reset;
$obj->put(
	['s', 'body'],
	['d', 'attr1', 'value1'],
	['d', 'attr2', 'value2'],
	['e'],
);
$ret = $obj->flush;
$right_ret = <<'END';
body {
	attr1: value1;
	attr2: value2;
}
END
is($ret, $right_ret);

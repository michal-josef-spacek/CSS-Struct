# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 6;

print "Testing: Without comment.\n";
my $obj = CSS::Structure::Output::Indent->new(
	'skip_comments' => 1,
);
$obj->put(
	['c', 'comment'],
);
my $ret = $obj->flush;
is($ret, '');

print "Testing: Comment.\n";
$obj = CSS::Structure::Output::Indent->new(
	'skip_comments' => 0,
);
$obj->put(
	['c', 'comment'],
);
$ret = $obj->flush;
is($ret, "/* comment */");

$obj->reset;
$obj->put(
	['s', 'body'],
	['c', 'comment'],
	['e'],
);
$ret = $obj->flush;
my $right_ret = <<'END';
body {
	/* comment */
}
END
chomp $right_ret;
is($ret, $right_ret);

$obj->reset;
$obj->put(
	['s', 'body'],
	['c', 'comment1'],
	['c', 'comment2'],
	['e'],
);
$ret = $obj->flush;
$right_ret = <<'END';
body {
	/* comment1 */
	/* comment2 */
}
END
chomp $right_ret;
is($ret, $right_ret);

$obj->reset;
$obj->put(
	['s', 'body'],
	['d', 'attr1', 'value1'],
	['c', 'comment'],
	['d', 'attr2', 'value2'],
	['e'],
);
$ret = $obj->flush;
$right_ret = <<'END';
body {
	attr1: value1;

	/* comment */
	attr2: value2;
}
END
chomp $right_ret;
is($ret, $right_ret);

$obj->reset;
$obj->put(
	['s', 'body'],
	['d', 'attr1', 'value1'],
	['c', 'comment1'],
	['c', 'comment2'],
	['d', 'attr2', 'value2'],
	['e'],
);
$ret = $obj->flush;
$right_ret = <<'END';
body {
	attr1: value1;

	/* comment1 */
	/* comment2 */
	attr2: value2;
}
END
chomp $right_ret;
is($ret, $right_ret);

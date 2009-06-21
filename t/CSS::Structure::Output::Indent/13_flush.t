# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 4;

print "Testing: flush() method.\n";
my $obj = CSS::Structure::Output::Indent->new;
$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
my $ret = $obj->flush;
my $right_ret = <<'END';
selector {
	attr: value;
}
END
chomp $right_ret;
is($ret, $right_ret);

$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush;
$right_ret = <<'END';
selector {
	attr: value;
}
selector {
	attr: value;
}
END
chomp $right_ret;
is($ret, $right_ret);

$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush(1);
$right_ret = <<'END';
selector {
	attr: value;
}
selector {
	attr: value;
}
selector {
	attr: value;
}
END
chomp $right_ret;
is($ret, $right_ret);

$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush;
$right_ret = <<'END';
selector {
	attr: value;
}
END
chomp $right_ret;
is($ret, $right_ret);

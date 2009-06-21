# Modules.
use CSS::Structure::Output::Core;
use Test::More 'tests' => 4;

print "Testing: flush() method.\n";
my $obj = CSS::Structure::Output::Core->new;
$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
my $ret = $obj->flush;
my $right_ret = <<'END';
Selector
Definition
End of selector
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
Selector
Definition
End of selector
Selector
Definition
End of selector
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
Selector
Definition
End of selector
Selector
Definition
End of selector
Selector
Definition
End of selector
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
Selector
Definition
End of selector
END
chomp $right_ret;
is($ret, $right_ret);

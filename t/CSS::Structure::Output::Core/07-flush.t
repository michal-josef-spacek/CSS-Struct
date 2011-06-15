# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Core;
use English qw(-no_match_vars);
use Test::More 'tests' => 5;

# Test.
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

# Test.
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

# Test.
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

# Test.
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

SKIP: {
	eval {
		require File::Temp;
	};
	if ($EVAL_ERROR) {
		skip 'File::Temp not installed', 1;
	};
	my $temp_fh = File::Temp::tempfile();
	$obj = CSS::Structure::Output::Core->new(
		'output_handler' => $temp_fh,
	);
	$obj->put(
		['s', 'selector'],
		['d', 'attr', 'value'],
		['e'],
	);
	$temp_fh->close;
	eval {
		$ret = $obj->flush;
	};
	is($EVAL_ERROR, "Cannot write to output handler.\n");
}

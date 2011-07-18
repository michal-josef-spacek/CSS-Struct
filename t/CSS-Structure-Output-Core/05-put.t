# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Core;
use Test::More 'tests' => 2;

# Test.
my $obj = CSS::Structure::Output::Core->new;
$obj->put(
	['a', 'at-rule'],
	['c', 'comment'],
	['d', 'definition'],
	['e'],
	['i', 'target', 'code'],
	['r', 'raw data'],
	['s', 'selector'],
);
my $ret = $obj->flush;
my $right_ret = <<'END';
At-rule
Comment
Definition
End of selector
Instruction
Raw data
Selector
END
chomp $right_ret;
is($ret, $right_ret);

# Test.
$obj = CSS::Structure::Output::Core->new(
	'skip_bad_types' => 1,
);
$obj->put(
	['x', 'bad selector'],
);
$ret = $obj->flush;
is($ret, '');

use strict;
use warnings;

use CSS::Struct::Output::Raw;
use Test::More 'tests' => 1;

# Test.
my $obj = CSS::Struct::Output::Raw->new;
$obj->put(
	['r', 'raw'],
);
my $ret = $obj->flush;
is($ret, 'raw');

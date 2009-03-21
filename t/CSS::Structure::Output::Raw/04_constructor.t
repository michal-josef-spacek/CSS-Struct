# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 3;

print "Testing: new() plain constructor.\n";
my $obj = CSS::Structure::Output::Raw->new;
ok(defined $obj);
ok($obj->isa('CSS::Structure::Output::Raw'));

print "Testing: new() empty constructor.\n";
eval {
	$obj = CSS::Structure::Output::Raw->new('');
};
is($@, "Unknown parameter ''.\n");

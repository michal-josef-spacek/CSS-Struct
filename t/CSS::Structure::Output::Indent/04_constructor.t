# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 3;

print "Testing: new() plain constructor.\n";
my $obj = CSS::Structure::Output::Indent->new;
ok(defined $obj);
ok($obj->isa('CSS::Structure::Output::Indent'));

print "Testing: new() empty constructor.\n";
eval {
	$obj = CSS::Structure::Output::Indent->new('');
};
is($@, "Unknown parameter ''.\n");

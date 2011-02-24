# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($CSS::Structure::Output::Raw::VERSION, '0.01');

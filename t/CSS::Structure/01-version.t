# Modules.
use CSS::Structure;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: version.\n";

# Test.
is($CSS::Structure::VERSION, '0.01');

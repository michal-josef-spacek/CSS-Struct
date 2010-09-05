# Modules.
use CSS::Structure::Utils;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: version.\n";

# Test.
is($CSS::Structure::Utils::VERSION, '0.01');

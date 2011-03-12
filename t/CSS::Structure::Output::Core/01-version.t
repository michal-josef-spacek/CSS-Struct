# Modules.
use CSS::Structure::Output::Core;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: Version.\n";

# Test.
is($CSS::Structure::Output::Core::VERSION, '0.01');

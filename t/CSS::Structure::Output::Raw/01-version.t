# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: version.\n";

# Test.
is($CSS::Structure::Output::Raw::VERSION, '0.01');

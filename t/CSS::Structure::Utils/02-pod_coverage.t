# Modules.
use Test::Pod::Coverage 'tests' => 1;

# Debug message.
print "Testing: Pod coverage.\n";

# Test.
pod_coverage_ok('CSS::Structure::Utils', 'CSS::Structure::Utils is covered.');

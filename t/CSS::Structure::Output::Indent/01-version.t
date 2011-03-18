# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: version.\n";

# Test.
is($CSS::Structure::Output::Indent::VERSION, '0.01');

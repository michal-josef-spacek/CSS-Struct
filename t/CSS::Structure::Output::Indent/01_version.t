# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($CSS::Structure::Output::Indent::VERSION, '0.01');

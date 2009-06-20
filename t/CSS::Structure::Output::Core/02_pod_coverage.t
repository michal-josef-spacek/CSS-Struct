# Modules.
use Test::Pod::Coverage 'tests' => 1;

print "Testing: Pod coverage.\n";
pod_coverage_ok('CSS::Structure::Output::Core',
	'CSS::Structure::Output::Core is covered.');

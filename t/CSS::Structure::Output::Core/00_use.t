# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('CSS::Structure::Output::Core');
}
require_ok('CSS::Structure::Output::Core');

# Modules.
use Test::More 'tests' => 2;

BEGIN {

	# Debug message.
	print "Usage tests.\n";

	# Test.
	use_ok('CSS::Structure::Output::Raw');
}

# Test.
require_ok('CSS::Structure::Output::Raw');

# Modules.
use Test::More 'tests' => 2;

BEGIN {

	# Debug comment.
	print "Usage tests.\n";

	# Test.
	use_ok('CSS::Structure::Utils');
}

# Test.
require_ok('CSS::Structure::Utils');

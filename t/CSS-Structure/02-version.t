use strict;
use warnings;

use CSS::Structure;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($CSS::Structure::VERSION, 0.01, 'Version.');

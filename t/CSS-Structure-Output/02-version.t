use strict;
use warnings;

use CSS::Structure::Output;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($CSS::Structure::Output::VERSION, 0.01, 'Version.');

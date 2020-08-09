use strict;
use warnings;

use CSS::Structure::Output::Raw;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($CSS::Structure::Output::Raw::VERSION, 0.01, 'Version.');

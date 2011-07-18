# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Raw;
use Test::More 'tests' => 1;

# Test.
is($CSS::Structure::Output::Raw::VERSION, 0.01, 'Version.');

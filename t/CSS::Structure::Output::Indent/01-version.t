# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Output::Indent;
use Test::More 'tests' => 1;

# Test.
is($CSS::Structure::Output::Indent::VERSION, 0.01, 'Version.');

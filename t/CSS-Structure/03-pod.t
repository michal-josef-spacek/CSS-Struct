# Pragmas.
use strict;
use warnings;

# Modules.
use English qw(-no_match_vars);
use File::Object;
use Test::More 'tests' => 1;
use Test::Pod;

# Test.
SKIP: {
	if ($PERL_VERSION lt v5.8.0) {
		skip 'Perl version lesser then 5.8.0.', 1;
	}
	pod_file_ok(File::Object->new->up(2)->file('Structure.pm')->s);
};
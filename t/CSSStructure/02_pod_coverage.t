# Modules.
use Test::Pod::Coverage;

print "Testing: pod coverage.\n" if $debug;
pod_coverage_ok('CSS::Structure', 'CSS::Structure has complete POD.');

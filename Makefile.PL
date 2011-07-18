# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Structure oriented CSS manipulation.';
author 'Michal Špaček <skim@cpan.org>';
license 'bsd';
name 'CSS-Structure';
requires 'Class::Utils' => 0.01;
requires 'Error::Pure' => 0.01;
requires 'List::MoreUtils' => 0;
requires 'Readonly' => 0;
resources 'repository' => {
	'url' => 'git://github.com/tupinek/CSS::Structure',
	'web' => 'https://github.com/tupinek/CSS::Structure',
	'type' => 'git',
};
test_requires 'English' => 0;
test_requires 'File::Object' => 0.01;
test_requires 'Test::More' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();

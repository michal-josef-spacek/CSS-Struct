# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Structure oriented CSS manipulation.';
author 'Michal Spacek <skim@cpan.org>';
license 'bsd';
name 'CSS-Structure';
readme_from 'Structure.pm';
requires 'Class::Utils' => 0.03;
requires 'Error::Pure' => 0.11;
requires 'List::MoreUtils' => 0;
requires 'Readonly' => 0;
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=CSS-Structure';
resources 'homepage' => 'https://github.com/tupinek/CSS-Structure';
resources 'repository' => 'git://github.com/tupinek/CSS-Structure';
test_requires 'English' => 0;
test_requires 'File::Object' => 0.05;
test_requires 'Test::More' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();

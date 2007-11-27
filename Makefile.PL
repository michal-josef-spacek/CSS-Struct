# $Id: Makefile.PL,v 1.2 2007-11-27 13:21:48 skim Exp $

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'CSS::Structure',
	'PREREQ_PM' => {
		'Error::Simple::Multiple' => 0.04,
	},
	'VERSION' => 0.01,
);

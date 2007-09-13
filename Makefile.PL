# $Id: Makefile.PL,v 1.1 2007-09-13 00:22:54 skim Exp $

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'CSS::Structure',
	'PREREQ_PM' => {
		'Error::Simple::Multiple' => 0.03,
	},
	'VERSION' => 0.01,
);

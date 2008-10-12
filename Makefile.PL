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

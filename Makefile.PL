# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'CSS::Structure',
	'PREREQ_PM' => {
		'Error::Simple::Multiple' => 0.04,
	},
	'VERSION' => 0.01,
	'test' => {
		'TESTS' => 't/CSS::Structure/*.t '.
			't/CSS::Structure::Output::Indent/*.t '.
			't/CSS::Structure::Output::Raw/*.t',
	},
);

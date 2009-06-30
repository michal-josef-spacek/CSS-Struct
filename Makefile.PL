# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'CSS::Structure',
	'PREREQ_PM' => {
		'Error::Simple::Multiple' => 0.05,
		'File::Object' => 0,
		'List::MoreUtils' => 0,
		'Readonly' => 0,
	},
	'VERSION' => 0.01,
	'test' => {
		'TESTS' => 't/CSS::Structure/*.t '.
			't/CSS::Structure::Output::Core/*.t '.
			't/CSS::Structure::Output::Indent/*.t '.
			't/CSS::Structure::Output::Raw/*.t '.
			't/CSS::Structure::Utils/*.t',
	},
);

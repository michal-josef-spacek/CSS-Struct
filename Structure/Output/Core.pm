#------------------------------------------------------------------------------
package CSS::Structure::Output::Core;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use CSS::Structure::Utils qw(set_params);
use Error::Simple::Multiple qw(err);
use List::MoreUtils qw(none);

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Get default parameters.
	$self->_default_parameters;

	# Process params.
	set_params($self, @params);

	# Check parameters to right values.
	$self->_check_params;

	# Reset.
	$self->reset;

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub flush {
#------------------------------------------------------------------------------
# Flush CSS structure in object.

	my ($self, $reset_flag) = @_;
	my $ouf = $self->{'output_handler'};
	my $ret;
	if (ref $self->{'flush_code'} eq 'ARRAY') {
		$ret = join $self->{'output_sep'}, @{$self->{'flush_code'}};
	} else {
		$ret = $self->{'flush_code'};
	}
	if ($ouf) {
		no warnings;
		print {$ouf} $ret or err 'Cannot write to output handler.';
		undef $ret;
	}

	# Reset.
	if ($reset_flag) {
		$self->reset;
	}

	# Return string.
	return $ret;
}


#------------------------------------------------------------------------------
sub put {
#------------------------------------------------------------------------------
# Put CSS structure code.

	my ($self, @data) = @_;

	# For every data.
	foreach my $css_structure_ar (@data) {

		# Bad data.
		if (ref $css_structure_ar ne 'ARRAY') {
			err 'Bad data.';
		}

		# Split to type and main CSS structure.
		my ($type, @css_struct) = @{$css_structure_ar};

		# Attributes.
		if ($type eq 'a') {
			$self->_check_arguments(\@css_struct, 1, 2);
			$self->_put_at_rules(@css_struct);

		# Comment.
		} elsif ($type eq 'c') {
			$self->_put_comment(@css_struct);

		# Definition.
		} elsif ($type eq 'd') {
			$self->_check_arguments(\@css_struct, 1, 2);
			$self->_put_definition(@css_struct);

		# End of selector.
		} elsif ($type eq 'e') {
			$self->_check_arguments(\@css_struct, 0, 0);
			$self->_put_end_of_selector;

		# Instruction.
		} elsif ($type eq 'i') {
			$self->_check_arguments(\@css_struct, 1, 2);
			$self->_put_instruction(@css_struct);

		# Raw data.
		} elsif ($type eq 'r') {
			$self->_put_raw(@css_struct);

		# Selector.
		} elsif ($type eq 's') {
			$self->_check_arguments(\@css_struct, 1, 1);
			$self->_put_selector(@css_struct);

		# Other.
		} else {
			if (! $self->{'skip_bad_types'}) {
				err 'Bad type of data.', 'type', $type;
			}
		}
	}

	# Auto-flush.
	if ($self->{'auto_flush'}) {
		$self->flush;
		$self->_reset_flush_code;
	}

	return;
}


#------------------------------------------------------------------------------
sub reset {
#------------------------------------------------------------------------------
# Resets internal variables.

	my $self = shift;

	# Tmp code.
	$self->{'tmp_code'} = [];

	# Flush code.
	$self->_reset_flush_code;

	# Open selector flag.
	$self->{'open_selector'} = 0;

	return;
}

#------------------------------------------------------------------------------
# Private methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _check_arguments {
#------------------------------------------------------------------------------
# Check arguments.

	my ($self, $css_structure_ar, $min_arg_num, $max_arg_num) = @_;
	my $arg_num = scalar @{$css_structure_ar};
	if ($arg_num < $min_arg_num || $arg_num > $max_arg_num) {
		err 'Bad number of arguments.',
			'\'CSS::Structure\' structure',
			join ', ', @{$css_structure_ar};
	}
	return;
}

#------------------------------------------------------------------------------
sub _check_opened_selector {
#------------------------------------------------------------------------------
# Check to opened selector.

	my $self = shift;
	if (! $self->{'open_selector'}) {
		err 'No opened selector.';
	}
	return;
}

#------------------------------------------------------------------------------
sub _default_parameters {
#------------------------------------------------------------------------------
# Default parameters.

	my $self = shift;

	# Auto flush flag.
	$self->{'auto_flush'} = 0;

	# CSS comment delimeters.
	$self->{'comment_delimeters'} = [q{/*}, q{*/}];

	# Set output handler.
	$self->{'output_handler'} = undef;

	# Output separator.
	$self->{'output_sep'} = "\n";

	# Skip bad 'CSS::Structure' types.
	$self->{'skip_bad_types'} = 0;

	# Skip comments.
	$self->{'skip_comments'} = 0;

	return;
}

#------------------------------------------------------------------------------
sub _check_params {
#------------------------------------------------------------------------------
# Check parameters to rigth values.

	my $self = shift;

	# Check to output handler.
	if (defined $self->{'output_handler'}
		&& ref $self->{'output_handler'} ne 'GLOB') {

		err 'Output handler is bad file handler.';
	}
	# Check auto-flush only with output handler.
	if ($self->{'auto_flush'} && ! defined $self->{'output_handler'}) {
		err 'Auto-flush can\'t use without output handler.';
	}

	# Check to comment delimeters.
	if (ref $self->{'comment_delimeters'} ne 'ARRAY'
		|| (none { $_ eq $self->{'comment_delimeters'}->[0] }
		(q{/*}, '<!--'))
		|| (none { $_ eq $self->{'comment_delimeters'}->[1] }
		(q{*/}, '-->'))) {

		err 'Bad comment delimeters.';
	}

	return;
}

#------------------------------------------------------------------------------
sub _put_at_rules {
#------------------------------------------------------------------------------
# At-rules.

	my ($self, $at_rule, $file) = @_;
	push @{$self->{'flush_code'}}, 'At-rule';
	return;
}

#------------------------------------------------------------------------------
sub _put_comment {
#------------------------------------------------------------------------------
# Comment.

	my ($self, @comments) = @_;
	push @{$self->{'flush_code'}}, 'Comment';
	return;
}

#------------------------------------------------------------------------------
sub _put_definition {
#------------------------------------------------------------------------------
# Definition.

	my ($self, $key, $value) = @_;
	push @{$self->{'flush_code'}}, 'Definition';
	return;
}

#------------------------------------------------------------------------------
sub _put_end_of_selector {
#------------------------------------------------------------------------------
# End of selector.

	my $self = shift;
	push @{$self->{'flush_code'}}, 'End of selector';
	return;
}

#------------------------------------------------------------------------------
sub _put_instruction {
#------------------------------------------------------------------------------
# Instruction.

	my ($self, $target, $code) = @_;
	push @{$self->{'flush_code'}}, 'Instruction';
	return;
}

#------------------------------------------------------------------------------
sub _put_raw {
#------------------------------------------------------------------------------
# Raw data.

	my ($self, @raw_data) = @_;
	push @{$self->{'flush_code'}}, 'Raw data';
	return;
}

#------------------------------------------------------------------------------
sub _put_selector {
#------------------------------------------------------------------------------
# Selectors.

	my ($self, $selector) = @_;
	push @{$self->{'flush_code'}}, 'Selector';
	return;
}

#------------------------------------------------------------------------------
sub _reset_flush_code {
#------------------------------------------------------------------------------
# Reset flush code.

	my $self = shift;
	$self->{'flush_code'} = [];
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

CSS::Structure::Output::Core - Base class for CSS::Structure::Output::*.

=head1 SYNOPSIS

 use CSS::Structure::Output::Raw;
 my $css = CSS::Structure::Output::Core->new(%parameters);
 $css->put(@data);
 $css->flush($reset_flag);
 $css->reset;

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=over 8

=item * B<auto_flush>

 Auto flush flag.
 Default is 0.

=item * B<comment_delimeters>

 Reference to array with begin and end comment delimeter.
 Default value is ['/*', '*/'].
 Possible values are:
 - ['/*', '*/']
 - ['<!--', '-->'],

=item * B<output_handler>

 Handler for print output strings.
 Must be a GLOB.
 Default value is undef.

=item * B<output_sep>

 Output separator.
 Default value is newline.

=item * B<skip_bad_types>

 Flag, that means bad 'CSS::Structure' types skipping.
 Default value is 0.

=item * B<skip_comments>

 Flag, that means comment skipping.
 Default value is 0.

=back

=item B<flush($reset_flag)>

 Flush CSS structure in object.
 If defined 'output_handler' flush to its.
 Or return code.
 If enabled $reset_flag, then resets internal variables via reset method.

=item B<put(@data)>

 Put CSS structure in format specified in L<CSS::Structure(3pm)>.

=item B<reset()>

 Resets internal variables.

=back

=head1 ERRORS

 Mine:
   Auto-flush can't use without output handler.
   Bad comment delimeters.
   Bad data.
   Bad number of arguments.
     ('CSS::Structure' structure array),
   Bad type of data.
   Cannot write to output handler.
   No opened selector.
   Output handler is bad file handler.

 From CSS::Structure::Utils:
   Unknown parameter '%s'.

=head1 DEPENDENCIES

L<CSS::Structure::Utils(3pm)>,
L<Error::Simple::Multiple(3pm)>,
L<List::MoreUtils(3pm)>.

=head1 SEE ALSO

L<CSS::Structure(3pm)>,
L<CSS::Structure::Utils(3pm)>,
L<CSS::Structure::Output::Indent(3pm)>,
L<CSS::Structure::Output::Raw(3pm)>.

=head1 AUTHOR

Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut

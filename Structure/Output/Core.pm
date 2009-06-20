#------------------------------------------------------------------------------
package CSS::Structure::Output::Core;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use List::MoreUtils qw(none);

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Set output handler.
	$self->{'output_handler'} = undef;

	# Skip bad tags.
	$self->{'skip_bad_tags'} = 0;

	# CSS comment delimeters.
	$self->{'comment_delimeters'} = ['/*', '*/'];

	# Process params.
	while (@params) {
		my $key = shift @params;
		my $val = shift @params;
		if (! exists $self->{$key}) {
			err "Unknown parameter '$key'.";
		}
		$self->{$key} = $val;
	}

	# Check to output handler.
	if (defined $self->{'output_handler'} 
		&& ref $self->{'output_handler'} ne 'GLOB') {

		err 'Output handler is bad file handler.';
	}

	# Check to comment delimeters.
	if ((none { $_ eq $self->{'comment_delimeters'}->[0] }
		('/*', '<!--'))
		|| (none { $_ eq $self->{'comment_delimeters'}->[1] }
		('*/', '-->'))) {
		
		err 'Bad comment delimeters.';
	}

	# Reset.
	$self->reset;

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub flush {
#------------------------------------------------------------------------------
# Flush css structure in object.

	my ($self, $reset_flag) = @_;
	my $ouf = $self->{'output_handler'};
	my $ret;
	if (ref $self->{'flush_code'} eq 'ARRAY') {
		my $output_sep = $self->{'output_sep'}
			? $self->{'output_sep'}
			: "\n";
		$ret = join $output_sep, @{$self->{'flush_code'}};
	} else {
		$ret = $self->{'flush_code'};
	}
	if ($ouf) {
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
# Put css structure code.

	my ($self, @data) = @_;

	# For every data.
	foreach my $css_structure_ar (@data) {

		# Bad data.
		if (ref $css_structure_ar ne 'ARRAY') {
			err 'Bad data.';
		}

		# Split to type and main css structure.
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
			if (! $self->{'skip_bad_tags'}) {
				err 'Bad type of data.';
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

	my ($self, $tags_struct_ar, $min_arg_num, $max_arg_num) = @_;
	my $arg_num = scalar @{$tags_struct_ar};
	if ($arg_num < $min_arg_num || $arg_num > $max_arg_num) {
		err 'Bad number of arguments.', 
			'\'Tags2\' structure', join ', ', @{$tags_struct_ar};
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
	push @{$self->{'flush_code'}}, "End of selector";
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

 CSS::Structure::Output::Core - TODO

=head1 SYNOPSIS

 use CSS::Structure::Output::Raw;
 my $css = CSS::Structure::Output::Core->new(
         # TODO 
 );
 $css->put(
         ['s', 'foo'],
         ['d', 'weight', '100px'],
         ['e'],
 );
 $css->flush;
 $css->reset;

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=over 8

=item * B<skip_bad_tags>

 TODO

=item * B<comment_delimeters>

 TODO

=back

=item B<flush()>

 TODO

=item B<put()>

 TODO

=item B<reset()>

 TODO

=back

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>,
L<List::MoreUtils(3pm)>,
L<Readonly(3pm)>.

=head1 SEE ALSO

L<CSS::Structure(3pm)>,
L<CSS::Structure::Output::Indent(3pm)>,
L<CSS::Structure::Output::Raw(3pm)>.

=head1 AUTHOR

 Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

 0.01

=cut

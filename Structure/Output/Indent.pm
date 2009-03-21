#------------------------------------------------------------------------------
package CSS::Structure::Output::Indent;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use List::MoreUtils qw(none);
use Readonly;

# Constants.
Readonly::Scalar my $EMPTY_STR => q{};
Readonly::Scalar my $SPACE => q{ };

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

	# Indent string.
	$self->{'indent_string'} = "\t";

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

	my $self = shift;
	my $ouf = $self->{'output_handler'};
	if ($ouf) {
		print {$ouf} $self->{'flush_code'};
		return;
	} else {
		return $self->{'flush_code'};
	}
}

#------------------------------------------------------------------------------
sub put {
#------------------------------------------------------------------------------
# Put css structure code.

	my ($self, @data) = @_;

	# For every data.
	foreach my $dat (@data) {

		# Bad data.
		if (ref $dat ne 'ARRAY') {
			err 'Bad data.';
		}

		# Detect and process data.
		$self->_detect_data($dat);
	}
	return;
}

#------------------------------------------------------------------------------
sub reset {
#------------------------------------------------------------------------------
# Resets internal variables.

	my $self = shift;

	# Flush code.
	$self->{'flush_code'} = $EMPTY_STR;

	# Tmp code.
	$self->{'tmp_code'} = [];

	# Open selector flag.
	$self->{'open_selector'} = 0;

	# Any processed selector.
	$self->{'processed'} = 0;

	# Indent flag.
	$self->{'indent_flag'} = 0;

	return;
}

#------------------------------------------------------------------------------
# Private methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _detect_data {
#------------------------------------------------------------------------------
# Detect and process data.

	my ($self, $data) = @_;

	# Definitions.
	if ($data->[0] eq 'd') {
		if (scalar @{$self->{'tmp_code'}}) {
			$self->_flush_tmp;
		}
		if (! $self->{'open_selector'}) {
			err 'No selector.';
		}
		shift @{$data};
		while (@{$data}) {
			my $par = shift @{$data};
			my $val = shift @{$data};
			$self->{'flush_code'} .= $self->{'indent_string'}.
				$par.': '.$val.";\n";
		}
		$self->{'processed'} = 1;

	# At-rule.
	# TODO
	} elsif ($data->[0] eq 'a') {
		$self->{'flush_code'} .= $data->[1];
		$self->{'processed'} = 1;

	# Begin of selector.
	} elsif ($data->[0] eq 's') {
		push @{$self->{'tmp_code'}}, "$data->[1]";
		$self->{'open_selector'} = 1;
		$self->{'indent_flag'} = 1;

	# Comment.
	} elsif ($data->[0] eq 'c') {
		shift @{$data};
		if (scalar @{$self->{'tmp_code'}}) {
			$self->_flush_tmp;
		}
		if ($self->{'processed'}) {
			$self->{'flush_code'} .= "\n";
		}
		if ($self->{'indent_flag'}) {
			$self->{'flush_code'} .= $self->{'indent_string'};
		}
		$self->{'flush_code'} .= $self->{'comment_delimeters'}->[0].
			$SPACE;
		foreach my $d (@{$data}) {
			$self->{'flush_code'} .= ref $d eq 'SCALAR' ? ${$d}
				: $d;
		}
		$self->{'flush_code'} .= $SPACE.
			$self->{'comment_delimeters'}->[1]."\n";;
		$self->{'processed'} = 0;

	# End of selector.
	} elsif ($data->[0] eq 'e') {
		if (! $self->{'open_selector'}) {
			err 'Bad ending of selector.';
		}
		if (scalar @{$self->{'tmp_code'}}) {
			$self->_flush_tmp;
		}
		$self->{'flush_code'} .= "}\n";
		$self->{'open_selector'} = 0;
		$self->{'processed'} = 1;
		$self->{'indent_flag'} = 0;

	# Raw data.
	} elsif ($data->[0] eq 'r') {
		shift @{$data};
		while (@{$data}) {
			my $data = shift @{$data};
			$self->{'flush_code'} .= $data;
		}

	# Other.
	} else {
		if ($self->{'skip_bad_tags'}) {
			err 'Bad type of data.';
		}
	}
	return;
}

#------------------------------------------------------------------------------
sub _flush_tmp {
#------------------------------------------------------------------------------
# Flush $self->{'tmp_code'}.

	my $self = shift;
	if ($self->{'processed'}) {
		$self->{'flush_code'} .= "\n";
	}
	$self->{'flush_code'} .= join(', ', @{$self->{'tmp_code'}})." {\n";
	$self->{'tmp_code'} = [];
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

 CSS::Structure::Output::Indent - Indent printing 'CSS::Structure' structure to css code.

=head1 SYNOPSIS

 use CSS::Structure::Output::Indent;
 my $t = CSS::Structure::Output::Indent->new(
         'output_handler' => \*STDOUT,
 );
 $t->put(
         ['s', 'blam'],
         ['d', 'weight', '100px'],
         ['e'],
 );
 $t->finalize;
 $t->flush;
 $t->reset;

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=over 8

=item * B<output_handler>

 Handler for print output strings.
 Default is undef.

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

L<Readonly(3pm)>,
L<Error::Simple::Multiple(3pm)>.

=head1 SEE ALSO

L<CSS::Structure(3pm)>,
L<CSS::Structure::Output::Raw(3pm)>.

=head1 AUTHOR

 Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

 0.01

=cut

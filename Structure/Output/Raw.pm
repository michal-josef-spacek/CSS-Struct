#------------------------------------------------------------------------------
package CSS::Structure::Output::Raw;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple;
use List::MoreUtils qw(none);
use Readonly;

# Constants.
Readonly::Scalar my $EMPTY => q{};

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Set output handler.
	$self->{'output_handler'} = $EMPTY;

	# Skip bad tags.
	$self->{'skip_bad_tags'} = 0;

	# CSS comment delimeters.
	$self->{'comment_delimeters'} = ['/*', '*/'];

	# Process params.
	while (@params) {
		my $key = shift @params;
		my $val = shift @params;
		err "Bad parameter '$key'." if ! exists $self->{$key};
		$self->{$key} = $val;
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
	$self->{'flush_code'} = $EMPTY;

	# Tmp code.
	$self->{'tmp_code'} = [];

	# Open selector flag.
	$self->{'open_selector'} = 0;

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
			$self->{'flush_code'} .= $par.':'.$val.';';
		}

	# At-rule.
	# TODO
	} elsif ($data->[0] eq 'a') {
		$self->{'flush_code'} .= $data->[1];

	# Begin of selector.
	} elsif ($data->[0] eq 's') {
		push @{$self->{'tmp_code'}}, "$data->[1]";
		$self->{'open_selector'} = 1;

	# Comment.
	} elsif ($data->[0] eq 'c') {
		shift @{$data};
		$self->{'flush_code'} .= $self->{'comment_delimeters'}->[0];
		foreach my $d (@{$data}) {
			$self->{'flush_code'} .= ref $d eq 'SCALAR' ? ${$d}
				: $d;
		}
		$self->{'flush_code'} .= $self->{'comment_delimeters'}->[1];

	# End of selector.
	} elsif ($data->[0] eq 'e') {
		if (! $self->{'open_selector'}) {
			err 'Bad ending of selector.';
		}
		$self->{'flush_code'} .= '}';
		$self->{'open_selector'} = 0;

	# Raw data.
	} elsif ($data->[0] eq 'r') {
		shift @{$data};
		while (@{$data}) {
			my $data = shift @{$data};
			$self->{'flush_code'} .= $data;
		}

	# Other.
	} else {
		err 'Bad type of data.' if $self->{'skip_bad_tags'};
	}
	return;
}

#------------------------------------------------------------------------------
sub _flush_tmp {
#------------------------------------------------------------------------------
# Flush $self->{'tmp_code'}.

	my $self = shift;
	$self->{'flush_code'} .= join(',', @{$self->{'tmp_code'}}).'{';
	$self->{'tmp_code'} = [];
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

 CSS::Structure::Output::Raw - Raw printing 'CSS::Structure' structure to css code.

=head1 SYNOPSIS

 use CSS::Structure::Output::Raw;
 my $t = CSS::Structure::Output::Raw->new(
   'output_handler' => *STDOUT,
 );
 $t->put(['s', 'blam']);
 $t->put(['d', 'weight', '100px']);
 $t->put(['e']);
 $t->finalize;
 $t->flush;
 $t->reset;

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=head1 PARAMETERS

=over 8

=item B<output_handler>

 Handler for print output strings.
 Default is *STDOUT.

=item B<skip_bad_tags>

 TODO

=item B<comment_delimeters>

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
L<CSS::Structure::Output::Indent(3pm)>.

=head1 AUTHOR

 Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

 0.01

=cut

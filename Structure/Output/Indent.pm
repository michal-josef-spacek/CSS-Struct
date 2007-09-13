#------------------------------------------------------------------------------
package CSS::Structure::Output::Indent;
#------------------------------------------------------------------------------
# $Id: Indent.pm,v 1.2 2007-09-13 00:36:25 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple::Multiple;

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub new($@) {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Set output handler.
	$self->{'output_handler'} = '';

	# Skip bad tags.
	$self->{'skip_bad_tags'} = 0;

	# CSS comment delimeters.
	$self->{'comment_delimeters'} = ['/*', '*/'];

	# Indent string.
	$self->{'indent_string'} = "\t";

	# Process params.
	while (@_) {
		my $key = shift;
		my $val = shift;
		err "Bad parameter '$key'." unless exists $self->{$key};
		$self->{$key} = $val;
	}

	# Check to comment delimeters.
	# TODO

	# Reset.
	$self->reset;

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub flush($) {
#------------------------------------------------------------------------------
# Flush css structure in object.

	my $self = shift;
	my $ouf = $self->{'output_handler'};
	if ($ouf) {
		print $ouf $self->{'flush_code'};
	} else {
		return $self->{'flush_code'};
	}
}

#------------------------------------------------------------------------------
sub put($@) {
#------------------------------------------------------------------------------
# Put css structure code.

	my $self = shift;
	my @data = @_;

	# For every data.
	foreach my $dat (@data) {

		# Bad data.
		unless (ref $dat eq 'ARRAY') {
			err "Bad data.";
		}

		# Detect and process data.
		$self->_detect_data($dat);
	}
}

#------------------------------------------------------------------------------
sub reset($) {
#------------------------------------------------------------------------------
# Resets internal variables.

	my $self = shift;

	# Flush code.
	$self->{'flush_code'} = '';

	# Tmp code.
	$self->{'tmp_code'} = [];

	# Open selector flag.
	$self->{'open_selector'} = 0;

	# Any processed selector.
	$self->{'processed'} = 0;

	# Indent flag.
	$self->{'indent_flag'} = 0;
}

#------------------------------------------------------------------------------
# Private methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _detect_data($$) {
#------------------------------------------------------------------------------
# Detect and process data.

	my ($self, $data) = @_;

	# Definitions.
	if ($data->[0] eq 'd') {
		if ($#{$self->{'tmp_code'}} > -1) {
			$self->_flush_tmp;
		}
		unless ($self->{'open_selector'}) {
			err "No selector.";
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
		if ($#{$self->{'tmp_code'}} > -1) {
			$self->_flush_tmp;
		}
		if ($self->{'processed'}) {
			$self->{'flush_code'} .= "\n";
		}
		if ($self->{'indent_flag'}) {
			$self->{'flush_code'} .= $self->{'indent_string'};
		}
		$self->{'flush_code'} .= $self->{'comment_delimeters'}->[0].
			' ';
		foreach my $d (@{$data}) {
			$self->{'flush_code'} .= ref $d eq 'SCALAR' ? ${$d} 
				: $d;
		}
		$self->{'flush_code'} .= ' '.
			$self->{'comment_delimeters'}->[1]."\n";;
		$self->{'processed'} = 0;

	# End of selector.
	} elsif ($data->[0] eq 'e') {
		unless ($self->{'open_selector'}) {
			err "Bad ending of selector.";
		}
		if ($#{$self->{'tmp_code'}} > -1) {
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
		err "Bad type of data." if $self->{'skip_bad_tags'};
	}
}

#------------------------------------------------------------------------------
sub _flush_tmp($) {
#------------------------------------------------------------------------------
# Flush $self->{'tmp_code'}.

	my $self = shift;
	if ($self->{'processed'}) {
		$self->{'flush_code'} .= "\n";
	}
	$self->{'flush_code'} .= join(', ', @{$self->{'tmp_code'}})." {\n";
	$self->{'tmp_code'} = [];
}

1;

=pod

=head1 NAME

 CSS::Structure::Output::Indent - Indent printing 'CSS::Structure' structure to css code.

=head1 SYNOPSIS

 use CSS::Structure::Output::Indent;
 my $t = CSS::Structure::Output::Indent->new(
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

=head1 REQUIREMENTS

L<Error::Simple::Multiple>

=head1 SEE ALSO

L<CSS::Structure>, 
L<CSS::Structure::Output::Raw>

=head1 AUTHOR

 Michal Spacek L<tupinek@gmail.com>

=head1 VERSION

 0.01

=cut

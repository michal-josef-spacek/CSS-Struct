#------------------------------------------------------------------------------
package CSS::Structure::Utils;
#------------------------------------------------------------------------------

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use Readonly;

# Constants.
Readonly::Array our @EXPORT_OK => qw(set_params);

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub set_params {
#------------------------------------------------------------------------------
# Set parameters to user values.

	my ($self, @params) = @_;
	while (@params) {
		my $key = shift @params;
		my $val = shift @params;
		if (! exists $self->{$key}) {
			err "Unknown parameter '$key'.";
		}
		$self->{$key} = $val;
	}
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

CSS::Structure::Utils - 'CSS::Structure' utilities subroutines.

=head1 SYNOPSIS

 use CSS::Structure::Utils qw(set_params);
 set_params($self, %parameters);

=head1 SUBROUTINES

=over 8

=item B<set_params($self, @params)>

 Sets object parameters to user values.
 If setted key doesn't exist in $self object, turn fatal error.
 $self - Object or hash reference.
 @params - Key, value pairs.

=back

=head1 ERRORS

 Unknown parameter '%s'.

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>,
L<Readonly(3pm)>.

=head1 SEE ALSO

L<CSS::Structure(3pm)>,
L<CSS::Structure::Output::Core(3pm)>,
L<CSS::Structure::Output::Indent(3pm)>,
L<CSS::Structure::Output::Raw(3pm)>.

=head1 AUTHOR

Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut

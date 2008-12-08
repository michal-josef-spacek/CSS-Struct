=pod

=encoding utf8

=head1 NAME

 CSS::Structure - Overview about CSS::Structure classes.

=head1 STRUCTURE

 Perl structure:

 Reference to array.
 [type, data]
 data are:
 - normal scalar.
 - reference to scalar.

 Types:
 a - At-rules.
 c - Comment.
 d - Definition.
 e - End of selector.
 r - Raw section.
 s - Selector.

=head1 DEPENDENCIES

 None.

=head1 SEE ALSO

L<CSS::Structure::Output::Raw>,
L<CSS::Structure::Output::Indent>

=head1 AUTHOR

 Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

 0.01

=cut

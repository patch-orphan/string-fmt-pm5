package String::Fmt;
use 5.006;
use strict;
use warnings;
use parent 'Exporter';

our $VERSION     = '0.00_1';
our @EXPORT_OK   = qw( fmt );
our %EXPORT_TAGS = ( all => \@EXPORT_OK );

my $SCALAR_FORMAT   = "%s";
my $ARRAY_FORMAT    = "%s";
my $ARRAY_SEPARATOR = " ";
my $HASH_FORMAT     = "%s\n%s";
my $HASH_SEPARATOR  = "\n";

sub fmt {
    my ($value, $format, $separator) = @_;
    my $type = ref $value;

    if (!$type || $type eq 'SCALAR') {
        $format = $SCALAR_FORMAT unless defined $format;
        return sprintf $format, $value;
    }
    elsif ($type eq 'ARRAY') {
    }
    elsif ($type eq 'HASH') {
    }

    return;
}

1;

__END__

=head1 NAME

String::Fmt - Smart sprintf-style string formatting for strings, arrays, and hashes

=head1 VERSION

This document describes String::Fmt version 0.00_1.

=head1 SYNOPSIS

    use String::Fmt qw( fmt );

=head1 DESCRIPTION

...

=head1 FUNCTIONS

The following functions are provided but are not exported by default.

=over 4

=item fmt

...

=back

=head1 SEE ALSO

...

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 ACKNOWLEDGEMENTS

...

=head1 COPYRIGHT AND LICENSE

Copyright 2010 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

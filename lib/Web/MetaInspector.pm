package Web::MetaInspector;
use 5.008005;
use strict;
use warnings;

use Web::MetaInspector::Scraper;

our $VERSION = "0.01";

sub new {
    my ($class, $url) = @_;
    return Web::MetaInspector::Scraper->new($url)->scrape;
}

1;
__END__

=encoding utf-8

=head1 NAME

Web::MetaInspector - It's new $module

=head1 SYNOPSIS

    use Web::MetaInspector;

=head1 DESCRIPTION

Web::MetaInspector is ...

=head1 LICENSE

Copyright (C) Syohei YOSHIDA.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Syohei YOSHIDA E<lt>syohex@gmail.comE<gt>

=cut

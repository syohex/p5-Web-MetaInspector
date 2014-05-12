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

Web::MetaInspector - URI Inspection

=head1 SYNOPSIS

    use Web::MetaInspector;

    my $res = Web::MetaInspector->new('http://example.com');
    print $res->title;
    print $res->author;
    print $_ for @{$res->keywords};

=head1 DESCRIPTION

Web::MetaInspector is Perl port of Ruby's metainspector.
You can get easily title, links, images, charset, keywords, author, feed URLs
from url given.

=head1 INTERFACE

=head2 new($url)

Get some useful information from C<$url> and return a C<Web::MetaInspector::Response>
instance. C<Web::MetaInspector::Response> has following accessors

=over

=item uri

URI of the page

=item scheme

Scheme of the page

=item host

Hostname of the page

=item root

Root url

=item title

Title of the page

=item language

Language of the page

=item author

Author of the pages

=item description

Description of the page

=item generator

Generator of the page

=item feed

Feed URLs of the page

=item charset

Charset of the page

=item links

Links which are linked in the page

=item images

Images which are linked in the page

=item keyword

Keywords of the page

=back

=head1 LICENSE

Copyright (C) Syohei YOSHIDA.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Syohei YOSHIDA E<lt>syohex@gmail.comE<gt>

=cut

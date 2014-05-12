[![Build Status](https://travis-ci.org/syohex/p5-Web-MetaInspector.png?branch=master)](https://travis-ci.org/syohex/p5-Web-MetaInspector)
# NAME

Web::MetaInspector - URI Inspection

# SYNOPSIS

    use Web::MetaInspector;

    my $res = Web::MetaInspector->new('http://example.com');
    print $res->title;
    print $res->author;
    print $_ for @{$res->keywords};

# DESCRIPTION

Web::MetaInspector is Perl port of Ruby's metainspector.
You can get easily title, links, images, charset, keywords, author, feed URLs
from url given.

# INTERFACE

## new($url)

Get some useful information from `$url` and return a `Web::MetaInspector::Response`
instance. `Web::MetaInspector::Response` has following accessors

- uri

    URI of the page

- scheme

    Scheme of the page

- host

    Hostname of the page

- root

    Root url

- title

    Title of the page

- language

    Language of the page

- author

    Author of the pages

- description

    Description of the page

- generator

    Generator of the page

- feed

    Feed URLs of the page

- charset

    Charset of the page

- links

    Links which are linked in the page

- images

    Images which are linked in the page

- keyword

    Keywords of the page

# LICENSE

Copyright (C) Syohei YOSHIDA.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Syohei YOSHIDA <syohex@gmail.com>

package Web::MetaInspector::Scraper;
use strict;
use warnings;

use Web::Query;
use URI;

use Web::MetaInspector::Response;

sub new {
    my ($class, $url) = @_;

    bless {
        url => $url,
    }, __PACKAGE__;
}

sub scrape {
    my $self = shift;

    my $res = Web::MetaInspector::Response->new;
    my $q = Web::Query->new_from_url($self->{url});

    my $u = URI->new($self->{url});
    $res->scheme($u->scheme);
    $res->host($u->host);
    $res->root(sprintf("%s://%s", $u->scheme, $u->host));

    $res->title( _title($q) );
    $res->language( _language($q) );

    for my $attr (qw/author description generator/) {
        $res->$attr( _meta_value($q, $attr) );
    }
    $res->keywords( _keywords($q) );
    $res->feed( _feed($q) );
    $res->charset( _charset($q) );
    $res->links( _links($q) );
    $res->images( _images($q) );

    $res;
}

sub _title {
    my $q = shift;
    $q->find('title')->first->text();
}

sub _language {
    my $q = shift;
    $q->find('http')->end->attr('lang') || '';
}

sub _meta_value {
    my ($q, $attr) = @_;
    my $value = '';
    $q->find("meta[name=$attr]")->each(
        sub {
            $value = $_->attr('content');
        });
    $value;
}

sub _keywords {
    my $q = shift;
    my @keywords;
    $q->find('meta[name=keywords]')->each(
        sub {
            push @keywords, split /\s*,\s*/, $_->attr('content');
        });
    \@keywords;
}

my @FEED_TYPES = qw(application/atom+xml application/rss+xml);

sub _feed {
    my $q = shift;
    my @feeds;

    $q->find('link[rel=alternate]')->each(
        sub {
            my $type = $_->attr('type');
            if (grep { $_ eq $type } @FEED_TYPES) {
                push @feeds, $_->attr('href');
            }
        });

    \@feeds;
}

sub _charset {
    my $q = shift;
    my $charset = '';

    $q->find('meta')->each(
        sub {
            my $meta_charset = $_->attr('charset');
            if ($meta_charset) {
                $charset = $meta_charset;
                return;
            }

            my $http_equiv = $_->attr('http-equiv');
            if ($http_equiv) {
                my $content = $_->attr('content');
                if ($content =~ m{charset=(.+)\z}) {
                    $charset = $1;
                }
            }
        });

    return $charset;
}

sub _links {
    my $q = shift;
    my @links;

    $q->find('a')->each(
        sub {
            my $href = $_->attr('href');
            return unless $href;

            push @links, $href;
        });

    return \@links;
}

sub _images {
    my $q = shift;
    my @images;

    $q->find('img')->each(
        sub {
            my $href = $_->attr('src');
            return unless $href;

            push @images, $href;
        });

    return \@images;
}

1;

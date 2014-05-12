use strict;
use warnings;
use Test::More;

use Web::MetaInspector;
use Test::TCP;
use Plack::Loader;

my $html =<<'...';
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="description" content="This is test">
<meta name="keywords" content="Perl, Python, Ruby">
<meta name="author" content="Syohei Yoshida">
<link rel="alternate" type="application/atom+xml" title="Atom" href="feed99"/>
<link rel="alternate" type="application/rss+xml" title="RSS2.0" href="rss88"/>
<title>Sample Application</title>
</head>
<body>
<a href="http://www.yahoo.co.jp">yahoo</a>
<a href="http://www.yahee.co.jp">yahee</a>
<img src="a.jpg" />
<img src="b.jpg" />
</body>
</html>
...

my $app = sub {
    return [200, ['Content-Type' => 'text/html'], [$html]];
};

test_tcp(
    server => sub {
        my $port = shift;
        my $loader = Plack::Loader->auto(port => $port)->run($app);
        exit;
    },
    client => sub {
        my $port = shift;
        my $res = Web::MetaInspector->new("http://localhost:$port/");

        is $res->title, "Sample Application";
        is $res->author, "Syohei Yoshida";
        is $res->description, "This is test";
        is_deeply $res->keywords, [qw/Perl Python Ruby/];
        is_deeply $res->links, [qw(http://www.yahoo.co.jp http://www.yahee.co.jp)];
        is_deeply $res->images, [qw(a.jpg b.jpg)];
        is_deeply $res->feed, [qw(feed99 rss88)];
    }
);

done_testing;

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
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
</head>
<body>
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

        is $res->charset, "ISO-8859-1";
    }
);

done_testing;

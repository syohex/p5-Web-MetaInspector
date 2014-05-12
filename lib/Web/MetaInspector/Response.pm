package Web::MetaInspector::Response;
use strict;
use warnings;

use Class::Accessor::Lite (
    new => 1,
    rw => [qw/uri scheme host root
              title language author description generator
              feed charset links images keywords/],
);

1;

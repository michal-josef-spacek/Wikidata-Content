use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
is($Wikidata::Content::VERSION, 0.01, 'Version.');

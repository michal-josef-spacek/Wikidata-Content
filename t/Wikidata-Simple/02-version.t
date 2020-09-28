use strict;
use warnings;

use Wikidata::Simple;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Wikidata::Simple::VERSION, 0.01, 'Version.');

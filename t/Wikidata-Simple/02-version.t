use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Simple;

# Test.
is($Wikidata::Simple::VERSION, 0.01, 'Version.');

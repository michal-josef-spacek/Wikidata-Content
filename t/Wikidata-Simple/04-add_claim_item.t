use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 1;
use Test::NoWarnings;
use Wikidata::Simple;

# Test.
my $obj = Wikidata::Simple->new(
	'entity' => 'Q42',
);
$obj->add_claim_item({'P31' => 'Q5'});
# TODO Check

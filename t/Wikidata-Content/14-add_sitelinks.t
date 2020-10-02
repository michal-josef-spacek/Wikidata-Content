use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_sitelinks({'cswiki' => 'Douglas Adams'});
is($ret, undef, 'Add sitelinks.');

use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my @sitelinks = $obj->sitelinks;
is_deeply(\@sitelinks, [], 'Get blank sitelinks.');

# Test.
$obj->add_sitelinks({'cswiki' => 'Douglas Adams'});
@sitelinks = $obj->sitelinks;
is(@sitelinks, 1, 'Get numbert of sitelinks.');

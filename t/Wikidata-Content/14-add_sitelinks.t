use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$obj->add_sitelinks({'cswiki' => 'Douglas Adams'});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'sitelinks' => {
			'cswiki' => {
				'badges' => [],
				'site' => 'cswiki',
				'title' => 'Douglas Adams',
			},
		},
		'title' => 'Q42',
	},
	'Single sitelink.',
);


use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$obj->add_claim_url({'P856' => 'https://skim.cz'});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P856' => [
				{
					'mainsnak' => {
						'datatype' => 'url',
						'datavalue' => {
							'type' => 'string',
							'value' => 'https://skim.cz'
						},
						'property' => 'P856',
						'snaktype' => 'value',
					},
					'rank' => 'normal',
					'type' => 'statement',
				},
			],
		},
		'title' => 'Q42',
	},
	'Single value.',
);

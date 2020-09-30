use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$obj->add_claim_commons_media({'P185' => 'Michal Josef Špaček - self photo.jpg'});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P185' => [
				{
					'mainsnak' => {
						'datatype' => 'commonsMedia',
						'datavalue' => {
							'type' => 'string',
							'value' => 'Michal Josef Špaček - self photo.jpg',
						},
						'property' => 'P185',
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

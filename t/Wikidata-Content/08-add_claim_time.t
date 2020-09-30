use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$obj->add_claim_time({'P569' => '+2018-09-29T00:00:00Z'});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P569' => [
				{
					'mainsnak' => {
						'datatype' => 'time',
						'datavalue' => {
							'type' => 'time',
							'value' => {
								'after' => 0,
								'before' => 0,
								'calendarmodel' => 'http://www.wikidata.org/entity/Q1985727',
								'precision' => 11,
								'time' => '+2018-09-29T00:00:00Z',
								'timezone' => 0,
							},
						},
						'property' => 'P569',
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

use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;
use Wikidata::Simple;

# Test.
my $obj = Wikidata::Simple->new(
	'entity' => 'Q42',
);
$obj->add_claim_item({'P31' => 'Q5'});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P31' => [
				{
					'mainsnak' => {
						'datatype' => 'wikibase-item',
						'datavalue' => {
							'type' => 'wikibase-entityid',
							'value' => {
								'entity-type' => 'item',
								'id' => 'Q5',
							},
						},
						'property' => 'P31',
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

# Test.
$obj = Wikidata::Simple->new(
	'entity' => 'Q42',
);
$obj->add_claim_item({'P31' => ['Q5', 'Q6']});
$ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P31' => [
				{
					'mainsnak' => {
						'datatype' => 'wikibase-item',
						'datavalue' => {
							'type' => 'wikibase-entityid',
							'value' => {
								'entity-type' => 'item',
								'id' => 'Q5',
							},
						},
						'property' => 'P31',
						'snaktype' => 'value',
					},
					'rank' => 'normal',
					'type' => 'statement',
				},
				{
					'mainsnak' => {
						'datatype' => 'wikibase-item',
						'datavalue' => {
							'type' => 'wikibase-entityid',
							'value' => {
								'entity-type' => 'item',
								'id' => 'Q6',
							},
						},
						'property' => 'P31',
						'snaktype' => 'value',
					},
					'rank' => 'normal',
					'type' => 'statement',
				},
			],
		},
		'title' => 'Q42',
	},
	'Multiple values.',
);

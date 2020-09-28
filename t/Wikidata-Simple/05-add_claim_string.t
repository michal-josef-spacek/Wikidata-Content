use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Wikidata::Simple;

# Test.
my $obj = Wikidata::Simple->new(
	'entity' => 'Q42',
);
$obj->add_claim_string({'P31' => 'text'});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P31' => [
				{
					'mainsnak' => {
						'datatype' => 'string',
						'datavalue' => {
							'type' => 'string',
							'value' => 'text',
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
$obj->add_claim_string({'P31' => ['foo', 'bar']});
$ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P31' => [
				{
					'mainsnak' => {
						'datatype' => 'string',
						'datavalue' => {
							'type' => 'string',
							'value' => 'foo',
						},
						'property' => 'P31',
						'snaktype' => 'value',
					},
					'rank' => 'normal',
					'type' => 'statement',
				},
				{
					'mainsnak' => {
						'datatype' => 'string',
						'datavalue' => {
							'type' => 'string',
							'value' => 'bar',
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

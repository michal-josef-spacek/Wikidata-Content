use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;
use Unicode::UTF8 qw(decode_utf8);
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my @claims = $obj->claims;
is_deeply(\@claims, [], 'Get blank claims.');

# Test.
$obj->add_claim_commons_media({'P185' => 'Michal Josef Špaček - self photo.jpg'});
@claims = $obj->claims;
is(@claims, 1, 'Check number of claims.');

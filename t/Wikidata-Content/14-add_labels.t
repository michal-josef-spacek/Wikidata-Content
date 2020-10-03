use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Unicode::UTF8 qw(decode_utf8);
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_labels({'cs' => decode_utf8('Příklad'), 'en' => 'Example'});
is($ret, undef, 'Add labels.');

use advent::decoyroom;
use Test;
plan 17;

my @sample1 = decode('aaaa-bbb-z-y-x-123[abxyz]');
my @sample2 = decode('a-b-c-d-e-f-g-h-987[abcde]');
my @sample3 = decode('not-a-real-room-404[oarel]');
my @sample4 = decode('totally-real-room-200[decoy]');
is @sample1, ('aaaa-bbb-z-y-x', '123', 'abxyz');
is @sample2, ('a-b-c-d-e-f-g-h', '987', 'abcde');
is @sample3, ('not-a-real-room', '404', 'oarel');
is @sample4, ('totally-real-room', '200', 'decoy');
@sample1 = (sortLetters(@sample1[0]), @sample1[1], @sample1[2]);
@sample2 = (sortLetters(@sample2[0]), @sample2[1], @sample2[2]);
@sample3 = (sortLetters(@sample3[0]), @sample3[1], @sample3[2]);
@sample4 = (sortLetters(@sample4[0]), @sample4[1], @sample4[2]);
is @sample1[0][^5].join, 'abxyz';
is @sample2[0][^5].join, 'abcde';
is @sample3[0][^5].join, 'oarel';
is @sample4[0][^5].join, 'loart';

is isReal(@sample1[0], @sample1[2]), True;
is isReal(@sample2[0], @sample2[2]), True;
is isReal(@sample3[0], @sample3[2]), True;
is isReal(@sample4[0], @sample4[2]), False;
is Room.new('aaaa-bbb-z-y-x-123[abxyz]').Bool, True;
is Room.new('a-b-c-d-e-f-g-h-987[abcde]').Bool, True;
is Room.new('not-a-real-room-404[oarel]').Bool, True;
is Room.new('totally-real-room-200[decoy]').Bool, False;
is Room.new('qzmt-zixmtkozy-ivhz-343[abcde]').plaintext, 'very encrypted name';

my @decoded = "static/4.txt".IO.lines.map({ Room.new($_); });
say (@decoded.cache ==> grep {$_.Bool} ==> map {$_[0].sector} ==> sum );
my @real = @decoded ==> grep {$_.Bool};
my @candidates = @real.grep: { $_.plaintext ~~ /.*north.*/};
say @candidates;

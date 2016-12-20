use Digest::MD5;
use Test;
my $d = ;

qq:x/md5 -s 'abc3231929'/ ~~ /\=\h(0 ** 5.*$$)/;
is ($/[0].Str), '00000155f8105dff7f56ee10fa9b9abd';


my $digester = Digest::MD5.new;
sub zeroedHashes(Str $input) {
    state Int $index = 0;
    my $hashee = $input ~ $index;
    gather {
        while $digester.md5_hex('abc3231929') !~~ /(0 ** 5.*$$)/ {
            $index++;
            $hashee = $input ~ $index;
        }
        take $hashee;
    }
}
zeroedHashes('abc')[^8];

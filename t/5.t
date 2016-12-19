use Digest::MD5;
use Test;
my $digester = Digest::MD5.new;
my $d = $digester.md5_hex: 'abc3231929';

qq:x/md5 -s 'abc3231929'/ ~~ /\=\h(0 ** 5.*$$)/;
is ($/[0].Str), '00000155f8105dff7f56ee10fa9b9abd';
my @solutions = zeroedHashes('cxdnnyjw')[^8];
say @solutions.map({ $_.substr(7,1) }).join; #1


sub zeroedHashes(Str $input) {
    state Int $index = 0;
    my $hashee = $input ~ $index;
    gather {
        while qq:x{md5 -s '$hashee' | grep '= 00000'} eq '' {
            $index++;
            $hashee = $input ~ $index;
        }
        take qq:x{md5 -s '$hashee' | grep '= 00000'};
    }
}

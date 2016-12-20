use Digest::MD5;

sub solution1() is export {
    zeroedHashes('cxdnnyjw')[^8] ==>
    map { $_.substr(7,1) } ==>
    join;
}

sub solution2() is export {
    zeroedHashes('cxdnnyjw')[^8] ==>
    map { ($_.substr(7,1), $_.substr(8,1)) } ==>
    sort { $^a[0] cmp $^b[0] } ==>
    map { $_[1] } ==>
    join;
}

sub zeroedHashes(Str $input) is export {
    state Int $index = 0;
    my $hashee = $input ~ $index;
    gather {
        while qq:x{md5 -s '$hashee' | grep '= 00000'} eq '' {
            $index++;
            $hashee = $input ~ $index;
        }
        qq:x{md5 -s '$hashee' | grep '= 00000'} ~~ /\=\h(0 ** 5.*$$)/;
        take $/[0].Str
    }
}

sub zeroedPostionHashes(Str $input) {
    state Int $index = 0;
    my $hashee = $input ~ $index;
    gather {
        while qq:x{md5 -s '$hashee' | grep -e '= 00000[0-7]'} eq '' {
            $index++;
            $hashee = $input ~ $index;
        }
        qq:x{md5 -s '$hashee' | grep '= 00000'} ~~ /\=\h(0 ** 5.*$$)/;
        take $/[0].Str
    }
}

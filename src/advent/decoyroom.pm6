
sub decode($line) is export {
    $line ~~ /(<[\w \d -]>+) \[(.*)\]/; ($/[0].Str, $/[1].Str);
}

sub isReal(@input, $checksum) is export {
    @input[^5].join eq $checksum;
}
 
sub comparePair($p1, $p2) {
    return $p1[1] cmp $p2[1] if (($p1[1] cmp $p2[1]) ne Same);
    $p2[0] cmp $p1[0];
    
}
sub sortLetters(Str $input) is export {
    my Bag $counts = $input.comb.Bag;
    zip($counts.keys, $counts.values)
        ==> sort({comparePair($^b, $^a) })
        ==> map({ $_[0]})
        ==> grep({$_ !~~ /<[- \d]>**1/})
}

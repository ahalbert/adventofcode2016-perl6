
class Room {
    has Str $.id;
    has Str $.sector;
    has Str $.checksum;
    method new(Str $line) {
        $line ~~ /(<[ \w -]>+)\-(\d+)\[(.*)\]/; 
        return self.bless(id => sortLetters($/[0].Str)[^5].join, sector => $/[1].Str, checksum => $/[2].Str);
    }

    method Bool() { $.id eq $.checksum; }
}

sub isReal(@input, Str $checksum) is export { @input[^5].join eq $checksum; }

sub decode(Str $line) is export {
    $line ~~ /(<[ \w -]>+)\-(\d+)\[(.*)\]/; ($/[0].Str, $/[1].Str, $/[2].Str);
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

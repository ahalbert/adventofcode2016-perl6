
sub decompressv1(Str $in is copy ) returns Str is export {
    my Str $fulltext = '';
    while $in ne '' {
        my $next = $in.substr(0,1);
        $in = $in.substr(1,$in.chars);
        if $next eq '(' {
            $in ~~ /(\d+) x (\d+) \)/;
            my ($len, $times) = $/[0].Int, $/[1].Int;
            my $data = $in.substr(2+$/[0].chars+$/[1].chars, $len);
            $fulltext ~= ($data x $times);
            $in = $in.substr(2+$len+$/[0].chars+$/[1].chars, $in.chars);
        } 
        else  {
            $fulltext ~= $next;
        }
    }
    $fulltext;
}

sub decompressv2(Str $in) returns Int is export {
    $in ~~ m:g/ <(\( \d+ x \d+ \))> || <(\w?)> /;
    my @tokens = $/.map({ $_.Str }).grep({$_ ne ''}).map({ ($_,1) }).Array;
    my @decompressed;
    while @tokens {
        my $curr = (@tokens.shift);
        if $curr[0].chars > 1 {
            $curr ~~ /(\d+) x (\d+)/;
            my ($len, $times) = $/[0].Int, $/[1].Int;
            my $index = 0;
            while $len > 0 and $len >= @tokens[$index][0].chars and $index < @tokens.elems {
                $len -= @tokens[$index][0].chars;
                @tokens[$index] = (@tokens[$index][0], @tokens[$index][1]*$times) ;
                $index++;
            }
        }
        @decompressed.push($curr);
    }
    @decompressed ==>  grep { $_[0].chars == 1 } ==> map {$_[1] } ==> reduce &[+] ;
}


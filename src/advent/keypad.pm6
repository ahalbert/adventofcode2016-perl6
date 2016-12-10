
my @buttons = (('1','2','3'),('4','5','6'),('7','8','9')); 

#Subtype of list where all items are Str with UDLR\n
my Str $test = q{ULL
RRDDD
LURDL
UUUUD
};
subset DirectionList of List where { .map({$_ ~~ Str and $_ ~~ 'U'|'D'|'L'|'R'|"\n"}) ==> reduce { $^a and $^b} }
sub dl(DirectionList $d) is export {
    for $d {
        say $_;
    }
}

sub bathroomKeypad(@input) returns Str is export { 
    my ($x, $y) = 1, 1;
    my @solution;
    for @input {
        given $_ {
            when "U" { $y-- if $y > 0}
            when "D" { $y++ if $y < 2}
            when "L" { $x-- if $x > 0}
            when "R" { $x++ if $x < 2}
            when "\n" {  @solution.push(@buttons[$y][$x]) }
        } 
    }
    @solution.join;
}

#More generic algorthim
my @weirdbuttons = ((Nil, Nil, 1, Nil, Nil),(Nil,2,3,4,Nil),(5,6,7,8,9),(Nil,'A', 'B', 'C'), (Nil, Nil, 'D', Nil, Nil));
sub bathroomCrosspad(@input) is export { 
    my ($x, $y) = 0, 2;
    my @solution;
    for @input {
        given $_ {
            when "U" { $y-- if @weirdbuttons[$y-1][$x].defined }
            when "D" { $y++ if @weirdbuttons[$y+1][$x].defined }
            when "L" { $x-- if @weirdbuttons[$y][$x-1].defined }
            when "R" { $x++ if @weirdbuttons[$y][$x+1].defined }
            when "\n" {  @solution.push(@weirdbuttons[$y][$x]) }
        } 
    }
    @solution.join;
}

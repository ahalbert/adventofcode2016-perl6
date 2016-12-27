use Test;
use python::itertools;

class Generator { has $.element; }

class Chip { has $.element}

my %testState;
%testState{1} = [Chip.bless(element => 'H'), Chip.bless(element => 'Li') ];
%testState{2} = [Generator.bless(element => 'H')];
%testState{3} = [Generator.bless(element => 'Li')];
%testState{4} = [];

my %state;
my $elevator = 1;


sub isDestructive(%state) { 
    for 1..4 {
        my @generators = (%state{$_} ==> grep({ $^a ~~ Generator }) ==> grep({ $^a.element }));
        my @chips = (%state{$_} ==> grep({ $^a ~~ Chip }) ==> grep({ $^a.element }));
        return True if @chips.grep({ $^a ∉ @generators }).elems > 2;
    }
    False;
}

sub solved(%state) {
    for 1..3 {
       return False if %arrangement{$_}.elems > 0
    }
    True;
}

sub BFS(%state is copy, :$reset) {
    state @deqeue;
    @deqeue = [] if $reset;
    until solved(%state) {
    }
}

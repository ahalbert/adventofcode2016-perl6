use v6;
use Test;
use advent::keypad;
plan 1;

my Str $test = q{ULL
RRDDD
LURDL
UUUUD
};
is bathroomKeypad($test.comb.List), "1985";
say bathroomKeypad("static/2.txt".IO.slurp.comb.List);
say bathroomCrosspad("static/2.txt".IO.slurp.comb.List);

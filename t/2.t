use v6;
use Test;
use advent::keypad;
plan 1;

my Str $test = q{ULL
RRDDD
LURDL
UUUUD
};
is bathroomKeypad($test);
say bathroomKeypad("t/2.txt".IO.slurp)

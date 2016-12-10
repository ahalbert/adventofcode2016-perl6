use advent::triangles;
use Test;
plan 2;
is isTriangle(5,10,15), False;
is isTriangle(3,4,5), True;
my @test = "static/3.txt".IO.lines;
@test = @test.map({ $_.split(' ', :skip-empty).map({ .Int }).Array });
my Array @test1 = @test;
say @test1.grep({ isTriangle($_[0], $_[1], $_[2]) }).elems; #Should be 982
@test = @test.rotor(3);
@test
say @test;
# say [Z] @test[0] ; #Dunno why this doesn't work.
# Stopgap because of [Z];
sub transpose(@matrix) {
    (
    (@matrix[0][0], @matrix[1][0], @matrix[2][0]),
    (@matrix[0][1], @matrix[1][1], @matrix[2][1]),
    (@matrix[0][2], @matrix[1][1], @matrix[2][2]),
    );
}

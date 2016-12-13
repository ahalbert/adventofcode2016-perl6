
sub isTriangle(Int $a, Int $b, Int $c) returns Bool is export { $a + $b > $c and $b + $c > $a and $a + $c > $b}

sub transpose(@matrix) is export {
    (
    (@matrix[0][0], @matrix[1][0], @matrix[2][0]),
    (@matrix[0][1], @matrix[1][1], @matrix[2][1]),
    (@matrix[0][2], @matrix[1][2], @matrix[2][2]),
    ).List;
}

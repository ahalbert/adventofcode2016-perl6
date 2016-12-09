use python::itertools;

my @directions = <N E S W>;

sub current($facing) { @directions.grep($facing, :k)[0] }
sub right(Str $facing) { cycle(@directions)[((current $facing) + 1)]; }
sub left(Str $facing) { cycle(@directions)[((current $facing) + 3)]; }

sub move(Str $step) {
    say $step;
    state ($facing, $x,$y) = @directions[^1][0], 0, 0;
    my Str $direction = $step.substr(0,1); 
    my Int $dist = $step.substr(1,1).Int;
    # say "$direction$dist";
    given $direction {
        when 'L' { $facing = left $facing }
        when 'R' { $facing = right $facing }
        default { die "Given invalid direction:$direction"}
    }
    given $facing {
        when 'N' {$y += $dist }
        when 'E' {$x += $dist }
        when 'S' {$y -= $dist }
        when 'W' {$x -= $dist }
        default { die "Given incorrect direction:$facing" }
    }
    say "($x, $y)$facing";
    (abs($x) + abs($y));
}

sub shortestBunnyDistance(@steps) is export {
    for @steps {
        move $_;
    }
}


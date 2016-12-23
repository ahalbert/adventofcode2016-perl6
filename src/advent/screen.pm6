
class Display {
    has Int $.height;
    has Int $.width;
    has Array @.screen;
    
    method new(Int $height, Int $width) {
        self.bless(height => $height, 
            width => $width,
            screen => (['.' xx $width] xx $height).Array);
    }

    method display() {
        say $_ for @.screen;
    }

    method litPixels() {
        @.screen ==> map { $_.Bag } ==> map { $_<#> } ==> reduce {$^a + $^b};
    }

    method rect(Int $cols, Int $rows) { 
        for 0..$rows-1 -> $row {
            for 0..$cols-1 -> $col {
                @.screen[$row][$col] = '#';
            }
        }
    }

    method rotateCol(Int $col, Int $by) {
        my @col = @.screen.map({ $_[$col] }).Array.rotate($by*-1);
        for 0..$.height-1 {
            @.screen[$_][$col] = @col[$_];
        }
    }

    method rotateRow(Int $row, Int $by) {
        @.screen[$row] .= rotate(($by * -1));
    }

    method execute(Str $instruction) {
        given $instruction {
            self.rect($/[0].Int, $/[1].Int) when $instruction ~~ /rect \s (\d+)x(\d+)/;
            self.rotateRow($/[0].Int, $/[1].Int) when $instruction ~~ /rotate \s row \s y'='(\d+) \s by \s (\d+)/;
            self.rotateCol($/[0].Int, $/[1].Int) when $instruction ~~ /rotate \s column \s x'='(\d+) \s by \s (\d+)/;
        }
    }
}

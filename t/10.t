use Test;

my %robots;
my %outputs;
my @chips;

sub give($chip, $target) { 
    giveToOutput($chip, $/[0].Int) if $target ~~ /output \s (\d+)/ ;
    giveToBot($chip, $/[0].Int) if $target ~~ /bot \s (\d+)/ ;
}

sub giveToBot($chip, $bot) {
    if %robots{$bot}[2] { %robots{$bot} = (%robots{$bot}[0], %robots{$bot}[1], %robots{$bot}[2], $chip);  }
    else {%robots{$bot} = (%robots{$bot}[0], %robots{$bot}[1], $chip, %robots{$bot}[3])}
}

sub giveToOutput($chip, $hole) {
    %outputs{$hole} = Array.new() if not %outputs{$hole};
    %outputs{$hole}.push: $chip;
}

sub compareChips($robot) {
    my ($hi, $lo) = %robots{$robot}[0], %robots{$robot}[1];
    my ($chip1, $chip2) = %robots{$robot}[2], %robots{$robot}[3];
    given $chip1 cmp $chip2 {
        when More { give($chip1, $lo); give($chip2, $hi); }
        when Less { give($chip2, $lo); give($chip1, $hi); }
    }
    %robots{$robot} = (%robots{$robot}[0], %robots{$robot}[1], Nil, Nil);
}

for "static/10.txt".IO.lines {
       %robots{$/[0].Int} = ($/[1].Str, $/[2].Str, Nil, Nil) if $_ ~~ m:s/bot (\d+) gives low to ([bot|output] \d+) and high to ([bot|output] \d+)/;
       @chips.push(($/[0].Int, $/[1].Int)) if $_ ~~ m:s/value (\d+) goes to bot (\d+)$/;
}

for @chips {
    if %robots{$_[1]}[2] { %robots{$_[1]} = (%robots{$_[1]}[0], %robots{$_[1]}[1], %robots{$_[1]}[2], $_[0]) }
    else { %robots{$_[1]} = (%robots{$_[1]}[0], %robots{$_[1]}[1], $_[0], %robots{$_[1]}[2]) }
}

for 0..3000 {
    for %robots.keys {
        if %robots{$_}[2] and %robots{$_}[3] {
            say $_ if %robots{$_}[2] == 17 and %robots{$_}[3] == 61;
            say $_ if %robots{$_}[2] == 61 and %robots{$_}[3] == 17;
            compareChips($_);
        }
   } 
}
say %outputs{0}[0] * %outputs{1}[0] * %outputs{2}[0];

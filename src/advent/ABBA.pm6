
sub isABBA(Str $address) returns Bool is export {
    my %parsed = $address.comb(/"[" <-[[]>+ "]" ||<-[[]>+/).categorize({.starts-with("[") && .ends-with("]") ?? "in" !! "out"});
    %parsed<in> = %parsed<in>.map({ $_.substr(1,$_.chars-2) });
    return False if %parsed<in>.grep({ findABBA($_) }).elems > 0;
    return True if %parsed<out>.grep({ findABBA($_) }).elems > 0;
    False;
}

sub findABBA(Str $input) returns Bool is export {
    my $test = '';
    for (0..$input.chars - 4) {
        $test = $input.substr($_, 4);
        return True if  ($test.substr(0,1) eq $test.substr(3,1) 
            and $test.substr(1,1) eq $test.substr(2,1)
            and $test.substr(0,1) ne $test.substr(1,1));
    }
    False;
}

sub isSSL(Str $address) returns Bool is export {
    my %parsed = $address.comb(/"[" <-[[]>+ "]" ||<-[[]>+/).categorize({.starts-with("[") && .ends-with("]") ?? "in" !! "out"});
    %parsed<in> = %parsed<in>.map({ $_.substr(1,$_.chars-2) });
    my @inverted_abas = %parsed<out>.map({ findABAs($_) }).flat.map({ invertABA($_) });
    return True if %parsed<in>.map({ hasBAB($_, @inverted_abas)}).grep( {$_} ).elems > 0;
    False;
}

sub invertABA(Str $aba) {
    my Str $first = $aba.substr(0,1);
    my Str $second = $aba.substr(1,1);
    "$second$first$second";
}

sub isABA(Str $test) returns Bool is export { $test.substr(0,1) eq $test.substr(2,1) and $test.substr(0,1) ne $test.substr(1,1) }

sub findABAs(Str $address) is export {
    my Str $test = '';
    my Str @abas;
    for (0..$address.chars - 3) {
        $test = $address.substr($_, 3);
        @abas.push($test) if isABA($test);
    }
    @abas;
}
sub hasBAB(Str $address, @abas) returns Bool is export {
    my Str $test = '';
    for (0..$address.chars - 3) {
        $test = $address.substr($_, 3);
        if isABA($test) {
            return True if $test (elem) @abas; 
        }
    }
    False;
}


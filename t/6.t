use Test;
plan 1;

sub most(Str $input) { $input.comb.Bag.antipairs.sort.reverse.first.value; }
sub columns(@words) { (0..(@words.first.chars-1)).map(-> $index { @words.map({ $_.substr($index, 1) }).join }); }

my @input = <eedadn drvtee eandsr raavrd atevrs tsrnev sdttsa rasrtv nssdts ntnada svetve tesnvt vntsnd vrdear dvrsen enarar >;
my @columns = columns(@input); 
my $answer = @columns.map({ most($_) }).join;
is $answer, "easter";
say (columns("static/6.txt".IO.lines ) ==> map { most($_) }).join;
#


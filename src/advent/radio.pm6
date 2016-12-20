
sub most(Str $input) is export { $input.comb.Bag.antipairs.sort.first.value; }

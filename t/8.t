use advent::screen;

my $testScreen = Display.new(3,7);
$testScreen.rect(3,2);
$testScreen.rotateCol(1,1);
$testScreen.rotateRow(0,4);
$testScreen.rotateCol(1,1);
$testScreen.display;

my $screen = Display.new(6,50);
$screen.execute($_) for "static/8.txt".IO.lines ;
$screen.display;
say $screen.litPixels();

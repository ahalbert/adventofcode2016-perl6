use Test;
use advent::decompress;
plan 10;

is decompressv1("ADVENT"), "ADVENT";
is decompressv1("A(1x5)BC"), "ABBBBBC";
is decompressv1("(3x3)XYZ"), "XYZXYZXYZ";
is decompressv1("A(2x2)BCD(2x2)EFG"), "ABCBCDEFEFG";
is decompressv1("(6x1)(1x3)A"), "(1x3)A";
is decompressv1("X(8x2)(3x3)ABCY"), "X(3x3)ABC(3x3)ABCY";

say decompressv1("static/9.txt".IO.lines.Str).chars;

is decompressv2('(3x3)XYZ'), "XYZXYZXYZ".chars;
is decompressv2('X(8x2)(3x3)ABCY'), "XABCABCABCABCABCABCY".chars;
is decompressv2("(27x12)(20x12)(13x14)(7x10)(1x12)A"), 241920;
is decompressv2('(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN'), 445;

say decompressv2("static/9.txt".IO.lines.Str);

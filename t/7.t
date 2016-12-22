use Test;
use advent::ABBA;
plan 8;
is isABBA('abba[mnop]qrst'), True;
is isABBA('abcd[bddb]xyyx'), False;
is isABBA('aaaa[qwer]tyui'), False;
is isABBA('ioxxoj[asdfgh]zxcvbn'), True;

say "static/7.txt".IO.lines.grep({ isABBA($_) }).elems;
is isSSL('aba[bab]xyz'), True;
is isSSL('xyx[xyx]xyx'), False;
is isSSL('aaa[kek]eke'), True;
is isSSL('zazbz[bzb]cdb'), True;
say "static/7.txt".IO.lines.grep({ isSSL($_) }).elems;

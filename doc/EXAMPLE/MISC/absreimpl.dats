(* ****** ****** *)

#include
"\
share/\
atspre_staload.hats"
//
// #staload "./absreimpl.sats"
// The content of absreimpl.sats:
//
abstype X = ptr
local assume X = $tup(int, int) in end

local

absreimpl X

in

fun f(): X = $tup(0, 1)
fun f0(x: X): int = x.0
fun f1(x: X): int = x.1

end

implement
main0() =
let val x = f() in println!("0 + 1 = ", f0(x) + f1(x)) end

(* ****** ****** *)

(* end of [absreimpl.dats] *)

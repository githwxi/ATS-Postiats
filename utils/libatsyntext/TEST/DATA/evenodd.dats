(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
isevn(x: int): bool =
if x > 0 then not(isodd(x-1)) else true
and
isodd(x: int): bool =
if x > 0 then not(isevn(x-1)) else false
//
(* ****** ****** *)

(* end of [evenodd.dats] *)
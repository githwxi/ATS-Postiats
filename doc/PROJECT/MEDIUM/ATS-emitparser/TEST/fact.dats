(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern fun fact : int -> int
//
implement
fact (n) = if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)

(* end of [fact.dats] *)

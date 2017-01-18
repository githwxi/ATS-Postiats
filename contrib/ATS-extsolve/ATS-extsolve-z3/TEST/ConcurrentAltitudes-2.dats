(*
** Proving that
** the 3 altitudes of a triangle
** are concurrent
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/SATS/Number/real.sats"
//
(* ****** ****** *)

stacst x1: real
stacst y1: real // A: (x1, y1)
stacst x2: real
stacst y2: real // B: (x2, y2)
stacst x3: real
stacst y3: real // C: (x3, y3)

(* ****** ****** *)
//
stadef
A_alt(x: real, y: real) = (x-x1)*(x2-x3) + (y-y1)*(y2-y3)
stadef
B_alt(x: real, y: real) = (x-x2)*(x3-x1) + (y-y2)*(y3-y1)
stadef
C_alt(x: real, y: real) = (x-x3)*(x1-x2) + (y-y3)*(y1-y2)
//
(* ****** ****** *)
//
extern
prfun
MainLemma
{ x,y:real
| A_alt(x, y)==0 && B_alt(x, y)==0
} ((*void*)): [C_alt(x, y) == 0] void
//
(* ****** ****** *)
//
primplmnt MainLemma{x,y}() = ()
//
(* ****** ****** *)

(* end of [ConcurrentAltitudes-2.dats] *)

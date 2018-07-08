(*
** Proving that
** the 3 medians of a triangle
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
stadef x12 = (x1 + x2) / 2
stadef y12 = (y1 + y2) / 2
//
stadef x23 = (x2 + x3) / 2
stadef y23 = (y2 + y3) / 2
//
stadef x31 = (x3 + x1) / 2
stadef y31 = (y3 + y1) / 2
//
(* ****** ****** *)
//
stadef
A_med(x: real, y: real) = (x-x1)*(y23-y1)-(y-y1)*(x23-x1)
stadef
B_med(x: real, y: real) = (x-x2)*(y31-y2)-(y-y2)*(x31-x2)
stadef
C_med(x: real, y: real) = (x-x3)*(y12-y3)-(y-y3)*(x12-x3)
//
(* ****** ****** *)
//
extern
prfun
MainLemma
{ x,y:real
| A_med(x, y)==0 && B_med(x, y)==0
} ((*void*)): [C_med(x, y)==0] void
//
(* ****** ****** *)
//
primplmnt MainLemma{x,y}() = ()
//
(* ****** ****** *)

(* end of [ConcurrentMedians.dats] *)

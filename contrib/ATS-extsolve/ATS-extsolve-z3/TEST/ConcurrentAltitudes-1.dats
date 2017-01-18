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

stacst y1: real // A: (0, y1)
stacst x2: real // B: (x2, 0)
stacst x3: real // C: (x3, 0)

(* ****** ****** *)

stadef
B_alt(x: real, y: real) = (x-x2)*x3 - y*y1
stadef
C_alt(x: real, y: real) = (x-x3)*x2 - y*y1

(* ****** ****** *)
//
extern
prfun
MainLemma
{ x,y:real
; x2 != x3
; B_alt(x, y)==0
; C_alt(x, y)==0
} ((*void*)): [x==0] void
//
(* ****** ****** *)
//
primplmnt MainLemma{x,y}() = ()
//
(* ****** ****** *)

(* end of [ConcurrentAltitudes-1.dats] *)

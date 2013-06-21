//
// Some code involving linear rec-patterns
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: June, 2013
//
(* ****** ****** *)

abstype T
absvtype VT

vtypedef xy = $rec_vt { x= T, y= VT }

(* ****** ****** *)

fun foo (xy: !xy): T = xy.x

(* ****** ****** *)

fun foo2 (xy: xy): T = let val '{ x=x, ... } = xy in x end

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [patlinrec.dats] *)

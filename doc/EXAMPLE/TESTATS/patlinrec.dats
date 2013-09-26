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

abst@ype T = int
absvt@ype VT = double

(* ****** ****** *)

vtypedef xy = $rec_vt { x= T, y= VT }

(* ****** ****** *)

fun foo (xy: !xy): T = xy.x

(* ****** ****** *)
//
// HX: Note that [...] can leak out linear values
// HX: For now, this is considered intended behavior(?)
//
fun foo2 (xy: xy): T = let val '{ x=x, ... } = xy in x end
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [patlinrec.dats] *)

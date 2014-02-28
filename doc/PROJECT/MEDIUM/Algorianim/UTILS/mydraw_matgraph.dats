(*
** Displaying bar graphs
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: February, 2014
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
"{$LIBATSHWXI}/teaching/mydraw/SATS/mydraw.sats"

(* ****** ****** *)
//
// HX: p1, p2, p3 and p4 are positioned CCW
//
extern
fun{
} mydraw_matgraph
(
  m: intGte(1), n: intGte(1)
, p1: point, p2: point, p3: point, p4: point
) : void // end of [mydraw_matgraph]
//
extern
fun{} mydraw_matgraph$color (i: intGte(0), j: intGte(0)): color
//
(* ****** ****** *)

(* end of [mydraw_matgraph.dats] *)

(*
** for testing [libats/linset_listord]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: January, 2014
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ATS1/SATS/linset_listord.sats"
staload _ = "libats/ATS1/DATS/linset_listord.dats"

(* ****** ****** *)

val () =
{
//
vtypedef set = set(int)
//
val
cmp = lam (x:int, y:int): int =<cloref> compare(x, y)
//
var xs1: set = linset_nil{int}()
val-false = linset_insert (xs1, 0, cmp)
val-false = linset_insert (xs1, 1, cmp)
val-false = linset_insert (xs1, 2, cmp)
//
val () = assertloc (linset_is_member (xs1, 0, cmp))
val () = assertloc (linset_is_member (xs1, 1, cmp))
val () = assertloc (linset_is_member (xs1, 2, cmp))
val () = assertloc (linset_isnot_member (xs1, 3, cmp))
val () = assertloc (linset_isnot_member (xs1, 4, cmp))
//
val-~Some_vt(_) = linset_chooseout_opt (xs1)
//
var xs2: set = linset_nil{int}()
val-false = linset_insert (xs2, 2, cmp)
val-false = linset_insert (xs2, 3, cmp)
val-false = linset_insert (xs2, 4, cmp)
//
val-~Some_vt(_) = linset_chooseout_opt (xs2)
//
val xs12 = linset_union (xs1, xs2, cmp)
val xs12 = linset_listize (xs12)
val () = fprintln! (stdout_ref, "xs12 = ", xs12)
val ((*void*)) = list_vt_free (xs12)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ATS1_linset_listord.dats] *)

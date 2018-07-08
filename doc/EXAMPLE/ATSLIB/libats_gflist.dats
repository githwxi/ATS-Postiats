(*
** for testing [libats/gflist]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: June, 2015
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/SATS/gflist.sats"
//
staload _ = "libats/DATS/gflist.dats"
staload _ = "libats/DATS/gflist_vt.dats"
//
(* ****** ****** *)

val xs1 = $list{int}(0,2,4,6,8)
val xs2 = $list{int}(1,3,5,7,9)
val (pf1len | xs1) = list2gflist(xs1)
val (pf2len | xs2) = list2gflist(xs2)

(* ****** ****** *)
//
val (pf3app | xs3) = gflist_append<int> (xs1, xs2)
val () = println! ("xs3 = ", (gflist2list(xs3)).1)
//
(* ****** ****** *)
//
val (pf4rev | xs4) = gflist_reverse<int> (xs3)
//
val xs4 = gflist_vt2t(xs4)
val () = println! ("xs4 = ", (gflist2list(xs4)).1)
//  
(* ****** ****** *)
//
staload UN = $UNSAFE
//
implement
gflist_mergesort$cmp<int>
  (x1, x2) = (
//
$UN.cast
(
g0int_sgn
(
$UN.cast2int(x1) - $UN.cast2int(x2)
) (*g0int_sgn*)
) (* $UN.cast *)
//
) (* end of [gflist_mergesort$cmp] *)
//
val (pf5ord | xs5) = gflist_mergesort<int> (xs3)
//
val xs5 = gflist_vt2t(xs5)
val () = println! ("xs5 = ", (gflist2list(xs5)).1)
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_gllist.dats] *)

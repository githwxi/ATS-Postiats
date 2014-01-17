(*
** for testing [libats/linset_listord]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: June, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linset_listord.sats"
staload _(*anon*) = "libats/DATS/linset_listord.dats"

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val ints =
  $list_vt{int}(1, 1, 1, 2, 3)
//
val xs = linset_make_list ($UN.list_vt2t(ints))
//
val () = list_vt_free (ints)
//
val () = fprintln! (out, "xs = ", xs)
val () = assertloc (linset_size(xs) = 3)
//
val () = assertloc (linset_is_member (xs, 1))
val () = assertloc (linset_is_member (xs, 2))
val () = assertloc (linset_is_member (xs, 3))
val () = assertloc (linset_isnot_member (xs, 0))
val () = assertloc (linset_isnot_member (xs, 4))
//
var xs = xs
val () = assertloc (~linset_insert (xs, 0))
val () = assertloc ( linset_insert (xs, 1))
val () = assertloc ( linset_remove (xs, 1))
val () = assertloc (~linset_remove (xs, 4))
val () = assertloc (~linset_insert (xs, 4))
//
val () = fprintln! (out, "xs = ", xs)
//
val () = linset_free (xs)
//
} // end of [val]

val () = {
val n = 10
val n2 = n/2
val () = assertloc (n > 0)

var ints1: set (int) = linset_make_nil ()
var i: int; val () =
  for (i := 0; i < n2; i := i+1) {
    val _ = linset_insert<int> (ints1, i)
  } (* end of [for] *)
// end [val]
val size1 = linset_size (ints1)
val () = println! ("size1 = ", size1)

var ints2: set (int) = linset_make_nil ()
var i: int; val () =
  for (i := n2; i < n + n/2; i := i+1) {
    val _ = linset_insert<int> (ints2, i)
  } (* end of [for] *)
// end [val]
val size2 = linset_size (ints2)
val () = println! ("size2 = ", size2)

val ints_union = linset_union (ints1, ints2)
val size = linset_size (ints_union)
val () = println! ("size(ints_union) = ", size)
val () = linset_free (ints_union)
//
} // end of [val]


(* ****** ****** *)

val () =
{
//
vtypedef set = set(int)
//
var xs: set = linset_nil{int}()
//
val-false = linset_insert (xs, 0)
val-false = linset_insert (xs, 1)
val-false = linset_insert (xs, 2)
val-false = linset_insert (xs, 3)
val-false = linset_insert (xs, 4)
//
val nx =
linset_takeoutmin_ngc (xs)
val p_nx = ptrcast(nx)
val () = assertloc (p_nx > 0)
//
val () = mynode_set_elt<int> (nx, 9)
val _0_ = linset_insert_ngc (xs, nx)
val () = assertloc (ptrcast(_0_) = 0)
prval () = mynode_free_null (_0_)
//
val nx2 =
linset_takeoutmax_ngc (xs)
val p_nx2 = ptrcast(nx2)
val () = assertloc (p_nx2 > 0)
//
val () = assertloc (p_nx = p_nx2)
//
val () = linset_free (xs)
val-(9) = mynode_getfree_elt (nx2)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linset_listord.dats] *)

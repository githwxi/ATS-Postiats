(*
** for testing
** [libats/ATS1/funmset_listord]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: January, 2014
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"libats/ATS1/SATS/funmset_listord.sats"
staload
_(*anon*) = "libats/ATS1/DATS/funmset_listord.dats"
//
(* ****** ****** *)

val () =
{
//
val cmp = $UN.cast{cmp(int)}(0)
//
implement
compare_elt_elt<int> (x, y, cmp) = compare (x, y)
//
var mxs0 = funmset_make_nil{int}()
val-( 0 ) = sz2i(funmset_size(mxs0))
//
val () = funmset_insert (mxs0, 1, cmp)
val () = funmset_insert (mxs0, 1, cmp)
val () = funmset_insert (mxs0, 2, cmp)
//
val-( 3 ) = sz2i(funmset_size(mxs0))
//
val-( 0 ) = funmset_get_ntime (mxs0, 0, cmp)
val-( 2 ) = funmset_get_ntime (mxs0, 1, cmp)
val-( 1 ) = funmset_get_ntime (mxs0, 2, cmp)
//
val xs = funmset_listize (mxs0)
val () = fprintln! (stdout_ref, "xs = ", xs)
val ((*void*)) = list_vt_free (xs)
//
val xs = funmset_mlistize (mxs0)
val () = fprintln! (stdout_ref, "xs = ", xs)
val ((*void*)) = list_vt_free (xs)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ATS1_funmset_listord.dats] *)

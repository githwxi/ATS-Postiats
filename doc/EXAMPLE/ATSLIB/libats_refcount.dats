(*
** for testing [libats/refcount]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: July, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/refcount.sats"
staload _ = "libats/DATS/refcount.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val rfc = refcnt_make<T> (1000)
val cnt = refcnt_get_count (rfc)
val rfc2 = refcnt_incref (rfc)
val-~None_vt() = refcnt_decref_opt (rfc)
val-~Some_vt(x) = refcnt_decref_opt (rfc2)
val () = println! ("x = ", x)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_refcount.dats] *)

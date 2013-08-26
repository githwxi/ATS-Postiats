(*
** for testing [libats/linheap_binomial2]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: August, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)
//
staload "libats/SATS/linheap_binomial.sats"
//
staload _(*anon*) = "libats/DATS/gnode.dats"
staload _(*anon*) = "libats/DATS/linheap_binomial2.dats"
//
(* ****** ****** *)

val () =
{
//
typedef elt = int
vtypedef heap = heap (elt)
//
var hp
  : heap = linheap_nil{elt}()
val () = linheap_insert (hp, 0)
//
val () = assertloc (linheap_size(hp) = 5)
//
val-~Some_vt (_) = linheap_getmin_opt (hp)
val-~Some_vt (0) = linheap_delmin_opt (hp)
//
val-~None_vt ( ) = linheap_getmin_opt (hp)
val-~None_vt ( ) = linheap_delmin_opt (hp)
//
val () = assertloc (linheap_size(hp) = 0)
//
val () = linheap_free (hp)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linheap_binomial2.dats] *)

(*
** for testing [libats/linheap_binomial]
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Start time: July, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "libats/SATS/linheap_binomial.sats"
staload _(*anon*) = "libats/DATS/linheap_binomial.dats"

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
val () = linheap_insert (hp, 1)
val () = linheap_insert (hp, 2)
val () = linheap_insert (hp, 3)
val () = linheap_insert (hp, 4)
//
val () = assertloc (linheap_size(hp) = 5)
//
val-~Some_vt (_) = linheap_getmin_opt (hp)
val-~Some_vt (0) = linheap_delmin_opt (hp)
val-~Some_vt (1) = linheap_delmin_opt (hp)
val-~Some_vt (2) = linheap_delmin_opt (hp)
val-~Some_vt (3) = linheap_delmin_opt (hp)
val-~Some_vt (4) = linheap_delmin_opt (hp)
//
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

(* end of [libats_linheap_binomial.dats] *)

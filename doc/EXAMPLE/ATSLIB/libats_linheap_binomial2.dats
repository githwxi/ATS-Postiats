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
#include "share/atspre_staload.hats"
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
val () = linheap_insert (hp, 2)
val () = linheap_insert (hp, 4)
val hp1 = hp
val () = assertloc (linheap_size(hp1) = 3)
//
var hp
  : heap = linheap_nil{elt}()
val () = linheap_insert (hp, 1)
val () = linheap_insert (hp, 3)
val () = linheap_insert (hp, 5)
val hp2 = hp
val () = assertloc (linheap_size(hp2) = 3)
//
var hp
  : heap = linheap_merge (hp1, hp2)
//
val-~Some_vt (0) = linheap_getmin_opt (hp)
val-~Some_vt (0) = linheap_delmin_opt (hp)
val ((*void*)) = assertloc (linheap_size(hp) = 5)
val-~Some_vt (1) = linheap_getmin_opt (hp)
val-~Some_vt (1) = linheap_delmin_opt (hp)
val ((*void*)) = assertloc (linheap_size(hp) = 4)
val-~Some_vt (2) = linheap_getmin_opt (hp)
val-~Some_vt (2) = linheap_delmin_opt (hp)
val ((*void*)) = assertloc (linheap_size(hp) = 3)
val-~Some_vt (3) = linheap_getmin_opt (hp)
val-~Some_vt (3) = linheap_delmin_opt (hp)
val ((*void*)) = assertloc (linheap_size(hp) = 2)
val-~Some_vt (4) = linheap_getmin_opt (hp)
val-~Some_vt (4) = linheap_delmin_opt (hp)
val ((*void*)) = assertloc (linheap_size(hp) = 1)
val-~Some_vt (5) = linheap_getmin_opt (hp)
val-~Some_vt (5) = linheap_delmin_opt (hp)
val ((*void*)) = assertloc (linheap_size(hp) = 0)
//
val-~None_vt ((*void*)) = linheap_getmin_opt (hp)
val-~None_vt ((*void*)) = linheap_delmin_opt (hp)
//
val () = linheap_free (hp)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_linheap_binomial2.dats] *)

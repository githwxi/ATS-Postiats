(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: Feburary, 2013 *)

(* ****** ****** *)
//
// HX-2013-02: this is a completely new effort
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
// end of [staload]

(* ****** ****** *)

staload "libats/SATS/dllist.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

stadef mytkind = $extkind"atslib_dllist"

(* ****** ****** *)

typedef gnode0 (a:vt0p) = gnode0 (mytkind, a)
typedef gnode1 (a:vt0p) = gnode1 (mytkind, a)

(* ****** ****** *)

extern
fun{a:vt0p}
mynode_make_elt (x: a):<!wrt> gnode1 (a)
implement{a}
mynode_make_elt (x) = gnode_make_elt<mytkind><a> (x)

(* ****** ****** *)

assume
dllist_vtype
  (a:vt0p, f:int(*front*), r:int(*rear*)) = gnode0 (a)
// end of [dllist_vtype]

(* ****** ****** *)

implement{}
dllist_nil () = gnode_null ()

(* ****** ****** *)

implement{a}
dllist_sing (x) = let
in
  dllist_cons<a> (x, dllist_nil ())
end // end of [dllist_sing]

(* ****** ****** *)

implement{a}
dllist_cons (x, xs) = let
in
  gnode_cons (mynode_make_elt<a> (x), xs)
end // end of [dllist_cons]

implement{a}
dllist_uncons
  {r} (xs) = let
  val nx = $UN.cast{gnode1(a)}(xs)
  val nx2 = gnode_get_next (nx)
  val () = gnode0_set_prev_null (nx2)
  val () = xs := nx2
in
  gnode_getfree_elt (nx)
end // end of [dllist_uncons]

(* ****** ****** *)

implement{a}
dllist_snoc (xs, x) = let
in
  gnode_snoc (xs, mynode_make_elt<a> (x))
end // end of [dllist_snoc]

(* ****** ****** *)

implement{a}
dllist_make_list
  (xs) = let
//
fun loop (
  nx0: gnode1 (a), xs: List (a)
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val nx1 =
      mynode_make_elt<a> (x)
    val () = gnode_link (nx0, nx1)
  in
    loop (nx1, xs)
  end // end of [loop]
| list_nil () => let
    val () = gnode_set_next_null (nx0)
  in
    // nothing
  end // end of [list_nil]
//
end // end of [loop]
//
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val nx0 = mynode_make_elt<a> (x)
    val () = $effmask_all (loop (nx0, xs))
  in
    nx0 (*first-node*)
  end // end of [list_cons]
| list_nil () => dllist_nil ()
//
end // end of [dllist_make_list]

(* ****** ****** *)

implement{}
dllist_is_nil
  {a}{f,r} (xs) =
  $UN.cast{bool(r==0)}(gnodelst_is_nil (xs))
// end of [dllist_is_nil]

implement{}
dllist_is_cons
  {a}{f,r} (xs) =
  $UN.cast{bool(r > 0)}(gnodelst_is_cons (xs))
// end of [dllist_is_cons]

(* ****** ****** *)

implement{a}
dllist_is_atbeg
  {f,r} (xs) = let
//
val nxs = xs
val iscons = gnodelst_is_cons (nxs)
//
val ans = (
  if iscons then
    gnode_is_null (gnode_get_prev (nxs))
  else true // end of [if]
) : bool // end of [val]
//
in
  $UN.cast{bool(f==0)}(ans)
end // end of [dllist_is_atbeg]

(* ****** ****** *)

implement{a}
dllist_is_atend
  {f,r} (xs) = let
//
val nxs = $UN.cast{gnode1(a)}(xs)
//
in
  $UN.cast
    {bool(r==1)} (
    gnode_is_null (gnode_get_next (nxs))
  )
end // end of [dllist_is_atend]

(* ****** ****** *)

implement{a}
rdllist_is_atbeg
  {f,r} (xs) = dllist_is_atend {f,r} (xs)
// end of [rdllist_is_atbeg]

implement{a}
rdllist_is_atend
  {f,r} (xs) = dllist_is_atbeg {f,r} (xs)
// end of [rdllist_is_atend]

(* ****** ****** *)

implement{a}
dllist_getref_elt (xs) = let
  val nxs = $UN.cast{gnode1(a)}(xs) in gnode_getref_elt (nxs)
end // end of [dllist_getref_elt]

implement{a}
dllist_getref_next (xs) = let
  val nxs = $UN.cast{gnode1(a)}(xs) in gnode_getref_next (nxs)
end // end of [dllist_getref_next]

implement{a}
dllist_getref_prev (xs) = let
  val nxs = $UN.cast{gnode1(a)}(xs) in gnode_getref_prev (nxs)
end // end of [dllist_getref_prev]

(* ****** ****** *)

implement{a}
dllist_get
  {f,r} (xs) = let
  val p_elt =
    dllist_getref_elt {f,r} (xs) in $UN.ptr_get<a> (p_elt)
  // end of [val]
end // end of [dllist_get]

implement{a}
dllist_set
  {f,r} (xs, x) = let
  val p_elt =
    dllist_getref_elt {f,r} (xs) in $UN.ptr_set<a> (p_elt, x)
  // end of [val]
end // end of [dllist_set]

(* ****** ****** *)

implement{a}
dllist_length
  {f,r} (xs) = let
in
  $UN.cast{int(r)}(gnodelst_length (xs))
end // end of [dllist_length]

(* ****** ****** *)

implement{a}
dllist_move (xs) = let
  val nx = $UN.cast{gnode1(a)}(xs) in gnode_get_next (nx)
end // end of [dllist_move]

implement{a}
dllist_move_all
  {f,r} (xs) = let
//
fun loop (
  nxs: gnode1 (a)
) : gnode1 (a) = let
  val nxs_next = gnode_get_next (nxs)
in
  if gnodelst_is_cons (nxs_next) then loop (nxs_next) else nxs
end // end of [loop]
//
val nxs = $UN.cast{gnode1(a)}(xs)
//
in
  $effmask_all (loop (nxs))
end // end of [dllist_move_all]

(* ****** ****** *)

implement{a}
rdllist_move (xs) = let
  val nx = $UN.cast{gnode1(a)}(xs) in gnode_get_prev (nx)
end // end of [rdllist_move]

implement{a}
rdllist_move_all
  {f,r} (xs) = let
//
fun loop (
  nxs: gnode1 (a)
) : gnode1 (a) = let
  val nxs_prev = gnode_get_prev (nxs)
in
  if gnodelst_is_cons (nxs_prev) then loop (nxs_prev) else nxs
end // end of [loop]
//
val nxs = $UN.cast{gnode1(a)}(xs)
//
in
  $effmask_all (loop (nxs))
end // end of [dllist_move_all]

(* ****** ****** *)

implement{a}
dllist_append
  (xs1, xs2) = let
//
val nxs1 = xs1 and nxs2 = xs2
//
fun loop (
  nxs1: gnode1 (a), nxs2: gnode0 (a)
) : void = let
  val nxs1_next = gnode_get_next (nxs1)
  val iscons = gnodelst_is_cons (nxs1_next)
in
//
if iscons then loop (nxs1_next, nxs2) else gnode_link10 (nxs1, nxs2)
//
end // end of [loop]
//
val iscons = gnodelst_is_cons (nxs1)
//
in
//
if iscons then let
  val () = $effmask_all (loop (nxs1, nxs2)) in nxs1
end else nxs2 // end of [if]
//
end // end of [dllist_append]

(* ****** ****** *)

implement{a}
dllist_reverse (xs) = let
//
fun loop (
  nxs: gnode0 (a), res: gnode1 (a)
) : gnode1 (a) = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx = nxs
  val nxs = gnode_get_next (nx)
  val () = gnode_link (nx, res)
in
  loop (nxs, nx)
end else res // end of [if]
//
end // end of [loop]
//
val nxs = xs
val iscons = gnodelst_is_cons (nxs)
//
in
//
if iscons then let
  val nx = nxs
  val nxs = gnode_get_next (nx)
  val nxp = gnode_get_prev (nx)
  val () = gnode_set_next_null (nx)
  val res = $effmask_all (loop (nxs, nx))
  val () = gnode_link01 (nxp, res)
in
  res
end else
  nxs
// end of [if]
//
end // end of [dllist_reverse]

(* ****** ****** *)

implement{a}
dllist_free (xs) = gnodelst_free (xs)

(* ****** ****** *)

implement{}
fprint_dllist$sep
  (out) = fprint_string (out, "->")
implement{a}
fprint_dllist (out, xs) = let
//
val nxs = xs
//
fun loop (
  out: FILEref, nxs: gnode0 (a), i: int
) : void = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val () =
    if i > 0 then fprint_dllist$sep (out)
  // end of [val]
  val [l:addr] p_elt = gnode_getref_elt (nx0)
  prval (pf, fpf) = $UN.ptr_vtake {a}{l} (p_elt)
  val () = fprint_ref (out, !p_elt)
  prval () = fpf (pf)
in
  loop (out, nxs, i+1)
end // end of [if]
//
end // end of [loop]
//
in
  loop (out, nxs, 0)
end // end of [fprint_dllist]

(* ****** ****** *)

implement{}
fprint_rdllist$sep
  (out) = fprint_string (out, "<-")
implement{a}
fprint_rdllist (out, xs) = let
//
val nxs = xs
//
fun loop (
  out: FILEref, nxs: gnode0 (a), i: int
) : void = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx0 = nxs
  val nxs = gnode_get_prev (nx0)
  val () =
    if i > 0 then fprint_rdllist$sep (out)
  // end of [val]
  val [l:addr] p_elt = gnode_getref_elt (nx0)
  prval (pf, fpf) = $UN.ptr_vtake {a}{l} (p_elt)
  val () = fprint_ref (out, !p_elt)
  prval () = fpf (pf)
in
  loop (out, nxs, i+1)
end // end of [if]
//
end // end of [loop]
//
val iscons = gnodelst_is_cons (nxs)
//
in
  if iscons then loop (out, gnode_get_prev (nxs), 0) else ()
end // end of [fprint_rdllist]

(* ****** ****** *)

datavtype mynode
  (a:vt@ype+) = MYNODE of (a, ptr(*next*), ptr(*prev*))
// end of [mynode]

(* ****** ****** *)

extern
praxi mynode_vfree {a:vt0p} (nx: mynode (a)): void
extern
castfn
gnode_decode {a:vt0p} (nx: gnode1 (INV(a))):<> mynode (a)
extern
castfn
gnode_encode {a:vt0p} (nx: mynode (INV(a))):<> gnode1 (a)

(* ****** ****** *)

implement(a)
gnode_make_elt<mytkind><a>
  (x) = let
in
  $UN.castvwtp0{gnode1(a)}(MYNODE{a}(x, _, _))
end // end of [gnode_make_elt]

(* ****** ****** *)

implement(a)
gnode_free<mytkind><a>
  (nx) = let
  val nx = gnode_decode (nx)
  val~MYNODE (_, _, _) = (nx) in (*nothing*)
end // end of [gnode_free]

implement(a)
gnode_free_elt<mytkind><a>
  (nx, res) = let
  val nx = gnode_decode (nx)
  val~MYNODE (x, _, _) = (nx); val () = res := x in (*nothing*)
end // end of [gnode_free_elt]

(* ****** ****** *)

implement(a)
gnode_getref_elt<mytkind><a>
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @MYNODE (elt, _, _) = nx
val p_elt = addr@ (elt)
prval () = fold@ (nx)
prval () = mynode_vfree (nx)
//
in
  p_elt
end // end of [gnode_getref_elt]

(* ****** ****** *)

implement(a)
gnode_getref_next<mytkind><a>
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @MYNODE (_, next, _) = nx
val p_next = addr@ (next)
prval () = fold@ (nx)
prval () = mynode_vfree (nx)
//
in
  p_next
end // end of [gnode_getref_next]

(* ****** ****** *)

implement(a)
gnode_getref_prev<mytkind><a>
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @MYNODE (_, _, prev) = nx
val p_prev = addr@ (prev)
prval () = fold@ (nx)
prval () = mynode_vfree (nx)
//
in
  p_prev
end // end of [gnode_getref_prev]

(* ****** ****** *)

(* end of [dllist.dats] *)

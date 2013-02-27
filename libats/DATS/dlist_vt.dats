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

staload "libats/SATS/dlist_vt.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

stadef
dlist_kind = $extkind"atslib_dlist_kind"
stadef dlknd = dlist_kind // abbreviation

(* ****** ****** *)

typedef
gnode0 (a:vt0p) = gnode0 (dlist_kind, a)
typedef
gnode1 (a:vt0p) = gnode1 (dlist_kind, a)

(* ****** ****** *)

assume
dlist_vtype
  (a: vt@ype, f: int, r: int) = gnode0 (a)
// end of [dlist_vtype]

(* ****** ****** *)

implement{}
dlist_vt_nil () = gnode_null ()

(* ****** ****** *)

implement{a}
dlist_vt_sing (x) = let
in
  dlist_vt_cons<a> (x, dlist_vt_nil ())
end // end of [dlist_vt_sing]

(* ****** ****** *)

implement{a}
dlist_vt_cons (x, xs) = let
in
  gnode_cons (gnode_make_elt<dlknd><a> (x), xs)
end // end of [dlist_vt_cons]

implement{a}
dlist_vt_uncons
  {r} (xs) = let
  val nx = $UN.cast{gnode1(a)}(xs)
  val nx_next = gnode_get_next (nx)
  val () = gnode0_set_prev_null (nx_next)
  val () = xs := nx_next
in
  gnode_getfree_elt (nx)
end // end of [dlist_vt_uncons]

(* ****** ****** *)

implement{a}
dlist_vt_snoc (xs, x) = let
in
  gnode_snoc (xs, gnode_make_elt<dlknd><a> (x))
end // end of [dlist_vt_snoc]

(* ****** ****** *)

implement{a}
dlist_vt_make_list
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
      gnode_make_elt<dlknd><a> (x)
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
    val nx0 = gnode_make_elt<dlknd><a> (x)
    val () = $effmask_all (loop (nx0, xs))
  in
    nx0 (*first-node*)
  end // end of [list_cons]
| list_nil () => dlist_vt_nil ()
//
end // end of [dlist_vt_make_list]

(* ****** ****** *)

implement{}
dlist_vt_is_nil
  {a}{f,r} (xs) =
  $UN.cast{bool(r==0)}(gnodelst_is_nil (xs))
// end of [dlist_vt_is_nil]

implement{}
dlist_vt_is_cons
  {a}{f,r} (xs) =
  $UN.cast{bool(r > 0)}(gnodelst_is_cons (xs))
// end of [dlist_vt_is_cons]

(* ****** ****** *)

implement{a}
dlist_vt_is_atbeg
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
end // end of [dlist_vt_is_atbeg]

(* ****** ****** *)

implement{a}
dlist_vt_is_atend
  {f,r} (xs) = let
//
val nxs = $UN.cast{gnode1(a)}(xs)
//
in
  $UN.cast
    {bool(r==1)} (
    gnode_is_null (gnode_get_next (nxs))
  )
end // end of [dlist_vt_is_atend]

(* ****** ****** *)

implement{a}
rdlist_vt_is_atbeg
  {f,r} (xs) = dlist_vt_is_atend {f,r} (xs)
// end of [rdlist_vt_is_atbeg]

implement{a}
rdlist_vt_is_atend
  {f,r} (xs) = dlist_vt_is_atbeg {f,r} (xs)
// end of [rdlist_vt_is_atend]

(* ****** ****** *)

implement{a}
dlist_vt_getref_elt (xs) = let
  val nxs = $UN.cast{gnode1(a)}(xs) in gnode_getref_elt (nxs)
end // end of [dlist_vt_getref_elt]

implement{a}
dlist_vt_getref_next (xs) = let
  val nxs = $UN.cast{gnode1(a)}(xs) in gnode_getref_next (nxs)
end // end of [dlist_vt_getref_next]

implement{a}
dlist_vt_getref_prev (xs) = let
  val nxs = $UN.cast{gnode1(a)}(xs) in gnode_getref_prev (nxs)
end // end of [dlist_vt_getref_prev]

(* ****** ****** *)

implement{a}
dlist_vt_get
  {f,r} (xs) = let
  val p_elt =
    dlist_vt_getref_elt {f,r} (xs) in $UN.ptr_get<a> (p_elt)
  // end of [val]
end // end of [dlist_vt_get]

implement{a}
dlist_vt_set
  {f,r} (xs, x) = let
  val p_elt =
    dlist_vt_getref_elt {f,r} (xs) in $UN.ptr_set<a> (p_elt, x)
  // end of [val]
end // end of [dlist_vt_set]

(* ****** ****** *)

implement{a}
dlist_vt_length
  {f,r} (xs) = let
in
  $UN.cast{int(r)}(gnodelst_length (xs))
end // end of [dlist_vt_length]

(* ****** ****** *)

implement{a}
dlist_vt_move (xs) = let
  val nx = $UN.cast{gnode1(a)}(xs) in gnode_get_next (nx)
end // end of [dlist_vt_move]

implement{a}
dlist_vt_move_all
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
end // end of [dlist_vt_move_all]

(* ****** ****** *)

implement{a}
rdlist_vt_move (xs) = let
  val nx = $UN.cast{gnode1(a)}(xs) in gnode_get_prev (nx)
end // end of [rdlist_vt_move]

implement{a}
rdlist_vt_move_all
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
end // end of [dlist_vt_move_all]

(* ****** ****** *)

implement{a}
dlist_vt_append
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
end // end of [dlist_vt_append]

(* ****** ****** *)

implement{a}
dlist_vt_reverse (xs) = let
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
  val ( ) = gnode_link (nx, res)
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
  val ( ) = gnode_set_next_null (nx)
  val res = $effmask_all (loop (nxs, nx))
  val ( ) = gnode_link01 (nxp, res)
in
  res
end else
  nxs
// end of [if]
//
end // end of [dlist_vt_reverse]

(* ****** ****** *)

implement{a}
dlist_vt_free (xs) = gnodelst_free (xs)

(* ****** ****** *)

implement{}
fprint_dlist_vt$sep
  (out) = fprint_string (out, "->")
implement{a}
fprint_dlist_vt (out, xs) = let
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
    if i > 0 then fprint_dlist_vt$sep (out)
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
end // end of [fprint_dlist_vt]

(* ****** ****** *)

implement{}
fprint_rdlist_vt$sep
  (out) = fprint_string (out, "<-")
implement{a}
fprint_rdlist_vt (out, xs) = let
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
    if i > 0 then fprint_rdlist_vt$sep (out)
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
end // end of [fprint_rdlist_vt]

(* ****** ****** *)

datavtype
g2node (a:vt@ype+) =
  | G2NODE of (a, ptr(*next*), ptr(*prev*))
// end of [g2node]

(* ****** ****** *)

extern
praxi g2node_vfree {a:vt0p} (nx: g2node (a)): void
extern
castfn
gnode_decode {a:vt0p} (nx: gnode1 (INV(a))):<> g2node (a)
extern
castfn
gnode_encode {a:vt0p} (nx: g2node (INV(a))):<> gnode1 (a)

(* ****** ****** *)

implement(a)
gnode_make_elt<dlknd><a>
  (x) = let
in
  $UN.castvwtp0{gnode1(a)}(G2NODE{a}(x, _, _))
end // end of [gnode_make_elt]

(* ****** ****** *)

implement(a)
gnode_free<dlknd><a>
  (nx) = let
  val nx = gnode_decode (nx)
  val~G2NODE (_, _, _) = (nx) in (*nothing*)
end // end of [gnode_free]

implement(a)
gnode_free_elt<dlknd><a>
  (nx, res) = let
  val nx = gnode_decode (nx)
  val~G2NODE (x, _, _) = (nx); val () = res := x in (*nothing*)
end // end of [gnode_free_elt]

(* ****** ****** *)

implement(a)
gnode_getref_elt<dlknd><a>
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @G2NODE (elt, _, _) = nx
val p_elt = addr@ (elt)
prval () = fold@ (nx)
prval () = g2node_vfree (nx)
//
in
  p_elt
end // end of [gnode_getref_elt]

(* ****** ****** *)

implement(a)
gnode_getref_next<dlknd><a>
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @G2NODE (_, next, _) = nx
val p_next = addr@ (next)
prval () = fold@ (nx)
prval () = g2node_vfree (nx)
//
in
  p_next
end // end of [gnode_getref_next]

(* ****** ****** *)

implement(a)
gnode_getref_prev<dlknd><a>
  (nx) = let
//
val nx = gnode_decode (nx)
//
val @G2NODE (_, _, prev) = nx
val p_prev = addr@ (prev)
prval () = fold@ (nx)
prval () = g2node_vfree (nx)
//
in
  p_prev
end // end of [gnode_getref_prev]

(* ****** ****** *)

(* end of [dlist_vt.dats] *)

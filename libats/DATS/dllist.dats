(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

staload "libats/SATS/dllist.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)
//
extern
fun{a:vt0p}
g2node_make_elt (x: a):<!wrt> g2node1 (a)
//
extern
fun{a:t0p} // [a] is nonlinear
g2node_free (nx: g2node1 (INV(a))):<!wrt> void
extern
fun{a:vt0p}
g2node_free_elt
  (nx: g2node1 (INV(a)), res: &(a?) >> a):<!wrt> void
//
extern
fun{a:vt0p}
g2node_getfree_elt (nx: g2node1 (INV(a))):<!wrt> (a)
//
(* ****** ****** *)
//
extern
castfn
dllist_encode
  : {a:vt0p}{f,r:int} (g2node0 (INV(a))) -<> dllist (a, f, r)
extern
castfn
dllist_decode
  : {a:vt0p}{f,r:int} (dllist (INV(a), f, r)) -<> g2node0 (a)
//
extern
castfn
dllist1_encode
  : {a:vt0p}{f,r:int | r > 0} (g2node1 (INV(a))) -<> dllist (a, f, r)
extern
castfn
dllist1_decode
  : {a:vt0p}{f,r:int | r > 0} (dllist (INV(a), f, r)) -<> g2node1 (a)
//
(* ****** ****** *)

implement{}
dllist_nil () = dllist_encode (gnode_null ())

implement{a}
dllist_sing (x) = dllist_cons<a> (x, dllist_nil ())

(* ****** ****** *)

implement{a}
dllist_cons
  (x, xs) = let
//
val nx = g2node_make_elt<a> (x) in dllist_cons_ngc (nx, xs)
//
end // end of [dllist_cons]

implement{a}
dllist_uncons
  (xs) = let
//
val nx0 = dllist_uncons_ngc (xs) in g2node_getfree_elt<a> (nx0)
//
end // end of [dllist_uncons]

(* ****** ****** *)

implement{a}
dllist_snoc
  (xs, x) = let
//
val nx = g2node_make_elt<a> (x) in dllist_snoc_ngc (xs, nx)
//
end // end of [dllist_snoc]

implement{a}
dllist_unsnoc
  (xs) = let
//
val nx0 = dllist_unsnoc_ngc (xs) in g2node_getfree_elt<a> (nx0)
//
end // end of [dllist_unsnoc]

(* ****** ****** *)

implement{a}
dllist_make_list (xs) = let
//
fun loop (
  nx0: g2node1 (a), xs: List (a)
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val nx1 =
      g2node_make_elt<a> (x)
    // end of [val]
    val () = gnode_link11 (nx0, nx1)
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
    val nx0 = g2node_make_elt<a> (x)
    val () = $effmask_all (loop (nx0, xs))
  in
    dllist_encode (nx0)
  end // end of [list_cons]
| list_nil () => dllist_nil ()
//
end // end of [dllist_make_list]

(* ****** ****** *)

implement{}
dllist_is_nil
  {a}{f,r} (xs) = let
  val nxs = $UN.castvwtp1{g2node0(a)}(xs)
in
  $UN.cast{bool(r==0)}(gnodelst_is_nil (nxs))
end // end of [dllist_is_nil]

implement{}
dllist_is_cons
  {a}{f,r} (xs) = let
  val nxs = $UN.castvwtp1{g2node0(a)}(xs)
in
  $UN.cast{bool(r > 0)}(gnodelst_is_cons (nxs))
end // end of [dllist_is_cons]

(* ****** ****** *)

(*
fun{a:vt0p}
dllist_is_atbeg
  {f,r:int}
  (xs: !dllist (INV(a), f, r)):<> bool (f==0)
// end of [dllist_is_atbeg]
*)
implement{a}
dllist_is_atbeg
  {f,r} (xs) = let
//
val nxs =
  $UN.castvwtp1{g2node0(a)}(xs)
val iscons = gnodelst_is_cons (nxs)
//
val ans = (
  if iscons
    then gnode_is_null (gnode_get_prev (nxs)) else true
  // end of [if]
) : bool // end of [val]
//
in
  $UN.cast{bool(f==0)}(ans)
end // end of [dllist_is_atbeg]

(* ****** ****** *)

(*
fun{a:vt0p}
dllist_is_atend
  {f,r:int | r > 0}
  (xs: !dllist (INV(a), f, r)):<> bool (r==1)
// end of [dllist_is_atend]
*)
implement{a}
dllist_is_atend
  {f,r} (xs) = let
//
val nxs = $UN.castvwtp1{g2node1(a)}(xs)
val ans = gnode_is_null (gnode_get_next (nxs))
//
in
  $UN.cast{bool(r==1)}(ans)
end // end of [dllist_is_atend]

(* ****** ****** *)

implement{a}
rdllist_is_atbeg {f,r} (xs) = dllist_is_atend {f,r} (xs)
implement{a}
rdllist_is_atend {f,r} (xs) = dllist_is_atbeg {f,r} (xs)

(* ****** ****** *)

implement{a}
dllist_getref_elt (xs) = let
  val nxs =
    $UN.castvwtp1{g2node1(a)}(xs) in gnode_getref_elt (nxs)
  // end of [val]
end // end of [dllist_getref_elt]

(* ****** ****** *)

implement{a}
dllist_getref_next (xs) = let
  val nxs =
    $UN.castvwtp1{g2node1(a)}(xs) in cptr2ptr (gnode_getref_next (nxs))
  // end of [val]  
end // end of [dllist_getref_next]

implement{a}
dllist_getref_prev (xs) = let
  val nxs =
    $UN.castvwtp1{g2node1(a)}(xs) in cptr2ptr (gnode_getref_prev (nxs))
  // end of [val]  
end // end of [dllist_getref_prev]

(* ****** ****** *)

implement{a}
dllist_get_elt (xs) = let
  val p_elt =
    dllist_getref_elt (xs) in $UN.cptr_get<a> (p_elt)
  // end of [val]
end // end of [dllist_get_elt]

implement{a}
dllist_set_elt (xs, x0) = let
  val p_elt = 
    dllist_getref_elt (xs) in $UN.cptr_set<a> (p_elt, x0)
  // end of [val]
end // end of [dllist_set_elt]

(* ****** ****** *)

(*
fun{a:vt0p}
dllist_length
  {f,r:int} (xs: !dllist (INV(a), f, r)):<> int (r)
*)
implement{a}
dllist_length
  {f,r} (xs) = let
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  $UN.cast{int(r)}(gnodelst_length (nxs))
end // end of [dllist_length]

(*
fun{a:vt0p}
rdllist_length
  {f,r:int} (xs: !dllist (INV(a), f, r)):<> int (f)
*)
implement{a}
rdllist_length
  {f,r} (xs) = let
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  $UN.cast{int(f)}(gnodelst_rlength (nxs))
end // end of [rdllist_length]

(* ****** ****** *)

(*
fun{a:vt0p}
dllist_move
  {f,r:int | r > 1}
  (xs: dllist (INV(a), f, r)):<> dllist (a, f+1, r-1)
*)
implement{a}
dllist_move (xs) = let
  val nxs = dllist1_decode (xs)
in
  dllist_encode (gnode_get_next (nxs))
end // end of [dllist_move]

(*
fun{a:vt0p}
dllist_move_all
  {f,r:int | r > 0}
  (xs: dllist (INV(a), f, r)):<> dllist (a, f+r-1, 1)
*)
implement{a}
dllist_move_all
  {f,r} (xs) = let
//
val nxs = dllist1_decode (xs)
val nxs_end = gnodelst_next_all (nxs)
//
in
  dllist_encode (nxs_end)
end // end of [dllist_move_all]

(* ****** ****** *)

(*
fun{a:vt0p}
rdllist_move
  {f,r:int | f > 0}
  (xs: dllist (INV(a), f, r)):<> dllist (a, f-1, r+1)
*)
implement{a}
rdllist_move (xs) = let
//
prval (
) = lemma2_dllist_param (xs)
//
val nxs = dllist1_decode (xs)
//
in
  dllist_encode (gnode_get_prev (nxs))
end // end of [rdllist_move]

(*
fun{a:vt0p}
rdllist_move_all
  {f,r:int | r >= 0}
  (xs: dllist (INV(a), f, r)):<> dllist (a, 0(*front*), f+r)
*)
implement{a}
rdllist_move_all
  {f,r} (xs) = let
//
val nxs = dllist_decode (xs)
val iscons = gnodelst_is_cons (nxs)
val nxs_beg = (
  if iscons then $effmask_all (gnodelst_prev_all (nxs)) else nxs
) : g2node0 (a) // end of [val]
//
in
  dllist_encode (nxs_beg)
end // end of [rdllist_move_all]

(* ****** ****** *)

(*
fun{a:vt0p}
dllist_insert_next
  {f,r:int | r > 0}
  (xs: dllist (INV(a), f, r), x0: a):<!wrt> dllist (a, f, r+1)
*)
implement{a}
dllist_insert_next
  (xs, x0) = let
  val nxs = dllist1_decode (xs)
  val nx0 = g2node_make_elt<a> (x0)
  val () = gnode_insert_next (nxs, nx0)
in
  dllist_encode (nxs)
end // end of [dllist_insert_next]

(*
fun{a:vt0p}
dllist_insert_prev
  {f,r:int | r > 0}
  (xs: dllist (INV(a), f, r), x0: a):<!wrt> dllist (a, f, r+1)
*)
implement{a}
dllist_insert_prev
  (xs, x0) = let
  val nxs = dllist1_decode (xs)
  val nx0 = g2node_make_elt<a> (x0)
  val () = gnode_insert_prev (nxs, nx0)
in
  dllist_encode (nx0)
end // end of [dllist_insert_prev]

(* ****** ****** *)

(*
fun{a:vt0p}
dllist_takeout
  {f,r:int | r > 1}
  (xs: &dllist (INV(a), f, r) >> dllist (a, f, r-1)):<!wrt> (a)
*)
implement{a}
dllist_takeout
  (xs) = let
  val nxs = dllist1_decode (xs)
  val nxs_prev = gnode_get_prev (nxs)
  val nxs_next = gnode_get_next (nxs)
  val nxs_next = $UN.cast{g2node1(a)}(nxs_next)
  val () = gnode_link01 (nxs_prev, nxs_next)
  val () = (xs := dllist_encode (nxs_next))
in
  g2node_getfree_elt (nxs)
end // end of [dllist_takeout]

(* ****** ****** *)

(*
fun{a:vt0p}
dllist_append
  {f1,r1:int}{f2,r2:int} (
  xs1: dllist (INV(a), f1, r1), xs2: dllist (a, f2, r2)
) :<!wrt> dllist (a, f1, r1+f2+r2) // end of [dllist_append]
*)
implement{a}
dllist_append
  {f1,r1}{f2,r2} (xs1, xs2) = let
//
prval () = lemma1_dllist_param (xs1)
prval () = lemma1_dllist_param (xs2)
//
val xs2_beg = rdllist_move_all (xs2)
//
val iscons1 = dllist_is_cons (xs1)
//
in
//
if iscons1 then let
  val iscons2 = dllist_is_cons (xs2_beg)
in
  if iscons2 then let
    val nxs1 =
      $UN.castvwtp1{g2node0(a)}(xs1)
    val xs1_end = dllist_move_all (xs1)
    val nxs1_end = dllist1_decode (xs1_end)
    val nxs2_beg = dllist_decode (xs2_beg)
    val () = gnode_link10 (nxs1_end, nxs2_beg)
  in
    dllist_encode (nxs1)
  end else let
    prval () = dllist_free_nil (xs2_beg)
  in
    xs1
  end // end of [if]
end else let
  prval () = lemma3_dllist_param (xs1)
  prval () = dllist_free_nil (xs1)
in
  xs2_beg
end // end of [if]
//
end // end of [dllist_append]

(* ****** ****** *)

(*
fun{a:vt0p}
rdllist_append
  {f1,r1:int}{f2,r2:int | r2 > 0} (
  xs1: dllist (INV(a), f1, r1), xs2: dllist (a, f2, r2)
) :<!wrt> dllist (a, f1+r1+f2, r2) // end of [rdllist_append]
*)
implement{a}
rdllist_append
  (xs1, xs2) = let
//
prval () = lemma1_dllist_param (xs1)
prval () = lemma1_dllist_param (xs2)
//
val iscons1 = dllist_is_cons (xs1)
//
in
//
if iscons1 then let
  val nxs2 =
    $UN.castvwtp1{g2node1(a)}(xs2)
  val xs1_end = dllist_move_all (xs1)
  val xs2_beg = rdllist_move_all (xs2)
  val nxs1_end = dllist_decode (xs1_end)
  val nxs2_beg = dllist1_decode (xs2_beg)
  val () = gnode_link01 (nxs1_end, nxs2_beg)
in
  dllist_encode (nxs2)
end else let
  prval () = lemma3_dllist_param (xs1)
  prval () = dllist_free_nil (xs1)
in
  xs2
end // end of [if]
//
end // end of [rdllist_append]

(* ****** ****** *)

implement{a}
dllist_reverse (xs) = let
//
fun loop (
  nxs: g2node0 (a), res: g2node1 (a)
) : g2node1 (a) = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val () = gnode_link11 (nx0, res)
in
  loop (nxs, nx0)
end else res // end of [if]
//
end // end of [loop]
//
val iscons = dllist_is_cons (xs)
//
in
//
if iscons then let
  val nxs = dllist1_decode (xs)
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val nxp = gnode_get_prev (nx0)
  val () = gnode_set_next_null (nx0)
  val res = $effmask_all (loop (nxs, nx0))
  val () = gnode_link01 (nxp, res)
in
  dllist_encode (res)
end else (xs) // end of [if]
//
end // end of [dllist_reverse]

(* ****** ****** *)

implement{a}
dllist_free (xs) = let
//
fun loop (
  nxs: g2node0 (a)
) : void = let
//
val iscons = gnodelst_is_cons (nxs)
//
in
//
if iscons then let
  val nxs2 = gnode_get_next (nxs)
  val () = g2node_free (nxs)
in
  loop (nxs2)
end else () // end of [if]
//
end // end of [loop]
//
val nxs = dllist_decode (xs)
//
in
  $effmask_all (loop (nxs))
end // end of [dllist_free]

(* ****** ****** *)

(*
fun{
a:vt0p}{env:vt0p
} dllist_foreach_env
  {f,r:int} (xs: !dllist (INV(a), f, r), env: &env >> _): void
*)
implement
{a}{env}
dllist_foreach_env
  (xs, env) = let
//
fun loop (
  nxs: g2node0 (a), env: &env
) : void = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx0 = nxs
  val nxs = gnode_get_next (nxs)
  val p_elt = gnode_getref_elt (nx0)
  val (pf, fpf | p_elt) = $UN.cptr_vtake {a} (p_elt)
  val test = dllist_foreach$cont (!p_elt, env)
in
  if test then let
    val () = dllist_foreach$fwork (!p_elt, env)
    prval () = fpf (pf)
  in
    loop (nxs, env)
  end else let
    prval () = fpf (pf)
  in
    // nothing
  end // end of [if]
end else () // end of [if]
//
end // end of [loop]
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  loop (nxs, env)
end // end of [dllist_foreach_env]

(* ****** ****** *)

(*
fun{
a:vt0p}{env:vt0p
} rdllist_foreach_env
  {f,r:int} (xs: !dllist (INV(a), f, r), env: &env >> _): void
*)
implement
{a}{env}
rdllist_foreach_env
  (xs, env) = let
//
fun loop (
  nxs: g2node1 (a), env: &env
) : void = let
  val nxs2 = gnode_get_prev (nxs)
  val iscons = gnodelst_is_cons (nxs2)
in
//
if iscons then let
  val nx0 = nxs2
  val p_elt = gnode_getref_elt (nx0)
  val (pf, fpf | p_elt) = $UN.cptr_vtake {a} (p_elt)
  val test = rdllist_foreach$cont (!p_elt, env)
in
  if test then let
    val () = rdllist_foreach$fwork (!p_elt, env)
    prval () = fpf (pf)
  in
    loop (nxs2, env)
  end else let
    prval () = fpf (pf)
  in
    // nothing
  end // end of [if]
end else () // end of [if]
//
end // end of [loop]
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  if gnodelst_is_cons (nxs) then loop (nxs, env) else ()
end // end of [rdllist_foreach_env]

(* ****** ****** *)

implement{}
fprint_dllist$sep
  (out) = fprint_string (out, "->")
implement{a}
fprint_dllist (out, xs) = let
//
fun loop (
  out: FILEref, nxs: g2node0 (a), i: int
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
  val p_elt = gnode_getref_elt (nx0)
  val (pf, fpf | p_elt) = $UN.cptr_vtake {a} (p_elt)
  val () = fprint_ref (out, !p_elt)
  prval () = fpf (pf)
in
  loop (out, nxs, i+1)
end // end of [if]
//
end // end of [loop]
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
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
fun loop (
  out: FILEref, nxs: g2node0 (a), i: int
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
  val p_elt = gnode_getref_elt (nx0)
  val (pf, fpf | p_elt) = $UN.cptr_vtake {a} (p_elt)
  val () = fprint_ref (out, !p_elt)
  prval () = fpf (pf)
in
  loop (out, nxs, i+1)
end // end of [if]
//
end // end of [loop]
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
val iscons = gnodelst_is_cons (nxs)
//
in
  if iscons then loop (out, gnode_get_prev (nxs), 0) else ()
end // end of [fprint_rdllist]

(* ****** ****** *)

datavtype
dlnode_vtype (a:vt@ype+) =
  | DLNODE of (a, ptr(*next*), ptr(*prev*))
// end of [dlnode_vtype]

(* ****** ****** *)

vtypedef dlnode (a:vt0p) = dlnode_vtype (a)

(* ****** ****** *)

extern
praxi dlnode_vfree {a:vt0p} (nx: dlnode (a)): void
extern
castfn
g2node_decode {a:vt0p} (nx: g2node1 (INV(a))):<> dlnode (a)
extern
castfn
g2node_encode {a:vt0p} (nx: dlnode (INV(a))):<> g2node1 (a)

(* ****** ****** *)

implement{a}
g2node_make_elt
  (x) = let
in
  $UN.castvwtp0{g2node1(a)}(DLNODE{a}(x, _, _))
end // end of [g2node_make_elt]

(* ****** ****** *)

implement{a}
g2node_free (nx) = let
  val nx = g2node_decode (nx)
  val~DLNODE (_, _, _) = (nx) in (*nothing*)
end // end of [g2node_free]

implement{a}
g2node_free_elt
  (nx, res) = let
  val nx = g2node_decode (nx)
  val~DLNODE (x, _, _) = (nx); val () = res := x in (*nothing*)
end // end of [g2node_free_elt]

implement{a}
g2node_getfree_elt
  (nx) = let
  val nx = g2node_decode (nx)
  val~DLNODE (x, _, _) = (nx) in x
end // end of [g2node_getfree_elt]

(* ****** ****** *)

implement(a)
gnode_getref_elt<mytkind><a>
  (nx) = let
//
val nx = g2node_decode (nx)
//
val+@DLNODE (elt, _, _) = nx
val p_elt = addr@ (elt)
prval ((*void*)) = fold@ (nx)
prval ((*void*)) = dlnode_vfree (nx)
//
in
  $UN.cast{cPtr1(a)}(p_elt)
end // end of [gnode_getref_elt]

(* ****** ****** *)

implement(a)
gnode_getref_next<mytkind><a>
  (nx) = let
//
val nx = g2node_decode (nx)
//
val+@DLNODE (_, next, _) = nx
val p_next = addr@ (next)
prval ((*void*)) = fold@ (nx)
prval ((*void*)) = dlnode_vfree (nx)
//
in
  $UN.cast{cPtr1(g2node0(a))}(p_next)
end // end of [gnode_getref_next]

(* ****** ****** *)

implement(a)
gnode_getref_prev<mytkind><a>
  (nx) = let
//
val nx = g2node_decode (nx)
//
val+@DLNODE (_, _, prev) = nx
val p_prev = addr@ (prev)
prval ((*void*)) = fold@ (nx)
prval ((*void*)) = dlnode_vfree (nx)
//
in
  $UN.cast{cPtr1(g2node0(a))}(p_prev)
end // end of [gnode_getref_prev]

(* ****** ****** *)

implement{a}
dllist_cons_ngc
  (nx0, xs) = let
//
val () =
  gnode_set_prev_null (nx0)
val nxs = dllist_decode (xs)
val () = gnode_link10 (nx0, nxs)
//
in
  dllist_encode (nx0)
end // end of [dllist_cons_ngc]

implement{a}
dllist_uncons_ngc
  (xs) = let
//
val nxs = dllist1_decode (xs)
val nxs2 = gnode_get_next (nxs)
val () = gnode0_set_prev_null (nxs2)
val () = xs := dllist_encode (nxs2)
//
in
  nxs
end // end of [dllist_uncons_ngc]

(* ****** ****** *)

implement{a}
dllist_snoc_ngc
  (xs, nx0) = let
//
val () = gnode_set_next_null (nx0)
val nxs = dllist_decode (xs)
val () = gnode_link01 (nxs, nx0)
//
in
  dllist_encode (nx0)
end // end of [dllist_snoc_ngc]

implement{a}
dllist_unsnoc_ngc
  (xs) = let
//
val nxs = dllist1_decode (xs)
val nxs2 = gnode_get_prev (nxs)
val () = gnode0_set_next_null (nxs2)
val () = xs := dllist_encode (nxs2)
//
in
  nxs
end // end of [dllist_unsnoc_ngc]

(* ****** ****** *)

(* end of [dllist.dats] *)

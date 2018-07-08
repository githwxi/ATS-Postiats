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
(* Start time: March, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

staload "libats/SATS/sllist.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)
//
extern
fun{a:vt0p}
g2node_make_elt
  (x: a):<!wrt> g2node1(a)
//
(* ****** ****** *)
//
extern
fun{a:t0p} // [a] is nonlinear
g2node_free
  (nx: g2node1(INV(a))):<!wrt> void
//
extern
fun{a:vt0p} // [a] may be linear
g2node_freelin
  (nx: g2node1(INV(a))):<!wrt> void
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
g2node_free_elt
(
nx: g2node1(INV(a)), res: &(a?) >> a
) :<!wrt> void // end-of-function
//
extern
fun{a:vt0p}
g2node_getfree_elt(nx: g2node1(INV(a))):<!wrt>(a)
//
(* ****** ****** *)
//
extern
castfn
sllist0_encode
{a:vt0p}{n:int}
  (nx: g2node0(INV(a))) :<> sllist(a, n)
extern
castfn
sllist0_decode
{a:vt0p}{n:int}
  (xs: sllist(INV(a), n)) :<> g2node0(a)
//
extern
castfn
sllist1_encode
{a:vt0p}{n:int | n > 0}
  (nx: g2node1(INV(a))) :<> sllist(a, n)
extern
castfn
sllist1_decode
{a:vt0p}{n:int | n > 0}
  (xs: sllist(INV(a), n)) :<> g2node1(a)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
sllist_nil() = sllist0_encode(gnode_null())
//
implement
{a}(*tmp*)
sllist_sing(x) = sllist_cons<a>(x, sllist_nil())
//
(* ****** ****** *)

implement
{a}(*tmp*)
sllist_cons
  (x, xs) = let
//
val nx =
g2node_make_elt<a>(x) in sllist_cons_ngc<a>(nx, xs)
//
end // end of [sllist_cons]

implement{a}
sllist_uncons
  (xs) = let
//
val nx0 =
sllist_uncons_ngc<a>(xs) in g2node_getfree_elt<a>(nx0)
//
end // end of [sllist_uncons]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_snoc
  (xs, x) = let
//
val nx = g2node_make_elt<a> (x) in sllist_snoc_ngc (xs, nx)
//
end // end of [sllist_snoc]

implement{a}
sllist_unsnoc
  (xs) = let
//
val nx0 = sllist_unsnoc_ngc (xs) in g2node_getfree_elt<a> (nx0)
//
end // end of [sllist_unsnoc]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_make_list
  {n}(xs) = let
//
fun loop (
  nx0: g2node1 (a), xs: List (a)
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val nx1 = g2node_make_elt<a> (x)
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
    sllist0_encode (nx0)
  end // end of [list_cons]
| list_nil () => sllist_nil ()
//
end // end of [sllist_make_list]

(* ****** ****** *)
//
implement
{a}(*tmp*)
sllist_make_list_vt
  {n}(xs) = $UN.castvwtp0{sllist(a,n)}(xs)
//
(* ****** ****** *)

implement
{}(*tmp*)
sllist_is_nil
  {a}{n} (xs) = let
  val nxs = $UN.castvwtp1{g2node0(a)}(xs)
in
  $UN.cast{bool(n==0)}(gnodelst_is_nil (nxs))
end // end of [sllist_is_nil]

implement
{}(*tmp*)
sllist_is_cons
  {a}{n} (xs) = let
  val nxs = $UN.castvwtp1{g2node0(a)}(xs)
in
  $UN.cast{bool(n > 0)}(gnodelst_is_cons (nxs))
end // end of [sllist_is_cons]

(* ****** ****** *)

(*
fun{a:vt0p}
sllist_length
  {n:int} (xs: !sllist (INV(a), n)):<> int (n)
*)
implement
{a}(*tmp*)
sllist_length
  {n} (xs) = let
//
val nxs = $UN.castvwtp1{g2node0(a)}(xs)
//
in
  $UN.cast{int(n)}(gnodelst_length (nxs))
end // end of [sllist_length]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_get_elt
  (xs) = let
  val p_elt =
    sllist_getref_elt (xs) in $UN.cptr_get<a> (p_elt)
  // end of [val]
end // end of [sllist_get_elt]

implement
{a}(*tmp*)
sllist_set_elt
  (xs, x0) = let
  val p_elt = 
    sllist_getref_elt (xs) in $UN.cptr_set<a> (p_elt, x0)
  // end of [val]
end // end of [sllist_set_elt]

implement
{a}(*tmp*)
sllist_getref_elt (xs) = let
  val nxs =
    $UN.castvwtp1{g2node1(a)}(xs) in gnode_getref_elt (nxs)
  // end of [val]
end // end of [sllist_getref_elt]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_getref_next (xs) = let
  val nxs =
    $UN.castvwtp1{g2node1(a)}(xs) in cptr2ptr (gnode_getref_next (nxs))
  // end of [val]  
end // end of [sllist_getref_next]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_get_elt_at
  (xs, i) = let
  val p_elt =
    sllist_getref_elt_at (xs, i) in $UN.cptr_get<a> (p_elt)
  // end of [val]
end // end of [sllist_get_elt_at]

implement
{a}(*tmp*)
sllist_set_elt_at
  (xs, i, x0) = let
  val p_elt = 
    sllist_getref_elt_at (xs, i) in $UN.cptr_set<a> (p_elt, x0)
  // end of [val]
end // end of [sllist_set_elt_at]

implement
{a}(*tmp*)
sllist_getref_elt_at
  (xs, i) = let
//
fun loop
(
  nxs: g2node1 (a), i: int
) : g2node1 (a) =
  if i > 0 then let
    val nxs = gnode_get_next (nxs)
  in
    loop ($UN.cast{g2node1(a)}(nxs), i-1)
  end else nxs // end of [if]
//
val nxs0 = $UN.castvwtp1{g2node1(a)}(xs)
val nxs_i = $effmask_all (loop (nxs0, i))
//
in
  gnode_getref_elt (nxs_i) 
end // end of [sllist_getref_elt_at]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_getref_at (xs, i) = let
//
fun loop (
  p: Ptr1, i: int
) : Ptr1 = let
in
  if i > 0 then let
    val nx =
      $UN.ptr1_get<g2node1(a)> (p)
    // end of [val]
    val p2 = gnode_getref_next (nx)
  in
    loop (cptr2ptr (p2), i-1)
  end else (p) // end of [if]
end // end of [loop]
//
val p0 = $UN.cast{Ptr1}(addr@(xs))
//
in
  $effmask_all (loop (p0, i))
end // end of [sllist_getref_at]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_insert_at
  {n} (xs, i, x0) = let
  var xs = xs
  val p_i = sllist_getref_at (xs, i)
  val nx0 = g2node_make_elt<a> (x0)
  val nxs = $UN.ptr1_get<g2node0(a)> (p_i)
  val () = gnode_link10 (nx0, nxs)
  val () = $UN.ptr1_set<g2node1(a)> (p_i, nx0)
in
  $UN.castvwtp0{sllist(a, n+1)}(xs)
end // end of [sllist_insert_at]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_takeout_at
  {n} (xs, i) = let
  val p_i = sllist_getref_at (xs, i)
  val nxs = $UN.ptr1_get<g2node1(a)> (p_i)
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val () = $UN.ptr1_set<g2node0(a)> (p_i, nxs)
  prval (
  ) = __assert (xs) where {
    extern praxi __assert (xs: &sllist (a, n) >> sllist (a, n-1)): void
  } // end of [where] // end of [prval]
in
  g2node_getfree_elt (nx0)
end // end of [sllist_takeout_at]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_append
  {n1,n2} (xs1, xs2) = let
//
prval() = lemma_sllist_param(xs1)
prval() = lemma_sllist_param(xs2)
//
val iscons1 = sllist_is_cons(xs1)
//
in
//
if
iscons1
then let
  val iscons2 = sllist_is_cons(xs2)
in
//
if iscons2 then let
  val nxs1 = sllist1_decode (xs1)
  val nxs2 = sllist0_decode (xs2)
  val nxs1_end = gnodelst_next_all (nxs1)
  val _void_ = gnode_link10 (nxs1_end, nxs2)
in
  sllist0_encode (nxs1)
end else let
  prval () = sllist_free_nil (xs2) in xs1
end // end of [if]
//
end else let
  prval () = sllist_free_nil (xs1) in xs2
end // end of [if]
//
end // end of [sllist_append]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_reverse (xs) = let
in
  sllist_reverse_append (xs, sllist_nil ())
end // end of [sllist_reverse]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_reverse_append
  (xs1, xs2) = let
//
fun loop
(
  nxs: g2node0 (a), res: g2node1 (a)
) : g2node1 (a) = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if
iscons
then let
  val nx0 = nxs
  val nxs = gnode_get_next (nx0)
  val () = gnode_link11 (nx0, res)
in
  loop (nxs, nx0)
end else res // end of [if]
//
end // end of [loop]
//
prval (
) = lemma_sllist_param (xs1)
//
val iscons = sllist_is_cons (xs1)
//
in
//
if
iscons
then let
  val nxs1 = sllist1_decode (xs1)
  val nx0 = nxs1
  val nxs1 = gnode_get_next (nx0)
  val () = gnode_link10 (nx0, sllist0_decode (xs2))
in
  sllist0_encode ($effmask_all (loop (nxs1, nx0)))
end else let
  prval () = sllist_free_nil (xs1)
in
  xs2
end // end of [if]
//
end // end of [sllist_reverse_append]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_free
  (xs) = let
//
fun
loop
(
  nxs: g2node0(a)
) : void = let
//
val
iscons =
gnodelst_is_cons(nxs)
//
in
//
if
iscons
then let
  val nxs2 =
    gnode_get_next(nxs)
  // end of [val]
  val () = g2node_free<a>(nxs)
in
  loop(nxs2)
end else () // end of [if]
//
end // end of [loop]
//
val nxs = sllist0_decode(xs)
//
in
  $effmask_all (loop(nxs))
end // end of [sllist_free]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_freelin
  (xs) = let
//
implement
(a2)(*tmp*)
gclear_ref<a2>(x0) =
{
prval () = $UN.castview2void_at(view@x0)
  val () = sllist_freelin$clear<a>(x0)
prval () = $UN.castview2void_at(view@x0)
} (* gclear_ref *)
//
fun
loop
(
  nxs: g2node0(a)
) : void = let
//
val
iscons =
gnodelst_is_cons(nxs)
//
in
//
if
iscons
then let
  val nxs2 =
    gnode_get_next(nxs)
  // end of [val]
  val () = g2node_freelin<a>(nxs)
in
  loop(nxs2)
end else () // end of [if]
//
end // end of [loop]
//
val nxs = sllist0_decode(xs)
//
in
  $effmask_all(loop(nxs))
end // end of [sllist_freelin]

(* ****** ****** *)

implement
{a}{b}
sllist_map{n}(xs) = let
//
fun
loop
(
  nxs: g2node0(a), p_res: ptr
) : void = let
//
val
iscons = gnodelst_is_cons(nxs)
//
in
//
if
iscons
then let
  val nx = nxs
  val nxs = gnode_get_next(nx)
  val p_x = gnode_getref_elt(nx)
  val (pf, fpf | p_x) = $UN.cptr_vtake{a}(p_x)
  val y = sllist_map$fopr<a><b>(!p_x)
prval ((*returned*)) = fpf(pf)
  val ny = g2node_make_elt<b>(y)
  val () = $UN.ptr0_set<g2node1(b)>(p_res, ny)
  val p_res = gnode_getref_next(ny)
in
  loop (nxs, cptr2ptr(p_res))
end else () // end of [if]
//
end (* end of [loop] *)
//
var res: ptr
val () = loop ($UN.castvwtp1{g2node0(a)}(xs), addr@(res))
//
in
  $UN.castvwtp0{sllist(b,n)}(res)
end (* end of [sllist_map] *)

(* ****** ****** *)

(*
fun{
a:vt0p}{env:vt0p
} sllist_foreach_env
  (xs: !Sllist (INV(a)), env: &env >> _): void
*)
implement
{a}{env}
sllist_foreach_env
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
  val test = sllist_foreach$cont (!p_elt, env)
in
  if test then let
    val () = sllist_foreach$fwork (!p_elt, env)
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
end // end of [sllist_foreach_env]

(* ****** ****** *)

implement
{}(*tmp*)
fprint_sllist$sep
  (out) = fprint_string (out, "->")
implement
{a}(*tmp*)
fprint_sllist (out, xs) = let
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
    if i > 0 then fprint_sllist$sep (out)
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
end // end of [fprint_sllist]

(* ****** ****** *)

datavtype
slnode_vtype
  (a:vt@ype+) = SLNODE of (a, ptr(*next*))
// end of [slnode_vtype]

(* ****** ****** *)

vtypedef slnode (a:vt0p) = slnode_vtype (a)

(* ****** ****** *)

extern
praxi slnode_vfree {a:vt0p} (nx: slnode (a)): void
extern
castfn
g2node_decode {a:vt0p} (nx: g2node1 (INV(a))):<> slnode (a)
extern
castfn
g2node_encode {a:vt0p} (nx: slnode (INV(a))):<> g2node1 (a)

(* ****** ****** *)

implement
{a}(*tmp*)
g2node_make_elt
  (x) = let
in
  $UN.castvwtp0{g2node1(a)}(SLNODE{a}(x, _))
end // end of [g2node_make_elt]

(* ****** ****** *)
//
implement
{a}(*tmp*)
g2node_free(nx) = let
  val nx =
    g2node_decode (nx)
  // end of [val]
  val+~SLNODE (_, _) = (nx) in (*nothing*)
end // end of [g2node_free]
//
implement
{a}(*tmp*)
g2node_freelin(nx) = let
  val nx =
    g2node_decode (nx)
  // end of [val]
  val+@SLNODE(x0, _) = (nx)
  val ((*freed*)) = gclear_ref<a>(x0) in free@{a}(nx)
end // end of [g2node_free]
//
(* ****** ****** *)

implement
{a}(*tmp*)
g2node_free_elt
  (nx, res) = let
  val nx = g2node_decode (nx)
  val~SLNODE (x, _) = (nx); val () = res := x in (*nothing*)
end // end of [g2node_free_elt]

implement
{a}(*tmp*)
g2node_getfree_elt
  (nx) = let
  val nx = g2node_decode (nx)
  val~SLNODE (x, _) = (nx) in x
end // end of [g2node_getfree_elt]

(* ****** ****** *)

implement(a)
gnode_getref_elt<mytkind><a>
  (nx) = let
//
val nx = g2node_decode (nx)
//
val+@SLNODE (elt, _) = nx
val p_elt = addr@ (elt)
prval () = fold@ (nx)
prval () = slnode_vfree (nx)
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
val+@SLNODE (_, next) = nx
val p_next = addr@ (next)
prval () = fold@ (nx)
prval () = slnode_vfree (nx)
//
in
  $UN.cast{cPtr1(g2node0(a))}(p_next)
end // end of [gnode_getref_next]

(* ****** ****** *)

implement(a)
gnode_link10<mytkind><a>
  (nx1, nx2) = gnode_set_next (nx1, nx2)
// end of [gnode_link10]

implement(a)
gnode_link11<mytkind><a>
  (nx1, nx2) = gnode_set_next (nx1, nx2)
// end of [gnode_link11]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_cons_ngc
  (nx0, xs) = let
//
val nxs = sllist0_decode (xs)
val _void_ = gnode_link10 (nx0, nxs)
//
in
  sllist0_encode (nx0)
end // end of [sllist_cons_ngc]

implement
{a}(*tmp*)
sllist_uncons_ngc
  (xs) = let
//
val nxs = sllist1_decode (xs)
val nxs2 = gnode_get_next (nxs)
val _void_ = xs := sllist0_encode (nxs2)
//
in
  nxs
end // end of [sllist_uncons_ngc]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_snoc_ngc
  {n} (xs, nx0) = let
//
vtypedef res = sllist(a,n+1)
//
val () = gnode_set_next_null (nx0)
//
val nxs = sllist0_decode (xs)
val iscons = gnodelst_is_cons (nxs)
//
in
//
if iscons then let
//
val nx_end = gnodelst_next_all (nxs)
val _void_ = gnode_link11 (nx_end, nx0)
//
in
  $UN.castvwtp0{res}(nxs)
end else
  $UN.castvwtp0{res}(nx0)
// end of [if]
//
end // end of [sllist_snoc_ngc]

(* ****** ****** *)

implement
{a}(*tmp*)
sllist_unsnoc_ngc
  {n} (xs) = let
//
fun loop
(
  xs: &Sllist1 (a) >> Sllist0(a)
) : g2node1(a) = let
//
val p = sllist_getref_next (xs)
//
val (pf, fpf | p) = $UN.ptr_vtake{Sllist0(a)}(p)
//
val iscons = sllist_is_cons (!p)
//
in
//
if iscons
  then let
    val res = loop (!p)
    prval () = fpf (pf) in res
  end // end of [then]
  else let
    prval () = fpf (pf)
    val nx = $UN.castvwtp0{g2node1(a)}(xs)
    val () = xs := sllist_nil{a}((*void*)) in nx
  end // end of [else]
// end of [if]
//
end (* end of [loop] *)
//
val res = $effmask_all (loop (xs))
//
prval [l:addr] EQADDR () = eqaddr_make_ptr (addr@xs)
//
prval () = view@xs := $UN.castview0{sllist(a,n-1)@l}(view@xs)
//
in
  res
end // end of [sllist_unsnoc_ngc]

(* ****** ****** *)

(* end of [sllist.dats] *)

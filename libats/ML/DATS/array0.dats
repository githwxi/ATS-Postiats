(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: July, 2012 *)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"

(* ****** ****** *)
//
extern
fun
memcpy
(
  d:ptr, s:ptr, n:size_t
) :<!wrt> ptr = "mac#atslib_ML_array0_memcpy"
// end of [memcpy]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
array0_of_arrszref{a}(A) = $UN.cast{array0(a)}(A)
//
implement
{}(*tmp*)
arrszref_of_array0{a}(A) = $UN.cast{arrszref(a)}(A)
//
(* ****** ****** *)

implement
{}(*tmp*)
array0_get_ref
  (A0) = let
  val ASZ =
    arrszref_of_array0 (A0) in arrszref_get_ref (ASZ)
  // end of [val]
end // end of [array0_get_ref]

implement
{}(*tmp*)
array0_get_size
  (A0) = let
  val ASZ =
    arrszref_of_array0 (A0) in arrszref_get_size (ASZ)
  // end of [val]
end // end of [array0_get_size]

implement
{}(*tmp*)
array0_get_refsize
  (A0) = let
  var asz: size_t
  val ASZ = arrszref_of_array0 (A0)
  val A = $effmask_wrt (arrszref_get_refsize (ASZ, asz))
in
  @(A, asz)
end // end of [array0_get_refsize]

(* ****** ****** *)

implement
{}(*tmp*)
array0_make_arrpsz
  (psz) = let
  val ASZ =
    arrszref_make_arrpsz(psz) in array0_of_arrszref(ASZ)
  // end of [val]
end // end of [array0_make_arrpsz]

implement
{}(*tmp*)
array0_make_arrayref
  (A, n) = let
  val ASZ =
    arrszref_make_arrayref(A, n) in array0_of_arrszref(ASZ)
  // end of [val]
end // end of [array0_make_arrpsz]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_make_elt
  (asz, x0) = let
  val ASZ =
    arrszref_make_elt<a>(asz, x0) in array0_of_arrszref(ASZ)
  // end of [val]
end // end of [array0_make_elt]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_make_list
  (xs) = let
  val xs = g1ofg0(xs)
  val ASZ = arrszref_make_list (xs) in array0_of_arrszref (ASZ)
end // end of [array0_make_list]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_make_rlist
  (xs) = let
  val xs = g1ofg0(xs)
  val ASZ = arrszref_make_rlist (xs) in array0_of_arrszref (ASZ)
end // end of [array0_make_rlist]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_make_subarray
  (A0, st, ln) = let
//
val st = g1ofg0(st)
val ln = g1ofg0(ln)
val [n:int] (A, asz) = array0_get_refsize (A0)
//
val [st:int] st =
  (if st <= asz then st else asz): sizeLte (n)
val [ln:int] ln =
  (if st + ln <= asz then ln else asz - st): sizeLte (n-st)
//
val A2 = arrayptr_make_uninitized<a> (ln)
val p2 = memcpy (ptrcast(A2), ptr_add<a> (ptrcast(A), st), ln*sizeof<a>)
val A2 = $UN.castvwtp0{arrayref(a,ln)}(A2)
//
in
  array0_make_arrayref (A2, ln)
end // end of [array0_make_subarray]

(* ****** ****** *)
//
implement
{a}(*tmp*)
print_array0 (A) =
  fprint_array0<a> (stdout_ref, A)
//
implement
{a}(*tmp*)
prerr_array0 (A) =
  fprint_array0<a> (stderr_ref, A)
//
implement
{a}(*tmp*)
fprint_array0 (out, A) =
  fprint_arrszref (out, arrszref_of_array0(A))
//
implement
{a}(*tmp*)
fprint_array0_sep (out, A, sep) =
  fprint_arrszref_sep (out, arrszref_of_array0(A), sep)
//
(* ****** ****** *)

implement
{a}{tk}
array0_get_at_gint
  (A0, i) = let
in
//
if i >= 0 then
  array0_get_at_size (A0, g0i2u(i))
else
  $raise ArraySubscriptExn() // neg index
//
end // end of [array0_get_at_gint]

implement
{a}{tk}
array0_get_at_guint
  (A0, i) = let
in
  array0_get_at_size (A0, g0u2u(i))
end // end of [array0_get_at_guint]

implement
{a}(*tmp*)
array0_get_at_size
  (A0, i) = let
  val ASZ =
    arrszref_of_array0 (A0) in arrszref_get_at_size (ASZ, i)
  // end of [val]
end // end of [array0_get_at_size]

(* ****** ****** *)

implement
{a}{tk}
array0_set_at_gint
  (A0, i, x) = let
in
//
if i >= 0 then
  array0_set_at_size (A0, g0i2u(i), x)
else
  $raise ArraySubscriptExn() // neg index
//
end // end of [array0_set_at_gint]

implement
{a}{tk}
array0_set_at_guint
  (A0, i, x) =
(
  array0_set_at_size (A0, g0u2u(i), x)
) // end of [array0_set_at_guint]

implement
{a}(*tmp*)
array0_set_at_size
  (A0, i, x) = let
  val ASZ =
    arrszref_of_array0 (A0) in arrszref_set_at_size (ASZ, i, x)
  // end of [val]
end // end of [array0_set_at_size]

(* ****** ****** *)

implement
{a}{tk}
array0_exch_at_gint
  (A0, i, x) = let
in
//
if i >= 0 then
  array0_exch_at_size (A0, g0i2u(i), x)
else
  $raise ArraySubscriptExn() // neg index
//
end // end of [array0_exch_at_gint]

implement
{a}{tk}
array0_exch_at_guint
  (A0, i, x) =
(
  array0_exch_at_size (A0, g0u2u(i), x)
) // end of [array0_exch_at_guint]

implement
{a}(*tmp*)
array0_exch_at_size
  (A0, i, x) = let
  val ASZ =
    arrszref_of_array0 (A0) in arrszref_exch_at_size (ASZ, i, x)
  // end of [val]
end // end of [array0_exch_at_size]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_interchange
  (A0, i, j) = let
  val ASZ =
    arrszref_of_array0 (A0) in arrszref_interchange (ASZ, i, j)
  // end of [val]
end // end of [array0_interchange]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_subcirculate
  (A0, i, j) = let
  val ASZ =
    arrszref_of_array0 (A0) in arrszref_subcirculate (ASZ, i, j)
  // end of [val]
end // end of [array0_subcirculate]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_copy
  (A0) = let
//
val ASZ = arrszref_of_array0 (A0)
//
var asz: size_t
val A = arrszref_get_refsize (ASZ, asz)
//
val (
  vbox pf | p
) = arrayref_get_viewptr (A)
val (pfarr, pfgc | q) = array_ptr_alloc<a> (asz)
val () = array_copy<a> (!q, !p, asz)
//
val A2 = arrayptr_encode (pfarr, pfgc | q)
val A2 = arrayptr_refize (A2) // non-linearizing
val ASZ2 = arrszref_make_arrayref (A2, asz)
//
in
  array0_of_arrszref (ASZ2)
end // end of [array0_copy]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_append
  (A01, A02) = let
//
val ASZ1 = arrszref_of_array0 (A01)
and ASZ2 = arrszref_of_array0 (A02)
//
var asz1: size_t and asz2: size_t
val A1 = arrszref_get_refsize (ASZ1, asz1)
and A2 = arrszref_get_refsize (ASZ2, asz2)
//
val (pf1box | p1) = arrayref_get_viewptr (A1)
and (pf2box | p2) = arrayref_get_viewptr (A2)
//
extern
praxi unbox
  : {v:view} vbox(v) -<prf> (v, v -<lin,prf> void)
//
prval (pf1, fpf1) = unbox (pf1box)
prval (pf2, fpf2) = unbox (pf2box)
//
val asz = asz1 + asz2
val (pfarr, pfgc | q) = array_ptr_alloc<a> (asz)
prval (pf1arr, pf2arr) = array_v_split_at (pfarr | asz1)
//
val () = array_copy<a> (!q, !p1, asz1)
val q2 = ptr1_add_guint<a> (q, asz1)
val (pf2arr | q2) = viewptr_match (pf2arr | q2)
val () = array_copy<a> (!q2, !p2, asz2)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
prval pfarr = array_v_unsplit (pf1arr, pf2arr)
//
val A12 = arrayptr_encode (pfarr, pfgc | q)
val A12 = arrayptr_refize (A12)
val ASZ12 = arrszref_make_arrayref (A12, asz)
//
in
  array0_of_arrszref (ASZ12)
end // end of [array0_append]

(* ****** ****** *)
//
implement
{a}{b}
array0_map
  (A, fopr) = let
//
val p0 = array0_get_ref (A)
val asz = array0_get_size (A)
//
val fopr = $UN.cast{cfun1(ptr, b)}(fopr)
//
in
//
array0_tabulate<b>
  (g1ofg0(asz), lam i => fopr(ptr_add<a>(p0, i)))
//
end // end of [array0_map]
//
implement
{a}{b}
array0_map_method
  (A0, _(*TYPE*)) = lam(fopr) => array0_map<a>(A0, fopr)
//
(* ****** ****** *)

implement
{a}(*tmp*)
array0_tabulate
  {n}(asz, f) = let
//
implement{a2}
array_tabulate$fopr
  (i) = let
//
  val i =
  $UN.cast{sizeLt(n)}(i)
//
in
  $UN.castvwtp0{a2}(f(i))
end // array_tabulate$fopr
//
val ASZ = arrszref_tabulate<a> (asz)
//
in
  array0_of_arrszref (ASZ)  
end // end of [array0_tabulate]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_find_exn (A0, p) = let
//
val
ASZ = arrszref_of_array0 (A0)
//
var
asz : size_t
val A = arrszref_get_refsize (ASZ, asz)
//
implement(tenv)
array_foreach$cont<a><tenv>(x, env) = ~p(x)
implement(tenv)
array_foreach$fwork<a><tenv>(x, env) = ((*nothing*))
//
val idx = arrayref_foreach<a>(A, asz)
//
in
  if idx < asz then idx else $raise NotFoundExn()
end // end of [array0_find_exn]

(* ****** ****** *)

(*
/*
implement
{a}(*tmp*)
array0_find_opt (A0, p) =
  try Some_vt(array0_find_exn<a> (A0, p)) with ~NotFoundExn() => None_vt()
// end of [array0_find_opt]
*/
*)

(* ****** ****** *)
//
implement
{a}(*tmp*)
array0_exists
  (A0, pred) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A =
  arrszref_get_refsize(ASZ, asz)
//
implement
array_foreach$cont<a><bool>
  (x, env) = not(env)
implement
array_foreach$fwork<a><bool>
  (x, env) =
  if pred(x) then env := true else ()
//
in
//
env where
{
//
var env:bool = false
val _(*asz*) =
  arrayref_foreach_env<a><bool>(A, asz, env)
//
} (* end of [where] *)
//
end // end of [array0_exists]
//
implement
{a}(*tmp*)
array0_exists_method(A0) =
  lam(pred) => array0_exists<a>(A0, pred)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
array0_iexists
  (A0, pred) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A =
  arrszref_get_refsize(ASZ, asz)
//
implement
array_iforeach$cont<a><bool>
  (i, x, env) = not(env)
implement
array_iforeach$fwork<a><bool>
  (i, x, env) =
  if pred(i, x) then env := true else ()
//
in
//
env where
{
//
var env:bool = false
val _(*asz*) =
  arrayref_iforeach_env<a><bool>(A, asz, env)
//
} (* end of [where] *)
//
end // end of [array0_iexists]
//
implement
{a}(*tmp*)
array0_iexists_method(A0) =
  lam(pred) => array0_iexists<a>(A0, pred)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
array0_forall
  (A0, pred) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A =
  arrszref_get_refsize(ASZ, asz)
//
implement
array_foreach$cont<a><bool>
  (x, env) = (env)
implement
array_foreach$fwork<a><bool>
  (x, env) =
  if pred(x) then () else env := false
//
in
//
env where
{
//
var env:bool = true
val _(*asz*) =
  arrayref_foreach_env<a><bool>(A, asz, env)
//
} (* end of [where] *)
//
end // end of [array0_forall]
//
implement
{a}(*tmp*)
array0_forall_method(A0) =
  lam(pred) => array0_forall<a>(A0, pred)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
array0_iforall
  (A0, pred) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A =
  arrszref_get_refsize(ASZ, asz)
//
implement
array_iforeach$cont<a><bool>
  (i, x, env) = (env)
implement
array_iforeach$fwork<a><bool>
  (i, x, env) =
  if pred(i, x) then () else env := false
//
in
//
env where
{
//
var env:bool = true
val _(*asz*) =
  arrayref_iforeach_env<a><bool>(A, asz, env)
//
} (* end of [where] *)
//
end // end of [array0_iforall]
//
implement
{a}(*tmp*)
array0_iforall_method(A0) =
  lam(pred) => array0_iforall<a>(A0, pred)
//
(* ****** ****** *)

implement
{a}(*tmp*)
array0_foreach
  (A0, fwork) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A = arrszref_get_refsize(ASZ, asz)
//
implement(tenv)
array_foreach$cont<a><tenv>(x, env) = true
implement(tenv)
array_foreach$fwork<a><tenv>(x, env) = fwork(x)
//
val _(*asz*) = arrayref_foreach<a>(A, asz)
//
in
  // nothing
end // end of [array0_foreach]
//
implement
{a}(*tmp*)
array0_foreach_method(A0) =
  lam(fwork) => array0_foreach<a>(A0, fwork)
//
(* ****** ****** *)

implement
{a}(*tmp*)
array0_iforeach
  (A0, fwork) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A = arrszref_get_refsize(ASZ, asz)
//
implement(tenv)
array_iforeach$cont<a><tenv>(i, x, env) = true
implement(tenv)
array_iforeach$fwork<a><tenv>(i, x, env) = fwork(i, x)
//
val _(*asz*) = arrayref_iforeach<a> (A, asz)
//
in
  // nothing
end // end of [array0_iforeach]
//
implement
{a}(*tmp*)
array0_iforeach_method(A0) =
  lam(fwork) => array0_iforeach<a>(A0, fwork)
//
(* ****** ****** *)

implement
{a}(*tmp*)
array0_rforeach
  (A0, fwork) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A = arrszref_get_refsize(ASZ, asz)
//
implement(tenv)
array_rforeach$cont<a><tenv>(x, env) = true
implement(tenv)
array_rforeach$fwork<a><tenv>(x, env) = fwork(x)
//
val _(*asz*) = arrayref_rforeach<a> (A, asz)
//
in
  // nothing
end // end of [array0_rforeach]
//
implement
{a}(*tmp*)
array0_rforeach_method(A0) =
  lam(fwork) => array0_rforeach<a>(A0, fwork)
//
(* ****** ****** *)

implement
{tres}{a}
array0_foldleft
(
  A0, ini, fopr
) = res where
{
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A = arrszref_get_refsize(ASZ, asz)
//
implement
array_foreach$cont<a><tres> (x, env) = true
implement
array_foreach$fwork<a><tres> (x, env) = env := fopr(env, x)
//
var
res: tres = ini
val _(*asz*) =
  arrayref_foreach_env<a><tres>(A, asz, res)
//
} (* end of [array0_foldleft] *)
//
implement
{tres}{a}
array0_foldleft_method(A0, _) =
  lam(ini, fopr) => array0_foldleft<tres><a>(A0, ini, fopr)
//
(* ****** ****** *)

implement
{tres}{a}
array0_ifoldleft
(
  A0, ini, fopr
) = res where
{
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A = arrszref_get_refsize(ASZ, asz)
//
implement
array_iforeach$cont<a><tres>(i, x, env) = true
implement
array_iforeach$fwork<a><tres>(i, x, env) = (env := fopr(env, i, x))
//
var
res: tres = ini
val _(*asz*) =
  arrayref_iforeach_env<a><tres>(A, asz, res)
//
} (* end of [array0_ifoldleft] *)
//
implement
{tres}{a}
array0_ifoldleft_method(A0, _) =
  lam(ini, fopr) => array0_ifoldleft<tres><a>(A0, ini, fopr)
//
(* ****** ****** *)

implement
{a}{tres}
array0_foldright
(
  A0, fopr, snk
) = res where
{
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A =
  arrszref_get_refsize(ASZ, asz)
//
implement
array_rforeach$cont<a><tres>
  (x, env) = true
implement
array_rforeach$fwork<a><tres>
  (x, env) = env := fopr(x, env)
//
var
res: tres = snk
//
val _(*asz*) =
arrayref_rforeach_env<a><tres>(A, asz, res)
//
} (* end of [array0_foldright] *)
//
implement
{a}{tres}
array0_foldright_method
  (A0, _) =
(
  lam(fopr, snk) =>
    array0_foldright<a><tres>(A0, fopr, snk)
) (* end of [lam] *)
//
(* ****** ****** *)

implement
{a}(*tmp*)
array0_is_ordered
  (A0, cmp) = let
//
implement
gcompare_ref_ref<a>
  (x, y) = $effmask_all(cmp(x, y))
//
in (* in-of-let *)
//
let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A =
  arrszref_get_refsize(ASZ, asz)
//
in
//
  arrayref_is_ordered<a>(A, asz)
//
end // end of [let]
//
end // end of [array0_is_ordered]

(* ****** ****** *)

implement
{a}(*tmp*)
array0_quicksort
  (A0, cmp) = let
//
val
ASZ = arrszref_of_array0(A0)
//
var
asz : size_t
val A =
  arrszref_get_refsize(ASZ, asz)
//
implement
{a}(*tmp*)
array_quicksort$cmp
  (x1, x2) = let
//
val
cmp =
$UN.cast{(&a,&a)-<cloref>int}(cmp)
//
in
   cmp(x1, x2)
end // end of [array_quicksort$cmp]
//
in
  arrayref_quicksort<a> (A, asz)
end // end of [array0_quicksort]

(* ****** ****** *)
//
// HX: some common generic functions
//
(* ****** ****** *)

implement
(a)(*tmp*)
fprint_val<array0(a)> = fprint_array0<a>

(* ****** ****** *)

implement
(a)(*tmp*)
gcompare_val_val<array0(a)>
  (xs, ys) = let
//
val m = array0_get_size{a}(xs)
val n = array0_get_size{a}(ys)
//
fun
loop
(
  px: ptr, py: ptr, i: size_t, j: size_t
) : int =
(
if (
i < m
) then (
//
if j < n
  then let
    val (pfx, fpfx | px) =
      $UN.ptr_vtake{a}(px)
    val (pfy, fpfy | py) =
      $UN.ptr_vtake{a}(py)
    val sgn = gcompare_ref_ref(!px, !py)
    prval () = fpfx(pfx) and () = fpfy(pfy)
  in
    if sgn != 0
      then (sgn)
      else loop(ptr_succ<a>(px), ptr_succ<a>(py), succ(i), succ(j))
    // end of [if]
  end else (1) // end of [else]
//
) else (
//
if j < n then (~1) else (0)
//
) (* end of [else] *)
) (* end of [loop] *)
//
in
  $effmask_all(loop(array0_get_ref{a}(xs), array0_get_ref{a}(xs), i2sz(0), i2sz(0)))
end // end of [gcompare_val_val]

(* ****** ****** *)

(* end of [array0.dats] *)

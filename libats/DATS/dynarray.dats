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
(* Start time: May, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/dynarray.sats"

(* ****** ****** *)
//
extern
fun memcpy
  : (ptr, ptr, size_t) -<0,!wrt> ptr = "mac#atslib_dynarray_memcpy"
extern
fun memmove
  : (ptr, ptr, size_t) -<0,!wrt> ptr = "mac#atslib_dynarray_memmove"
//
(* ****** ****** *)
//
// HX:
// recapacitizing policy
// 0: manual
// 1: automatic doubling
//
implement
{}(*tmp*)
dynarray$recapacitize () = 1 // default policy
//
(* ****** ****** *)

local

datavtype
dynarray (a:vt@ype+) =
  {m,n:int | m > 0; m >= n}
  DYNARRAY of (arrayptr (a, m), size_t m, size_t n)
// end of [dynarray]

assume
dynarray_vtype (a) = dynarray (a)

in (* in of [local] *)

implement
{a}(*tmp*)
dynarray_make_nil
  (cap) = let
//
val A = arrayptr_make_uninitized<a> (cap)
val A = __cast (A) where
{
  extern castfn __cast {n:int} (arrayptr (a?, n)):<> arrayptr (a, n)
} (* end of [val] *)
//
in
  DYNARRAY (A, cap, g1i2u(0))
end (* end of [dynarray_make_nil] *)

(* ****** ****** *)

implement
{}(*tmp*)
dynarray_getfree_arrayptr
  (DA, n) = let
//
val+
~DYNARRAY{a}{m,n}(A, _, n0) = DA
//
val () = n := n0
prval () = lemma_g1uint_param (n0)
//
in
  $UN.castvwtp0{arrayptr(a,n)}(A)
end (* end of [dynarray_getfree_arrayptr] *)

(* ****** ****** *)

implement
{}(*tmp*)
dynarray_get_array
  (DA, n) = let
//
val+DYNARRAY{a}{m,n}(A, _, n0) = DA
//
val () = n := n0
val p0 = arrayptr2ptr (A)
//
val (pf, fpf | p0) = $UN.ptr_vtake{array(a,n)}(p0)
//
in
  (pf, fpf | p0)
end (* end of [dynarray_get_array] *)

(* ****** ****** *)

implement
{}(*tmp*)
dynarray_get_size (DA) = let
  val+DYNARRAY (_, _, n) = DA in (n)
end // end of [dynarray_get_size]
implement
{}(*tmp*)
dynarray_get_capacity (DA) = let
  val+DYNARRAY (_, m, _) = DA in (m)
end // end of [dynarray_get_capacity]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_getref_at
  (DA, i) = let
//
val i = g1ofg0_uint (i)
val+DYNARRAY (A, m, n) = DA
val pi =
(
  if i < n then ptr_add<a> (arrayptr2ptr(A), i) else the_null_ptr
) : ptr // end of [val]
//
in
  $UN.cast{cPtr0(a)}(pi)
end // end of [dynarray_getref_at]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insert_at
  (DA, i, x, res) = let
//
val i = g1ofg0_uint(i)
//
val+@DYNARRAY(A, m, n) = DA
//
in
//
if i <= n then let
//
// HX: [i] is a valid position
//
in
//
if m > n then let
  val p1 =
    ptr_add<a>
    (arrayptr2ptr(A), i)
  // end of [val]
  val p2 = ptr_succ<a>(p1)
  val ptr =
    memmove
    (p2, p1, (n-i)*sizeof<a>)
  // end of [val]
  val () = $UN.ptr0_set<a> (p1, x)
  val () = n := succ(n)
//
prval () = fold@(DA)
prval () = opt_none{a}(res)
//
in
  false
end else let
  val m = m
//
prval () = fold@(DA)
//
  val recap = dynarray$recapacitize<>()
in
//
if
recap > 0
then let
  val _(*true*) =
  dynarray_reset_capacity<a>(DA, m+m)
in
  dynarray_insert_at<a>(DA, i, x, res)
end // end of [then]
else let
  val () = res := x
//
prval () = opt_some{a}(res)
//
in
  true
end // end of [else]
//
end // end of [if]
//
end else let
//
  val () = res := x
//
prval () = fold@(DA)
prval () = opt_some{a}(res)
//
in
  true
end // end of [if]
//
end // end of [dynarray_insert_at]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insert_atbeg_exn
  (DA, x) = let
in
  dynarray_insert_at_exn<a>(DA, i2sz(0), x)
end // end of [dynarray_insert_atbeg_exn]
implement
{a}(*tmp*)
dynarray_insert_atbeg_opt
  (DA, x) = let
in
  dynarray_insert_at_opt<a>(DA, i2sz(0), x)
end // end of [dynarray_insert_atbeg_opt]

(* ****** ****** *)
//
implement
{a}(*tmp*)
dynarray_insert_atend_exn
  (DA, x) = let
//
val+DYNARRAY (_, _, n) = DA
//
in
  dynarray_insert_at_exn<a>(DA, n, x)
end // end of [dynarray_insert_atend_exn]
//
implement
{a}(*tmp*)
dynarray_insert_atend_opt
  (DA, x) = let
//
val+DYNARRAY (_, _, n) = DA
//
in
  dynarray_insert_at_opt<a>(DA, n, x)
end // end of [dynarray_insert_atend_opt]
//
(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insertseq_at
  (DA, i, xs, n2) = let
//
fun pow2min
(
  s1: sizeGte(1), s2: size_t
) : sizeGte(1) =
(
  if s1 >= s2 then s1 else pow2min (s1+s1, s2)
) (* end of [pow2min] *)
//
val i = g1ofg0_uint (i)
val+@DYNARRAY (A, m, n) = DA
//
in
//
if i <= n then let
//
// HX: [i] is a valid position
//
in
//
if n + n2 <= m then let
  val p1 =
    ptr_add<a> (arrayptr2ptr(A), i)
  val p2 = ptr_add<a> (p1, n2)
  val ptr =
    memmove (p2, p1, (n-i)*sizeof<a>)
  val ptr =
    memcpy (p1, addr@(xs), n2*sizeof<a>)
  val () = n := n+n2
  prval () = fold@ (DA)
  prval () =
  __assert (xs) where
  {
    extern
    praxi
    __assert
      {n:int}
      (xs: &array(a, n) >> arrayopt (a, n, false)): void
    // praxi
  } (* end of [prval] *)
in
  false
end else let
  val m = m and n = n
  prval () = fold@ (DA)
  val recap = dynarray$recapacitize<>()
in
//
if recap > 0 then let
  val m2 = pow2min (m+m, n+n2)
  val _(*true*) = dynarray_reset_capacity<a>(DA, m2)
in
  dynarray_insertseq_at<a>(DA, i, xs, n2)
end else let
  prval () = arrayopt_some{a}(xs) in true
end (* end of [if] *)
//
end // end of [if]
//
end else let
  prval () = fold@ (DA)
  prval () = arrayopt_some{a}(xs) in true
end // end of [if]
//
end // end of [dynarray_insertseq_at]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_at
  (DA, i, res) = let
//
val i = g1ofg0_uint (i)
val+@DYNARRAY (A, m, n) = DA
//
in
//
if i < n then let
  val p1 = ptr_add<a> (arrayptr2ptr(A), i)
  val p2 = ptr_succ<a> (p1)
  val n1 = pred (n)
  val x = $UN.ptr0_get<a> (p1)
  val ptr = memmove (p1, p2, (n1-i)*sizeof<a>)
  val () = n := n1
  prval () = fold@ (DA)
  val () = res := x
  prval () = opt_some{a}(res)
in
  true
end else let
  prval () = fold@ (DA)
  prval () = opt_none{a}(res)
in
  false
end // end of [if]
//
end // end of [dynarray_takeout_at]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_atbeg_exn
  (DA) = let
in
  dynarray_takeout_at_exn<a>(DA, i2sz(0))
end // end of [dynarray_takeout_atbeg_exn]
//
implement
{a}(*tmp*)
dynarray_takeout_atbeg_opt
  (DA) = let
in
  dynarray_takeout_at_opt<a>(DA, i2sz(0))
end // end of [dynarray_takeout_atbeg_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_atend_exn
  (DA) = let
//
val+DYNARRAY (_, _, n) = DA
//
in
//
if
n > 0
then (
  dynarray_takeout_at_exn<a>(DA, pred(n))
) else let
  var res: a?
  val () = prerr "exit(ATSLIB): [dynarray_takeout_atend_exn] failed."
  val () = exit_void (1)
in
  $UN.castvwtp0{a}(res)
end (* end of [if] *)
//
end // end of [dynarray_takeout_atend_exn]
//
implement
{a}(*tmp*)
dynarray_takeout_atend_opt
  (DA) = let
//
val+DYNARRAY (_, _, n) = DA
//
in
//
if n > 0
  then dynarray_takeout_at_opt<a>(DA, pred(n)) else None_vt{a}()
//
end // end of [dynarray_takeout_atend_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_removeseq_at
  (DA, st, ln) = let
//
val+DYNARRAY (A, m, n) = DA
//
in
//
if
st < n
then let
//
val ln1 = n - st
val ln2 = min (ln, ln1)
val p0 = ptrcast(A)
val p1 = ptr_add<a> (p0, st)
val p2 = ptr_add<a> (p1, ln2)
//
val p1 =
memmove (p1, p2, (ln1-ln2)*sizeof<a>)
//
val+@DYNARRAY (A, m, n) = DA
val ((*void*)) = n := n - ln2
//
prval () = $UN.castview0{void}(view@A)
prval () = $UN.castview0{void}(view@m)
prval () = $UN.castview0{void}(view@n)
prval () = $UN.castview2void{dynarray(a)}(DA) in ln2
//
end // end of [then]
else i2sz(0) // end of [else]
//
end // end of [dynarray_removeseq_at]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_listize0
  (DA) = xs where
{
//
var asz: size_t?
val (pf, fpf | p0) =
  dynarray_get_array(DA, asz)
//
prval () =
  lemma_array_v_param(pf)
//
val xs =
  array_copy_to_list_vt<a>(!p0, asz)
//
prval ((*returned*)) = $UN.cast2void((pf, fpf | p0))
//
val+@DYNARRAY(A,m,n)=DA; val()=(n := i2sz(0)); prval()=fold@(DA)
//
} // end of [dynarray_listize0]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_listize1
  (DA) = xs where
{
//
var asz: size_t?
val (pf, fpf | p0) =
  dynarray_get_array(DA, asz)
//
prval () =
  lemma_array_v_param(pf)
//
val xs = array_copy_to_list_vt<a>(!p0, asz)
//
prval ((*returned*)) = fpf(pf)
//
} // end of [dynarray_listize1]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_reset_capacity
  (DA, m2) = let
//
val+@DYNARRAY (A, m, n) = DA
//
in
//
if m2 >= n then let
//
val A2 = arrayptr_make_uninitized<a> (m2)
//
val ptr = memcpy
(
  arrayptr2ptr(A2), arrayptr2ptr(A), n*sizeof<a>
) (* end of [val] *)
//
extern
castfn
__cast{n:int}(arrayptr (a, n)):<> arrayptr (a?, n)
extern
castfn
__cast2{n:int} (arrayptr (a?, n)):<> arrayptr (a, n)
//
val A1 = __cast(A)
val A2 = __cast2(A2)
//
val () = arrayptr_free (A1)
//
val () = A := A2
val () = m := m2
//
prval () = fold@ (DA)
//
in
  true
end else let
//
prval () = fold@ (DA)
//
in
  false
end // end of [if]
//
end // end of [dynarray_reset_capacity]

(* ****** ****** *)
//
implement
{a}(*tmp*)
dynarray_quicksort$cmp
  (x, y) = gcompare_ref_ref<a> (x, y)
//
(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_quicksort(DA) = let
//
val+
DYNARRAY{_a_}{m,n}(A, m, n) = DA
//
val p0 = arrayptr2ptr (A)
//
prval
(
pf, fpf
) = __assert (p0) where
{
//
extern
praxi
__assert
  {l:addr}
(
  p: ptr(l)
) : vtakeout0 (array_v (a, l, n))
//
} (* end of [prval] *)
//
implement
{a}(*tmp*)
array_quicksort$cmp
  (x, y) = dynarray_quicksort$cmp<a> (x, y)
//
val () =
  array_quicksort<a> (!p0, n)
//
prval ((*returned*)) = fpf (pf)
//
in
  // nothing
end // end of [dynarray_quicksort]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
{}(*tmp*)
dynarray_free(DA) = let
  var n: size_t
  val A = dynarray_getfree_arrayptr (DA, n)
in
  arrayptr_free (A)
end (* end of [dynarray_free] *)

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_dynarray(out, DA) = let
//
var n: size_t
//
val
(pf, fpf | p0) =
  dynarray_get_array(DA, n)
//
val ((*void*)) = fprint_array<a> (out, !p0, n)
//
prval ((*returned*)) = fpf(pf)
//
in
  // nothing
end (* end of [fprint_dynarray] *)

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_dynarray_sep
  (out, DA, sep) = let
//
implement
fprint_array$sep<>
  (out) = fprint_string(out, sep)
//
in
  fprint_dynarray<a>(out, DA)
end // end of [fprint_dynarray_sep]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_get_at_exn
  (DA, i) = let
//
val pi = dynarray_getref_at<a>(DA, i)
//
in
//
if cptr2ptr(pi) > 0
  then $UN.cptr_get<a>(pi) else $raise ArraySubscriptExn()
//
end // end of [dynarray_get_at_exn]

implement
{a}(*tmp*)
dynarray_set_at_exn
  (DA, i, x) = let
//
val pi = dynarray_getref_at<a>(DA, i)
//
in
//
if cptr2ptr(pi) > 0
  then $UN.cptr_set<a>(pi, x) else $raise ArraySubscriptExn()
//
end // end of [dynarray_set_at_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insert_at_exn
  (DA, i, x) = let
//
var res: a?
val ans =
  dynarray_insert_at<a>(DA, i, x, res)
//
in
//
if ans then let
//
prval () = opt_unsome{a}(res)
prval () = $UN.cast2void (res)
//
val () = prerr "exit(ATSLIB): [dynarray_insert_at_exn] failed."
//
in
  exit_void (1)
end else let
//
prval () = opt_unnone{a}(res)
//
in
  // nothing
end // end of [if]
//
end (* end of [dynarray_insert_at_exn] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_insert_at_opt
  (DA, i, x) = let
//
var res: a?
//
val ans =
  dynarray_insert_at<a>(DA, i, x, res)
//
in
  option_vt_make_opt<a>(ans, res)
end (* end of [dynarray_insert_at_opt] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_at_exn
  (DA, i) = let
//
var res: a?
//
val ans = dynarray_takeout_at<a>(DA, i, res)
//
in
//
if
ans
then let
//
prval () = opt_unsome{a}(res)
//
in
  res
end else let
//
prval () = opt_unnone{a}(res)
//
val (
) = prerr "exit(ATSLIB): [dynarray_takeout_at_exn] failed."
//
val () = exit_void (1)
//
in
  $UN.castvwtp0{a}(res)
end // end of [if]
//
end // end of [dynarray_takeout_at_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
dynarray_takeout_at_opt
  (DA, i) = let
//
var res: a?
val ans = dynarray_takeout_at<a>(DA, i, res)
//
in
  option_vt_make_opt<a>(ans, res)
end // end of [dynarray_takeout_at_opt]

(* ****** ****** *)
  
(* end of [dynarray.dats] *)

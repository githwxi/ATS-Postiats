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
(* Start time: September, 2013 *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.stkarray"
//
#define // HX: no dynloading
ATS_DYNLOADFLAG 0 // at run-time
//
#define // HX: prefix for external
ATS_EXTERN_PREFIX "atslib_" // names
//  
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/stkarray.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
stkarray_make_cap
  (cap) = stk where
{
//
val A = arrayptr_make_uninitized<a>(cap)
//
val
(pfat, pfgc | p) = ptr_alloc<stkarray_tsize>()
//
val (pfngc | stk) =
  stkarray_make_ngc_tsz{a}(pfat | p, A, cap, sizeof<a>)
//
prval ((*void*)) = mfree_gcngc_v_nullify(pfgc, pfngc)
//
} // end of [stkarray_make_cap]

(* ****** ****** *)

local

extern
fun
stkarray_get_size_tsz
  {a:vt0p}{m,n:int}
(
  stk: !stkarray (a, m, n), sizeof_t(a)
) :<> size_t(n) = "mac#%" // end-of-fun
extern
fun
stkarray_get_capacity_tsz
  {a:vt0p}{m,n:int}
(
  stk: !stkarray (a, m, n), sizeof_t(a)
) :<> size_t(m) = "mac#%" // end-of-fun

in (* in of [local] *)
//
implement
{a}(*tmp*)
stkarray_get_size
  (stk) =
  stkarray_get_size_tsz{a}(stk, sizeof<a>)
//
implement
{a}(*tmp*)
stkarray_get_capacity
  (stk) =
  stkarray_get_capacity_tsz{a}(stk, sizeof<a>)
//
end // end of [local]

(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_stkarray$sep
  (out) = fprint (out, "<-")
//
implement
{a}(*tmp*)
fprint_stkarray
  (out, stk) = let
//
val n =
stkarray_get_size<a>(stk)
//
prval
[n:int]
EQINT() = eqint_make_guint(n)
//
implement
fprint_array$sep<>
  (out) = fprint_stkarray$sep<>(out)
//
val
p_beg =
stkarray_get_ptrbeg{a}(stk)
//
val
(pf,fpf|p_beg) =
$UN.ptr_vtake{array(a,n)}(p_beg)
//
val () = fprint_array<a>(out, !p_beg, n)
//
prval () = fpf(pf) // end of [prval]
//
in
  // nothing
end // end of [fprint_stkarray]
//
(* ****** ****** *)

implement
{a}(*tmp*)
fprint_stkarray_sep
  (out, stk, sep) = let
//
implement
{}(*tmp*)
fprint_stkarray$sep
  (out) = fprint_string(out, sep)
//
in
  fprint_stkarray<a> (out, stk)
end // end of [fprint_stkarray_sep]

(* ****** ****** *)

extern fun
stkarray_get_ptrcur{a:vt0p}
  {m,n:int} (stk: !stkarray (INV(a), m, n)):<> ptr = "mac#%"
// end of [stkarray_get_ptrcur]
extern fun
stkarray_set_ptrcur{a:vt0p}
  {m,n:int} (stk: !stkarray (INV(a), m, n), ptr):<!wrt> void = "mac#%"
// end of [stkarray_set_ptrcur]

(* ****** ****** *)

implement
{a}(*tmp*)
stkarray_insert
  {m,n}(stk, x0) = let
//
val p_cur =
  stkarray_get_ptrcur{a}(stk)
//
val ((*void*)) =
  $UN.ptr0_set<a>(p_cur, x0)
val ((*void*)) =
  stkarray_set_ptrcur{a}(stk, ptr_succ<a>(p_cur))
//
prval () = __assert (stk) where
{
//
extern
praxi
__assert
  (!stkarray(a, m, n) >> stkarray(a, m, n+1)): void
//
} (* end of [prval] *)
//
in
  // nothing
end // end of [stkarray_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
stkarray_insert_opt
  (stk, x0) = let
//
val
isnot = stkarray_isnot_full{a}(stk)
//
in
//
if
isnot
then let
  val () = stkarray_insert<a>(stk, x0) in None_vt()
end else Some_vt{a}(x0)
//
end // end of [stkarray_insert_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
stkarray_takeout
  {m,n} (stk) = x0 where
{
//
val p_cur =
  stkarray_get_ptrcur{a}(stk)
//
val p1_cur = ptr_pred<a>(p_cur)
//
val x0 = $UN.ptr0_get<a>(p1_cur)
val () = stkarray_set_ptrcur{a}(stk, p1_cur)
//
prval () = __assert (stk) where
{
//
extern
praxi
__assert
  (!stkarray(a, m, n) >> stkarray(a, m, n-1)): void
//
} (* end of [prval] *)
//
} // end of [stkarray_takeout]

(* ****** ****** *)

implement
{a}(*tmp*)
stkarray_takeout_opt
  (stk) = let
//
val
isnot = stkarray_isnot_nil{a}(stk)
//
in
//
if
isnot
then let
//
  val x0 =
  stkarray_takeout<a>(stk) in Some_vt{a}(x0)
//
end else None_vt((*void*))
//
end // end of [stkarray_takeout_opt]

(* ****** ****** *)

implement
{a}{env}
stkarray_foreach$cont(x, env) = true

implement
{a}(*tmp*)
stkarray_foreach
  (stk) = let
  var env: void = () in
  stkarray_foreach_env<a><void>(stk, env)
end // end of [stkarray_foreach]

(* ****** ****** *)

implement
{a}{env}
stkarray_foreach_env
  (stk, env) = let
//
implement
array_rforeach$cont<a><env>
  (x, env) =
  stkarray_foreach$cont<a><env>(x, env)
implement
array_rforeach$fwork<a><env>
  (x, env) =
  stkarray_foreach$fwork<a><env>(x, env)
//
val n =
stkarray_get_size<a>(stk)
//
prval
[
n:int
] EQINT() = eqint_make_guint(n)
//
val p0 = stkarray_get_ptrbeg{a}(stk)
val (pf,fpf|p0) = $UN.ptr0_vtake{array(a,n)}(p0)
//
val res = array_rforeach_env<a><env>(!p0, n, env)
//
in
  let prval () = fpf(pf) in res end
end // end of [stkarray_foreach_env]

(* ****** ****** *)

(* end of [stkarray.dats] *)

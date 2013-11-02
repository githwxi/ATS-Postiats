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
(* Start time: October, 2013 *)

(* ****** ****** *)
  
#define ATS_PACKNAME "ATSLIB.libats.deqarray"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names
  
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/deqarray.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_make_cap
  (cap) = deq where
{
//
val cap1 = succ (cap)
//
val A = arrayptr_make_uninitized<a> (cap1)
//
val (pfat, pfgc | p) = ptr_alloc<deqarray_tsize> ()
//
val (pfngc | deq) = deqarray_make_ngc__tsz (pfat | p, A, cap, sizeof<a>)
//
prval ((*void*)) = mfree_gcngc_v_nullify (pfgc, pfngc)
//
} // end of [deqarray_make_cap]

(* ****** ****** *)

local
//
extern
fun deqarray_get_size__tsz{a:vt0p}
  {m,n:int} (deq: !deqarray (a, m, n), sizeof_t(a)):<> size_t(n) = "mac#%"
extern
fun deqarray_get_capacity__tsz{a:vt0p}
  {m,n:int} (deq: !deqarray (a, m, n), sizeof_t(a)):<> size_t(m) = "mac#%"
//
in (* in of [local] *)

implement{a}
deqarray_get_size (deq) = deqarray_get_size__tsz (deq, sizeof<a>)
implement{a}
deqarray_get_capacity (deq) = deqarray_get_capacity__tsz (deq, sizeof<a>)

end // end of [local]

(* ****** ****** *)
//
extern
fun deqarray_get_ptrfrnt{a:vt0p}
  {m,n:int} (deq: !deqarray (INV(a), m, n)):<> Ptr1 = "mac#%"
extern
fun deqarray_set_ptrfrnt{a:vt0p}
  {m,n:int} (deq: !deqarray (INV(a), m, n), p: ptr):<!wrt> void = "mac#%"
//
extern
fun deqarray_get_ptrrear{a:vt0p}
  {m,n:int} (deq: !deqarray (INV(a), m, n)):<> Ptr1 = "mac#%"
extern
fun deqarray_set_ptrrear{a:vt0p}
  {m,n:int} (deq: !deqarray (INV(a), m, n), p: ptr):<!wrt> void = "mac#%"
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
deqarray_ptr_succ{m,n:int} (deq: !deqarray (INV(a), m, n), p: ptr):<> ptr
extern
fun{a:vt0p}
deqarray_ptr_pred{m,n:int} (deq: !deqarray (INV(a), m, n), p: ptr):<> ptr
//
(* ****** ****** *)

local
//
extern
fun
deqarray_ptr_succ__tsz
  {a:vt0p}{m,n:int}
  (deq: !deqarray (INV(a), m, n), p: ptr, sizeof_t(a)):<> ptr = "mac#%"
extern
fun
deqarray_ptr_pred__tsz
  {a:vt0p}{m,n:int}
  (deq: !deqarray (INV(a), m, n), p: ptr, sizeof_t(a)):<> ptr = "mac#%"
//
in (* in of [local] *)

implement{a}
deqarray_ptr_succ (deq, p) = deqarray_ptr_succ__tsz (deq, p, sizeof<a>)
implement{a}
deqarray_ptr_pred (deq, p) = deqarray_ptr_pred__tsz (deq, p, sizeof<a>)

end // end of [local]

(* ****** ****** *)

local
//
extern
fun
deqarray_is_full__tsz
  {a:vt0p}{m,n:int}
(
  !deqarray (INV(a), m, n), sizeof_t(a)
) :<> bool (m==n) = "mac#%" // endfun
//
in (* in of [local] *)

implement{a}
deqarray_is_full (deq) =
  deqarray_is_full__tsz (deq, sizeof<a>)
implement{a}
deqarray_isnot_full (deq) = let
//
prval () = lemma_deqarray_param (deq)
//
in
  not(deqarray_is_full__tsz (deq, sizeof<a>))
end // end of [deqarray_isnot_full]

end // end of [local]

(* ****** ****** *)

implement{a}
deqarray_insert_atbeg
  {m,n} (deq, x0) = let
//
val p_rear = deqarray_get_ptrrear (deq)
val p1_rear = deqarray_ptr_pred<a> (deq, p_rear)
val ((*void*)) = $UN.ptr0_set<a> (p1_rear, x0)
val ((*void*)) = deqarray_set_ptrrear (deq, p1_rear)
//
prval () = __assert (deq) where
{
extern praxi __assert (!deqarray (a, m, n) >> deqarray (a, m, n+1)): void
} (* end of [prval] *)
//
in
  // nothing
end // end of [deqarray_insert_atbeg]

implement{a}
deqarray_insert_atbeg_opt
  (deq, x0) = let
//
val isnot = deqarray_isnot_full<a> (deq)
//
in
//
if isnot then let
  val () = deqarray_insert_atbeg (deq, x0) in None_vt()
end else Some_vt{a}(x0)
//
end // end of [deqarray_insert_atbeg_opt]

(* ****** ****** *)

implement{a}
deqarray_insert_atend
  {m,n} (deq, x0) = let
//
val p_frnt = deqarray_get_ptrfrnt (deq)
val ((*void*)) = $UN.ptr0_set<a> (p_frnt, x0)
val ((*void*)) = deqarray_set_ptrfrnt (deq, deqarray_ptr_succ<a> (deq, p_frnt))
//
prval () = __assert (deq) where
{
extern praxi __assert (!deqarray (a, m, n) >> deqarray (a, m, n+1)): void
} (* end of [prval] *)
//
in
  // nothing
end // end of [deqarray_insert_atend]

implement{a}
deqarray_insert_atend_opt
  (deq, x0) = let
//
val isnot = deqarray_isnot_full<a> (deq)
//
in
//
if isnot then let
  val () = deqarray_insert_atend (deq, x0) in None_vt()
end else Some_vt{a}(x0)
//
end // end of [deqarray_insert_atend_opt]

(* ****** ****** *)

implement{a}
deqarray_takeout_atbeg
  {m,n} (deq) = (x0) where
{
//
val p_rear = deqarray_get_ptrrear (deq)
//
val (
  pf, fpf | p
) = $UN.ptr0_vtake{a}(p_rear)
val x0 = !p
prval () = $UN.castview0((fpf, pf))
//
val () = deqarray_set_ptrrear (deq, deqarray_ptr_succ<a> (deq, p_rear))
//
prval () = __assert (deq) where
{
extern praxi __assert (!deqarray (a, m, n) >> deqarray (a, m, n-1)): void
} (* end of [prval] *)
//
} (* end of [deqarray_takeout_atbeg] *)

(* ****** ****** *)

implement{a}
deqarray_takeout_atbeg_opt
  (deq) = let
//
val isnot = deqarray_isnot_nil (deq)
//
in
//
if isnot then let
  val x0 = deqarray_takeout_atbeg (deq) in Some_vt{a}(x0)
end else None_vt((*void*))
//
end // end of [deqarray_takeout_atbeg_opt]

(* ****** ****** *)

implement{a}
deqarray_takeout_atend
  {m,n} (deq) = (x0) where
{
//
val p_frnt = deqarray_get_ptrfrnt (deq)
val p1_frnt = deqarray_ptr_pred<a> (deq, p_frnt)
//
val (
  pf, fpf | p
) = $UN.ptr0_vtake{a}(p1_frnt)
val x0 = !p
prval () = $UN.castview0((fpf, pf))
//
val () = deqarray_set_ptrfrnt (deq, p1_frnt)
//
prval () = __assert (deq) where
{
extern praxi __assert (!deqarray (a, m, n) >> deqarray (a, m, n-1)): void
} (* end of [prval] *)
//
} (* end of [deqarray_takeout_atend] *)

(* ****** ****** *)

implement{a}
deqarray_takeout_atend_opt
  (deq) = let
//
val isnot = deqarray_isnot_nil (deq)
//
in
//
if isnot then let
  val x0 = deqarray_takeout_atend (deq) in Some_vt{a}(x0)
end else None_vt((*void*))
//
end // end of [deqarray_takeout_atend_opt]

(* ****** ****** *)

implement{a}
fprint_deqarray_sep
  (out, deq, sep) = let
//
implement{}
fprint_deqarray$sep (out) = fprint_string (out, sep)
//
in
  fprint_deqarray<a> (out, deq)
end // end of [fprint_deqarray_sep]

(* ****** ****** *)

implement
{a}{env}
deqarray_foreach$cont (x, env) = true

implement{a}
deqarray_foreach (deq) = let
  var env: void = () in deqarray_foreach_env<a><void> (deq, env)
end // end of [deqarray_foreach]

(* ****** ****** *)

(* end of [deqarray.dats] *)

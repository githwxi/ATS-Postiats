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
val A = arrayptr_make_uninitized<a>(cap1)
//
val (pfat,pfgc|p) = ptr_alloc<deqarray_tsize> ()
//
val (pfngc | deq) =
  deqarray_make_ngc__tsz{a}(pfat | p,A,cap,sizeof<a>)
//
prval ((*freed*)) = mfree_gcngc_v_nullify(pfgc, pfngc)
//
} // end of [deqarray_make_cap]

(* ****** ****** *)

local
//
extern
fun
deqarray_get_size__tsz
  {a:vt0p}{m,n:int}
(
  deq: !deqarray(a, m, n), tsz: sizeof_t(a)
) :<> size_t(n) = "mac#%" // end-of-function
extern
fun
deqarray_get_capacity__tsz
  {a:vt0p}{m,n:int}
(
  deq: !deqarray(a, m, n), tsz: sizeof_t(a)
) :<> size_t(m) = "mac#%" // end-of-function
//
in (* in of [local] *)
//
implement
{a}(*tmp*)
deqarray_get_size
  (deq) =
  deqarray_get_size__tsz{a}(deq, sizeof<a>)
implement
{a}(*tmp*)
deqarray_get_capacity
  (deq) =
  deqarray_get_capacity__tsz{a}(deq, sizeof<a>)
//
end // end of [local]

(* ****** ****** *)
//
extern
fun
deqarray_get_ptrbeg
  {a:vt0p}{m,n:int}
  (deq: !deqarray (a, m, n)):<> Ptr1 = "mac#%"
extern
fun
deqarray_get_ptrend
  {a:vt0p}{m,n:int}
  (deq: !deqarray (a, m, n)):<> Ptr1 = "mac#%"
//
(* ****** ****** *)
//
extern
fun
deqarray_get_ptrfrnt
  {a:vt0p}{m,n:int}
  (deq: !deqarray (a, m, n)):<> Ptr1 = "mac#%"
extern
fun
deqarray_set_ptrfrnt
  {a:vt0p}{m,n:int}
  (deq: !deqarray (a, m, n), p: ptr):<!wrt> void = "mac#%"
//
extern
fun
deqarray_get_ptrrear
  {a:vt0p}{m,n:int}
  (deq: !deqarray(a, m, n)):<> Ptr1 = "mac#%"
extern
fun
deqarray_set_ptrrear
  {a:vt0p}{m,n:int}
  (deq: !deqarray(a, m, n), p: ptr):<!wrt> void = "mac#%"
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
deqarray_ptr_succ
  {m,n:int}
  (deq: !deqarray (INV(a), m, n), p: ptr):<> ptr
//
extern
fun{a:vt0p}
deqarray_ptr_pred
  {m,n:int}
  (deq: !deqarray (INV(a), m, n), p: ptr):<> ptr
//
(* ****** ****** *)

local
//
extern
fun
deqarray_ptr_succ__tsz
  {a:vt0p}{m,n:int}
(
  !deqarray(INV(a), m, n)
, p0: ptr, tsz: sizeof_t(a)
) :<> ptr = "mac#%" // end-of-function
extern
fun
deqarray_ptr_pred__tsz
  {a:vt0p}{m,n:int}
(
  !deqarray(INV(a), m, n)
, p0: ptr, tsz: sizeof_t(a)
) :<> ptr = "mac#%" // end-of-function
//
in (* in of [local] *)
//
implement
{a}(*tmp*)
deqarray_ptr_succ
  (deq, p0) =
  deqarray_ptr_succ__tsz{a}(deq, p0, sizeof<a>)
implement
{a}(*tmp*)
deqarray_ptr_pred
  (deq, p0) =
  deqarray_ptr_pred__tsz{a}(deq, p0, sizeof<a>)
//
end // end of [local]

(* ****** ****** *)

local
//
extern
fun
deqarray_is_full__tsz
  {a:vt0p}{m,n:int}
(
  !deqarray(INV(a), m, n), sizeof_t(a)
) :<> bool (m==n) = "mac#%" // endfun
//
in (* in of [local] *)
//
implement
{a}(*tmp*)
deqarray_is_full (deq) =
  deqarray_is_full__tsz{a}(deq, sizeof<a>)
//
implement
{a}(*tmp*)
deqarray_isnot_full(deq) = let
//
prval () = lemma_deqarray_param(deq)
//
in
  not(deqarray_is_full__tsz{a}(deq, sizeof<a>))
end // end of [deqarray_isnot_full]
//
end // end of [local]

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_insert_atbeg
  {m,n}(deq, x0) = let
//
val p_rear =
  deqarray_get_ptrrear{a}(deq)
val p1_rear =
  deqarray_ptr_pred<a>(deq, p_rear)
//
val ((*void*)) =
  $UN.ptr0_set<a>(p1_rear, x0)
val ((*void*)) =
  deqarray_set_ptrrear{a}(deq, p1_rear)
//
prval () = __assert(deq) where
{
extern praxi
  __assert (!deqarray(a, m, n) >> deqarray(a, m, n+1)): void
} (* end of [prval] *)
//
in
  // nothing
end // end of [deqarray_insert_atbeg]

implement
{a}(*tmp*)
deqarray_insert_atbeg_opt
  (deq, x0) = let
//
val isnot = deqarray_isnot_full<a>(deq)
//
in
//
if
isnot
then let
  val () = deqarray_insert_atbeg<a>(deq, x0) in None_vt()
end // end of [then]
else Some_vt{a}(x0) // end of [else]
//
end // end of [deqarray_insert_atbeg_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_insert_atend
  {m,n} (deq, x0) = let
//
val p_frnt = deqarray_get_ptrfrnt{a}(deq)
val ((*void*)) = $UN.ptr0_set<a>(p_frnt, x0)
val ((*void*)) =
  deqarray_set_ptrfrnt{a}(deq, deqarray_ptr_succ<a>(deq, p_frnt))
//
prval () = __assert (deq) where
{
extern praxi __assert (!deqarray(a, m, n) >> deqarray(a, m, n+1)): void
} (* end of [prval] *)
//
in
  // nothing
end // end of [deqarray_insert_atend]

implement
{a}(*tmp*)
deqarray_insert_atend_opt
  (deq, x0) = let
//
val isnot = deqarray_isnot_full<a>(deq)
//
in
//
if
isnot
then let
  val () = deqarray_insert_atend<a>(deq, x0) in None_vt()
end // end of [then]
else Some_vt{a}(x0) // end of [else]
//
end // end of [deqarray_insert_atend_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_takeout_atbeg
  {m,n} (deq) = (x0) where
{
//
val
p_rear =
deqarray_get_ptrrear{a}(deq)
//
val
(
  pf, fpf | p
) = $UN.ptr0_vtake{a}(p_rear)
val x0 = !p
prval () = $UN.castview0((fpf, pf))
//
val ((*void*)) =
deqarray_set_ptrrear{a}
  (deq, deqarray_ptr_succ<a>(deq, p_rear))
//
prval () = __assert (deq) where
{
extern
praxi __assert(!deqarray(a, m, n) >> deqarray(a, m, n-1)): void
} (* end of [where] *) // end of [prval]
//
} (* end of [deqarray_takeout_atbeg] *)

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_takeout_atbeg_opt
  (deq) = let
//
val isnot = deqarray_isnot_nil{a}(deq)
//
in
//
if
isnot
then let
  val x0 = deqarray_takeout_atbeg<a>(deq) in Some_vt{a}(x0)
end // end of [then]
else None_vt((*void*)) // end of [else]
//
end // end of [deqarray_takeout_atbeg_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_takeout_atend
  {m,n}(deq) = (x0) where
{
//
val p_frnt =
  deqarray_get_ptrfrnt{a}(deq)
val p1_frnt =
  deqarray_ptr_pred<a>(deq, p_frnt)
//
val (
  pf, fpf | p
) = $UN.ptr0_vtake{a}(p1_frnt)
val x0 = !p
prval () = $UN.castview0((fpf, pf))
//
val () =
deqarray_set_ptrfrnt{a}(deq, p1_frnt)
//
prval () = __assert(deq) where
{
//
extern praxi
  __assert(!deqarray(a, m, n) >> deqarray(a, m, n-1)): void
//
} (* end of [where] *) // end of [prval]
//
} (* end of [deqarray_takeout_atend] *)

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_takeout_atend_opt
  (deq) = let
//
val isnot = deqarray_isnot_nil{a}(deq)
//
in
//
if isnot then let
  val x0 = deqarray_takeout_atend<a>(deq) in Some_vt{a}(x0)
end else None_vt((*void*))
//
end // end of [deqarray_takeout_atend_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_get_at
  (deq, i) =
(
  $UN.cptr_get(deqarray_getref_at<a>(deq, i))
) (* end of [deqarray_get_at] *)

implement
{a}(*tmp*)
deqarray_set_at
  (deq, i, x) =
(
  $UN.cptr_set(deqarray_getref_at<a>(deq, i), x)
) (* end of [deqarray_set_at] *)

(* ****** ****** *)

local
//
extern
fun
deqarray_getref_at__tsz
  {a:vt0p}{m,n:int}
(
  deq: !deqarray(a, m, n), i: sizeLt(n), tsz: sizeof_t(a)
) :<> cPtr1(a) = "mac#%" // end-of-fun
//
in (* in of [local] *)
//
implement
{a}(*tmp*)
deqarray_getref_at
  (deq, i) = deqarray_getref_at__tsz{a}(deq, i, sizeof<a>)
//
end // end of [local]

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_deqarray
  (out, deq) = let
//
typedef tenv = int
//
implement
deqarray_foreach$fwork<a><tenv>
  (x, env) = let
//
val n0 = env
val () = if n0 > 0 then fprint_deqarray$sep<>(out)
val () = env := n0 + 1
//
in
  fprint_ref<a>(out, x)
end // end of [deqarray_foreach$fwork]
//
var env: tenv = 0
val ((*void*)) = deqarray_foreach_env<a><tenv>(deq, env)
//
in
  // nothing
end // end of [fprint_deqarray]

(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_deqarray$sep
  (out) =
  fprint_string(out, ", ")
//
(* ****** ****** *)

implement
{a}(*tmp*)
fprint_deqarray_sep
  (out, deq, sep) = let
//
implement
fprint_deqarray$sep<>
  (out) =
  fprint_string( out, sep )
//
in
  fprint_deqarray<a>(out, deq)
end // end of [fprint_deqarray_sep]

(* ****** ****** *)

implement
{a}{env}
deqarray_foreach$cont(x, env) = true

(* ****** ****** *)

implement
{a}(*tmp*)
deqarray_foreach(deq) = let
//
var
env: void = () in
  deqarray_foreach_env<a><void>(deq, env)
//
end // end of [deqarray_foreach]

(* ****** ****** *)

implement
{a}{env}
deqarray_foreach_env
  (deq, env) = let
//
fun
foreach
(
  p0: ptr, p1: ptr, env: &env
) : void = let
in
//
if
p0 < p1
then let
  val (
    pf, fpf | p0
  ) = $UN.ptr_vtake{a}(p0)
  val cont =
    deqarray_foreach$cont<a>(!p0, env)
  prval ((*returned*)) = fpf(pf)
in
  if cont
    then let
      val (
        pf, fpf | p0
      ) = $UN.ptr_vtake{a}(p0)
      val () =
        deqarray_foreach$fwork<a>(!p0, env)
      prval () = fpf (pf)
    in
      foreach(ptr_succ<a>(p0), p1, env)
    end // end of [then]
    else () // end of [else]
  // end of [if]
end // end of [then]
else () // end of [else]
//
end // end of [foreach]
//
val p_frnt = deqarray_get_ptrfrnt{a}(deq)
val p_rear = deqarray_get_ptrrear{a}(deq)
//
in
//
if
p_frnt > p_rear
then foreach(p_rear, p_frnt, env)
else let
  val p_beg = deqarray_get_ptrbeg{a}(deq)
  val p_end = deqarray_get_ptrend{a}(deq)
in
  foreach(p_rear, p_end, env); foreach(p_beg, p_frnt, env)
end // end of [else]
//
end // end of [deqarray_foreach_env]

(* ****** ****** *)

(* end of [deqarray.dats] *)

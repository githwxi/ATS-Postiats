(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: May, 2014 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.hashtbl_linprb"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
staload
STRING =
"libats/libc/SATS/string.sats"
//
(* ****** ****** *)

staload "libats/SATS/hashfun.sats"

(* ****** ****** *)

staload "libats/SATS/hashtbl_linprb.sats"

(* ****** ****** *)

#include "./SHARE/hashtbl.hats" // code reuse

(* ****** ****** *)

implement
{key,itm}
hashtbl_linprb_keyitm_nullize (kx) = let
  vtypedef ki = @(key, itm)
  val _(*ptr*) =
  $STRING.memset_unsafe(addr@(kx), 0, sizeof<ki>)
  prval () =
  __assert (kx) where
  { 
    extern praxi __assert (&(ki)? >> _): void
  } (* end of [prval] *)
in
  // nothing
end // end of [hashtbl_linprb_keyitm_nullize]

(* ****** ****** *)

implement(itm)
hashtbl_linprb_keyitm_is_null<string,itm> (kx) = (string2ptr(kx.0) = 0)

(* ****** ****** *)

extern
fun{
key:t0p;
itm:vt0p
} keyitmarr_linprb{m:int}
(
  A: &array((key,itm), m), cap: size_t(m), k0: key, ans: &bool? >> _
) : Ptr0 // end of [keyitmarr_linprb]

(* ****** ****** *)

implement
{key,itm}
keyitmarr_linprb
  {m}(A, cap, k0, ans) = let
//
val p0 = addr@(A)
vtypedef ki = @(key, itm)
val p_end = ptr_add<ki> (p0, cap)
//
fun loop
(
  p: ptr, ans: &bool? >> _
) : ptr =
(
if
p < p_end
then let
  val (pf, fpf | p) =
    $UN.ptr0_vtake{ki}(p)
  val isnul =
    hashtbl_linprb_keyitm_is_null<key,itm> (!p)
  prval ((*void*)) = fpf (pf)
in
  if isnul
    then let
      val () = ans := false in p
    end // end of [then]
    else let
      val (pf, fpf | p) =
        $UN.ptr0_vtake{ki}(p)
      val keq = equal_key_key<key> (k0, p->0)
      prval ((*void*)) = fpf (pf)
    in
      if keq
        then let
          val () = ans := true in p
        end // end of [then]
        else loop (ptr_succ<ki> (p), ans)
      // end of [if]
    end // end of [else]
  // end of [if]
end // end of [then]
else let
  val () = ans := false in the_null_ptr
end // end of [else]
)
//
val p_kx = loop(addr@(A), ans)
//
in
  g1ofg0 (p_kx) // it needs to be of the type [Ptr0]
end // end of [keyitmarr_linprb]

(* ****** ****** *)

extern
fun{
key:t0p;
itm:vt0p
} keyitmarr_linprb2
  {m:int}{ofs:int | ofs <= m}
(
  A: &array((key,itm), m), cap: size_t(m), ofs: size_t(ofs), k0: key, ans: &bool? >> _
) : Ptr0 // end of [keyitmarr_linprb2]

(* ****** ****** *)

implement
{key,itm}
keyitmarr_linprb2
  {m}{ofs}
(
  A, cap, ofs, k0, ans
) = let
//
val p0 = addr@(A)
vtypedef ki = @(key, itm)
val p1 = ptr_add<ki> (p0, ofs)
//
stadef n1 = ofs and n2 = m - ofs
//
val (pf, fpf | p1) = $UN.ptr0_vtake{array(ki,n2)}(p1)
val p_kx = keyitmarr_linprb<key,itm> (!p1, cap - ofs, k0, ans)
prval () = fpf (pf)
//
in
//
if p_kx > 0
  then p_kx
  else let
    val (pf, fpf | p0) = $UN.ptr0_vtake{array(ki,n1)}(p0)
    val p_kx = keyitmarr_linprb<key,itm> (!p0, ofs, k0, ans)
    prval () = fpf (pf)
  in
    p_kx
  end // end of [else]
// end of [if]
//
end // end of [keyitmarr_linprb2]

(* ****** ****** *)

extern
fun{
key:t0p;
itm:vt0p
} keyitmarr_reinserts
  {m:int}
(
  A: &array((key,itm), m) >> _, cap: size_t(m), p_kx: ptr
) : void // end of [keyitmarr_reinserts]

(* ****** ****** *)

implement
{key,itm}
keyitmarr_reinserts
  {m}(A, cap, p_kx) = let
//
val p0 = addr@(A)
vtypedef ki = @(key, itm)
val p_end = ptr_add<ki> (p0, cap)
//
fun
loop
(
  A: &array(ki, m) >> _, cap: size_t(m), p_kx: ptr
) : bool = let
in
//
if
p_kx < p_end
then let
//
val (pf, fpf | p_kx) = $UN.ptr0_vtake{ki}(p_kx)
val isnul =
  hashtbl_linprb_keyitm_is_null<key,itm> (!p_kx)
//
in
  if isnul
    then let
      prval () = fpf (pf) in true(*stopped*)
    end // end of [then]
    else let
      val k = p_kx->0
      val hk = hash_key<key> (k)
      val ofs = g0uint_mod (hk, $UN.cast{ulint}(cap))
      val ofs = $UN.cast{sizeLt(m)}(ofs)
//
      var ans: bool // uninitized
      val p2_kx = keyitmarr_linprb2<key,itm> (A, cap, ofs, k, ans)
//
    in
      if ans
        then let
          prval () = fpf (pf)
        in
          loop (A, cap, ptr_succ<ki> (p_kx))
        end // end of [then]
        else let
          val (pf2, fpf2 | p2_kx) = $UN.ptr0_vtake{ki?}(p2_kx)
          val () = p2_kx->0 := p_kx->0
          val () = p2_kx->1 := p_kx->1
          val () = hashtbl_linprb_keyitm_nullize<key,itm> (!p_kx)
          prval () = $UN.castview0((pf, fpf))
          prval () = $UN.castview0((pf2, fpf2))
        in
          loop (A, cap, ptr_succ<ki> (p_kx))
        end // end of [else]
      // end of [if]
    end // end of [else]
  // end of [if]
end // end of [then]
else false (*~stopped*)
//
end // end of [loop]
//
val stopped = loop (A, cap, p_kx)
val _(*true*) =
(
  if not(stopped) then loop (A, cap, p0) else true
) : bool // end of [val]
//
in
  // nothing
end // end of [keyitmarr_reinserts]

(* ****** ****** *)

datavtype hashtbl
(
  key:t@ype, itm:vt@ype+
) =
  {m:int | m >= 1}
  HASHTBL of (
    arrayptr ((key, itm), m), size_t m, size_t(*ntot*)
  ) (* end of [HASHTBL] *)
// end of [hashtbl]

(* ****** ****** *)

assume
hashtbl_vtype (key:t0p, itm:vt0p) = hashtbl (key, itm)

(* ****** ****** *)

implement
{key,itm}
hashtbl_make_nil
  (cap) = let
//
vtypedef ki = @(key, itm)
//
prval
[m:int]
EQINT () = eqint_make_guint (cap)
//
val A0 =
arrayptr_make_uninitized<ki> (cap)
val p_A0 = ptrcast(A0)
val _(*ptr*) =
$STRING.memset_unsafe (p_A0, 0, cap*sizeof<ki>)
val A0 = $UN.castvwtp0{arrayptr(ki,m)}(A0)
//
in
  HASHTBL (A0, cap, i2sz(0))
end // end of [hashtbl_make_nil]

(* ****** ****** *)
  
implement{
} hashtbl_get_size
  (tbl) = let
//
val+HASHTBL(A, cap, ntot) = tbl in ntot
//
end // end of [hashtbl_get_size]

(* ****** ****** *)

implement{
} hashtbl_get_capacity
  (tbl) = let
//
val+HASHTBL (A, cap, ntot) = tbl in (cap)
//
end // end of [hashtbl_get_capacity]
  
(* ****** ****** *)

implement
{key,itm}
hashtbl_search_ref
  (tbl, k0) = let
//
val+HASHTBL{..}{m}(A, cap, ntot) = tbl
//
val hk = hash_key<key> (k0)
val ofs = g0uint_mod (hk, $UN.cast{ulint}(cap))
val ofs = $UN.cast{sizeLt(m)}(ofs)
//
val p_A = ptrcast(A)
prval pf_A = arrayptr_takeout(A)
var ans: bool // uninitalized
val p_kx = keyitmarr_linprb2<key,itm> (!p_A, cap, ofs, k0, ans)
prval ((*void*)) = arrayptr_addback (pf_A | A)
//
in
//
if ans then let
  vtypedef ki = @(key, itm)
  val (pf, fpf | p_kx) = $UN.ptr0_vtake{ki}(p_kx)
  val p_itm = addr@(p_kx->1)
  prval ((*void*)) = fpf (pf)
in
  $UN.cast{cPtr1(itm)}(p_itm)
end else cptr_null{itm}((*void*))
//
end // end of [hashtbl_search_ref]

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert
  (tbl, k, x, res) = let
//
vtypedef ki = @(key, itm)
//
val+@HASHTBL{..}{m}(A, cap, ntot) = tbl
//
val hk = hash_key<key> (k)
val ofs = g0uint_mod (hk, $UN.cast{ulint}(cap))
val ofs = $UN.cast{sizeLt(m)}(ofs)
//
val p_A = ptrcast(A)
prval pf_A = arrayptr_takeout(A)
var ans: bool // uninitalized
val p_kx = keyitmarr_linprb2<key,itm> (!p_A, cap, ofs, k, ans)
prval ((*void*)) = arrayptr_addback (pf_A | A)
//
in
//
if ans
then let
  val (pf, fpf | p_kx) = $UN.ptr0_vtake{ki}(p_kx)
  val x2 = p_kx->1
  val () = p_kx->1 := x
  prval ((*void*)) = fpf (pf)
  val () = res := x2
  prval () = opt_some{itm}(res)
  prval () = fold@ (tbl)
in
  true
end // end of [then]
else let
//
// HX-2013-05: [k] is not found
//
in
  if p_kx > 0 then let
    val (pf, fpf | p_kx) = $UN.ptr0_vtake{ki?}(p_kx)
    val () = p_kx->0 := k
    val () = p_kx->1 := x
    val () = ntot := succ(ntot)
    prval () = $UN.castview0((pf, fpf))
    prval () = opt_none{itm}(res)
    prval () = fold@ (tbl)
    val () =
    if hashtbl$recapacitize() > 0
      then ignoret(hashtbl_adjust_capacity<key,itm> (tbl))
    // end of [if] // end of [val]
  in
    false
  end else let
    val () = res := x
    prval () = opt_some{itm}(res)
    prval () = fold@ (tbl)
  in
    true
  end // end of [if]
end // end of [else]
//
end // end of [hashtbl_insert]

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout
  (tbl, k, res) = let
//
val+@HASHTBL{..}{m}(A, cap, ntot) = tbl
//
val hk = hash_key<key> (k)
val ofs = g0uint_mod (hk, $UN.cast{ulint}(cap))
val ofs = $UN.cast{sizeLt(m)}(ofs)
//
val p_A = ptrcast(A)
prval pf_A = arrayptr_takeout(A)
var ans: bool // uninitalized
val p_kx = keyitmarr_linprb2<key,itm> (!p_A, cap, ofs, k, ans)
prval ((*void*)) = arrayptr_addback (pf_A | A)
//
in
//
if ans
then let
  vtypedef ki = @(key, itm)
  val (pf, fpf | p_kx) = $UN.ptr0_vtake{ki}(p_kx)
  val () = res := p_kx->1
  val () = hashtbl_linprb_keyitm_nullize<key,itm> (!p_kx)
  val () = ntot := pred (ntot)
  prval () = $UN.castview0 ((pf, fpf))
  prval pf_A = arrayptr_takeout(A)
  val () = keyitmarr_reinserts<key,itm> (!p_A, cap, ptr_succ<ki> (p_kx))
  prval ((*void*)) = arrayptr_addback (pf_A | A)
  prval () = fold@ (tbl)
  prval () = opt_some{itm}(res)
in
  true
end // end of [then]
else let
  prval () = fold@ (tbl)
  prval () = opt_none{itm}(res)
in
  false
end // end of [else]
//
end // end of [hashtbl_takeout]

(* ****** ****** *)

implement
{key,itm}
hashtbl_reset_capacity
  (tbl, cap2) = let
//
val+@HASHTBL{..}{m}(A, cap, ntot) = tbl
//
in
//
if
ntot <= cap2
then let
//
val p0 = ptrcast(A)
vtypedef ki = @(key, itm)
val p_end = ptr_add<ki> (p0, cap)
//
fun
loop{m2:int}
(
  p_A2: ptr, cap2: size_t(m2), p: ptr
) : void = let
in
//
if
p < p_end
then let
  val (pf, fpf | p) =
    $UN.ptr0_vtake{ki}(p)
  val isnul =
    hashtbl_linprb_keyitm_is_null<key,itm> (!p)
in
  if isnul
    then let
      prval ((*void*)) = fpf (pf)
    in
      loop (p_A2, cap2, ptr_succ<ki> (p))
    end // end of [then]
    else let
      val k = p->0
      val hk = hash_key<key> (k)
      var ans: bool // uninitalized
      val ofs = g0uint_mod (hk, $UN.cast{ulint}(cap2))
      val ofs = $UN.cast{sizeLt(m2)}(ofs)
      val (pf_A2, fpf_A2 | p_A2) = $UN.ptr0_vtake{array(ki,m2)}(p_A2)
      val p_kx = keyitmarr_linprb2<key,itm> (!p_A2, cap2, ofs, k, ans)
      prval ((*void*)) = fpf_A2 (pf_A2)
      val (pf_kx, fpf_kx | p_kx) = $UN.ptr0_vtake{ki?}(p_kx)
      val () = p_kx->0 := k
      val () = p_kx->1 := p->1
      prval () = $UN.castview0((pf, fpf))
      prval () = $UN.castview0((pf_kx, fpf_kx))
    in
      loop (p_A2, cap2, ptr_succ<ki> (p))
    end // end of [else]
end // end of [then]
else () // end of [else]
//
end // end of [loop]
//
prval
[m2:int]
EQINT () = eqint_make_guint (cap2)
//
val A2 =
arrayptr_make_uninitized<ki> (cap2)
val p_A2 = ptrcast(A2)
val _(*ptr*) =
$STRING.memset_unsafe (p_A2, 0, cap2*sizeof<ki>)
val ((*void*)) = loop (p_A2, cap2, p0)
val A2 = $UN.castvwtp0{arrayptr(ki,m2)}(A2)
//
val () =
arrayptr_free ($UN.castvwtp0{arrayptr(ki?,m)}(A))
//
val () = A := A2
val () = cap := cap2
prval () = fold@ (tbl)
//
in
  true
end // end of [then]
else let
  prval () = fold@ (tbl)
in
  false
end // end of [else]
//
end // end of [hashtbl_reset_capacity]

(* ****** ****** *)
//
// HX: please reimplement it if needed
//
implement
{key,itm}
hashtbl_adjust_capacity
  (tbl) = let
//
val+HASHTBL (A, cap, ntot) = tbl
//
in
//
if ntot + ntot >= cap
  then hashtbl_reset_capacity (tbl, cap + cap) else false
//
end // end of [hashtbl_adjust_capacity]

(* ****** ****** *)

implement
{key,itm}{env}
hashtbl_foreach_env
  (tbl, env) = let
//
val+HASHTBL (A, cap, _) = tbl
//
val p0 = ptrcast(A)
vtypedef ki = @(key, itm)
val p_end = ptr_add<ki> (p0, cap)
//
fun
loop
(
  p: ptr, env: &env >> _
) : void = let
in
//
if
p < p_end
then let
  val (pf, fpf | p) =
    $UN.ptr0_vtake{ki}(p)
  val isnul =
    hashtbl_linprb_keyitm_is_null<key,itm> (!p)
in
  if isnul
    then let
      prval () = fpf (pf)
    in
      loop (ptr_succ<ki> (p), env)
    end // end of [then]
    else let
      val () =
        hashtbl_foreach$fwork<key,itm><env> (p->0, p->1, env)
      prval () = fpf (pf)
    in
      loop (ptr_succ<ki> (p), env)
    end // end of [else]
  // end of [if]
end // end of [then]
else ((*exit*)) // end of [else]
//
end // end of [loop]
//
in
  loop (p0, env)
end // end of [hashtbl_foreach_env]

(* ****** ****** *)

implement
{key,itm}
hashtbl_free (tbl) = let
//
typedef ki = @(key, itm)
//
val+~HASHTBL (A, cap, ntot) = tbl in arrayptr_free{ki}(A)
//
end // end of [hashtbl_free]

(* ****** ****** *)

implement
{key,itm}{ki2}
hashtbl_flistize
  (tbl) = let
//
val+~HASHTBL (A, cap, _) = tbl
//
val p0 = ptrcast(A)
vtypedef ki = @(key, itm)
val p_end = ptr_add<ki> (p0, cap)
//
fun
loop
(
  p: ptr
, res: List0_vt(ki2)
) : List0_vt(ki2) = let
in
//
if
p > p0
then let
  val p = ptr_pred<ki> (p)
  val (pf, fpf | p) = $UN.ptr0_vtake{ki}(p)
  val isnul = hashtbl_linprb_keyitm_is_null<key,itm> (!p)
in
  if isnul
    then let
      prval ((*void*)) = fpf (pf)
    in
      loop (p, res)
    end // end of [then]
    else let
      val kx2 =
        hashtbl_flistize$fopr<key,itm><ki2> (p->0, p->1)
      val res = list_vt_cons{ki2}(kx2, res)
      val ((*void*)) = hashtbl_linprb_keyitm_nullize<key,itm> (!p)
      prval ((*void*)) = $UN.castview0 ((pf, fpf))
    in
      loop (p, res)
    end // end of [else]
  // end of [if]
end // end of [then]
else res // end of [else]
//
end // end of [loop]
//
val res = $effmask_all(loop (p_end, list_vt_nil(*void*)))
//
val ((*freed*)) = arrayptr_free($UN.castvwtp0{arrayptr(ki?,0)}(A))
//
in
  res
end // end of [hashtbl_flistize]

(* ****** ****** *)

(* end of [hashtbl_linprb.dats] *)

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
(* Start time: December, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/qlist.sats"

(* ****** ****** *)

implement{}
qlist_make_nil (
) = pq where {
  val (
    pf, pfgc | p
  ) = ptr_alloc<qstruct> ()
  val pq = ptr2ptrlin (p)
  val () = qstruct_initize (!p)
  prval pfngc = qstruct_objfize (pf | pq)
  prval () = free_gcngc_v_nullify (pfgc, pfngc)
} // end of [qlist_make]

implement{}
qlist_free_nil
  {a} (pq) = () where {
  val () =
    __mfree (pq) where {
    extern fun __mfree
      : qlist (a, 0) -<0,!wrt> void = "mac#atspre_mfree_gc"
  } // end of [where] // end of [val]
} (* end of [qlist_free_nil] *)

(* ****** ****** *)

implement{a}
qlist_insert
  (q, x) = let
//
val nx = mynode_make_elt<a> (x)
//
in
  qlist_insert_ngc<a> (q, nx)
end // end of [qlist_insert]

implement{a}
qstruct_insert
  (q, x) = let
//
val pq = addr@(q)
val q2 = ptr2ptrlin (pq)
prval pfngc =
  qstruct_objfize (view@(q) | q2)
val () = qlist_insert<a> (q2, x)
prval pfat = qstruct_unobjfize (pfngc | pq, q2)
prval () = view@(q) := pfat
prval () = ptrlin_free (q2)
//
in
  // nothing
end // end of [qstruct_insert]

(* ****** ****** *)

implement{a}
qlist_takeout
  (q) = res where {
  val nx0 = qlist_takeout_ngc<a> (q)
  val res = mynode_getfree_elt (nx0)
} // end of [qlist_takeout]

implement{a}
qstruct_takeout
  (q) = res where {
//
val pq = addr@(q)
val q2 = ptr2ptrlin (pq)
prval pfngc =
  qstruct_objfize (view@(q) | q2)
val res = qlist_takeout<a> (q2)
prval pfat = qstruct_unobjfize (pfngc | pq, q2)
prval () = view@(q) := pfat
prval () = ptrlin_free (q2)
//
} // end of [qstruct_takeout]

(* ****** ****** *)

stadef mykind = $extkind"atslib_qlist"

(* ****** ****** *)

datavtype
qlist_data (a:vt@ype+) = QLIST of (ptr, ptr)

(* ****** ****** *)

assume
qlist_vtype (a:vt0p, n:int) = qlist_data (a)

(* ****** ****** *)

implement{a}
qlist_is_nil
  {n} (q) = let
//
val+@QLIST (nxf, p_nxr) = q
val isnil = (addr@ (nxf) = p_nxr)
prval () = fold@ (q)
//
in
  $UN.cast{bool(n==0)}(isnil)
end // end of [qlist_is_nil]

implement{a}
qlist_isnot_nil
  {n} (q) = let
//
val+@QLIST (nxf, p_nxr) = q
val isnot = (addr@ (nxf) != p_nxr)
prval () = fold@ (q)
//
in
  $UN.cast{bool(n > 0)}(isnot)
end // end of [qlist_isnot_nil]

(* ****** ****** *)

implement{a}
qlist_length
  {n} (q) = let
//
fun loop (
  p_nxf: ptr, p_nxr: ptr, len: int
) : int = let
in
//
if p_nxf != p_nxr then let
  val xs =
    $UN.ptr0_get<List1_vt(a)> (p_nxf)
  // end of [val]
  val+@list_vt_cons (_, xs2) = xs
  val p2_nxf = addr@ (xs2)
  prval ((*prf*)) = fold@ (xs)
  prval ((*prf*)) = $UN.cast2void (xs)
in
  loop (p2_nxf, p_nxr, succ (len))
end else (len) // end of [if]
//
end // end of [loop]
//
val+@QLIST (nxf, p_nxr) = q
val res = $effmask_all (loop (addr@ (nxf), p_nxr, 0))
prval () = fold@ (q)
//
in
  $UN.cast{int(n)}(res)
end // end of [qlist_length]

(* ****** ****** *)

implement{
} qstruct_initize {a} (q) = let
//
val q2 =
  $UN.castvwtp0{qlist(a,0)}(addr@ (q))
// end of [val]
val+@QLIST (nxf, p_nxr) = q2
val () = (p_nxr := addr@ (nxf))
prval () = fold@ (q2)
prval () = __assert (q, q2) where {
  extern praxi __assert (q: &qstruct? >> qstruct (a, 0), q2: qlist (a, 0)): void
} // end of [where] // end of [prval]
//
in
  (* DoNothing *)
end // end of [qstruct_initize]

(* ****** ****** *)

extern
castfn
mynode1_encode
  {a:vt0p} (xs: List1_vt (INV(a))):<> mynode1 (a)
// end of [mynode1_encode]
extern
castfn
mynode1_decode
  {a:vt0p} (nx: mynode1 (INV(a))):<> List1_vt (a)
// end of [mynode1_decode]

(* ****** ****** *)

implement{a}
mynode_make_elt (x) =
  $UN.castvwtp0{mynode1(a)}(list_vt_cons{a}{0}(x, _))
// end of [mynode_make_elt]

implement{a}
mynode_free_elt
  (nx, res) = () where {
//
val xs = mynode1_decode (nx)
val+~list_vt_cons (x, xs2) = xs
val () = res := x
prval () = __assert (xs2) where {
  extern praxi __assert : {vt:vtype} (vt) -<prf> void
} // end of [where] // end of [prval]
//
} // end of [mynode_free_elt]

implement{a}
mynode_getfree_elt
  (nx) = (x) where {
//
val xs = mynode1_decode (nx)
val+~list_vt_cons (x, xs2) = xs
prval () = __assert (xs2) where {
  extern praxi __assert : {vt:vtype} (vt) -<prf> void
} // end of [where] // end of [prval]
//
} // end of [mynode_getfree_elt]

(* ****** ****** *)

implement{a}
qlist_insert_ngc
  (q, nx0) = let
//
val+@QLIST (nxf, p_nxr) = q
//
val xs = mynode1_decode (nx0)
val+@list_vt_cons (_, xs2) = xs
val p2_nxr = addr@ (xs2)
prval ((*prf*)) = fold@ (xs)
val nx0 = mynode1_encode (xs)
//
val () = $UN.ptr0_set<mynode1(a)> (p_nxr, nx0)
val () = p_nxr := p2_nxr
//
prval ((*prf*)) = fold@ (q)
//  
in
  // nothing
end // end of [qlist_insert_ngc]

(* ****** ****** *)

implement{a}
qlist_takeout_ngc
  (q) = nx0 where {
//
val+@QLIST (nxf, p_nxr) = q
val nx0 = $UN.castvwtp0{mynode1(a)}(nxf)
//
val xs = mynode1_decode (nx0)
val+@list_vt_cons (_, xs2) = xs
val p2_nxr = addr@ (xs2)
prval ((*prf*)) = fold@ (xs)
val nx0 = mynode1_encode (xs)
//
val () = (
  if (p_nxr != p2_nxr)
    then nxf := $UN.ptr0_get<ptr> (p2_nxr)
    else p_nxr := addr@ (nxf)
  // end of [if]
) : void // end of [val]
//
prval ((*prf*)) = fold@ (q)
//
} // end of [qlist_takeout_ngc]

(* ****** ****** *)

implement{a}
qlist_takeout_list
  {n} (q) = let
//
val+@QLIST (nxf, p_nxr) = q
val () = $UN.ptr0_set<ptr> (p_nxr, the_null_ptr)
val nx0 = nxf
val () = p_nxr := addr@ (nxf)
prval () = fold@ (q)
//
in
  $UN.castvwtp0{list_vt(a,n)} (nx0)
end // end of [qlist_takeout_list]

(* ****** ****** *)

(* end of [qlist.dats] *)

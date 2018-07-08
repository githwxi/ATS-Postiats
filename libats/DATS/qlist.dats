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
(* Start time: December, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/qlist.sats"

(* ****** ****** *)

implement
{}(*tmp*)
qlist_make_nil
  () = pq where {
//
  val (
    pf, pfgc | p
  ) = ptr_alloc<qstruct> ()
//
  val pq = ptr2ptrlin (p)
  val () = qstruct_initize (!p)
//
  prval pfngc = qstruct_objfize (pf | pq)
  prval ((*freed*)) = mfree_gcngc_v_nullify (pfgc, pfngc)
//
} (* end of [qlist_make] *)

implement
{}(*tmp*)
qlist_free_nil
  {a}(pq) = () where
{
//
val () = __mfree(pq) where
{
  extern fun __mfree
    : qlist (a, 0) -<0,!wrt> void = "mac#atspre_mfree_gc"
} // end of [where] // end of [val]
//
} (* end of [qlist_free_nil] *)

(* ****** ****** *)

implement
{a}(*tmp*)
qlist_insert
  (pq, x) = let
//
val nx =
mynode_make_elt<a>(x) in qlist_insert_ngc<a>(pq, nx)
//
end // end of [qlist_insert]

implement
{a}(*tmp*)
qstruct_insert
  (que, x) = let
//
val pq = addr@(que)
val pq2 = ptr2ptrlin(pq)
//
prval
pfngc =
qstruct_objfize(view@(que)|pq2)
//
val () = qlist_insert<a>(pq2, x)
//
prval pfat = qstruct_unobjfize(pfngc | pq, pq2)
//
prval () =
  (view@(que) := pfat)
//
prval () = ptrlin_free(pq2)
//
in
  // nothing
end // end of [qstruct_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
qlist_takeout(pq) = let
//
val nx0 =
qlist_takeout_ngc(pq) in mynode_getfree_elt<a>(nx0)
//
end // end of [qlist_takeout]

implement
{a}(*tmp*)
qlist_takeout_opt(pq) =
(
if qlist_isnot_nil(pq)
  then Some_vt{a}(qlist_takeout(pq)) else None_vt{a}()
// end of [if]
) // end of [qlist_takeout_opt]

(* ****** ****** *)

implement
{a}(*tmp*)
qstruct_takeout
  (que) = res where
{
//
val pq = addr@(que)
val pq2 = ptr2ptrlin(pq)
//
prval
pfngc =
qstruct_objfize(view@(que)|pq2)
//
val res = qlist_takeout<a>(pq2)
//
prval pfat = qstruct_unobjfize(pfngc | pq, pq2)
//
prval () =
  (view@(que) := pfat)
//
prval () = ptrlin_free(pq2)
//
} // end of [qstruct_takeout]

(* ****** ****** *)

stadef mykind = $extkind"atslib_qlist"

(* ****** ****** *)

datavtype
qlist_data(a:vt@ype+) = QLIST of (ptr, ptr)

(* ****** ****** *)

assume
qlist_vtype(a: vt0p, n: int) = qlist_data(a)

(* ****** ****** *)

implement
{a}(*tmp*)
qlist_is_nil
  {n} (pq) = let
//
val+@QLIST (nxf, p_nxr) = pq
val isnil = (addr@(nxf) = p_nxr)
prval () = fold@ (pq)
//
in
  $UN.cast{bool(n==0)}(isnil)
end // end of [qlist_is_nil]

implement
{a}(*tmp*)
qlist_isnot_nil
  {n} (pq) = let
//
val+@QLIST (nxf, p_nxr) = pq
val isnot = (addr@(nxf) != p_nxr)
prval ((*prf*)) = fold@ (pq)
//
in
  $UN.cast{bool(n > 0)}(isnot)
end // end of [qlist_isnot_nil]

(* ****** ****** *)

implement
{a}(*tmp*)
qlist_length
  {n} (pq) = let
//
implement
{a}{ env }
qlist_foreach$cont(x, env) = true
implement
qlist_foreach$fwork<a><int>(x, env) = env := env+1
//
var env: int = (0)
//
val () =
  $effmask_all(qlist_foreach_env<a><int>(pq, env))
//
in
  $UN.cast{int(n)}(env)
end // end of [qlist_length]

(* ****** ****** *)

implement
{}(*tmp*)
fprint_qlist$sep
  (out) = fprint_string (out, "->")
//
implement
{a}(*tmp*)
fprint_qlist
  (out, pq) = let
//
implement
{a}{ env }
qlist_foreach$cont
  (x, env) = true
//
implement
qlist_foreach$fwork<a><int>
  (x0, env) = let
  val () =
  if env > 0
    then fprint_qlist$sep<>(out)
  // end of [if]
  val () = (env := env + 1)
  val () = fprint_ref<a>(out, x0)
in
  // nothing
end // end of [qlist_foreach$fwork]
//
var env: int = 0
//
in
  qlist_foreach_env<a><int>(pq, env)
end // end of [fprint_qlist]

(* ****** ****** *)

implement
{a}(*tmp*)
fprint_qlist_sep
  (out, pq, sep) = let
//
implement
{}(* tmp *)
fprint_qlist$sep (out) = fprint_string (out, sep)
//
in
  fprint_qlist<a> (out, pq)
end // end of [fprint_qlist_sep]

(* ****** ****** *)

implement
{a}{ env }
qlist_foreach$cont(_x_, env) = true

implement
{a}(*tmp*)
qlist_foreach(pq) = let
//
var
env: void = () in qlist_foreach_env<a><void>(pq, env)
//
end // end of [qlist_foreach]

implement
{a}{ env }
qlist_foreach_env
  (pq, env) = let
//
fun loop
(
  p_nxf: ptr, p_nxr: ptr, env: &env
) : void = let
in
//
if p_nxf != p_nxr then let
//
val xs =
  $UN.ptr0_get<List1_vt(a)>(p_nxf)
// end of [val]
val+@list_vt_cons(x1, xs2) = xs
//
val test =
  qlist_foreach$cont<a><env>(x1, env)
//
val () =
(
//
if
test
then let
//
val () =
qlist_foreach$fwork<a><env>(x1, env)
//
in
  loop(addr@(xs2), p_nxr, env)
end // end of [then] // end of [if]
//
) : void // end of [val]
//
prval ((*proof*)) = fold@ (xs)
prval ((*proof*)) = $UN.cast2void(xs)
//
in
  // nothing
end else () // end of [if]
//
end // end of [loop]
//
val+@QLIST(nxf, p_nxr) = pq
//
val () = loop(addr@(nxf), p_nxr, env)
//
prval ((*folded*)) = fold@(pq)
//
in
  // nothing
end // end of [qlist_foreach_env]

(* ****** ****** *)

implement
{}(* tmp *)
qstruct_initize
  {a}(que) = let
//
val pq =
$UN.castvwtp0
  {qlist(a,0)}(addr@(que))
// end of [val]
//
val+@QLIST(nxf, p_nxr) = pq
val () = (p_nxr := addr@ (nxf))
//
prval () = fold@(pq)
//
prval () =
__assert(que, pq) where
{
  extern praxi
    __assert (que: &qstruct? >> qstruct(a, 0), pq: qlist(a, 0)): void
  // end of [extern]
} // end of [where] // end of [prval]
//
in
  (* DoNothing *)
end // end of [qstruct_initize]

(* ****** ****** *)

extern
castfn
mynode1_encode
  {a:vt0p}
  (xs: List1_vt(INV(a))):<> mynode1(a)
// end of [mynode1_encode]
extern
castfn
mynode1_decode
  {a:vt0p}
  (nx: mynode1(INV(a))):<> List1_vt(a)
// end of [mynode1_decode]

(* ****** ****** *)

implement
{}(*tmp*)
mynode_null{a}() =
  $UN.castvwtp0{mynode(a,null)}(list_vt_nil)
// end of [mynode_null]

(* ****** ****** *)

implement
{a}(*tmp*)
mynode_make_elt (x) =
  $UN.castvwtp0{mynode1(a)}(list_vt_cons{a}{0}(x, _))
// end of [mynode_make_elt]

implement
{a}(*tmp*)
mynode_free_elt
  (nx, res) = () where
{
//
val xs =
  mynode1_decode(nx)
//
val+~list_vt_cons(x1, xs2) = xs
//
val () = (res := x1)
//
prval () =
__assert (xs2) where {
  extern praxi __assert : {vt:vtype} (vt) -<prf> void
} // end of [where] // end of [prval]
//
} (* end of [mynode_free_elt] *)

(* ****** ****** *)

implement
{a}(*tmp*)
mynode_getfree_elt
  (nx) = (x1) where
{
//
val xs =
  mynode1_decode(nx)
//
val+~list_vt_cons(x1, xs2) = xs
//
prval () =
__assert(xs2) where {
  extern praxi __assert : {vt:vtype} (vt) -<prf> void
} // end of [where] // end of [prval]
//
} (* end of [mynode_getfree_elt] *)

(* ****** ****** *)

implement
{a}(*tmp*)
qlist_insert_ngc
  (pq, nx0) = let
//
val+@QLIST(nxf, p_nxr) = pq
//
val xs = mynode1_decode(nx0)
val+@list_vt_cons(_, xs2) = xs
//
val p2_nxr = addr@(xs2)
prval ((*folded*)) = fold@(xs)
//
val nx0 = mynode1_encode(xs)
//
val () = $UN.ptr0_set<mynode1(a)>(p_nxr, nx0)
//
val () = (p_nxr := p2_nxr)
//
prval ((*folded*)) = fold@ (pq)
//  
in
  // nothing
end // end of [qlist_insert_ngc]

(* ****** ****** *)

implement
{a}(*tmp*)
qlist_takeout_ngc
  (q0) = nx0 where
{
//
val+@QLIST(nxf, p_nxr) = q0
//
val nx0 =
$UN.castvwtp0{mynode1(a)}(nxf)
//
val xs = mynode1_decode(nx0)
val+@list_vt_cons (_, xs2) = xs
//
val p2_nxr = addr@(xs2)
prval ((*folded*)) = fold@(xs)
//
val nx0 = mynode1_encode(xs)
//
val () =
(
//
if
(p_nxr != p2_nxr)
then
(
nxf := $UN.ptr0_get<ptr>(p2_nxr)
) (* end of [then] *)
else p_nxr := addr@(nxf)
//
) : void // end of [val]
//
prval ((*folded*)) = fold@ (q0)
//
} // end of [qlist_takeout_ngc]

(* ****** ****** *)

implement
{}(* tmp *)
qlist_takeout_list
  {a}{n}(pq) = xs where
{
//
val+@QLIST(nxf, p_nxr) = pq
//
val () =
$UN.ptr0_set<ptr>(p_nxr, the_null_ptr)
//
val xs = $UN.castvwtp0{list_vt(a,n)}(nxf)
//
val () = p_nxr := addr@(nxf)
//
prval ((*folded*)) = fold@(pq)
//
} // end of [qlist_takeout_list]

implement
{}(* tmp *)
qstruct_takeout_list
  {a}{n}(que) = xs where
{
//
val pq = addr@(que)
val pq2 = ptr2ptrlin (pq)
//
prval
pfngc =
qstruct_objfize(view@(que)|pq2)
//
val xs = qlist_takeout_list(pq2)
prval pfat = qstruct_unobjfize(pfngc | pq, pq2)
//
prval () =
  (view@(que) := pfat)
//
prval () = ptrlin_free (pq2)
//
} (* end of [qstruct_takeout_list] *)

(* ****** ****** *)

(* end of [qlist.dats] *)

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
(* Start time: July, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"

(* ****** ****** *)

implement{a}
gvector_getref_at
  (V, d, i) = let
  val p = $UN.cast2Ptr1(ptr_add<a> (addr@(V), i*d))
in
  $UN.ptr2cptr{a}(p)
end // end of [gvector_getref_at]

(* ****** ****** *)

implement{}
fprint_gvector$sep
  (out) = fprint_string (out, ", ")
// end of [fprint_gvector$sep]

(* ****** ****** *)

implement{a}
fprint_gvector
  (out, V, n, d) = let
//
typedef tenv = int
implement
gvector_foreach$fwork<a><tenv>
  (x, env) = let
  val i = env
  val () = if i > 0 then fprint_gvector$sep<> (out)
  val () = env := i + 1
in
  fprint_ref<a> (out, x)
end // end of [gvector_foreach$fwork]
//
var env: tenv = 0
val _(*n*) = gvector_foreach_env<a><tenv> (V, n, d, env)
//
in
  // nothing
end // end of [fprint_gvector]

(* ****** ****** *)

implement
{a}(*tmp*)
gvector_copyto
  {n}{d1,d2}
  (V1, V2, n, d1, d2) = let
//
prval (
) = __initize (V2) where
{
extern praxi
__initize (&GVT(a?, n, d2) >> GVT(a, n, d2)): void
} (* end of [where] *) // end of [prval]
//
implement
{a1,a2}{env}
gvector_foreach2$cont (x, y, env) = true
implement(env)
gvector_foreach2$fwork<a,a><env> (x, y, env) = y := x
//
val _(*n*) = gvector_foreach2<a,a> (V1, V2, n, d1, d2)
//
in
  // nothing
end // end of [gvector_copyto]

(* ****** ****** *)

implement{a}
gvector_exchange
  (V1, V2, n, d1, d2) = let
//
implement
{a1,a2}{env}
gvector_foreach2$cont (x, y, env) = true
//
implement(env)
gvector_foreach2$fwork<a,a><env>
  (x, y, env) = let val t = x in x := y; y := t end
//
val _(*n*) = gvector_foreach2<a,a> (V1, V2, n, d1, d2)
//
in
  // nothing
end // end of [gvector_exchange]

(* ****** ****** *)

implement{a}{env}
gvector_foreach$cont (x, env) = true

(*
implement{a}{env}
gvector_foreach$fwork (x, env) = ((*void*))
*)

implement{a}
gvector_foreach
  (V, n, d) = let
  var env: void = () in
  gvector_foreach_env<a><void> (V, n, d, env)
end // end of [gvector_foreach]

implement
{a}{env}
gvector_foreach_env
  {n}{d}(V, n, d, env) = let
//
fun loop
  {i:nat | i <= n}
(
  p: ptr, i: int i, env: &env >> _
) : natLte(n) = let
in
//
if i > 0 then let
  val p = g1ofg0(p)
  val (pf, fpf | p) = $UN.ptr_vtake{a}(p)
  val cont = gvector_foreach$cont<a><env> (!p, env)
  prval () = fpf (pf)
in
  if cont then let
    val (pf, fpf | p) = $UN.ptr_vtake{a}(p)
    val () = gvector_foreach$fwork<a><env> (!p, env)
    prval () = fpf (pf)
  in
    loop (ptr_add<a> (p, d), pred(i), env)
  end else i // end of [if]
end else (0) // end of [if]
//
end // end of [loop]
//
prval (
) = lemma_gvector_param (V)
val i = loop (addr@(V), n, env)
//
in
  (n - i)
end // end of [gvector_foreach_env]

(* ****** ****** *)

implement{a,b}{env}
gvector_foreach2$cont (x, y, env) = true

implement{a,b}
gvector_foreach2
(
  V1, V2, n, d1, d2
) = let
  var env: void = () in
  gvector_foreach2_env<a,b><void> (V1, V2, n, d1, d2, env)
end // end of [gvector_foreach2]

implement
{a,b}{env}
gvector_foreach2_env
  {n}{d1,d2}(V1, V2, n, d1, d2, env) = let
//
fun loop
  {i:nat | i <= n}
(
  p1: ptr, p2: ptr, i: int i, env: &env >> _
) : natLte(n) = let
in
//
if i > 0 then let
  val p1 = g1ofg0(p1)
  val p2 = g1ofg0(p2)
  val (pf1, fpf1 | p1) = $UN.ptr_vtake{a}(p1)
  val (pf2, fpf2 | p2) = $UN.ptr_vtake{b}(p2)
  val cont = gvector_foreach2$cont<a,b><env> (!p1, !p2, env)
  prval () = fpf1 (pf1) and () = fpf2 (pf2)
in
  if cont then let
    val (pf1, fpf1 | p1) = $UN.ptr_vtake{a}(p1)
    val (pf2, fpf2 | p2) = $UN.ptr_vtake{b}(p2)
    val () = gvector_foreach2$fwork<a,b><env> (!p1, !p2, env)
    prval () = fpf1 (pf1) and () = fpf2 (pf2)
  in
    loop (ptr_add<a> (p1, d1), ptr_add<b> (p2, d2), pred(i), env)
  end else i // end of [if]
end else (0) // end of [if]
//
end // end of [loop]
//
prval (
) = lemma_gvector_param (V1)
val i = loop (addr@(V1), addr@(V2), n, env)
//
in
  (n - i)
end // end of [gvector_foreach2_env]

(* ****** ****** *)

(* end of [gvector.dats] *)

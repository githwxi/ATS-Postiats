(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2014-05:
// This is based on spinlock
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/athread.sats"

(* ****** ****** *)

staload "./../SATS/spinvar.sats"

(* ****** ****** *)
//
datavtype
spinvar_vt(a:vt0p) =
{l:agz} SPINVAR of (spin(l), a)
//
(* ****** ****** *)

(*
assume spinvar_vtype (a:vt0p) = spinvar_vt(a)
*)

(* ****** ****** *)

implement
{a}(*tmp*)
spinvar_create_exn (x) = let
//
val spn = spin_create_exn ()
//
in
  $UN.castvwtp0{spinvar(a)}(SPINVAR{a}(spn, x))
end // end of [spinvar_create_exn]

(* ****** ****** *)

implement
{}(*tmp*)
spinvar_destroy
  {a}(spnv) = let
//
val+~SPINVAR (spn, _) =
  $UN.castvwtp0{spinvar_vt(a)}(spnv)
//
in
  spin_vt_destroy(unsafe_spin_t2vt(spn))
end // end of [spinvar_destroy]

(* ****** ****** *)

implement
{a}(*tmp*)
spinvar_get
  (spnv) = x_ where
{
//
val spnv =
$UN.castvwtp1{spinvar_vt(a)}(spnv)
//
val+@SPINVAR(spn, x) = spnv
//
val (pf | ()) = spin_lock (spn)
val x_ = x
val ((*void*)) = spin_unlock (pf | spn)
//
prval () = fold@ (spnv)
prval () = $UN.castview0{void}(spnv)
//
} (* end of [spinvar_get] *)

(* ****** ****** *)

implement
{a}(*tmp*)
spinvar_getfree
  (spnv) = x where
{
//
val+~SPINVAR (spn, x) =
  $UN.castvwtp0{spinvar_vt(a)}(spnv)
val () = spin_vt_destroy(unsafe_spin_t2vt(spn))
//
} (* end of [spinvar_getfree] *)

(* ****** ****** *)

implement
{a}(*tmp*)
spinvar_process
  (spnv) = let
//
var env: void = ()
//
in
  spinvar_process_env<a><void> (spnv, env)
end // end of [spinvar_process]

(* ****** ****** *)

implement
{a}{env}
spinvar_process_env
  (spnv, env) = () where
{
//
val spnv =
$UN.castvwtp1{spinvar_vt(a)}(spnv)
//
val+@SPINVAR(spn, x) = spnv
//
val (pf | ()) = spin_lock (spn)
val () = spinvar_process$fwork (x, env)
val ((*void*)) = spin_unlock (pf | spn)
//
prval () = fold@ (spnv)
prval () = $UN.castview0{void}(spnv)
//
} (* end of [spinvar_process_env] *)

(* ****** ****** *)

(* end of [spinvar.dats] *)

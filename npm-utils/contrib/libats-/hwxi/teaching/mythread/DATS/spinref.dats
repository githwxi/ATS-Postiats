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
staload "./../SATS/spinref.sats"

(* ****** ****** *)

implement{a}
spinref_create_exn (x) = let
//
val spnv = spinvar_create_exn (x)
//
in
  $UN.castvwtp0{spinref(a)}(spnv)
end // end of [spinref_create_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
spinref_get
  (spnr) = x where
{
//
val spnv =
$UN.castvwtp0{spinvar(a)}(spnr)
val x = spinvar_get<a> (spnv)
prval () = $UN.castview0{void}(spnv)
//
} (* end of [spinref_get] *)

(* ****** ****** *)

implement
{a}(*tmp*)
spinref_process
  (spnr) = let
//
var env: void = ()
//
in
  spinref_process_env<a><void> (spnr, env)
end // end of [spinref_process]

(* ****** ****** *)

implement
{a}{env}
spinref_process_env
  (spnr, env) = () where
{
//
implement
spinvar_process$fwork<a><env> =
  spinref_process$fwork<a><env>
//
val spnv =
$UN.castvwtp0{spinvar(a)}(spnr)
val () = spinvar_process_env<a><env> (spnv, env)
prval () = $UN.castview0{void}(spnv)
//
} (* end of [spinref_process_env] *)

(* ****** ****** *)

(* end of [spinref.dats] *)

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
// An abstract thread interface
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/athread.sats"

(* ****** ****** *)

implement
{}(*tmp*)
spin_create_exn() = let
//
val spn = spin_create()
val p_spn = spin2ptr(spn)
val () =
if p_spn = the_null_ptr then
{
//
val () =
fprintln! (
  stderr_ref, "libats/athread: [spin_create]: failed."
) (* end of [val] *)
val ((*void*)) = assertloc(false)
//
}
//
in
  $UN.cast{spin1}(spn)
end // end of [spin_create_exn]

(* ****** ****** *)

implement
{}(*tmp*)
mutex_create_exn() = let
//
val mtx = mutex_create()
val p_mtx = mutex2ptr(mtx)
val () =
if p_mtx = the_null_ptr then
{
//
val () =
fprintln!
(
  stderr_ref, "libats/athread: [mutex_create]: failed."
) (* end of [val] *)
val ((*void*)) = assertloc(false)
//
} (* end of [if] *) // end of [val]
//
in
  $UN.cast{mutex1}(mtx)
end // end of [mutex_create_exn]

(* ****** ****** *)

implement
{}(*tmp*)
condvar_create_exn() = let
//
val cvr = condvar_create()
//
val p_cvr = condvar2ptr(cvr)
val () =
if p_cvr = the_null_ptr then
{
//
val () =
fprintln! (
  stderr_ref, "libats/athread: [condvar_create]: failed."
) (* end of [val] *)
val ((*void*)) = assertloc(false)
//
}
//
in
  $UN.cast{condvar1}(cvr)
end // end of [condvar_create_exn]

(* ****** ****** *)

implement
{}(*tmp*)
athread_create_cloptr
  (tid, fwork) = err where
{
//
fun app
(
  f: () -<lincloptr1> void
): void = let
  val () = f () in cloptr_free($UN.castvwtp0{cloptr0}(f))
end // end of [app]
//
val f = $UN.castvwtp1{ptr}(fwork)
val err = athread_create_funenv<>(tid, app, fwork)
val () = if (err != 0) then cloptr_free($UN.castvwtp0{cloptr0}(f))
//
} (* end of [athread_create_cloptr] *)

(* ****** ****** *)

implement
{}(*tmp*)
athread_create_cloptr_exn
  (fwork) = tid where
{
//
var tid: lint
val err =
athread_create_cloptr<>(tid, fwork)
//
val () =
if (err != 0) then
{
//
val () =
fprintln! (
  stderr_ref, "libats/athread: [athread_create_cloptr_exn]: failed."
) (* end of [val] *)
//
} (* end of [if] *)
//
} (* end of [athread_create_cloptr_exn] *)

(* ****** ****** *)

(* end of [athread.dats] *)

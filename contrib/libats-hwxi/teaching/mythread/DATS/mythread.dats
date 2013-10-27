(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// HX-2013-10:
// A simple thread interface
//
(* ****** ****** *)

staload "./../SATS/mythread.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement
mutex_create_exn () = let
//
val mtx = mutex_create ()
val p_mtx = ptrcast (mtx)
val () =
if p_mtx = the_null_ptr then
{
//
val () = fprintln!
(
  stderr_ref, "libats-hwxi: mythread: [mutex_create]: failed."
)
val ((*void*)) = assertloc (false)
//
}
//
in
  $UN.cast{mutex1}(mtx)
end // end of [mutex_create_exn]

(* ****** ****** *)

implement
condvar_create_exn () = let
//
val cvr = condvar_create ()
//
val p_cvr = ptrcast (cvr)
val () =
if p_cvr = the_null_ptr then
{
//
val () = fprintln!
(
  stderr_ref, "libats-hwxi: mythread: [condvar_create]: failed."
)
val ((*void*)) = assertloc (false)
//
}
//
in
  $UN.cast{condvar1}(cvr)
end // end of [condvar_create_exn]

(* ****** ****** *)

(* end of [mythread.dats] *)

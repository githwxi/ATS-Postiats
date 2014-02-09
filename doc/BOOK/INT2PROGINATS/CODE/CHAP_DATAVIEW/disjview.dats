(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** Disjunctive Views
**
** Author: Hongwei Xi (gmhwxiATgmailDOTcom)
** Time: February, 2014
*)

(* ****** ****** *)

dataview VOR (v0:view+, v1:view+, int) =
  | VORleft (v0, v1, 0) of (v0) | VORright (v0, v1, 1) of (v1)

(* ****** ****** *)

abst@ype T

(* ****** ****** *)
//
extern
fun getopt{l:addr}
  (pf: T? @ l | ptr (l)): [i:int] (VOR (T? @ l, T @ l, i) | int (i))
//
(* ****** ****** *)

fun foo (): void = let
  var x: T?
  val (pfor | i) = getopt (view@(x) | addr@(x))
in
//
if i = 0
then let
  prval VORleft (pf0) = pfor in view@(x) := pf0 // uninitialized
end // end of [then]
else let
  prval VORright (pf1) = pfor in view@(x) := pf1 // initialized
end // end of [else]
//
end // end of [foo]

(* ****** ****** *)
//
extern
fun getopt (x: &T? >> opt (T, b)): #[b:bool] bool(b)
//
(* ****** ****** *)

extern
prfun opt_unsome{a:t@ype} (x: !opt (a, true) >> a): void
extern
prfun opt_unnone{a:t@ype} (x: !opt (a, false) >> a?): void

(* ****** ****** *)

fun foo (): void = let
  var x: T?
  val b = getopt (x)
in
//
if (b)
then let
  prval () = opt_unsome(x) in (*initialized*)
end // end of [then]
else let
  prval () = opt_unnone(x) in (*uninitialized*)
end // end of [else]
//
end // end of [foo]

(* ****** ****** *)

(* end of [disjview.dats] *)

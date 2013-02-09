(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2012 Hongwei Xi, ATS Trustful Software, Inc.
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
** 
*)

(* ****** ****** *)

(*
** Functions for traversing aggregates
*)

(* ****** ****** *)

fun{}
foreach_int$fwork (i: int): void
fun{} foreach_int (n: Nat): void

fun{}
foreach_size$fwork (i: size_t): void
fun{} foreach_size (n: Size): void

(* ****** ****** *)

fun{a:t0p}
foreach_list$fwork (x: a): void
fun{a:t0p}
foreach_list (xs: List (a)): void

fun{a:t0p}
iforeach_list$fwork (i: int, x: a): void
fun{a:t0p}
iforeach_list (xs: List (a)): void

(* ****** ****** *)

fun{a:vt0p}
foreach_list_vt$fwork (x: &a): void
fun{a:vt0p}
foreach_list_vt (xs: !List_vt (a)): void

fun{a:vt0p}
iforeach_list_vt$fwork (i: int, x: &a): void
fun{a:vt0p}
iforeach_list_vt (xs: !List_vt (a)): void

(* ****** ****** *)

fun{a:vt0p}
foreach_array$fwork (x: &a): void
fun{a:vt0p}
foreach_array
  {n:int} (A: &(@[a][n]), asz: size_t n) : void
// end of [foreach_array]

fun{a:vt0p}
iforeach_array$fwork (i: size_t, x: &a): void
fun{a:vt0p}
iforeach_array
  {n:int} (A: &(@[a][n]), asz: size_t n) : void
// end of [iforeach_array]

(* ****** ****** *)

sortdef tk = tkind

(* ****** ****** *)

staload
IT = "prelude/SATS/giterator.sats"
stadef giter = $IT.giter_5

fun{x:t0p}
foreach_giter_val$fwork (x: x): void
fun{
knd:tk}{x:t0p
} foreach_giter_val
  {kpm:tk} {f,r:int} (
  itr: !giter (knd, kpm, x, f, r) >> giter (knd, kpm, x, f+r, 0)
) : void // end of [foreach_giter_val]

fun{x:vt0p}
foreach_giter_ref$fwork (x: &x): void
fun{
knd:tk}{x:vt0p
} foreach_giter_ref
  {kpm:tk} {f,r:int} (
  itr: !giter (knd, kpm, x, f, r) >> giter (knd, kpm, x, f+r, 0)
) : void // end of [foreach_giter_ref]

(* ****** ****** *)

(* end of [foreach.sats] *)

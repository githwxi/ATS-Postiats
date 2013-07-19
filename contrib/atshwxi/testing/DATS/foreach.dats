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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "atshwxi/testing/SATS/foreach.sats"

(* ****** ****** *)

implement{}
foreach_int (n) = let
//
fun loop
  {n:int}
  {i:nat | i <= n} .<n-i>. (
  n: int n, i: int i
) : void =
  if i < n then let
    val () = foreach_int$fwork (i) in loop (n, succ(i))
  end else () // end of [if]
(* end of [loop] *)
//
in
  loop (n, 0)
end // end of [foreach_int]

(* ****** ****** *)

implement{}
foreach_size (n) = let
//
fun loop
  {n:int}
  {i:nat | i <= n} .<n-i>. (
  n: size_t (n), i: size_t (i)
) : void =
  if i < n then let
    val () = foreach_size$fwork (i) in loop (n, succ(i))
  end else () // end of [if]
(* end of [loop] *)
//
in
  loop (n, g1int2uint(0))
end // end of [foreach_size]

(* ****** ****** *)

implement{a}
foreach_list (xs) = let
//
implement(env)
list_foreach$cont<a><env> (x, env) = true
implement(env)
list_foreach$fwork<a><env> (x, env) = foreach_list$fwork<a> (x)
//
in
  list_foreach<a> (xs)
end // end of [foreach_list]

(* ****** ****** *)

implement{a}
iforeach_list (xs) = let
//
implement(env)
list_iforeach$cont<a><env> (i, x, env) = true
implement(env)
list_iforeach$fwork<a><env> (i, x, env) = iforeach_list$fwork<a> (i, x)
//
in
  ignoret (list_iforeach<a> (xs))
end // end of [iforeach_list]

(* ****** ****** *)

implement{a}
foreach_list_vt (xs) = let
//
implement(env)
list_vt_foreach$cont<a><env> (x, env) = true
implement(env)
list_vt_foreach$fwork<a><env> (x, env) = foreach_list_vt$fwork<a> (x)
//
in
  list_vt_foreach<a> (xs)
end // end of [foreach_list_vt]

(* ****** ****** *)

implement{a}
iforeach_list_vt (xs) = let
//
implement(env)
list_vt_iforeach$cont<a><env> (i, x, env) = true
implement(env)
list_vt_iforeach$fwork<a><env> (i, x, env) = iforeach_list_vt$fwork<a> (i, x)
//
in
  ignoret (list_vt_iforeach<a> (xs))
end // end of [iforeach_list_vt]

(* ****** ****** *)

implement{a}
foreach_array (A, n) = let
//
implement(env)
array_foreach$cont<a><env> (x, env) = true
implement(env)
array_foreach$fwork<a><env> (x, env) = foreach_array$fwork<a> (x)
//
in
  ignoret (array_foreach<a> (A, n))
end // end of [foreach_array]

(* ****** ****** *)

implement{a}
iforeach_array (A, n) = let
//
typedef tenv = size_t
//
implement
array_foreach$cont<a><tenv> (x, env) = true
implement(env)
array_foreach$fwork<a><tenv> (x, env) = let
  val i = env; val () = env := succ (i) in iforeach_array$fwork<a> (i, x)
end // end of [array_foreach$fwork]
//
var env: tenv = g1int2uint (0)
//
in
  ignoret (array_foreach_env<a><tenv> (A, n, env))
end // end of [iforeach_array]

(* ****** ****** *)

local

staload IT = "prelude/SATS/giterator.sats"

in // in of [local]

implement
{knd}{x}
foreach_giter_val
  {kpm}{f,r} (itr) = let
//
val () = $IT.lemma_giter_param (itr)
//
stadef giter
  (f:int, r:int) = $IT.giter (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  itr: !giter (f, r) >> giter (f+r, 0)
) : void = let
  val test = $IT.giter_isnot_atend (itr)
in
  if test then let
    val x = $IT.giter_get_inc (itr)
    val () = foreach_giter_val$fwork (x)
  in
    loop (itr)
  end else () // end of [if]
end (* end of [loop] *)
//
in
  loop (itr)
end // end of [foreach_giter_val]

(* ****** ****** *)

implement
{knd}{x}
foreach_giter_ref
  {kpm}{f,r} (itr) = let
//
val () = $IT.lemma_giter_param (itr)
//
stadef giter
  (f:int, r:int) = $IT.giter (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  itr: !giter (f, r) >> giter (f+r, 0)
) : void = let
  val test = $IT.giter_isnot_atend (itr)
in
  if test then let
    val p = $IT.giter_getref_inc (itr)
    val (pf, fpf | p) = $UN.ptr_vtake{x}(p)
    val () = foreach_giter_ref$fwork (!p)
    prval () = fpf (pf)
  in
    loop (itr)
  end else () // end of [if]
end (* end of [loop] *)
//
in
  loop (itr)
end // end of [foreach_giter_ref]

end // end of [local]

(* ****** ****** *)

(* end of [foreach.dats] *)

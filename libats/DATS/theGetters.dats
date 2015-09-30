(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// HX-2015-09-28:
// Some templates for getters
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/theGetters.sats"

(* ****** ****** *)

implement
{a}(*tmp*)
the_getall_list
  ((*void*)) = let
//
vtypedef
res_vt = List0_vt(a)
//
fun
loop
(
  res: &ptr? >> res_vt
) : void = let
//
val () =
  res :=
  list_vt_cons{a}{0}(_, _)
//
val+list_vt_cons(x, res1) = res
//
val ans = the_get_elt<a>(x)
//
in
//
if
ans
then let
  prval
    () = opt_unsome(x)
  // end of [prval]
  val () = loop(res1)
  prval () = fold@(res)
in
  // nothing
end // end of [then]
else let
  prval
    () = opt_unnone(x)
  // end of [prval]
  val () = free@{a}{0}(res)
  val () = res := list_vt_nil()
in
  // nothing
end // end of [else]
//
end // end of [loop]
//
var res: ptr // uninitized
//
in
  loop(res); res
end // end of [the_getall_list]

(* ****** ****** *)

implement
{a}(*tmp*)
the_get_elt_exn
  ((*void*)) = let
//
var x: a? // uninitized
val ans = the_get_elt<a> (x)
//
in
//
if
ans
then let
  prval () = opt_unsome(x) in x
end // end of [then]
else let
  prval () = opt_unnone(x) in $raise Exception_the_get_elt_exn()
end // end of [else]
//
end // end of [the_get_elt_exn]

(* ****** ****** *)

implement
{a}(*tmp*)
the_getall_list_exn
  ((*void*)) =
(
  list_vt_reverse(the_getall_rlist_exn<a>())
) (* end of [the_getall_list_exn] *)

(* ****** ****** *)

implement
{a}(*tmp*)
the_getall_rlist_exn
  ((*void*)) = let
//
vtypedef
res_vt = List0_vt(a)
//
fun
loop
(
  p: ptr
) : void = loop(p) where
{
  val x =
    the_get_elt_exn()
  val xs =
    $UN.ptr0_get<res_vt>(p)
  val () =
    $UN.ptr0_set<res_vt>(p, cons_vt{a}(x, xs))
} (* end of [loop] *)
//
var
res: ptr =
  list_vt_nil()
val
p_res = addr@res
//
val () =
ptr_as_volatile (p_res) // longjmp/setjmp bug
//
val ((*void*)) =
(
  try loop(p_res) with ~Exception_the_get_elt_exn() => ()
) : void // end of [val]
//
in
  res
end // end of [the_getall_rlist_exn]

(* ****** ****** *)

local
//
staload
"libats/SATS/dynarray.sats"
//
(*
staload
_ = "libats/DATS/dynarray.dats"
*)
in (* in-of-local *)
//
implement
{}(*tmp*)
the_getall_asz_hint
  ((*void*)) = i2sz(64)
//
implement
{a}(*tmp*)
the_getall_arrayptr_exn
  (asz) = let
//
vtypedef DA = dynarray(a)
//
fun
loop
(
  DA: ptr
) : void = loop(DA) where
{
  val x =
    the_get_elt_exn()
  // end of [val]
  val DA =
    $UN.castvwtp0{DA}(DA)
  // end of [val]
  val () =
    dynarray_insert_atend_exn<a>(DA, x)
  // end of [val]
  val DA = $UN.castvwtp0{ptr}(DA)
} (* end of [loop] *)
//
val n0 = the_getall_asz_hint()
val DA = dynarray_make_nil<a>(n0)
val () = loop($UN.castvwtp1{ptr}(DA))
//
in
  dynarray_getfree_arrayptr{a}(DA, asz)
end // end of [the_getall_arrayptr_exn]
//
end // end of [local]

(* ****** ****** *)

(* end of [theGetters.dats] *)

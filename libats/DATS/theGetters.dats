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
//
implement
{}(*tmp*)
the_getall_asz_hint((*void*)) = i2sz(64)
//  
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
the_getall_arrayptr
  (asz) = let
//
fun
loop
(
  pp: ptr, pa: ptr, pz: ptr, asz: &size_t? >> _
) : ptr = (
//
if
pp < pz
then let
//
val (
  pf, fpf | pp
) = $UN.ptr0_vtake{a?}(pp)
val ans = the_get_elt<a>(!pp)
prval () = $UN.cast2void((fpf, pf | pp))
//
in
//
if ans
  then
    loop(ptr0_succ<a>(pp), pa, pz, asz)
  // end of [then]
  else let
    val () =
    asz := $UN.cast2size(pp-pa)/sizeof<a> in pa
  end // end of [else]
// end of [if]
//
end // end of [then]
else let
//
val n =
$UN.cast2size(pz-pa)/sizeof<a>
val n = $UN.cast{sizeGte(1)}(n)
val n2 = n + n
//
val pa2 =
$UN.castvwtp0{ptr}
(
  arrayptr_make_uninitized<a>(n2)
)
//
extern
fun
memcpy
(
  dst: ptr, src: ptr, bsz: size_t
) : ptr = "atslib_memcpy"
val _ = memcpy(pa2, pa, n*sizeof<a>)
//
val pp2 = ptr_add<a>(pa2, n)
val pz2 = ptr_add<a>(pa2, n2)
//
in
  loop (pp2, pa2, pz2, asz)
end // end of [else]
//
) (* end of [loop] *)
//
val n =
the_getall_asz_hint()
//
val pa =
$UN.castvwtp0{ptr}
  (arrayptr_make_uninitized<a>(n))
//
val pz = ptr_add<a> (pa, n)
//
val pa = loop(pa, pa, pz, asz)
//
val [n:int] n = g1ofg0_uint(asz)
//
prval
[l:addr]
EQADDR() = eqaddr_make_ptr(addr@asz)
prval () = view@asz := $UN.castview0{size_t(n)@l}(view@asz)
//
in
  $UN.castvwtp0{arrayptr(a, n)}(asz)  
end // end of [the_getall_arrayptr]

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
val p_DA = $UN.castvwtp1{ptr}(DA)
//
val () =
ptr_as_volatile (p_DA) // longjmp/setjmp bug
//
val ((*void*)) =
(
  try loop(p_DA) with ~Exception_the_get_elt_exn() => ()
) : void // end of [val]
//
in
  dynarray_getfree_arrayptr{a}(DA, asz)
end // end of [the_getall_arrayptr_exn]
//
end // end of [local]

(* ****** ****** *)

(* end of [theGetters.dats] *)

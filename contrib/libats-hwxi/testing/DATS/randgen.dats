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
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
** THE SOFTWARE.
** 
*)

(* ****** ****** *)

(*
** Functions
** for generating random data
*)

(* ****** ****** *)

staload "./../SATS/randgen.sats"

(* ****** ****** *)
//
implement randgen_val<int> () = 0
implement randgen_val<uint> () = 0u
//
implement randgen_val<lint> () = 0l
implement randgen_val<ulint> () = 0ul
//
implement randgen_val<llint> () = 0ll
implement randgen_val<ullint> () = 0ull
//
implement randgen_val<float> () = 0.0f
implement randgen_val<double> () = 0.0
implement randgen_val<ldouble> () = 0.0l
//
(* ****** ****** *)

implement{a}
randgen_ref (x) = x := randgen_val<a> ()

(* ****** ****** *)

implement{a}
randgen_list
  (n) = res where
{
//
fun loop
  {n:nat} .<n>.
(
  n: int n, res: &ptr? >> list_vt (a, n)
) : void = let
in
//
if n > 0 then let
//
val () =
  res := cons_vt{a}{0} (_, _)
// end of [val]
val+ list_vt_cons (x, res1) = res
val () = randgen_ref<a> (x)
val () = loop (pred (n), res1)
//
in
  fold@ (res)
end else res := nil_vt((*void*))
//
end // end of [loop]
//
var res: ptr // uninitialized
val () = loop (n, res)
//
} // end of [randgen_list]

(* ****** ****** *)

implement{a}
randgen_arrayptr
  (n) = A where {
//
val A = arrayptr_make_uninitized<a> (n)
//
implement
array_initize$init<a> (_, x) = randgen_ref<a> (x)
//
prval pf = arrayptr_takeout (A)
val () = array_initize<a> (!(ptrcast(A)), n)
prval () = arrayptr_addback (pf | A)
//
} // end of [randgen_arrayptr]

(* ****** ****** *)

implement{a}
randarr_initize
  (A, n) = let
//
implement
array_initize$init<a> (_, x) = randgen_ref<a> (x)
//
in
  array_initize (A, n)
end // end of [randarr_initize]

(* ****** ****** *)

(* end of [randgen.dats] *)

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
// Author: Hongwei Xi
// Authoremail: hwxi AT gmail DOT com
// Start Time: April, 2013
//
(* ****** ****** *)
//
#staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/intinf.sats"
//
vtypedef
intinf_vt(i:int) = intinf_vtype(i)
//
(* ****** ****** *)
//
#staload "./../SATS/intinf_t.sats"
#staload VT = "./../SATS/intinf_vt.sats"
//
(* ****** ****** *)
//
implement
{}(*tmp*)
intinf_make_int
  (i) = // intinf_make_int
  intinf_vt2t($VT.intinf_make_int(i))
implement
{}(*tmp*)
intinf_make_uint
  (i) = // intinf_make_uint
  intinf_vt2t($VT.intinf_make_uint(i))
implement
{}(*tmp*)
intinf_make_lint
  (i) = // intinf_make_lint
  intinf_vt2t($VT.intinf_make_lint(i))
implement
{}(*tmp*)
intinf_make_ulint
  (i) = // intinf_make_ulint
  intinf_vt2t($VT.intinf_make_ulint(i))
//
(* ****** ****** *)

implement
{}(*tmp*)
intinf_get_int
  (x) = res where
{
//
val
(
  fpf | x
) = intinf_takeout (x)
//
val res = $VT.intinf_get_int(x)
//
prval ((*returned*)) = fpf(x)
//
} (* end of [intinf_get_int] *)

implement
{}(*tmp*)
intinf_get_lint
  (x) = res where
{
//
val
(
  fpf | x
) = intinf_takeout (x)
//
val res = $VT.intinf_get_lint(x)
//
prval ((*returned*)) = fpf(x)
//
} (* end of [intinf_get_lint] *)

(* ****** ****** *)

implement
{}(*tmp*)
intinf_get_string
  (x, base) = let
//
val
(
  fpf | x
) = intinf_takeout (x)
val str = $VT.intinf_get_strptr (x, base)
prval () = fpf (x)
//
in
  strptr2string(str)
end (* end of [intinf_get_string] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
print_intinf
  (x) = fprint_intinf(stdout_ref, x)
implement
{}(*tmp*)
prerr_intinf
  (x) = fprint_intinf(stderr_ref, x)
//
implement
{}(*tmp*)
fprint_intinf
  (out, x) = fprint_intinf_base(out, x, 10(*base*))
//
(* ****** ****** *)

implement
{}(*tmp*)
fprint_intinf_base
  (out, x, base) =
{
//
val
(
  fpf | x
) = intinf_takeout (x)
val () =
  $VT.fprint_intinf_base (out, x, base)
prval ((*returned*)) = fpf(x)
//
} (* fprint_intinf_base *)

(* ****** ****** *)

implement
{}(*tmp*)
neg_intinf
  (x) = let
//
val
(
  fpf | x
) = intinf_takeout(x)
val res = $VT.neg_intinf1(x)
//
prval ((*returned*)) = fpf(x)
//
in
  intinf_vt2t(res)
end (* end of [neg_intinf] *)

(* ****** ****** *)

implement
{}(*tmp*)
abs_intinf
  (x) = let
//
val
(
  fpf | x
) = intinf_takeout (x)
//
val res = $VT.abs_intinf1(x)
//
prval ((*returned*)) = fpf(x)
//
in
  intinf_vt2t(res)
end (* end of [abs_intinf] *)

(* ****** ****** *)

implement
{}(*tmp*)
succ_intinf(x) = add_intinf_int (x, 1)
implement
{}(*tmp*)
pred_intinf(x) = sub_intinf_int (x, 1)

(* ****** ****** *)

implement
{}(*tmp*)
add_intinf_int
  (x, y) = let
//
val
(
  fpf | x
) = intinf_takeout (x)
//
val res =
  $VT.add_intinf1_int (x, y)
//
prval ((*returned*)) = fpf(x)
//
in
  intinf_vt2t(res)
end // end of [add_intinf_int]

implement
{}(*tmp*)
add_int_intinf
  (x, y) = let
//
val
(
  fpf | y
) = intinf_takeout(y)
//
val res =
  $VT.add_int_intinf1(x, y)
//
prval ((*returned*)) = fpf(y)
//
in
  intinf_vt2t(res)
end // end of [add_int_intinf]

implement
{}(*tmp*)
add_intinf_intinf
  (x, y) = let
//
val
(
  fpf1 | x
) = intinf_takeout(x)
val
(
  fpf2 | y
) = intinf_takeout(y)
val res =
  $VT.add_intinf1_intinf1(x, y)
//
prval ((*returned*)) = fpf1(x)
prval ((*returned*)) = fpf2(y)
//
in
  intinf_vt2t(res)
end (* end of [add_intinf_intinf] *)

(* ****** ****** *)

implement
{}(*tmp*)
sub_intinf_int
  (x, y) = let
//
val
(
  fpf | x
) = intinf_takeout(x)
//
val res =
  $VT.sub_intinf1_int(x, y)
//
prval ((*returned*)) = fpf (x)
//
in
  intinf_vt2t(res)
end // end of [sub_intinf_int]

implement
{}(*tmp*)
sub_int_intinf
  (x, y) = let
//
val
(
  fpf | y
) = intinf_takeout (y)
//
val res =
  $VT.sub_int_intinf1(x, y)
//
prval ((*returned*)) = fpf(y)
//
in
  intinf_vt2t(res)
end // end of [sub_int_intinf]

implement
{}(*tmp*)
sub_intinf_intinf
  (x, y) = let
//
val
(
  fpf1 | x
) = intinf_takeout (x)
val
(
  fpf2 | y
) = intinf_takeout (y)
val res =
  $VT.sub_intinf1_intinf1 (x, y)
//
prval ((*returned*)) = fpf1 (x)
prval ((*returned*)) = fpf2 (y)
//
in
  intinf_vt2t(res)
end (* end of [sub_intinf_intinf] *)

(* ****** ****** *)

implement
{}(*tmp*)
mul_intinf_int
  (x, y) = let
//
val
(
  fpf | x
) = intinf_takeout(x)
//
val res =
  $VT.mul_intinf1_int(x, y)
//
prval ((*returned*)) = fpf(x)
//
in
  intinf_vt2t(res)
end // end of [mul_intinf_int]

implement
{}(*tmp*)
mul_int_intinf
  (x, y) = let
//
val
(
  fpf | y
) = intinf_takeout(y)
//
val res =
  $VT.mul_int_intinf1(x, y)
//
prval ((*returned*)) = fpf(y)
//
in
  intinf_vt2t(res)
end // end of [mul_int_intinf]

implement
{}(*tmp*)
mul_intinf_intinf
  (x, y) = let
//
val
(
  fpf1 | x
) = intinf_takeout (x)
val
(
  fpf2 | y
) = intinf_takeout (y)
val res =
  $VT.mul_intinf1_intinf1(x, y)
//
prval ((*returned*)) = fpf1(x)
prval ((*returned*)) = fpf2(y)
//
in
  intinf_vt2t(res)
end (* end of [mul_intinf_intinf] *)

(* ****** ****** *)

implement
{}(*tmp*)
div_intinf_int
  (x, y) = let
//
val
(
  fpf | x
) = intinf_takeout (x)
//
val res =
  $VT.div_intinf1_int (x, y)
//
prval ((*returned*)) = fpf (x)
//
in
  intinf_vt2t(res)
end // end of [div_intinf_int]

implement
{}(*tmp*)
div_intinf_intinf
  (x, y) = let
//
val
(
  fpf1 | x
) = intinf_takeout (x)
val
(
  fpf2 | y
) = intinf_takeout (y)
val res =
  $VT.div_intinf1_intinf1(x, y)
//
prval ((*returned*)) = fpf1(x)
prval ((*returned*)) = fpf2(y)
//
in
  intinf_vt2t(res)
end (* end of [div_intinf_intinf] *)

(* ****** ****** *)

implement
{}(*tmp*)
nmod_intinf_int
  (x, y) = res where
{
//
val
(
  fpf | x
) = intinf_takeout(x)
//
val res = $VT.nmod_intinf1_int(x, y)
//
prval ((*returned*)) = fpf(x)
//
} (* end of [nmod_intinf_int] *)

(* ****** ****** *)

implement
{}(*tmp*)
compare_intinf_int
  (x, y) = let
//
val
(
  fpf1 | x
) = intinf_takeout (x)
val sgn = $VT.compare_intinf_int (x, y)
prval () = fpf1 (x)
//
in
  sgn (* HX: -1/0/1 *)
end (* end of [compare_intinf_int] *)

implement
{}(*tmp*)
compare_int_intinf
  (x, y) = let
//
val
(
  fpf2 | y
) = intinf_takeout (y)
val sgn = $VT.compare_int_intinf (x, y)
prval () = fpf2 (y)
//
in
  sgn (* HX: -1/0/1 *)
end (* end of [compare_int_intinf] *)

implement
{}(*tmp*)
compare_intinf_intinf
  (x, y) = let
//
val
(
  fpf1 | x
) = intinf_takeout (x)
val
(
  fpf2 | y
) = intinf_takeout (y)
val sgn = $VT.compare_intinf_intinf (x, y)
prval () = fpf1 (x)
prval () = fpf2 (y)
//
in
  sgn (* HX: -1/0/1 *)
end (* end of [compare_intinf_intinf] *)

(* ****** ****** *)

implement
{}(*tmp*)
pow_int_int
  (base, exp) = let
//
val res =
  $VT.pow_int_int(base, exp)
//
in
  intinf_vt2t(res)
end (* end of [pow_int_int] *)

(* ****** ****** *)

implement
{}(*tmp*)
pow_intinf_int
  (base, exp) = let
//
val
(
  fpf | base
) = intinf_takeout(base)
//
val res =
  $VT.pow_intinf_int(base, exp)
//
prval ((*returned*)) = fpf(base)
//
in
  intinf_vt2t(res)
end (* end of [pow_intinf_int] *)

(* ****** ****** *)

(* end of [intinf_t.dats] *)

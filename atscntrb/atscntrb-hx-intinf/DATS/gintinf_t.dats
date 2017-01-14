(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
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
// Author: Hongwei Xi
// Authoremail: hwxi AT gmail DOT com
// Start Time: July, 2014
//
(* ****** ****** *)

#staload "./../SATS/intinf.sats"
#staload "./../SATS/intinf_t.sats"

(* ****** ****** *)

(*
#staload _ = "./../DATS/intinf_t.dats"
#staload _ = "./../DATS/intinf_vt.dats"
*)

(* ****** ****** *)
//
abstype intinf_type = ptr
typedef intinf = intinf_type
//
(* ****** ****** *)
//
extern
castfn
g0ofg1_intinf:Intinf -<fun> intinf
extern
castfn
g1ofg0_intinf:intinf -<fun> Intinf
//
overload g0ofg1 with g0ofg1_intinf of 0
overload g1ofg0 with g1ofg0_intinf of 0
//
(* ****** ****** *)
//
extern
fun{}
print_intinf : (intinf) -> void
extern
fun{}
prerr_intinf : (intinf) -> void
extern
fun{}
fprint_intinf : (FILEref, intinf) -> void
//
overload print with print_intinf of 0
overload prerr with prerr_intinf of 0
//
overload fprint with fprint_intinf of 0
//
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
fprint_intinf(out, x) = fprint(out, g1ofg0(x))
//
(* ****** ****** *)
//
// Generic operations on intinf-values
//
(* ****** ****** *)
//
implement
gnumber_int<intinf>
  (x) = let
//
val x = g1ofg0(x)
val y = $effmask_all(intinf_make_int(x))
//
in
  g0ofg1_intinf(y)
end // end of [gnumber_int]
//
(* ****** ****** *)

implement
gneg_val<intinf>
  (x) = let
//
val x = g1ofg0(x)
val y = $effmask_all(neg_intinf(x))
//
in
  g0ofg1_intinf(y)
end // end of [gneg_val]

(* ****** ****** *)

implement
gabs_val<intinf>
  (x) = let
//
val x = g1ofg0(x)
val y = $effmask_all(abs_intinf(x))
//
in
  g0ofg1_intinf(y)
end // end of [gabs_val]

(* ****** ****** *)

implement
gsucc_val<intinf>
  (x) = let
//
val x = g1ofg0(x)
val y = $effmask_all(succ_intinf(x))
//
in
  g0ofg1_intinf(y)
end // end of [gsucc_val]

(* ****** ****** *)

implement
gpred_val<intinf>
  (x) = let
//
val x = g1ofg0(x)
val y = $effmask_all(pred_intinf(x))
//
in
  g0ofg1_intinf(y)
end // end of [gpred_val]

(* ****** ****** *)

implement
gadd_val_val<intinf>
  (x1, x2) = let
//
val x1 = g1ofg0(x1)
and x2 = g1ofg0(x2)
val res = $effmask_all(add_intinf_intinf(x1, x2))
//
in
  g0ofg1_intinf(res)
end // end of [gadd_val_val]

(* ****** ****** *)

implement
gsub_val_val<intinf>
  (x1, x2) = let
//
val x1 = g1ofg0(x1)
and x2 = g1ofg0(x2)
val res = $effmask_all(sub_intinf_intinf(x1, x2))
//
in
  g0ofg1_intinf(res)
end // end of [gsub_val_val]

(* ****** ****** *)

implement
gmul_val_val<intinf>
  (x1, x2) = let
//
val x1 = g1ofg0(x1)
and x2 = g1ofg0(x2)
val res = $effmask_all(mul_intinf_intinf(x1, x2))
//
in
  g0ofg1_intinf(res)
end // end of [gmul_val_val]

(* ****** ****** *)

implement
gdiv_val_val<intinf>
  (x1, x2) = let
//
val x1 = g1ofg0(x1)
and x2 = g1ofg0(x2)
//
val sgn = compare_intinf_int (x2, 0)
//
in
//
if
sgn != 0
then let
//
val res =
$effmask_all(div_intinf_intinf(x1, x2))
//
in
  g0ofg1_intinf(res)
end // end of [then]
else
  $raise IllegalArgExn("gdiv_val_val<intinf>:division-by-zero")
//
end // end of [gdiv_val_val]

(* ****** ****** *)

implement
gequal_val_val<intinf>
  (x1, x2) = let
//
val sgn =
  gcompare_val_val<intinf> (x1, x2)
//
in
  if sgn = 0 then true else false
end // end of [gequal_val_val]

(* ****** ****** *)

implement
gcompare_val_val<intinf>
  (x1, x2) = let
  val x1 = g1ofg0(x1)
  and x2 = g1ofg0(x2)
in
  compare_intinf_intinf (x1, x2)
end // end of [gcompare_val_val]

(* ****** ****** *)

(* end of [gintinf_t.dats] *)

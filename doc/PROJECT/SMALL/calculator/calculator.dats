(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
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
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "./calculator.sats"

(* ****** ****** *)

implement
print_aexp (ae) = fprint_aexp (stdout_ref, ae)

(* ****** ****** *)
//
// HX: macros can often make code easier to access
//
implement
fprint_aexp
  (out, ae0) = let
//
macdef prcon1 (con, ae) =
  fprint! (out, ,(con), "(", ,(ae), ")")
macdef prcon2 (con, ae1, ae2) =
  fprint! (out, ,(con), "(", ,(ae1), ", ", ,(ae2), ")")
//
in
//
case+ ae0 of
| AEint (i) => prcon1 ("AEint", i)
| AEneg (ae) => prcon1 ("AEneg", ae)
| AEadd (ae1, ae2) => prcon2 ("AEadd", ae1, ae2)
| AEsub (ae1, ae2) => prcon2 ("AEsub", ae1, ae2)
| AEmul (ae1, ae2) => prcon2 ("AEmul", ae1, ae2)
| AEdiv (ae1, ae2) => prcon2 ("AEdiv", ae1, ae2)
//
end // end of [fprint_aexp]

(* ****** ****** *)

implement
aexp_eval (ae0) = let
//
macdef eval (x) = aexp_eval (,(x))
//
in
//
case+ ae0 of
| AEint (i) => g0i2f(i)
| AEneg (ae) => ~(eval(ae))
| AEadd (ae1, ae2) => eval(ae1) + eval(ae2)
| AEsub (ae1, ae2) => eval(ae1) - eval(ae2)
| AEmul (ae1, ae2) => eval(ae1) * eval(ae2)
| AEdiv (ae1, ae2) => eval(ae1) / eval(ae2)
//
end // end of [aexp_eval]

(* ****** ****** *)

(* end of [calculator.dats] *)

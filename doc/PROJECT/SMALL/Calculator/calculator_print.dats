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

staload "./calculator.sats"

(* ****** ****** *)

overload fprint with fprint_aexp of 10
overload fprint with fprint_token of 10

(* ****** ****** *)

implement
print_aexp (ae) = fprint (stdout_ref, ae)

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
print_token (tok) = fprint (stdout_ref, tok)

(* ****** ****** *)

implement
fprint_token
  (out, tok) = let
//
macdef prstr (x) = fprint_string (out, ,(x))
//
in
//
case+ tok of
| TOKint (int) =>
  (
    prstr "TOKint("; fprint (out, int); prstr ")"
  )
| TOKopr (opr) =>
  (
    prstr "TOKopr("; fprint (out, opr); prstr ")"
  )
//
| TOKlpar () => prstr "("
| TOKrpar () => prstr ")"
//
| TOKunknown (chr) =>
  (
    prstr "TOKunknown("; fprint (out, chr); prstr ")"
  )
| TOKeof () => prstr "TOKeof()"
//
end // end of [fprint_token]

(* ****** ****** *)

(* end of [calculator_print.dats] *)

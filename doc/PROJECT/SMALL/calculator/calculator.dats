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
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./calculator.sats"

(* ****** ****** *)

extern
fun REPloop
  (inp: FILEref, out: FILEref): void
// end of [REPloop]

implement
REPloop (inp, out) = let
//
val () = fprint (out, ">> ")
val () = fileref_flush (out)
val line = fileref_get_line_string (inp)
val opt = aexp_parse_string ($UN.strptr2string(line))
//
in
//
case+ opt of
| ~Some_vt (aexp) =>
  let
    val lval = aexp_eval (aexp)
    val (
    ) = fprintln! (out, "eval(", line, ") = ", lval)
    val () = strptr_free (line)
  in
    REPloop (inp, out)
  end // end of [Some_vt]
| ~None_vt ((*void*)) =>
  let val () = strptr_free (line) in REPloop (inp, out) end
  // end of [None_vt]
//
end // end of [REPloop]

(* ****** ****** *)

dynload "./calculator.sats"
dynload "./calculator_aexp.dats"
dynload "./calculator_token.dats"
dynload "./calculator_cstream.dats"
dynload "./calculator_tstream.dats"
dynload "./calculator_parsing.dats"
dynload "./calculator_print.dats"

(* ****** ****** *)

implement
main0 () = REPloop (stdin_ref, stdout_ref)

(* ****** ****** *)

(* end of [calculator.dats] *)

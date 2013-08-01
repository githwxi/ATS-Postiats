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

dynload "./calculator.dats"
dynload "./calculator_print.dats"
dynload "./calculator_cstream.dats"
dynload "./calculator_tstream.dats"

(* ****** ****** *)

val () =
{
//
val ae0 = AEint (0)
val ae1 = AEadd (ae0, ae0)
val ae2 = AEmul (ae1, ae1)
//
val () = println! ("ae2 = ", ae2)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
val () = fprintln! (out, TOKint(0))
val () = fprintln! (out, TOKopr("+"))
val () = fprintln! (out, TOKeof())
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val ts = tstream_make_string ("(1+23)*456/7%8^9")
//
val (
) = loop (ts) where
{
fun loop
  (ts: tstream): void = let
  val tok = tstream_getinc (ts)
  val () = println! ("tok = ", tok)
in
  case+ tok of TOKeof () => () | _ => loop (ts)
end // end of [loop]
} (* end of [val] *)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test.dats] *)

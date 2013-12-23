(*
** Copyright (C) 2011 Hongwei Xi, Boston University
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
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
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

(*
** Optional Views
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)

(*
dataview option_v (v:view+, bool) =
  | Some_v (v, true) of (v) | None_v (v, false) of ()
// end of [option_v]
*)

(* ****** ****** *)

extern
fun{a:t@ype}
ptr_alloc_opt
  (): [l:addr] (option_v (a? @ l, l > null) | ptr l)
// end of [ptr_alloc_opt]

(* ****** ****** *)

absviewt@ype window
extern fun get_width (x: &window): int

(* ****** ****** *)

viewdef optat
  (a:t@ype, l:addr) = option_v (a @ l, l > null)
// end of [optat]

fun get_width_alt {l:addr} (
  pf: !optat (int?, l) >> optat (int, l)
| x: &window, p: ptr l
) : void =
  if p > null then let
    prval Some_v (pf1) = pf
    val () = !p := get_width (x)
  in
    pf := Some_v (pf1)
  end else let
    prval None_v () = pf in pf := None_v ()
  end // end of [val]
// end of [get_width_alt]

(* ****** ****** *)

(* end of [optview.dats] *)

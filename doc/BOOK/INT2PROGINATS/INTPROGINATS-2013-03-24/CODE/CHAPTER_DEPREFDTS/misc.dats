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
**
** Some code used in the book PROGINATS
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(*
//
// this one is already defined
//
datatype list (a:t@ype+, int) =
  | list_nil (a, 0) of () // [of ()] is optional
  | {n:nat} list_cons (a, n+1) of (a, list (a, n))
// end of [list]
*)

(* ****** ****** *)

fun{a:t@ype}
list_length {n:nat} .<n>.
  // .<n>. is a termination metric
  (xs: list (a, n)): int (n) = case+ xs of
  | list_cons (_, xs1) => 1 + list_length (xs1)
  | list_nil () => 0
// end of [list_length]

(* ****** ****** *)

fun{a:t@ype}
list_length {n:nat} .<>.
  (xs: list (a, n)): int (n) = let
  // loop: {i,j:nat} (list (a, i), int (j)) -> int (i+j)
  fun loop {i,j:nat} .<i>.
    // .<i>. is a termination metric
    (xs: list (a, i), j: int j): int (i+j) = case+ xs of
    | list_cons (_, xs1) => loop (xs1, j+1) | list_nil () => j
  // end of [loop]
in
  loop (xs, 0)
end // end of [list_length]

(* ****** ****** *)

(*
datatype
option (a:t@ype, bool) =
  | Some (a, true) of a | None (a, false) of ()
// end of [option]
*)

fn{a:t@ype}
list_last {n:nat}
  (xs: list (a, n)): option (a, n > 0) = let
  fun loop {n:pos} .<n>.
    (xs: list (a, n)): a = let
    val+ list_cons (_, xs1) = xs
  in
    case+ xs1 of
    | list_cons _ => loop (xs1)
    | list_nil () => let
        val+ list_cons (x, _) = xs in x
      end // end of [list_nil]
  end // end of [loop]
in
  case+ xs of
  | list_cons _ => Some (loop (xs)) | list_nil () => None ()
end // end of [list_last]

(* ****** ****** *)

(*
fun{a1,a2:t@ype}{b:t@ype}
list_zipwith {n:nat} (
  xs1: list (a1, n)
, xs2: list (a2, n)
, f: (a1, a2) -<cloref1> b
) : list (b, n) =
  case+ (xs1, xs2) of
  | (list_cons (x1, xs1), list_cons (x2, xs2)) =>
      list_cons (f (x1, x2), list_zipwith (xs1, xs2, f))
  | (_, _) => list_nil () // sequentiality is not taken into account
// end of [list_zipwith]
*)

fun{a1,a2:t@ype}{b:t@ype}
list_zipwith {n:nat} (
  xs1: list (a1, n)
, xs2: list (a2, n)
, f: (a1, a2) -<cloref1> b
) : list (b, n) =
  case+ (xs1, xs2) of
  | (list_cons (x1, xs1), list_cons (x2, xs2)) =>
      list_cons (f (x1, x2), list_zipwith (xs1, xs2, f))
  | (_, _) =>> list_nil ()
// end of [list_zipwith]

(* ****** ****** *)

implement main () = ()

(* ****** ****** *)

(* end of [misc.dats] *)

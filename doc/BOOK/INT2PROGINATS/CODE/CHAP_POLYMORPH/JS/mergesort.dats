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
** Example:
** A Functional Implementation of Mergesort
*)

(* ****** ****** *)

(*
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-09
*)

(* ****** ****** *)

(*
** Ported to ATSCC2JS by HX-2014-10-12
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

(* ****** ****** *)

%{$
//
ats2jspre_the_print_store_clear();
my_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]

(* ****** ****** *)
//
#define nil0 list_nil
#define cons0 list_cons
//
typedef
list0 (a:t@ype) = List0 (a)
//
(* ****** ****** *)

#define list0_length list_length
#define list0_reverse list_reverse

(* ****** ****** *)

typedef lte (a:t@ype) = (a, a) -> bool

(* ****** ****** *)

fun{
a:t@ype
} merge (
  xs: list0 a, ys: list0 a, lte: lte a
) : list0 a =
(
  case+ xs of
  | nil0 () => ys
  | cons0 (x, xs1) => (
    case+ ys of
    | nil0 () => xs
    | cons0 (y, ys1) =>
        if x \lte y then
          cons0{a}(x, merge<a> (xs1, ys, lte))
        else
          cons0{a}(y, merge<a> (xs, ys1, lte))
        // end of [if]
    ) // end of [cons0]
) (* end of [merge] *)

(* ****** ****** *)

fun{
a:t@ype
} mergesort
(
  xs: list0 a, lte: lte a
) : list0 a = let
//
val n = list0_length (xs)
//
fun msort
(
  xs: list0 a, n: int, lte: lte a
) : list0 a =
  if n >= 2 then split (xs, n, lte, n/2, nil0) else xs
//
and split
(
  xs: list0 a, n: int, lte: lte a, i: int, xsf: list0 a
) : list0 a = (
//
if
i > 0
then let
  val-cons0 (x, xs) = xs
in
  split (xs, n, lte, i-1, cons0{a}(x, xsf))
end // end of [then]
else let
  val xsf = list0_reverse (xsf) // make sorting stable!
  val xsf = msort (xsf, n/2, lte) and xs = msort (xs, n-n/2, lte)
in
  merge<a> (xsf, xs, lte)
end // end of [else]
//
) (* end of [split] *)
//
in
  msort (xs, n, lte)
end // end of [mergesort]

(* ****** ****** *)
//
val xs =
(
cons0 (5,
cons0 (3,
cons0 (4,
cons0 (6,
cons0 (8,
cons0 (0,
cons0 (7,
cons0 (1,
cons0 (9,
cons0 (2,
nil0()))))))))))
) : list0 (int)
//
val () = println! ("xs = ", xs)
val () = println! ("mergesort(xs) = ", mergesort<int> (xs, lam (x, y) => x <= y))
//
(* ****** ****** *)
//
val xs =
(
cons0 ("5",
cons0 ("3",
cons0 ("4",
cons0 ("6",
cons0 ("8",
cons0 ("0",
cons0 ("7",
cons0 ("1",
cons0 ("9",
cons0 ("2",
nil0()))))))))))
) : list0 (string)
//
implement
print_val<string> (x) = print! ("\"", x, "\"")
//
val () = println! ("xs = ", xs)
val () = println! ("mergesort(xs) = ", mergesort<string> (xs, lam (x, y) => x <= y))
//
(* ****** ****** *)

(* end of [mergesort.dats] *)

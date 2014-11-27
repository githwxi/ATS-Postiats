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
** Example: Some Function Templates on Lists.
*)

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

fun{a:t@ype}
list0_append
(
  xs: list0 a, ys: list0 a
) : list0 a =
(
  case+ xs of
  | nil0 () => ys
  | cons0 (x, xs) =>
      cons0{a}(x, list0_append<a> (xs, ys))
    // end of [cons0]
) (* end of [list0_append] *)

fun{a:t@ype}
list0_reverse_append
(
  xs: list0 a, ys: list0 a
) : list0 a =
(
  case+ xs of
  | nil0 () => ys
  | cons0 (x, xs) =>
      list0_reverse_append<a> (xs, cons0{a}(x, ys))
    // end of [cons0]
) (* end of [list0_reverse_append] *)

fun{a:t@ype}
list0_reverse
  (xs: list0 a): list0 a = list0_reverse_append<a> (xs, nil0)
// end of [list0_reverse]

(* ****** ****** *)

fun
{a:t@ype}
{b:t@ype}
list0_map
(
  xs: list0 a, f: a -<cloref1> b
) : list0 b =
(
  case+ xs of
  | nil0 () => nil0 ()
  | cons0 (x, xs) =>
      cons0{b}(f x, list0_map<a> (xs, f))
    // end of [cons0]
) (* end of [list0_map] *)

(* ****** ****** *)

fun
{a:t@ype}
{b:t@ype}
list0_foldleft
(
  ini: a, xs: list0 (b), f: (a, b) -> a
) : a =
(
  case+ xs of
  | nil0 () => ini
  | cons0 (x, xs) => list0_foldleft<a><b> (f (ini, x), xs, f)
)

fun
{a:t@ype}
{b:t@ype}
list0_foldright
(
  xs: list0 (a), res: b, f: (a, b) -> b
) : b =
(
  case+ xs of
  | nil0 () => res
  | cons0 (x, xs) => f (x, list0_foldright<a><b> (xs, res, f))
)

(* ****** ****** *)

fun{
a,b:t@ype
} list0_zip
(
  xs: list0 a
, ys: list0 b
) : list0 '(a, b) = let
  typedef ab = '(a, b)
in
  case+ (xs, ys) of
  | (cons0 (x, xs),
     cons0 (y, ys)) => cons0{ab}( '(x, y), list0_zip<a,b> (xs, ys) )
  | (_, _) => nil0 ()
end (* end of [list0_zip] *)

(* ****** ****** *)

fun
{a,b:t@ype}
{c:t@ype}
list0_zipwith
(
  xs: list0 a
, ys: list0 b
, f: (a, b) -<cloref1> c
) : list0 c =
(
  case+ (xs, ys) of
  | (cons0 (x, xs),
     cons0 (y, ys)) =>
      cons0{c} (f (x, y), list0_zipwith<a,b><c> (xs, ys, f))
  | (_, _) => nil0 ()
) // end of [list0_zipwith]

(* ****** ****** *)
//
typedef T = int
typedef T2 = '(T, T)
//
(* ****** ****** *)

#define :: list_cons

(* ****** ****** *)

val () =
{
//
#define N1 10
#define N2 10
//
val xs1 =
(
  0 :: 1 :: 2 :: 3 :: 4 :: nil0()
) : list0(int)
val xs2 =
(
  5 :: 6 :: 7 :: 8 :: 9 :: nil0()
) : list0(int)
//
val () = println! ("xs1 = ", xs1)
val () = println! ("xs2 = ", xs2)
//
val ys =
list0_map<T2><T>
  (list0_zip<T,T> (xs1, xs2), lam xx => xx.0 + xx.1)
//
val () = println! ("ys = ", ys)
//
val zs =
list0_zipwith<T,T><T> (xs1, xs2, lam (x1, x2) => x1 + x2)
//
val () = println! ("zs = ", zs)
//
} (* end of [val] *)

(* ****** ****** *)

(* end of [listfuns.dats] *)

(*
** Copyright (C) 2011 Hongwei Xi, ATS Trustful Software, Inc.
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
** Example: Binary Search
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2 by Hongwei Xi (gmhwxiATgmailDOTcom)
** Time: March 24, 2013
*)

(* ****** ****** *)

(*
** Ported to ATSCC2JS by Hongwei Xi (gmhwxiATgmailDOTcom)
** Time: October 10, 2014
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

staload
"{$LIBATSCC2JS}/SATS/print.sats"

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

fun bsearch_fun
(
  f: int -<cloref1> int
, x0: int, lb: int, ub: int
) : int =
  if lb <= ub then let
    val mid = lb + (ub - lb) / 2
    val x = f (mid)
  in
    if x0 < x then
      bsearch_fun (f, x0, lb, mid-1)
    else
      bsearch_fun (f, x0, mid+1, ub)
    // end of [if]
  end else ub // end of [if]
// end of [bsearch_fun]

(* ****** ****** *)

macdef
square (x) = let val x = ,(x) in x * x end

(* ****** ****** *)
//
// Assume 32-bit ints
//
val ISQRT_MAX = (1 << 16) - 1
//
(* ****** ****** *)

fun isqrt
  (x: int): int =
(
  bsearch_fun (lam i => square (i), x, 0, ISQRT_MAX)
) // end of [isqrt]

(* ****** ****** *)

val () = println!("isqrt(100) = ", isqrt(100))
val () = println!("isqrt(1000) = ", isqrt(1000))
val () = println!("isqrt(1024) = ", isqrt(1024))

(* ****** ****** *)

(* end of [bsearch.dats] *)

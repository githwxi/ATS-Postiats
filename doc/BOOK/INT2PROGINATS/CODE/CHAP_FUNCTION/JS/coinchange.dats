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
** Example: Coin Changes
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

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

typedef int4 = '(int, int, int, int)

(* ****** ****** *)

val theCoins = '(1, 5, 10, 25): int4

(* ****** ****** *)

fun coin_get
  (n: int): int =
  if n = 0 then theCoins.0
  else if n = 1 then theCoins.1
  else if n = 2 then theCoins.2
  else if n = 3 then theCoins.3
  else ~1 (* erroneous value *)
// end of [coin_get]

fun coin_change
  (sum: int): int = let
  fun aux (sum: int, n: int): int =
    if sum > 0 then
     (if n >= 0 then aux (sum, n-1) + aux (sum-coin_get(n), n) else 0)
    else (if sum < 0 then 0 else 1)
  // end of [aux]
in
  aux (sum, 3)
end // end of [coin_change]

(* ****** ****** *)

val () =
{
  val () = println! ("coin_change (25) = ", coin_change (25))
  val () = println! ("coin_change (100) = ", coin_change (100))
  val () = println! ("coin_change (1000) = ", coin_change (1000))
} (* end of [val] *)

(* ****** ****** *)

(* end of [coinchange.dats] *)

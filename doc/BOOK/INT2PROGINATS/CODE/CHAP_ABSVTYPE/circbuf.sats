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
** Array-based implementation of circular buffer 
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: November, 2011
*)

(* ****** ****** *)

absviewtype
cbufObj (a:viewt@ype, m:int, n:int)

(* ****** ****** *)

prfun cbufObj_param_lemma
  {a:viewt@ype} {m,n:int} (buf: !cbufObj (a, m, n)): [m>=n; n>=0] void
// end of [cbufObj_param_lemma]

(* ****** ****** *)

fun{a:viewt@ype}
cbufObj_get_cap
  {m,n:int} (
  buf: !cbufObj (a, m, n)
) : size_t (m) // end of [cbufObj_get_cap]

fun{a:viewt@ype}
cbufObj_get_size
  {m,n:int} (
  buf: !cbufObj (a, m, n)
) : size_t (n) // end of [cbufObj_get_size]

(* ****** ****** *)

fun{a:viewt@ype}
cbufObj_is_empty
  {m,n:int} (
  buf: !cbufObj (a, m, n)
) : bool (n==0)

fun{a:viewt@ype}
cbufObj_isnot_empty
  {m,n:int} (
  buf: !cbufObj (a, m, n)
) : bool (n > 0)

(* ****** ****** *)

fun{a:viewt@ype}
cbufObj_is_full
  {m,n:int} (
  buf: !cbufObj (a, m, n)
) : bool (m==n)

fun{a:viewt@ype}
cbufObj_isnot_full
  {m,n:int} (
  buf: !cbufObj (a, m, n)
) : bool (n < m)

(* ****** ****** *)

fun{a:viewt@ype}
cbufObj_new {m:pos} (m: size_t m): cbufObj (a, m, 0)

fun cbufObj_free
  {a:viewt@ype} {m:int} (buf: cbufObj (a, m, 0)): void
// end of [cbufObj_free]

(* ****** ****** *)

fun cbufObj_clear_type
  {a:t@ype} {m,n:int} (
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, 0)
) : void // end of [cbufObj_clear_type]

(* ****** ****** *)

fun{a:viewt@ype}
cbufObj_insert
  {m,n:int | n < m} (
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, n+1), x: a
) : void // end of [cbufObj_insert]

fun{a:viewt@ype}
cbufObj_remove
  {m,n:int | n > 0} (
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, n-1)
) : a // end of [cbufObj_remove]

(* ****** ****** *)

(* end of [circbuf.sats] *)

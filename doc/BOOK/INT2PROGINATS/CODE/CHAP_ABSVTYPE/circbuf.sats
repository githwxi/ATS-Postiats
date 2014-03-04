(* ****** ****** *)
//
// An Array-based implementation of circular buffer 
//
(* ****** ****** *)

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
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: November, 2011
*)

(* ****** ****** *)
//
// HX-2014-03-03: ported to ATS2
//
(* ****** ****** *)

absvtype
cbufObj (a:viewt@ype, m:int, n:int) = ptr

(* ****** ****** *)

prfun
lemma_cbufObj_param
  {a:vt0p}{m,n:int}
  (buf: !cbufObj (a, m, n)): [m>=n; n>=0] void
// end of [cbufObj_param_lemma]

(* ****** ****** *)
//
fun{a:vt0p}
cbufObj_get_cap
  {m,n:int} (buf: !cbufObj (a, m, n)): size_t (m)
fun{a:vt0p}
cbufObj_get_size
  {m,n:int} (buf: !cbufObj (a, m, n)): size_t (n)
//
(* ****** ****** *)

fun{a:vt0p}
cbufObj_is_empty
  {m,n:int} (buf: !cbufObj (a, m, n)): bool (n==0)
fun{a:vt0p}
cbufObj_isnot_empty
  {m,n:int} (buf: !cbufObj (a, m, n)): bool (n > 0)

(* ****** ****** *)

fun{a:vt0p}
cbufObj_is_full
  {m,n:int} (buf: !cbufObj (a, m, n)): bool (m==n)
fun{a:vt0p}
cbufObj_isnot_full
  {m,n:int} (buf: !cbufObj (a, m, n)): bool (n < m)

(* ****** ****** *)
//
fun{a:vt0p}
cbufObj_new
  {m:pos} (m: size_t m): cbufObj (a, m, 0)
//
fun cbufObj_free
  {a:vt0p}{m:int} (buf: cbufObj (a, m, 0)): void
//
(* ****** ****** *)

fun cbufObj_clear
  {a:t@ype}{m,n:int}
(
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, 0)
) : void // end of [cbufObj_clear]

(* ****** ****** *)
//
fun{a:vt0p}
cbufObj_insert
  {m,n:int | n < m}
(
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, n+1), x: a
) : void // end of [cbufObj_insert]
//
fun{a:vt0p}
cbufObj_remove
  {m,n:int | n > 0}
  (buf: !cbufObj (a, m, n) >> cbufObj (a, m, n-1)): (a)
//
(* ****** ****** *)

(* end of [circbuf.sats] *)

(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: December, 2015
*)

(* ****** ****** *)
//
// HX-2015-12-05:
//
(* ****** ****** *)

#define
ATS_STALOADFLAG 0 // no staloading at run-time
#define
ATS_EXTERN_PREFIX "ats2js_bacon_" // prefix for external names

(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)

stadef cfun0 = cfun0
stadef cfun1 = cfun1

(* ****** ****** *)
//
abstype chanpos()
abstype channeg()
//
(* ****** ****** *)
//
typedef
chpcont0() = cfun1(chanpos(), void)
typedef
chpcont1(a:t0p) = cfun2(chanpos(), a, void)
//
(* ****** ****** *)
//
typedef
chncont0() = cfun1(channeg(), void)
typedef
chncont1(a:t0p) = cfun2(channeg(), a, void)
//
(* ****** ****** *)
//
fun
chanpos0_send
  {a:t0p}
(
  chanpos(), x: a, k0: chpcont0()
) : void = "mac#%" // end-of-fun
//
fun
chanpos0_recv
  {a:t0p}
  (chp: chanpos(), k0: chpcont1(a)): void = "mac#%"
//
(* ****** ****** *)
//
fun
channeg0_recv
  {a:t0p}
(
  channeg(), x: a, k0: chncont0()
) : void = "mac#%" // end-of-fun
//
fun
channeg0_send
  {a:t0p}
  (chn: channeg(), k0: chncont1(a)): void = "mac#%"
//
(* ****** ****** *)
//
abstype chsnd(a:vt@ype)
abstype chrcv(a:vt@ype)
//
abstype chnil
abstype chcons(a:type, ss:type)
//
stadef :: = chcons
//
(* ****** ****** *)

stadef chsing(x:type) = chcons(x, chnil)

(* ****** ****** *)

(* end of [channel.sats] *)

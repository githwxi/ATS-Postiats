//
(*
** For writing ATS code that translates into Python
*)
//
(* ****** ****** *)
//
(*
The MIT License (MIT)

Copyright (c) 2014 Hongwei Xi

Permission is hereby granted,  free of charge,  to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use,  copy,  modify, merge, publish, distribute, sublicense,
and/or  sell  copies  of  the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*)
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_PACKNAME
"ATSCC2PY3.basics"
#define
ATS_EXTERN_PREFIX "ats2pypre_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/basics.sats"
//
(* ****** ****** *)

abstype PYobj // generic

(* ****** ****** *)
//
abstype PYfilr(*fileref*)
//
(* ****** ****** *)
//
// HX-2014-08:
// invariant constructors!
//
abstype PYlist(a:vt@ype) // mutable datastructure!
//
(*
abstype PYset  (a:t@ype)
abstype PYdict (a:t@ype)
*)
//
(* ****** ****** *)
//
fun
lazy2cloref
  {a:t0p}
(
  lazyval: lazy(a)
) : ((*void*)) -<cloref1> (a) = "mac#%"
//
(* ****** ****** *)
//
fun
exit(ecode: int):<!exn> {a:t0p}(a) = "mac#%"
//
fun
exit_errmsg
  (ecode: int, msg: string):<!exn> {a:t0p}(a) = "mac#%"
//
(* ****** ****** *)
//
fun
assert_errmsg_bool0
  (x: bool, msg: string): void = "mac#%"
fun
assert_errmsg_bool1
  {b:bool} (x: bool b, msg: string): [b] void = "mac#%"
//
overload assert_errmsg with assert_errmsg_bool0 of 100
overload assert_errmsg with assert_errmsg_bool1 of 110
//
(* ****** ****** *)
//
macdef assertloc(x) = assert_errmsg(,(x), $mylocation)
//
(* ****** ****** *)

(* end of [basics_py.sats] *)

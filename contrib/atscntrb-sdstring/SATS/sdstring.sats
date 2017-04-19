(*
** For Simple Dynamic Strings:
** https://github.com/antirez/sds/
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
** Author: Hanwen Wu (Summer 2014)
** Author: Hongwei Xi (February 2015)
*)

(* ****** ****** *)

#define
ATS_PACKNAME
"ATSCNTRB.sdstring" // package name
#define
ATS_EXTERN_PREFIX
"atscntrb_sdstring_" // prefix for external names

(* ****** ****** *)

%{#
//
#include \
"atscntrb-sdstring/CATS/sdstring.cats"
//
%} // end of [%{#}

(* ****** ****** *)
//
absvtype
sds_vtype(l:addr) = ptr(l)
//
vtypedef sds(l:addr) = sds_vtype(l)
//
vtypedef sds0 = [l:addr] sds(l)
vtypedef sds1 = [l:addr | l > null] sds(l)
//
(* ****** ****** *)
//
castfn
sdstring2ptr
  {l:addr}(!sds(l)):<> ptr(l)
//
overload ptrcast with sdstring2ptr
//
(* ****** ****** *)
//
fun
sdsnew(RD(string)): sds0 = "mac#%"
//
fun
sdsnewlen{n:int}
  (arrayref(char, n), sizeLte(n)): sds0 = "mac#%"
//
(* ****** ****** *)

fun sdsempty((*void*)): sds0 = "mac#%"

(* ****** ****** *)

fun sdsdup(sds: !sds0): sds0 = "mac#%"

(* ****** ****** *)

fun sdsfree (sds: sds0): void = "mac#%"

(* ****** ****** *)

fun sdscmp (!sds0, !sds0): int = "mac#%"

(* ****** ****** *)

fun sdslen(sds: !sds0): size_t = "mac#%"
fun sdsavail(sds: !sds0): size_t = "mac#%"

(* ****** ****** *)  
//
fun
sdsgrowzero(sds: sds0, len: size_t): sds0 = "mac#%"
//
(* ****** ****** *)
//
fun sdscat(sds: sds0, string): sds0 = "mac#%"
fun sdscatsds(sds1: sds0, sds2: !sds0): sds0 = "mac#%"
//
fun
sdscatlen
  {n:int}
  (sds0, arrayref(char, n), size_t(n)): sds0 = "mac#%"
//
(*
fun sdscatlen(sds0, string, size_t): sds0 = "mac#%"
fun sdscatrepr(sds0, string, size_t): sds0 = "mac#%"
fun sdscatprintf{ts:t@ype}(sds, fmt: string, ts): sds0 = "mac#%"
*)
//
(* ****** ****** *)
//
fun sdscpy(sds: sds0, string): sds0 = "mac#%"
//
fun
sdscpylen
  {n:int}
  (sds0, arrayref(char, n), size_t(n)): sds0 = "mac#%"
//
(* ****** ****** *)
//
fun
sdstrim{l:addr}
  (sds: !sds(l) >> _, string): void = "mac#%"
fun
sdsrange{l:addr}
  (sds: !sds(l) >> _, _beg: int, _end: int): void = "mac#%"
//
(* ****** ****** *)

fun sdstolower{l:addr}(sds: !sds(l) >> _): void = "mac#%"
fun sdstoupper{l:addr}(sds: !sds(l) >> _): void = "mac#%"

(* ****** ****** *)

fun sdsfromlonglong(inp: llint): sds0 = "mac#%"

(* ****** ****** *)

fun
sdsjoin{n,n2:int}
(
  arrayref(string, n), int(n), sep: string(n2), size_t(n2)
) : sds0 = "mac#%" // end of [sdsjoin]

fun
sdsjoinsds{n,n2:int}
(
  sdss: !arrayptr(sds0, n), int(n), sep: string(n2), size_t(n2)
) : sds0 = "mac#%" // end of [sdsjoinsds]

(* ****** ****** *)

fun
sdsmapchars{l:addr}{n:int}
(
  sds: !sds(l) >> _, _from: string(n), _to: string(n), size_t(n)
) : void = "mac#%" // end of [sdsmapchars]

(* ****** ****** *)
//
// HX: Some extensions based on features in ATS
//
(* ****** ****** *)
//
fun{}
sdstring_get_at_int
  (sds: !sds0, intGte(0)): int
fun{}
sdstring_get_at_size
  (sds: !sds0, i: size_t): int
//
overload [] with sdstring_get_at_int
overload [] with sdstring_get_at_size
//
fun{}
sdstring_set_at_int
  {l:addr}(sds: !sds(l) >> _, intGte(0), char): int(*err*)
fun{}
sdstring_set_at_size
  {l:addr}(sds: !sds(l) >> _, i: size_t, c: char): int(*err*)
//
symintr sdstring_set_at
overload sdstring_set_at with sdstring_set_at_int
overload sdstring_set_at with sdstring_set_at_size
//
(* ****** ****** *)
//
fun{
} sdstring_foreach
  {l:addr}(sds: !sds(l) >> _): size_t
fun{
env:vt0p
} sdstring_foreach_env
  {l:addr}(sds: !sds(l) >> _, env: &(env) >> _): size_t
// end of [sdstring_foreach_env]
//
fun{env:vt0p}
sdstring_foreach$cont (c: &char, env: &env): bool
fun{env:vt0p}
sdstring_foreach$fwork (c: &char >> _, env: &env): void
//
(* ****** ****** *)

(* end of [sdstring.sats] *)

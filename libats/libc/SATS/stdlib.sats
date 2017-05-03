(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: June, 2012
//
(* ****** ****** *)

%{#
//
#include \
"libats/libc/CATS/stdlib.cats"
//
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_libats_libc_"
//
(* ****** ****** *)

vtypedef
RD(a:vt0p) = a // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)
//
staload
STDDEF =
"libats/libc/SATS/stddef.sats"
//
typedef wchar_t = $STDDEF.wchar_t
//
(* ****** ****** *)

macdef EXIT_FAILURE = $extval(int, "EXIT_FAILURE")
macdef EXIT_SUCCESS = $extval(int, "EXIT_SUCCESS")

(* ****** ****** *)

abst@ype div_t = $extype"div_t"
abst@ype ldiv_t = $extype"ldiv_t"
abst@ype lldiv_t = $extype"lldiv_t"

(* ****** ****** *)
/*
void _Exit(int);
*/
fun _Exit (int): void = "mac#%"

/*
int atexit(void (*)(void));
*/
fun atexit
  (f: ((*void*)) -> void): int(*err*) = "mac#%"
// end of [atexit]

(* ****** ****** *)

/*
void abort(void);
*/
fun abort((*void*)): void = "mac#%"

(* ****** ****** *)

/*
int abs(int)
*/
fun abs(int):<> int = "mac#%"
/*
long int labs(long int j);
*/
fun labs(lint):<> lint = "mac#%"
/*
long long int llabs(long long int j);
*/
fun llabs(lint):<> llint = "mac#%"

(* ****** ****** *)

/*
div_t div(int, int);
*/
fun div(int, int):<> div_t
/*
ldiv_t ldiv(long, long);
*/
fun ldiv(lint, lint):<> ldiv_t
/*
lldiv_t lldiv(long long, long long);                              
*/
fun lldiv(llint, llint):<> lldiv_t

(* ****** ****** *)

/*
long a64l(const char *);
*/
fun a64l(x: NSH(string)):<> lint = "mac#%"

/*
char *l64a(long value); // not defined for a negative value
*/
fun l64a
  {i:nat}
(
  x: lint i
) :<!refwrt> [l:agz] vttakeout0(strptr(l)) = "mac#%"
// end of [l64a]

(* ****** ****** *)

/*
int atoi(const char *);
*/
fun atoi(x: NSH(string)):<> int = "mac#%"

/*
long atol(const char *);
*/
fun atol(x: NSH(string)):<> lint = "mac#%"

/*
long long atoll(const char *);
*/
fun atoll(x: NSH(string)):<> llint = "mac#%"
                                          
(* ****** ****** *)

/*
double atof(const char *);
*/
fun atof(x: NSH(string)):<> double = "mac#%"

(* ****** ****** *)
//
/*
long int
strtol(const char *nptr, char **endptr, int base);
*/
fun strtol0
  (nptr: string, base: intBtwe(2, 36)):<!wrt> lint = "mac#%"
fun strtol1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe(2, 36)):<!wrt> lint = "mac#%"
fun strtol_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> lint = "mac#%"
// end of [strtol_unsafe]
//
symintr strtol
overload strtol with strtol0
overload strtol with strtol1
//
/*
long long int
strtoll(const char *nptr, char **endptr, int base);
*/
fun strtoll0
  (nptr: string, base: intBtwe(2, 36)):<!wrt> llint
fun strtoll1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe(2, 36)):<!wrt> llint
fun strtoll_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> llint
// end of [strtoll_unsafe]
//
symintr strtoll
overload strtoll with strtoll0
overload strtoll with strtoll1
//
(* ****** ****** *)
//
/*
unsigned long
strtoul(const char *nptr, char **endptr, int base);
*/
fun strtoul0
  (nptr: string, base: intBtwe(2, 36)):<!wrt> ulint
fun strtoul1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe(2, 36)):<!wrt> ulint
fun strtoul_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> ulint
// end of [strtoul_unsafe]
//
symintr strtoul
overload strtoul with strtoul0
overload strtoul with strtoul1
//
/*
unsigned long long
strtoull(const char *nptr, char **endptr, int base);
*/
fun strtoull0
  (nptr: string, base: intBtwe(2, 36)):<!wrt> ullint
fun strtoull1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe(2, 36)):<!wrt> ullint
fun strtoull_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> ullint
// end of [strtoull_unsafe]
//
symintr strtoull
overload strtoull with strtoull0
overload strtoull with strtoull1
//
(* ****** ****** *)
/*
float
strtof(const char *nptr, char **endptr);
*/
fun
strtof0
  (nptr: string):<!wrt> float = "mac#%"
fun
strtof1
  (nptr: string, endptr: &ptr? >> _):<!wrt> float = "mac#%"
fun strtof_unsafe
  (nptr: string, endptr: ptr):<!wrt> float = "mac#%"
// end of [strtof_unsafe]
//
symintr strtof
overload strtof with strtof0
overload strtof with strtof1
//
(* ****** ****** *)
/*
double
strtod(const char *nptr, char **endptr);
*/
fun
strtod0
  (nptr: string):<!wrt> double = "mac#%"
fun
strtod1
  (nptr: string, endptr: &ptr? >> _):<!wrt> double = "mac#%"
fun
strtod_unsafe
  (nptr: string, endptr: ptr):<!wrt> double = "mac#%"
// end of [strtod_unsafe]
//
symintr strtod
overload strtod with strtod0
overload strtod with strtod1
//
(* ****** ****** *)
/*
long double
strtold(const char *nptr, char **endptr);
*/
fun
strtold0
  (nptr: string):<!wrt> ldouble = "mac#%"
fun
strtold1
  (nptr: string, endptr: &ptr? >> _):<!wrt> ldouble = "mac#%"
fun
strtold_unsafe
  (nptr: string, endptr: ptr):<!wrt> ldouble = "mac#%"
// end of [strtold_unsafe]
//
symintr strtold
overload strtold with strtold0
overload strtold with strtold1
//
(* ****** ****** *)

(*
//
// HX: these env-functions may not be reentrant!
//
*)

(* ****** ****** *)

/*
char *getenv(char *);
*/
fun getenv
(
  name: NSH(string)
) :<!ref> [l:addr] vttakeout0(strptr(l)) = "mac#%"

fun{} getenv_gc(name: NSH(string)):<!refwrt> Strptr0

(* ****** ****** *)

/*
int putenv(char *);
*/
//
// HX: [nameval] is shared!
//
fun putenv
  (nameval: SHR(string)):<!refwrt> int = "mac#%"
// end of [putenv]

(* ****** ****** *)

/*
int setenv
(
  const char *name, const char *value, int overwrite
) ;
*/
fun setenv
(
  name: NSH(string), value: NSH(string), overwrite: int
) :<!refwrt> int = "mac#%"

/*
int unsetenv(const char *name);
*/
fun unsetenv
  (name: NSH(string)):<!refwrt> int = "mac#%"
// end of [unsetenv]

(* ****** ****** *)

/*
int clearenv(void);
*/
fun clearenv ((*void*)):<!refwrt> int = "mac#%"

(* ****** ****** *)
//
// HX:
// these funs seem to have become obsolete
//
fun rand ((*void*)):<!refwrt> int = "mac#%"
fun srand (seed: uint):<!refwrt> void = "mac#%"

fun rand_r (seed: &uint >> _):<> int = "mac#%"

(* ****** ****** *)
//
/*
long int random(void);
*/
fun random((*void*)):<!refwrt> lint = "mac#%"
//
/*
void srandom(unsigned int seed);
*/
fun srandom(seed: uint):<!refwrt> void = "mac#%"
//
/*
char
*initstate
(
  unsigned int seed, char *state, size_t n
) ;
*/
fun
initstate_unsafe
(
  seed: uint, state: cPtr1(char), n: sizeGte(8)
) : cPtr0(char) = "mac#%"
// end of [initstate_unsafe]
//
/*
char *setstate(char *state);
*/
fun setstate_unsafe
  (state: cPtr1(char)):<!ref> cPtr0(char) = "mac#%"
// end of [setstate_unsafe]
//
(* ****** ****** *)
/*
double drand48(void); // obsolete
*/
fun drand48 ((*void*)):<!ref> double = "mac#%"
     
/*
double erand48(unsigned short xsubi[3]); // obsolete
*/
fun erand48
  (xsubi: &(@[usint][3])):<!ref> double = "mac#%"
// end of [erand48]

/*
long int lrand48(void); // obsolete
*/
fun lrand48 ((*void*)):<!ref> lint = "mac#%"
/*
long int nrand48(unsigned short xsubi[3]); // obsolete
*/
fun nrand48
  (xsubi: &(@[usint][3])):<!ref> lint = "mac#%"
// end of [nrand48]

/*
long int mrand48(void); // obsolete
*/
fun mrand48 ((*void*)):<!ref> lint = "mac#%"

/*
long int jrand48(unsigned short xsubi[3]); // obsolete
*/
fun jrand48
  (xsubi: &(@[usint][3])):<!ref> lint = "mac#%"
// end of [jrand48]

/*
void srand48(long int seedval); // obsolete
*/
fun srand48 (seedval: lint):<!ref> void = "mac#%"

/*
unsigned short *seed48(unsigned short seed16v[3]); // obsolete
*/
// HX: returning pointer to some internal buffer
fun seed48 (seed16v: &(@[usint][3])): Ptr1 = "mac#%"

/*
void lcong48(unsigned short param[7]); // obsolete
*/
fun lcong48 (param: &(@[usint][7])):<!ref> void = "mac#%"

(* ****** ****** *)
/*
void
*bsearch
(
  const void *key
, const void *base
, size_t nmemb, size_t size
, int (*compar)(const void *, const void *)
) ; // end of [bsearch]
*/
fun bsearch
  {a:vt0p}{n:int}
(
  key: &RD(a)
, arr: &RD(@[INV(a)][n])
, asz: size_t (n), tsz: sizeof_t (a)
, cmp: cmpref (a)
) :<> Ptr0 = "mac#%" // end of [bsearch]

(* ****** ****** *)
/*
void qsort
(
  void *base, size_t nmemb, size_t size
, int(*compar)(const void *, const void *)
) ; // end of [qsort]
*/
fun qsort
  {a:vt0p}{n:int}
(
  A: &(@[INV(a)][n]), asz: size_t (n), tsz: sizeof_t (a), cmp: cmpref (a)
) :<!wrt> void = "mac#%" // end of [qsort]

(* ****** ****** *)
/*
int mblen(const char *s, size_t);
*/
fun
mblen_unsafe
  (s: cPtr0(char), n: size_t):<!refwrt> int = "mac#%"
// end of [mblen_unsafe]

/*
int wctomb(char *s, wchar_t wc);
*/
fun
wctomb_unsafe
  (s: cPtr0(char), wc: wchar_t):<!refwrt> int = "mac#%"
// end of [wctomb_unsafe]

/*
size_t
wcstombs(char *dest, const wchar_t *src, size_t);
*/
fun
wcstombs_unsafe
(
  dest: cPtr0(char), src: cPtr1(wchar_t), n: size_t
) :<!refwrt> ssize_t = "mac#%" // endfun

(* ****** ****** *)
/*
void setkey(const char *key);
*/
fun setkey_unsafe (key: cPtr1(char)):<!ref> void = "mac#%"

(* ****** ****** *)
/*
int mkstemp(char *template);
*/
fun
mkstemp
{n:int | n >= 6}
  (template: !strnptr(n)): int = "mac#%"
// end of [mkstemp] // endfun
//
/*
int mkostemp(char *template, int flags);
*/
fun
mkostemp
{n:int | n >= 6}
  (template: !strnptr(n), flags: int): int = "mac#%"
// end of [mkostemp] // endfun
//
(* ****** ****** *)
/*
int grantpt(int fd);
*/
fun grantpt (fd: int): int = "mac#%"
//
(* ****** ****** *)

dataview
malloc_libc_v
  (addr, int) =
  | {n:int}
    malloc_libc_v_fail
      (null, n)
    // malloc_libc_v_fail
  | {l:agz}{n:int}
    malloc_libc_v_succ
      (l(*addr*), n) of (b0ytes(n) @ l, mfree_libc_v(l))
    // malloc_libc_v_succ
// end of [malloc_libc_v]

(* ****** ****** *)

fun
malloc_libc
  {n:int}
(
  bsz: size_t n
) :<!wrt>
[
  l:addr
] (
  malloc_libc_v(l, n) | ptr(l)
) = "mac#%" // end of [malloc]

fun
malloc_libc_exn
  {n:int}
(
  bsz: size_t(n)
) :<!wrt>
[
  l:addr | l > null
] (
  b0ytes(n)@l, mfree_libc_v(l) | ptr(l)
) = "mac#%" // end of [malloc_exn]

(* ****** ****** *)

fun mfree_libc
  {l:addr}{n:int}
(
  b0ytes(n)@l, mfree_libc_v(l) | ptr(l)
) :<!wrt> void = "mac#%" // end-of-fun

(* ****** ****** *)
//
/*
int system(const char *command);
*/
fun system(command: NSH(string)): int = "mac#%"
//
(* ****** ****** *)

(* end of [stdlib.sats] *)

(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: June, 2012
//
(* ****** ****** *)

staload
STDDEF = "libc/SATS/stddef.sats"
typedef size_t = $STDDEF.size_t
typedef wchar_t = $STDDEF.wchar_t

(* ****** ****** *)

typedef wchar = $STDDEF.wchar_t // shorthand

(* ****** ****** *)

#define NSH (x) x // for commenting: no sharing
#define SHR (x) x // for commenting: it is shared

(* ****** ****** *)

macdef EXIT_FAILURE = $extval (int, "EXIT_FAILURE")
macdef EXIT_SUCCESS = $extval (int, "EXIT_SUCCESS")

(* ****** ****** *)

macdef NULL = $extval (ptr(null), "NULL")

(* ****** ****** *)

abst@ype div_t = $extype"div_t"
abst@ype ldiv_t = $extype"ldiv_t"
abst@ype lldiv_t = $extype"lldiv_t"

(* ****** ****** *)
/*
void _Exit(int);
*/
fun _Exit (int): void = "mac#atslib__Exit"

/*
int atexit(void (*)(void));
*/
fun atexit (f: ((*void*)) -> void): int = "mac#atslib_atexit"

(* ****** ****** *)

/*
void abort(void);
*/
fun abort ((*void*)): void = "mac#atslib_abort"

(* ****** ****** *)

/*
int abs (int)
*/
fun abs (int):<> int = "mac#atslib_abs"
/*
long int labs(long int j);
*/
fun labs (lint):<> lint = "mac#atslib_labs"
/*
long long int llabs(long long int j);
*/
fun llabs (lint):<> llint = "mac#atslib_llabs"

(* ****** ****** *)

/*
div_t div(int, int);
*/
fun div (int, int):<> div_t
/*
ldiv_t ldiv(long, long);
*/
fun ldiv (lint, lint):<> ldiv_t
/*
lldiv_t lldiv(long long, long long);                              
*/
fun lldiv (llint, llint):<> lldiv_t

(* ****** ****** *)

/*
long a64l(const char *);
*/
fun a64l (x: NSH(string)):<> lint = "mac#atslib_a64l"

/*
char *l64a(long value); // not defined for a negative value
*/
fun l64a
  {i:nat} (
  x: lint i
) :<!refwrt> [l:agz] vttakeout (void, strptr l)
  = "mac#atslib_l64a"
// end of [l64a]

(* ****** ****** *)

/*
int atoi(const char *);
*/
fun atoi (x: NSH(string)):<> int

/*
long atol(const char *);
*/
fun atol (x: NSH(string)):<> lint

/*
long long atoll(const char *);
*/
fun atoll (x: NSH(string)):<> llint
                                          
/*
double atof(const char *);
*/
fun atof (x: NSH(string)):<> double

(* ****** ****** *)

/*
long int strtol(const char *nptr, char **endptr, int base);
*/
symintr strtol
fun strtol0
  (nptr: string, base: intBtwe (2, 36)):<!wrt> lint
overload strtol with strtol0
fun strtol1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe (2, 36)):<!wrt> lint
overload strtol with strtol1
fun strtol_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> lint
// end of [strtol_unsafe]
/*
long long int strtoll(const char *nptr, char **endptr, int base);
*/
symintr strtoll
fun strtoll0
  (nptr: string, base: intBtwe (2, 36)):<!wrt> llint
overload strtoll with strtoll0
fun strtoll1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe (2, 36)):<!wrt> llint
overload strtoll with strtoll1
fun strtoll_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> llint
// end of [strtoll_unsafe]

(* ****** ****** *)

/*
unsigned long strtoul(const char *nptr, char **endptr, int base);
*/
symintr strtoul
fun strtoul0
  (nptr: string, base: intBtwe (2, 36)):<!wrt> ulint
overload strtoul with strtoul0
fun strtoul1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe (2, 36)):<!wrt> ulint
overload strtoul with strtoul1
fun strtoul_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> ulint
// end of [strtoul_unsafe]
/*
unsigned long long strtoull(const char *nptr, char **endptr, int base);
*/
symintr strtoull
fun strtoull0
  (nptr: string, base: intBtwe (2, 36)):<!wrt> ullint
overload strtoull with strtoull0
fun strtoull1
  (nptr: string, endptr: &ptr? >> _, base: intBtwe (2, 36)):<!wrt> ullint
overload strtoull with strtoull1
fun strtoull_unsafe
  (nptr: string, endptr: ptr, base: int):<!wrt> ullint
// end of [strtoull_unsafe]

(* ****** ****** *)

/*
float strtof(const char *nptr, char **endptr);
*/
symintr strtof
fun strtof0 (nptr: string):<!wrt> float = "mac#atslib_strtof0"
overload strtof with strtof0
fun strtof1
  (nptr: string, endptr: &ptr? >> _):<!wrt> float = "mac#atslib_strtof1"
overload strtof with strtof1
fun strtof_unsafe
  (nptr: string, endptr: ptr):<!wrt> float = "mac#atslib_strtof"
// end of [strtof_unsafe]
/*
double strtod(const char *nptr, char **endptr);
*/
symintr strtod
fun strtod0 (nptr: string):<!wrt> double = "mac#atslib_strtod0"
overload strtod with strtod0
fun strtod1
  (nptr: string, endptr: &ptr? >> _):<!wrt> double = "mac#atslib_strtod1"
overload strtod with strtod1
fun strtod_unsafe
  (nptr: string, endptr: ptr):<!wrt> double = "mac#atslib_strtod"
// end of [strtod_unsafe]
/*
long double strtold(const char *nptr, char **endptr);
*/
symintr strtold
fun strtold0 (nptr: string):<!wrt> ldouble = "mac#atslib_strtold0"
overload strtold with strtold0
fun strtold1
  (nptr: string, endptr: &ptr? >> _):<!wrt> ldouble = "mac#atslib_strtold1"
overload strtold with strtold1
fun strtold_unsafe
  (nptr: string, endptr: ptr):<!wrt> ldouble = "mac#atslib_strtold"
// end of [strtold_unsafe]

(* ****** ****** *)
/*
char *getenv(char *);
*/
fun getenv (
  name: NSH(string)
) :<!ref> [l:addr] vttakeout (void, strptr l)
  = "mac#atslib_getenv"
// end of [getenv]

/*
int putenv(char *);
*/
fun putenv // HX: [nameval] is shared!
  (nameval: SHR(string)):<!refwrt> int = "mac#atslib_putenv"
// end of [putenv]

/*
int setenv(const char *name, const char *value, int overwrite);
*/
fun setenv (
  name: NSH(string), value: NSH(string), overwrite: int
) :<!refwrt> int = "mac#atslib_setenv"

/*
int unsetenv(const char *name);
*/
fun unsetenv
  (name: NSH(string)):<!refwrt> int = "mac#atslib_unsetenv"
// end of [unsetenv]

/*
int clearenv(void);
*/
fun clearenv ((*void*)):<!refwrt> int = "mac#atslib_clearenv"

(* ****** ****** *)

fun rand((*void*)):<!ref> int
fun rand_r(seed: &uint):<> int // HX: it seems to have become obsolete
fun srand(seed: uint):<!ref> void

(* ****** ****** *)
/*
long int random(void);
*/
fun random((*void*)):<!ref> lint

/*
void srandom(unsigned int seed);
*/
fun srandom(seed: uint):<!ref> void

/*
char *initstate(unsigned int seed, char *state, size_t n);
*/
fun initstate_unsafe (
  seed: uint, state: cPtr1 (char), n: sizeGte(8)
) : cPtr0 (char) = "mac#atslib_initstate_unsafe"
// end of [initstate_unsafe]

/*
char *setstate(char *state);
*/
fun setstate_unsafe
  (state: cPtr1 (char)):<!ref> cPtr0 (char) = "mac#atslib_setstate_unsafe"
// end of [setstate_unsafe]

(* ****** ****** *)
/*
double drand48(void); // obsolete
*/
fun drand48 ((*void*)):<!ref> double = "mac#atslib_drand48"
     
/*
double erand48(unsigned short xsubi[3]); // obsolete
*/
fun erand48
  (xsubi: &(@[usint][3])):<!ref> double = "mac#atslib_erand48"
// end of [erand48]

/*
long int lrand48(void); // obsolete
*/
fun lrand48 ():<!ref> lint = "mac#atslib_lrand48"
/*
long int nrand48(unsigned short xsubi[3]); // obsolete
*/
fun nrand48
  (xsubi: &(@[usint][3])):<!ref> lint = "mac#atslib_nrand48"
// end of [nrand48]

/*
long int mrand48(void); // obsolete
*/
fun mrand48(void):<!ref> lint = "mac#atslib_mrand48"
/*
long int jrand48(unsigned short xsubi[3]); // obsolete
*/
fun jrand48
  (xsubi: &(@[usint][3])):<!ref> lint = "mac#atslib_jrand48"
// end of [jrand48]

/*
void srand48(long int seedval); // obsolete
*/
fun srand48 (seedval: lint):<!ref> void = "mac#atslib_srand48"

/*
unsigned short *seed48(unsigned short seed16v[3]); // obsolete
*/
// HX: the returned pointer pointing to
fun seed48
  (seed16v: &(@[usint][3])): Ptr1 = "mac#atslib_seed48" // an internal buffer
// end of [seed48]

/*
void lcong48(unsigned short param[7]); // obsolete
*/
fun lcong48 (param: &(@[usint][7])):<!ref> void = "mac#atslib_lcong48"

(* ****** ****** *)
/*
void *bsearch(
  const void *key
, const void *base
, size_t nmemb, size_t size
, int (*compar)(const void *, const void *)
) ; // end of [bsearch]
*/
fun bsearch
  {a:vt0p}{n:int} (
  key: &a
, A: &(@[INV(a)][n]), asz: size_t (n), tsz: sizeof_t (a)
, cmp: cmpref (a)
) :<> Ptr0 = "atslib_bsearch" // end of [bsearch]

(* ****** ****** *)
/*
void qsort(
  void *base, size_t nmemb, size_t size
, int(*compar)(const void *, const void *)
) ; // end of [qsort]
*/
fun qsort
  {a:vt0p}{n:int} (
  A: &(@[INV(a)][n])
, asz: size_t (n), tsz: sizeof_t (a)
, cmp: cmpref (a)
) :<!wrt> void = "atslib_qsort" // end of [qsort]

(* ****** ****** *)
/*
int mblen(const char *s, size_t n);
*/
fun mblen_unsafe
  (s: cPtr0 (char), n: size_t):<!refwrt> int = "mac#atslib_mblen"
// end of [mblen_unsafe]

/*
int wctomb(char *s, wchar_t wc);
*/
fun wctomb_unsafe
  (s: cPtr0 (char), wc: wchar_t):<!refwrt> int = "mac#atslib_wctomb"
// end of [wctomb_unsafe]

/*
size_t wcstombs(char *dest, const wchar_t *src, size_t n);
*/
fun wcstombs_unsafe (
  dest: cPtr0 (char), src: cPtr1 (wchar), n: size_t
) :<!refwrt> ssize_t = "mac#atslib_wcstombs" // endfun

(* ****** ****** *)
/*
void setkey(const char *key);
*/
fun setkey_unsafe (key: cPtr1 (char)):<!ref> void = "mac#atslib_setkey"

(* ****** ****** *)
/*
int mkstemp(char *template);
*/
fun mkstemp {n:int | n >= 6}
  (template: !strnptr (n)): int = "mac#atslib_mkstemp"
// end of [mkstemp]

/*
int mkostemp(char *template, int flags);
*/
fun mkostemp {n:int | n >= 6}
  (template: !strnptr (n), flags: int): int = "mac#atslib_mkostemp"
// end of [mkostemp]

(* ****** ****** *)
/*
int grantpt(int fd);
*/
fun grantpt (fd: int): int = "mac#atslib_grantpt"

(* ****** ****** *)

/*
int system(const char *command);
*/
fun system (command: NSH(string)): int = "mac#atslib_system"

(* ****** ****** *)

(* end of [stdlib.sats] *)

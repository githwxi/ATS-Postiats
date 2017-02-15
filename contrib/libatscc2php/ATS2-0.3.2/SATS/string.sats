(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
//
(* ****** ****** *)
//
fun
strval{a:t0p}(obj: a): string = "mac#%"
//
(* ****** ****** *)
//
fun
strlen(x0: string): intGte(0) = "mac#%"
fun
string_length(x0: string): intGte(0) = "mac#%"
//
overload .length with string_length of 100
//
(* ****** ****** *)

(* end of [string.sats] *)

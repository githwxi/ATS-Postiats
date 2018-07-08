(*
** For writing ATS code
** that translates into Perl
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2plpre_"
//
(* ****** ****** *)
//
fun
string_get_at
  {n:int}{i:nat | i < n}
  (str: string(n), i: int(i)): charNZ = "mac#%"
//
overload [] with string_get_at of 100
//
(* ****** ****** *)

fun
string_isalnum : string -> bool = "mac#%"
fun
string_isalpha : string -> bool = "mac#%"
fun
string_isdecimal : string -> bool = "mac#%"

(* ****** ****** *)

fun
string_lower (str: string): string = "mac#%"
fun
string_upper (str: string): string = "mac#%"

(* ****** ****** *)

(* end of [string.sats] *)

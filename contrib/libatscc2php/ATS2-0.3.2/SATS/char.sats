(* ****** ****** *)
(*
** For writing ATS code
** that translates into PHP
*)
(* ****** ****** *)
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "ats2phppre_"
//
(* ****** ****** *)
//
typedef char = int
//
(* ****** ****** *)

fun char_isalpha(c: char): bool = "mac#%"
fun char_isalnum(c: char): bool = "mac#%"
fun char_isdigit(c: char): bool = "mac#%"

(* ****** ****** *)

fun char_isspace(c: char): bool = "mac#%"

(* ****** ****** *)

(* end of [char.sats] *)

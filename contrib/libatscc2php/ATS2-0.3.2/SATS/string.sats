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
#define
ATS_STATIC_PREFIX "_ats2phppre_string_"
//
(* ****** ****** *)
//
#staload
"./../basics_php.sats" // HX: strchr
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
//
fun
string0_is_empty
  (str: string): bool = "mac#%"
fun
string0_isnot_empty
  (str: string): bool = "mac#%"
//
fun
string1_is_empty
  {n:int}(string(n)): bool(n==0) = "mac#%"
fun
string1_isnot_empty
  {n:int}(string(n)): bool(n > 0) = "mac#%"
//
overload iseqz with string0_is_empty of 100
overload iseqz with string1_is_empty of 100
//
overload isneqz with string0_isnot_empty of 110
overload isneqz with string1_isnot_empty of 110
//
(* ****** ****** *)
//
fun
strcmp
  (string, string): int = "mac#%"
fun
strncmp
  (string, string, n: intGte(0)): int = "mac#%"
//
(* ****** ****** *)
//
fun lt_string_string
  : (string, string) -> bool = "mac#%"
fun lte_string_string
  : (string, string) -> bool = "mac#%"
fun gt_string_string
  : (string, string) -> bool = "mac#%"
fun gte_string_string
  : (string, string) -> bool = "mac#%"
//
fun eq_string_string
  : (string, string) -> bool = "mac#%"
fun neq_string_string
  : (string, string) -> bool = "mac#%"
//
(* ****** ****** *)
//
overload < with lt_string_string of 100
overload <= with lte_string_string of 100
overload > with gt_string_string of 100
overload >= with gte_string_string of 100
//
overload = with eq_string_string of 100
overload != with neq_string_string of 100
overload <> with neq_string_string of 100
//
(* ****** ****** *)
//
fun
compare_string_string:
  (string, string) -> intBtwe(~1, 1) = "mac#%"
//
overload
compare with compare_string_string of 100
//
(* ****** ****** *)
//
fun
string_append
(
  str1: string, str2: string
) : string = "mac#%"
//
overload + with string_append of 100
//
(* ****** ****** *)
//
fun
string_concat_2
(
  x1: string, x2: string
) : string = "mac#%" // end-of-fun
fun
string_concat_3
(
  x1: string, x2: string, x3: string
) : string = "mac#%" // end-of-fun
fun
string_concat_4
(
  x1: string, x2: string, x3: string, x4: string
) : string = "mac#%" // end-of-fun
//
symintr string_concat
//
overload
string_concat with string_concat_2 of 100
overload
string_concat with string_concat_3 of 100
overload
string_concat with string_concat_4 of 100
//
(* ****** ****** *)
//
fun
string_explode(cs: string): List0(strchr) = "mac#%"
//
(* ****** ****** *)

(* end of [string.sats] *)

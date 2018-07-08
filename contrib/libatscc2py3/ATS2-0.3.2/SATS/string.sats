(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
//
(* ****** ****** *)

typedef strchr = string(1)

(* ****** ****** *)
//
fun
strchr_chr : int -> strchr = "mac#%"
//
fun
strchr_ord : strchr -> int = "mac#%"
//
(* ****** ****** *)
//
fun
string_get_at
{n:int}{i:nat | i < n}
(
  str: string(n), i: int(i)
) : strchr = "mac#%" // end-of-fun
//
overload [] with string_get_at of 100
//
(* ****** ****** *)
//
fun
string_fset_at
{n:int}
{i:nat | i < n}
(
  str: string(n), i0: int(i), c0: strchr
) : string(n) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
string_substring_beg_end
{n:int}
{i,j:int |
 0 <= i; i <= j; j <= n}
(
  str: string(n), i0: int(i), j0: int(j)
) : string(j-i) = "mac#%" // end-of-fun
//
//
fun
string_substring_beg_len
{n:int}
{i,len:nat | i + len <= n}
(
  str: string(n), i0: int(i), len: int(len)
) : string(len) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
string_length
  {n:int}(string(n)): int(n) = "mac#%"
//
overload length with string_length of 100
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
string_isalnum : string -> bool = "mac#%"
fun
string_isalpha : string -> bool = "mac#%"
fun
string_isdecimal : string -> bool = "mac#%"
//
(* ****** ****** *)
//
fun string_lower(string): string = "mac#%"
fun string_upper(string): string = "mac#%"
//
(* ****** ****** *)
//`
fun
string_append_2
  (string, string): string = "mac#%"
//
fun
string_append_3
(
  x1: string, x2: string, x3: string
) : string = "mac#%" // end-of-fun
fun
string_append_4
(
  x1: string, x2: string, x3: string, x4: string
) : string = "mac#%" // end-of-fun
//
overload + with string_append_2 of 100
//
overload
string_append with string_append_2 of 100
overload
string_append with string_append_3 of 100
overload
string_append with string_append_4 of 100
//
(* ****** ****** *)

(* end of [string.sats] *)

(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)
//
#staload "./../basics_js.sats"
//
(* ****** ****** *)
//
typedef char = int
typedef strchr = string(1)
//
(* ****** ****** *)
//
fun
strchr_code(strchr): char = "mac#%"
//
(* ****** ****** *)
//
fun
string_get_at
{n:int}
{i:nat | i < n}
(
  str: string(n), i0: int(i)
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
string_charAt{n:int}
  (str: string(n), i: natLt(n)): strchr = "mac#%"
fun
string_charCodeAt{n:int}
  (str: string(n), index: natLt(n)): int = "mac#%"
//
overload .charAt with string_charCodeAt of 100
overload .charCodeAt with string_charCodeAt of 100
//
(* ****** ****** *)
//
fun
string_fromCharCode_1
  (c1: int): string(1) = "mac#%"
fun
string_fromCharCode_2
  (c1: int, c2: int): string(2) = "mac#%"
fun
string_fromCharCode_3
  (c1: int, c2: int, c3: int): string(3) = "mac#%"
fun
string_fromCharCode_4
  (c1: int, c2: int, c3: int, c4: int): string(4) = "mac#%"
fun
string_fromCharCode_5
  (c1: int, c2: int, c3: int, c4: int, c5: int): string(5) = "mac#%"
fun
string_fromCharCode_6
  (c1: int, c2: int, c3: int, c4: int, c5: int, c6: int): string(6) = "mac#%"
//
symintr string_fromCharCode
overload
string_fromCharCode with string_fromCharCode_1
overload
string_fromCharCode with string_fromCharCode_2
overload
string_fromCharCode with string_fromCharCode_3
overload
string_fromCharCode with string_fromCharCode_4
overload
string_fromCharCode with string_fromCharCode_5
overload
string_fromCharCode with string_fromCharCode_6
//
(* ****** ****** *)
//
fun
strstr // libc-function
  (str: string, key: string): int = "mac#%"
fun
string_indexOf_2
  (str: string, key: string): int = "mac#%"
fun
string_indexOf_3
  (str: string, key: string, start: int): int = "mac#%"
//
symintr string_indexOf
//
overload
string_indexOf with string_indexOf_2 of 100
overload
string_indexOf with string_indexOf_3 of 100
//
overload .indexOf with string_indexOf of 100
//
(* ****** ****** *)
//
fun
string_lastIndexOf_2
  (str: string, key: string): int = "mac#%"
fun
string_lastIndexOf_3
  (str: string, key: string, start: int): int = "mac#%"
//
symintr string_lastIndexOf
//
overload
string_lastIndexOf with string_lastIndexOf_2 of 100
overload
string_lastIndexOf with string_lastIndexOf_3 of 100
//
overload .lastIndexOf with string_lastIndexOf of 100
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
  str1: string, str2: string
) : string = "mac#%" // endfun
fun
string_concat_3
(
  str1: string, str2: string, str3: string
) : string = "mac#%" // end-of-fun
//
symintr string_concat
//
overload
string_concat with string_concat_2 of 100
overload
string_concat with string_concat_3 of 100
//
(* ****** ****** *)
//
fun
string_exists_cloref
(
  string, pred: cfun(strchr, bool)
) : bool = "mac#%" // string_exists_cloref
fun
string_exists_method
(
  string)(pred: cfun(strchr, bool)
) : bool = "mac#%" // string_exists_method
//
overload .exists with string_exists_method
//
(* ****** ****** *)
//
fun
string_forall_cloref
(
  string, pred: cfun(strchr, bool)
) : bool = "mac#%" // string_forall_cloref
fun
string_forall_method
(
  string)(pred: cfun(strchr, bool)
) : bool = "mac#%" // string_forall_method
//
overload .forall with string_forall_method
//
(* ****** ****** *)
//
fun
string_foreach_cloref
(
  string, fwork: cfun(strchr, void)
) : void = "mac#%" // string_foreach_cloref
fun
string_foreach_method
(
  string)(fwork: cfun(strchr, void)
) : void = "mac#%" // string_foreach_method
//
overload .foreach with string_foreach_method
//
(* ****** ****** *)
//
fun
string_tabulate_cloref
  {n:nat}
(
n0: int(n), fopr: cfun(natLt(n), charNZ)
) : string(n) = "mac#%" // string_tabulate_cloref
//
(* ****** ****** *)
//
fun
streamize_string_code
  (str0: string): stream_vt(int) = "mac#%"
//
(* ****** ****** *)
//
fun
streamize_string_line
  (inp: string): stream_vt(string) = "mac#%"
//
(* ****** ****** *)

(* end of [string.sats] *)

(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./mybasis.sats"

(* ****** ****** *)

castfn
json_tokener2ptr
  {l:addr} (tok: !json_tokener (l)):<> ptr (l)
overload ptrcast with json_tokener2ptr

(* ****** ****** *)

(*
** HX-2013-07: field-selection
*)
fun
json_tokener_get_char_offset (tok: !json_tokener1):<> int = "mac#%"

(* ****** ****** *)

(*
const char*
json_tokener_error_desc (enum json_tokener_error jerr)
*)
fun json_tokener_error_desc
  (jerr: json_tokener_error): string = "mac#%"
// end of [json_tokener_error_desc]

(* ****** ****** *)

(*
enum
json_tokener_error
json_tokener_get_error (struct json_tokener *tok)
*)
fun json_tokener_get_error
  (tok: !json_tokener1): json_tokener_error = "mac#%"
// end of [json_tokener_get_error]

(* ****** ****** *)

(*
struct json_tokener* json_tokener_new (void)
*)
fun json_tokener_new (): json_tokener0 = "mac#%"
   
(*
struct json_tokener* json_tokener_new_ex (int depth)
*)
fun json_tokener_new_ex (depth: intGte(0)): json_tokener0 = "mac#%"

(* ****** ****** *)

(*
void
json_tokener_free (struct json_tokener *tok)
*)
fun json_tokener_free (tok: json_tokener1): void = "mac#%"

(* ****** ****** *)

(*
void
json_tokener_reset (struct json_tokener *tok)
*)
fun json_tokener_reset (tok: !json_tokener1): void = "mac#%"

(* ****** ****** *)

(*
struct json_object*
json_tokener_parse (const char *str)
*)
fun json_tokener_parse (str: string): json_object0 = "mac#%"

(*
struct json_object*
json_tokener_parse_verbose
  (const char *str, enum json_tokener_error *error)
*)
fun json_tokener_parse_verbose
  (str: string, error: &json_tokener_error): json_object0 = "mac#%"

(* ****** ****** *)
(*
** HX-2013-07: this one is in extension
*)
fun{
} json_tokener_parse$skip {n:int} (string n): natLte (n)
fun{
} json_tokener_parse_list (inp: string): List0_vt (json_object0)
fun{
} json_tokener_parse_list_delim (inp: string, delim: string): List0_vt (json_object0)
//
(* ****** ****** *)

(*
struct json_object*
json_tokener_parse_ex (struct json_tokener *tok, const char *str, int len)
*)
fun json_tokener_parse_ex
  (tok: !json_tokener1, str: string, len: intGte(0)): json_object0 = "mac#%"
// end of [json_tokener_parse_ex]

(* ****** ****** *)

(*
void json_tokener_set_flags (struct json_tokener *tok, int flags)
*)
fun json_tokener_set_flags (tok: !json_tokener1, flags: int): void = "mac#%"

(* ****** ****** *)

(* end of [json_tokener.sats] *)

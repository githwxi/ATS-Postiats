(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./mybasis.sats"

(* ****** ****** *)

castfn
json_object2ptr
  {l:addr} (al: !json_object (l)):<> ptr (l)
overload ptrcast with json_object2ptr

(* ****** ****** *)

fun{}
json_object_is_null
  {l:addr} (al: !json_object (l)):<> bool (l==null)
overload iseqz with json_object_is_null
fun{}
json_object_isnot_null
  {l:addr} (al: !json_object (l)):<> bool (l > null)
overload isneqz with json_object_isnot_null

(* ****** ****** *)

(*
const char* json_hex_chars
*)
macdef json_hex_chars = $extval (string, "atscntrb_json_hex_chars")
(*
const char* json_number_chars
*)
macdef json_number_chars = $extval (string, "atscntrb_json_number_chars")

(* ****** ****** *)

fun json_object_get{l:addr}
  (jso: !json_object(l)): json_object(l) = "mac#%"

(* ****** ****** *)

fun json_object_put (jso: json_object0): int = "mac#%"

(* ****** ****** *)

fun json_object_is_type
  (jso: !json_object0, type: json_type):<> int = "mac#%"

(* ****** ****** *)

fun json_object_get_type
  (jso: !json_object0):<> json_type = "mac#%"

(* ****** ****** *)

(*
#define JSON_C_TO_STRING_PLAIN 0
#define JSON_C_TO_STRING_SPACED (1<<0)
#define JSON_C_TO_STRING_PRETTY (1<<1)
#define JSON_C_TO_STRING_NOZERO (1<<2))
*)

macdef
JSON_C_TO_STRING_PLAIN = $extval (int, "JSON_C_TO_STRING_PLAIN")
macdef
JSON_C_TO_STRING_SPACED = $extval (int, "JSON_C_TO_STRING_SPACED")
macdef
JSON_C_TO_STRING_PRETTY = $extval (int, "JSON_C_TO_STRING_PRETTY")
macdef
JSON_C_TO_STRING_NOZERO = $extval (int, "JSON_C_TO_STRING_NOZERO")

(* ****** ****** *)

fun json_object_to_json_string
  (jso: !json_object0): vStrptr1 = "mac#%"
fun json_object_to_json_string_ext
  (jso: !json_object0, flags: int): vStrptr1 = "mac#%"

(* ****** ****** *)
//
// HX-2013-05: for convenience
//
fun{
} print_json_object (jso: !json_object0): void
fun{
} print_json_object_ext (jso: !json_object0, flags: int): void
overload print with print_json_object
overload print with print_json_object_ext
//
fun{
} prerr_json_object (jso: !json_object0): void
fun{
} prerr_json_object_ext (jso: !json_object0, flags: int): void
overload prerr with prerr_json_object
overload prerr with prerr_json_object_ext
//
fun{
} fprint_json_object
  (out: FILEref, jso: !json_object0): void
fun{
} fprint_json_object_ext
  (out: FILEref, jso: !json_object0, flags: int): void
//
overload fprint with fprint_json_object
overload fprint with fprint_json_object_ext
//
(* ****** ****** *)

(*
void json_object_set_serializer
(
  json_object *jso
, json_object_to_json_string_fn to_string_func
, void *userdata
, json_object_delete_fn *user_delete
) ; // end of [json_object_set_serializer]
*)

(* ****** ****** *)
//
// HX: for json-object-boolean
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_boolean (json_bool b)
*)
fun json_object_new_boolean (b: json_bool): json_object0 = "mac#%"

(*
json_bool
json_object_get_boolean (struct json_object *obj)
*)
fun json_object_get_boolean (obj: !json_object1): json_bool = "mac#%"

(* ****** ****** *)
//
// HX: for json-object-int32
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_int (int32_t i)
*)
fun json_object_new_int (i: int32): json_object0 = "mac#%"

(*
int32_t
json_object_get_int (struct json_object *obj)
*)
fun json_object_get_int (obj: !json_object1): int32 = "mac#%"

(* ****** ****** *)
//
// HX: for json-object-int64
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_int64 (int64_t i)
*)
fun json_object_new_int64 (i: int64): json_object0 = "mac#%"
    
(*     
int64_t
json_object_get_int64 (struct json_object *obj)
*)
fun json_object_get_int64 (obj: !json_object1): int64 = "mac#%"

(* ****** ****** *)
//
// HX: for json-object-double
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_double (double d)
*)
fun json_object_new_double (d: double): json_object0 = "mac#%"

(*
double
json_object_get_double (struct json_object *obj)
*)
fun json_object_get_double (obj: !json_object1): double = "mac#%"

(* ****** ****** *)
//
// HX: for json-object-string
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_string (const char *s)
*)
fun json_object_new_string (s: string): json_object0 = "mac#%"

(*
struct json_object*
json_object_new_string_len (const char *s, int len)
*)
fun json_object_new_string_len (s: string, len: intGte(0)): json_object0 = "mac#%"

(* ****** ****** *)

(*
const char*
json_object_get_string (struct json_object *obj)
*)
fun json_object_get_string (jso: !json_object1): vStrptr1 = "mac#%"

(*
int
json_object_get_string_len (struct json_object *obj)
*)
fun json_object_get_string_len (jso: !json_object1): intGte(0) = "mac#%"

(* ****** ****** *)
//
// HX: for json-object-array
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_array (void)
*)
fun json_object_new_array (): json_object0 = "mac#%"

(* ****** ****** *)

(*
struct array_list*
json_object_get_array (struct json_object *obj)
*)
fun json_object_get_array
  {l:agz} (jso: !json_object(l))
  : [l2:agez] vtget0 (json_object(l), array_list(l2)) = "mac#%"
// end of [json_object_get_array]

(* ****** ****** *)

(*
int json_object_array_length (struct json_object *obj)
*)
fun json_object_array_length (jso: !json_object1): intGte(0) = "mac#%"

(* ****** ****** *)

(*
int json_object_array_add
  (struct json_object *obj, struct json_object *val)
*)
fun json_object_array_add
  (jso: !json_object1, _val: json_object0): int = "mac#%"
fun json_object_array_add2
  (jso: !json_object1, _val: json_object0): int = "mac#%"

(* ****** ****** *)

(*
struct json_object*
json_object_array_get_idx (struct json_object *obj, int idx)
*)
fun
json_object_array_get_idx{l:agz}
(
  jso: !json_object(l), idx: intGte(0)
) : [l2:agez] vtget0 (json_object(l), json_object(l2)) = "mac#%"
// end of [json_object_array_get_idx]

(* ****** ****** *)

(*
int json_object_array_put_idx
  (struct json_object *obj, int idx, struct json_object *val)
*)
fun
json_object_array_put_idx
  {l:agz;l2:addr} (
  jso: !json_object(l), idx: intGte(0)
, _val: !json_object(l2) >> opt (json_object(l2), i < 0)
) : #[i:int | i <= 0] int (i) = "mac#%"
fun json_object_array_put2_idx
  (jso: !json_object1, idx: intGte(0), _val: json_object0): int = "mac#%"

(* ****** ****** *)

(*
void json_object_array_sort
(
  struct json_object *jso, int(*cmp)(const void*, const void*)
) ; // end of [json_object_array_sort]
*)
fun json_object_array_sort
(
  jso: !json_object1, cmp: (json_object0, json_object0) -> int
) : void = "mac#%" // end of [json_object_array_sort]

(* ****** ****** *)
//
// HX: for json-object-object
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_object (void)
*)
fun json_object_new_object (): json_object0 = "mac#%"

(* ****** ****** *)

(*
struct lh_table*
json_object_get_object(struct json_object *obj);
*)
fun
json_object_get_object
  {l:agz} (jso: !json_object(l))
  : [l2:agez] vtget0 (json_object(l), lh_table(l2)) = "mac#%"
// end of [json_object_get_object]

(* ****** ****** *)

(*
int json_object_object_length(struct json_object *jso)
*)
fun jsob_object_object_length (jso: !json_object1): intGte(0) = "mac#%"

(* ****** ****** *)

(*
void
json_object_object_add
(
  struct json_object* jso, const char *key, struct json_object *val
)
*)
fun json_object_object_add
(
  jso: !json_object1, key: string, jso_val: json_object0(*consumed*)
) : void = "mac#%" // end of [json_object_object_add]

(* ****** ****** *)

(*
void
json_object_object_del (struct json_object *jso, const char *key)     
*)
fun json_object_object_del (jso: !json_object1, key: string): void = "mac#%"

(* ****** ****** *)

(*
struct json_object*
json_object_object_get(struct json_object* obj, const char *key);
*)
fun
json_object_object_get{l:agz}
(
  jso: !json_object(l), key: string
) : [l2:agez] vtget0 (json_object(l), json_object(l2)) = "mac#%"
// end of [json_object_object_get]

(* ****** ****** *)

fun{env:vt0p}
json_object_iforeach$cont
  (i: int, v: !json_object0, env: &env): bool
fun{env:vt0p}
json_object_iforeach$fwork
  (i: int, v: !json_object0, env: &env >> _): void
fun{}
json_object_iforeach (jso: !json_object1): void
fun{env:vt0p}
json_object_iforeach_env (jso: !json_object1, env: &env >> _): void

(* ****** ****** *)

fun{env:vt0p}
json_object_kforeach$cont
  (k: !Strptr1, v: !json_object0, env: &env): bool
fun{env:vt0p}
json_object_kforeach$fwork
  (k: !Strptr1, v: !json_object0, env: &env >> _): void
fun{}
json_object_kforeach (jso: !json_object1): void
fun{env:vt0p}
json_object_kforeach_env (jso: !json_object1, env: &env >> _): void

(* ****** ****** *)

(* end of [json_object.sats] *)

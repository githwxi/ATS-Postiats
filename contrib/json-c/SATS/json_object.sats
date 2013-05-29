(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./json_header.sats"

(* ****** ****** *)

castfn
json_object2ptr
  {l:addr} (al: !json_object (l)):<> ptr (l)
overload ptrcast with json_object2ptr

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

fun json_object_new (): json_object0 = "mac#%"

(* ****** ****** *)

fun json_object_get{l:addr}
  (jso: !json_object (l)): json_object (l) = "mac#%"

(* ****** ****** *)

fun json_object_put (jso: json_object0): int = "mac#%"

(* ****** ****** *)

fun json_object_is_type
  (jso: !json_object0, type: json_type):<> int = "mac#%"

(* ****** ****** *)

fun json_object_get_type
  (jso: !json_object0):<> json_type = "mac#%"

(* ****** ****** *)

fun json_object_to_json_string
  (jso: !json_object0): vStrptr1 = "mac#%"
fun json_object_to_json_string_ext
  (jso: !json_object0, flags: int): vStrptr1 = "mac#%"

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
// HX: for json-object-string
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_string (const char *s)
*)
fun json_object_new_string (s: string): json_object0

(*
struct json_object*
json_object_new_string_len (const char *s, int len)
*)
fun json_object_new_string_len (s: string, len: intGte(0)): json_object0

(* ****** ****** *)

(*
const char*
json_object_get_string (struct json_object *obj)
*)
fun json_object_get_string (jso: !json_object1): vStrptr1

(*
int
json_object_get_string_len (struct json_object *obj)
*)
fun json_object_get_string_len (jso: !json_object1): intGte(0)

(* ****** ****** *)
//
// HX: for json-object-object
//
(* ****** ****** *)

(*
struct json_object*
json_object_new_object (void)
*)
fun json_object_new_object (): json_object0

(* ****** ****** *)

(*
struct lh_table* json_object_get_object(struct json_object *obj);
*)
fun json_object_get_object
  {l:addr} (jso: !json_object(l)): [l2:addr] vttakeout (json_object l, lh_table l2) = "mac#%"
// end of [json_object_get_object]

(* ****** ****** *)

(*
int json_object_object_length(struct json_object *jso)
*)
fun jsob_object_object_length (jso: !json_object1): intGte(0) = "mac#%"

(* ****** ****** *)

(*
void json_object_object_add
  (struct json_object* jso, const char *key, struct json_object *val)
*)
fun json_object_object_add
(
  jso: !json_object1, key: string, _val: json_object0(*consumed*)
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
fun json_object_object_get{l:addr}
  (jso: !json_object l, key: string): [l2:addr] vttakeout (json_object l, json_object l2) 
// end of [json_object_object_get]

(* ****** ****** *)

(* end of [json_object.sats] *)

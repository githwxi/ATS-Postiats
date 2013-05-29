(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./json_header.sats"

(* ****** ****** *)

castfn
json_object2ptr {l:addr} (al: !json_object (l)):<> ptr (l)
overload ptrcast with json_object2ptr

(* ****** ****** *)

fun json_object_new (): json_object0 = "mac#%"

(* ****** ****** *)

fun json_object_get{l:addr}
  (jso: !json_object (l)): json_object (l) = "mac#%"

(* ****** ****** *)

fun json_object_put (jso: json_object0): int = "mac#%"

(* ****** ****** *)

fun json_object_get_type
  (jso: !json_object0):<> json_type = "mac#%"
fun json_object_is_type
  (jso: !json_object0, type: json_type):<> int = "mac#%"

(* ****** ****** *)

fun json_object_to_json_string
  (jso: !json_object0): Strptr1 = "mac#%"
fun json_object_to_json_string_ext
  (jso: !json_object0, flags: int): Strptr1 = "mac#%"

(* ****** ****** *)

(* end of [json_object.sats] *)

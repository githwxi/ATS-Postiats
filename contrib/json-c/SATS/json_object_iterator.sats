(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./json_header.sats"

(* ****** ****** *)
//
// HX: not sure about this one
//
(*
struct json_object_iterator
json_object_iter_init_default (void)
*)

(* ****** ****** *)
//
// HX-2013-05: I added this one
//
fun json_object_iter_clear{l:addr}
  (iter: &json_object_iterator(l) >> json_object_iterator?): void = "mac#%"
// end of [json_object_iter_clear]

(* ****** ****** *)

(*
struct json_object_iterator
json_object_iter_begin (struct json_object *obj)
*)
fun json_object_iter_begin
  {l:agz} (jso: !json_object(l)): json_object_iterator(l) = "mac#%"
// end of [json_object_iter_begin]

(*
struct json_object_iterator
json_object_iter_end (const struct json_object *obj)
*)
fun json_object_iter_end
  {l:agz} (jso: !json_object(l)): json_object_iterator(l) = "mac#%"
// end of [json_object_iter_end]

(*
void
json_object_iter_next (struct json_object_iterator *iter)
*)
fun json_object_iter_next
  {l:addr} (jso: &json_object_iterator(l)): void = "mac#%"

(*
const char*
json_object_iter_peek_name (const struct json_object_iterator *iter)
*)
fun json_object_iter_peek_name
  {l:addr} (jso: &json_object_iterator(l)): string = "mac#%"

(*
struct json_object*
json_object_iter_peek_value (const struct json_object_iterator *iter)
*)
fun json_object_iter_peek_value{l:agz}
  (jso: &json_object_iterator(l)): [l2:addr] vttakeout0 (json_object(l2)) = "mac#%"
// end of [json_object_iter_peek_value]

(*
json_bool
json_object_iter_equal
(
  const struct json_object_iterator *iter1
, const struct json_object_iterator *iter2
) ; // end of [json_object_iter_equal]
*)
fun json_object_iter_equal{l:addr}
(
  iter1: &json_object_iterator(l), iter2: &json_object_iterator(l)
) : json_bool = "mac#%" // end of [json_object_iter_equal]
       
(* ****** ****** *)

(* end of [json_object_iterator.sats] *)

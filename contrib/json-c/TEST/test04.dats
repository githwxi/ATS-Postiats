(*
** Some testing code for [json]
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT edu
** Time: May, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/json.sats"
staload _(*anon*) = "./../DATS/json.dats"

(* ****** ****** *)

implement
main0 () =
{
//
val arr = json_object_new_array ()
val () = assertloc (ptrcast(arr) > 0)
//
val jso1 = json_object_new_string ("Zoe")
val jso2 = json_object_new_string ("Chloe")
//
val () = assertloc (json_object_array_add2 (arr, jso1) = 0)
val () = assertloc (json_object_array_add2 (arr, jso2) = 0)
//
val () = println! ("stringOf(arr) = ", arr)
//
val freed = json_object_put (arr)
//
val obj =json_object_new_object ()
val () = assertloc (ptrcast(obj) > 0)
//
val jso1 = json_object_new_string ("Zoe")
val jso2 = json_object_new_string ("Chloe")
val () = json_object_object_add (obj, "girl1", jso1)
val () = json_object_object_add (obj, "girl2", jso2)
//
val () = println! ("stringOf(obj) = ", obj)
//
var jsi: json_object_iterator?
var jsiEnd: json_object_iterator?
val () = jsi := json_object_iter_begin (obj)
val () = jsiEnd := json_object_iter_end (obj)
//
val () = println! ("[jsi] and [jsiEnd] are initialized.")
//
val x = json_object_iter_peek_name (jsi)
val () = println! ("json_object_iter_peek_name")
val () = println! ("name1 = ", x.1)
prval () = x.0 (x.1)
//
val (fpf | value1) = json_object_iter_peek_value (jsi)
val () = println! ("stringOf(value1) = ", value1)
prval () = fpf (value1)
//
val () = json_object_iter_next (jsi)
//
val x = json_object_iter_peek_name (jsi)
val () = println! ("name2 = ", x.1)
prval () = x.0 (x.1)
//
val (fpf | value2) = json_object_iter_peek_value (jsi)
val () = println! ("stringOf(value2) = ", value2)
prval () = fpf (value2)
//
val () = json_object_iter_next (jsi)
//
val () = assertloc (json_object_iter_equal (jsi, jsiEnd))
val () = json_object_iter_clear (obj, jsi)
val () = json_object_iter_clear (obj, jsiEnd)
//
val freed = json_object_put (obj)
//
} // end of [main]

(* ****** ****** *)

(* end of [test04.dats] *)

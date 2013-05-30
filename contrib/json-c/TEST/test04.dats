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

%{^
#include "json-c/CATS/json.cats"
%}

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "json-c/SATS/json.sats"

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
val
(
fpf | str
) = json_object_to_json_string (arr)
val () = println! ("stringOf(arr) = ", str)
prval () = fpf (str)
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
val
(
fpf | str
) = json_object_to_json_string (obj)
val () = println! ("stringOf(obj) = ", str)
prval () = fpf (str)
//
var jsi: json_object_iterator?
var jsiEnd: json_object_iterator?
val () = jsi := json_object_iter_begin (obj)
val () = jsiEnd := json_object_iter_end (obj)
//
val name1 = json_object_iter_peek_name (jsi)
val () = println! ("name1 = ", name1)
val () = json_object_iter_next (jsi)
//
val name2 = json_object_iter_peek_name (jsi)
val () = println! ("name2 = ", name2)
val () = json_object_iter_next (jsi)
//
val () = assertloc (json_object_iter_equal (jsi, jsiEnd) = json_true)
val () = json_object_iter_clear (jsi)
val () = json_object_iter_clear (jsiEnd)
//
val freed = json_object_put (obj)
//
} // end of [main]

(* ****** ****** *)

(* end of [test04.dats] *)

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
staload _(*anon*) = "json-c/DATS/json.dats"

(* ****** ****** *)

fun foo{l:agz}
  (jso: !json_object(l)): void =
{
//
vtypedef
iter = json_object_iterator(l)
//
var it: iter = json_object_iter_begin(jso);
var itEnd: iter = json_object_iter_end(jso);
//
val () =
while (it != itEnd)
{
  val
  (
    fpf | name
  ) = json_object_iter_peek_name (it)
  val () = println! ("name = ", name)
  prval () = fpf (name)
  val
  (
    fpf | value
  ) = json_object_iter_peek_value (it)
  val () = println! ("value = ", value)
  prval () = fpf (value)
  val () = json_object_iter_next (it)
}
//
val () = json_object_iter_clear (jso, it)
val () = json_object_iter_clear (jso, itEnd)
//
} (* end of [foo] *)

implement
main0 () =
{
//
val out = stdout_ref
//
val jso1 = json_tokener_parse ("{'relation':'daughter', 'name':'Zoe', 'age':8}")
val () = assertloc (ptrcast (jso1) > 0)
val () = fprintln! (out, "jso1 = ", jso1)
val jso2 = json_tokener_parse ("{'relation':'daughter', 'name':'Chloe', 'age':0}")
val () = assertloc (ptrcast (jso2) > 0)
val () = fprintln! (out, "jso2 = ", jso2)
//
val () = foo (jso1)
val () = foo (jso2)
//
val () = assertloc (json_object_put (jso1) > 0)
val () = assertloc (json_object_put (jso2) > 0)
//
} // end of [main]

(* ****** ****** *)

(* end of [test05.dats] *)

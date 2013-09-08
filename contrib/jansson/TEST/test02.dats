(*
** Some testing code for [jansson]
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: September, 2012
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

staload "./../SATS/jansson.sats"

(* ****** ****** *)

#define isnz JSONptr_isnot_null

(* ****** ****** *)

implement
main0 () = let
//
  val a =
    json_string("this is a string")
  val () = assertloc(isnz(a))
  val () = assertloc(json_is_string(a))
//
  val (
    fpf | s
  ) = json_string_value(a)
  val s2 = string0_copy ($UN.strptr2string(s))
  prval () = minus_addback (fpf, s | a)
//
  val err =
    json_string_set(a, $UN.strptr2string(s2))
  val () = print_string("Value is: ")
  val () = print_string($UN.strptr2string(s2))
  val () = print_newline()
  val () = strptr_free (s2)
  val () = json_decref(a)
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)

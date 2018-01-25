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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/jansson.sats"

(* ****** ****** *)

implement
main0 () =
{
//
var err: json_err? 
val out = stdout_ref
//
val rt = json_loads ("{\"one\":1}", 0, err)
val () = assertloc (JSONptr_isnot_null (rt))
//
val (fpf | one) = json_object_get_exnloc (rt, "one")
val ji = json_integer_value (one)
val () = println! ("int = ", $UN.cast2int(ji))
prval () = minus_addback (fpf, one | rt) 
//
val err = json_dumpf (rt, out, 0)
val ((*void*)) = json_decref (rt)
val ((*void*)) = fprint_newline (out)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

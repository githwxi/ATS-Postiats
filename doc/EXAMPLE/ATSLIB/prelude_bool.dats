(*
** for testing [prelude/bool]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () = {
//
  val () = assertloc (true && true)
  val () = assertloc (not(true && false))
  val () = assertloc (not(false && true))
  val () = assertloc (not(false && false))
//
  val () = assertloc (true || true)
  val () = assertloc (true || false)
  val () = assertloc (false || true)
  val () = assertloc (not(false || false))
//
  val () = assertloc (true + true)
  val () = assertloc (true + false)
  val () = assertloc (false + true)
  val () = assertloc (false + false = false)
//
  val () = assertloc (true * true)
  val () = assertloc (true * false = false)
  val () = assertloc (false * true = false)
  val () = assertloc (false * false = false)
//
  val () = assertloc (false < true)
  val () = assertloc (false <= true)
  val () = assertloc (true > false)
  val () = assertloc (true >= false)
//
  val () = assertloc (true = true)
  val () = assertloc (true != false)
  val () = assertloc (false != true)
  val () = assertloc (false = false)
//
  val () = assertloc (compare (true, true) = 0)
  val () = assertloc (compare (false, false) = 0)
  val () = assertloc (compare (true, false) = 1)
  val () = assertloc (compare (false, true) = ~1)
//
  val () = assertloc (int2bool1 (1) = true)
  val () = assertloc (int2bool1 (~1) = true)
  val () = assertloc (int2bool1 (0) = false)
//
  val () = assertloc (bool2int1 (true) = 1)
  val () = assertloc (bool2int1 (false) = 0)
//
} // end of [val]

(* ****** ****** *)

val () = {
  val out = stdout_ref
  val () = fprint (out, true)
  val () = fprint_newline (out)
  val () = fprint (out, false)
  val () = fprint_newline (out)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_bool.dats] *)

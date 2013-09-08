(*
** for testing [prelude/char]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () =
{
//
//
implement
gprint$out<> () = stdout_ref
//
val () = gprint_int (0)
val () = gprint_string (", ")
val () = gprint_int (1)
val () = gprint_string (", ")
val () = gprint_int (2)
val () = gprint_string (", ")
val () = gprint_int (3)
val () = gprint_newline ()
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
implement
gprint$out<> () = stderr_ref
//
val () = gprint_int (0)
val () = gprint_string (", ")
val () = gprint_int (1)
val () = gprint_string (", ")
val () = gprint_int (2)
val () = gprint_string (", ")
val () = gprint_int (3)
val () = gprint_newline ()
//
} // end of [val]

(* ****** ****** *)

val () = let
//
fun fpr
(
  out: FILEref, x: int
) : void = let
//
implement
gprint$out<> () = out
//
in
//
gprint_string ("("); gprint_int (x); gprint_string (")")
//
end // end of [fpr]
//
val out = stderr_ref
//
in
  fpr(out, 0); fpr(out, 1); fpr(out, 2); fpr(out, 3); fprint_newline (out)
end // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_gprint.dats] *)

(*
** testing code for GNU-readline
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

staload "./../SATS/history.sats"
staload "./../SATS/readline.sats"

(* ****** ****** *)

implement
main0 () = () where
{
//
val v_str = rl_library_version ()
val v_int = rl_readline_version ()
//
val () = println! ("v_str = ", v_str)
val () = println! ("v_int = ", v_int)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test00.dats] *)

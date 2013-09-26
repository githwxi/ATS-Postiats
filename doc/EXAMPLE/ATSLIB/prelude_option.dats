(*
** for testing [prelude/option]
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
val out = stdout_ref
//
val opt = None{int}()
val+None _ = opt
val () = fprintln! (out, "opt = ", opt)
//
val opt = Some{int}(0)
val () = fprintln! (out, "opt = ", opt)
val+Some x = opt
val () = assertloc (x = 0)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_option.dats] *)

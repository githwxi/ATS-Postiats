(*
** for testing [prelude/option]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

val () =
{
val+None _ = None{int}()
//
val opt = Some{int}(0)
val+Some x = opt
val () = assertloc (x = 0)
//
val out = stdout_ref
val () = fprintln! (out, "opt = ", opt)
//
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_option.dats] *)

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
val+None _ = None{int}( )
//
val x0 = 0
val+Some x = Some{int}(x0)
val () = assertloc (x = x0)
//
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_option.dats] *)

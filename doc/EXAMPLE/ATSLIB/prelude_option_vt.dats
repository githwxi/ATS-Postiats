(*
** for testing [prelude/option_vt]
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
val opt = None_vt{int}()
val () = fprintln! (out, "opt = ", opt)
val+~None_vt _ = opt
//
val opt = Some_vt{int}(0)
val () = fprintln! (out, "opt = ", opt)
val+~Some_vt x = opt
val () = assertloc (x = 0)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_option_vt.dats] *)

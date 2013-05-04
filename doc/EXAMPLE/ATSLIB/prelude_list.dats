(*
** for testing [prelude/list]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

val () =
{
val x0 = 0
val x1 = 1
val xs = list_nil{int}()
val xs = list_cons{int}(x0, list_cons{int}(x1, xs))
val-list_cons (x, xs) = xs
val () = assertloc (x = x0)
val-list_cons (x, xs) = xs
val () = assertloc (x = x1)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_list.dats] *)

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
val xs = nil{int}()
val xs = cons{int}(x0, cons{int}(x1, xs))
val+cons (x, xs) = xs
val () = assertloc (x = x0)
val+cons (x, xs) = xs
val () = assertloc (x = x1)
val+nil () = xs
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val out = stdout_ref
val digits = list_make_intrange (0, 10)
val () = fprint (out, "digits = ")
val () = fprint_list<int> (out, list_vt2t (digits))
val () = fprint_newline (out)
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_list.dats] *)

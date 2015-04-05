(*
** for testing [prelude/tostring]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val xs =
$list{int}(0,1,2,3,4,5,6,7,8,9)
val () = println! ("xs = ", tostring_val<List(int)>(xs))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_tostring.dats] *)

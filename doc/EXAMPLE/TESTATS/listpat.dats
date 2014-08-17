//
// Test list-patterns
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val xs = '[1,2,3]
val+$list(x1,x2,x3) = xs: list(int, 3)
val () = assertloc (length (xs) = 3)
val () = assertloc (x1 = 1 && x2 = 2 && x3 = 3)

(* ****** ****** *)

#define :: list_cons

(* ****** ****** *)

val xs = 1 :: 2 :: 3 :: nil()
val+$list_t(x1,x2,x3) = xs: list(int, 3)
val () = assertloc (length (xs) = 3)
val () = assertloc (x1 = 1 && x2 = 2 && x3 = 3)

(* ****** ****** *)

val+$list_t(x1,x2,x3) = $list_t{int}(1,2,3)
val () = assertloc (x1 = 1 && x2 = 2 && x3 = 3)

(* ****** ****** *)

val+$list_vt(x1,x2,x3) = $list_vt{int}(1,2,3)
val () = assertloc (x1 = 1 && x2 = 2 && x3 = 3)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [listpat.dats] *)

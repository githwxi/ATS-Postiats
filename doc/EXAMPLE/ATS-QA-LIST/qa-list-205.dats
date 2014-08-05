(* ****** ****** *)
//
// HX-2014-02-21
//
(* ****** ****** *)
//
// showtype and showview
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
// #define NDEBUG
//
(* ****** ****** *)

#ifdef
NDEBUG
//
macdef showtype (x) = ,(x)
macdef showview (x) = ()
macdef showviewtype (x) = ()
//
#endif // end of [#ifdef]

(* ****** ****** *)

implement
main0 () =
{
//
val x: int = 1
val y: int = 2
val z = showtype (x+y)
//
var u: int = 0
prval () = showview (view@u)
val () = u := z + 1
prval () = showview (view@u)
//
val () = println! ("z = ", z)
val () = println! ("u = ", u)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-205.dats] *)

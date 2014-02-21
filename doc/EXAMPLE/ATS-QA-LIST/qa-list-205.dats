(* ****** ****** *)
//
// HX-2014-02-21
//
(* ****** ****** *)
//
// showtype and showlvaltype
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
// #define NDEBUG // uncomment to stop showtype-messages
//
(* ****** ****** *)

(*
//
// Following is declared in [prelude/macrodef.sats]
//
macdef showtype (x) = $showtype ,(x)
macdef showlvaltype (x) = pridentity ($showtype ,(x))
*)

(* ****** ****** *)

#ifdef NDEBUG
macdef showtype (x) = ,(x)
macdef showlvaltype (x) = ()
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
prval _ = showlvaltype (view@u)
val () = u := z + 1
prval _ = showlvaltype (view@u)
//
val () = println! ("z = ", z)
val () = println! ("u = ", u)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-205.dats] *)

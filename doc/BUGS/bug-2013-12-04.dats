(*
** Source: reported by Will Blair
*)

(* ****** ****** *)

(*
** Status: Fixed by HX-2013-12-04
*)

(* ****** ****** *)

(* 
**
** Symptom:
** Erroneous pattern matching compilation
** 
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef int2 = (int, int)

(* ****** ****** *)

fun foo
  (xxs: List (int2)): int =
(
case+ xxs of
| list_nil () => (0)
//
// HX: x1 and x2
// are not properly initialized
//
| list_cons (xx as (x1, x2), _) => x1 + x2
)

(* ****** ****** *)

implement
main0 () = () where
{
//
val xxs = $list{int2}(@(10, 10))
//
val () = println! ("foo(xxs) = ", foo(xxs))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bug-2013-12-04.dats] *)

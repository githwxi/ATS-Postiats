(* ****** ****** *)
//
// HX-2014-08-16
//
// Support for explicit packaging
//
(* ****** ****** *)

typedef intx = [x:int] int (x)
typedef intxx = [x:int] int (x*x)

(* ****** ****** *)

extern fun foo : intx -> void
extern fun foo2 : intxx -> void

(* ****** ****** *)

val () = foo (1)
val () = foo2 (#[0 | 0])
val () = foo2 (#[1 | 1])
val () = foo2 (#[~1 | 1])

(* ****** ****** *)
//
implement main () = 0
//
(* ****** ****** *)

(* end of [qa-list-334.dats] *)

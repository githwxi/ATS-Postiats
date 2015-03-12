(* ****** ****** *)
//
// For use in INT2PROGINATS
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun{a:t@ype} myprint (x: a): void
//
(* ****** ****** *)

implement{a} myprint (x) = print_string "?"
implement(a) myprint<a> (x) = print_string "?"

(* ****** ****** *)

implement myprint<int> (x) = print_int (x)

(* ****** ****** *)
//
implement(a)
myprint<List(a)> (xs) =
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
    (myprint<a> (x); myprint<List(a)> (xs))
//
(* ****** ****** *)
//
val xs =
$list{int}(0,1,2,3,4,5,6,7,8,9)
//
val () = myprint<List(int)>(xs)
val () = print_newline((*void*))
//
(* ****** ****** *)

val ys = $list{int}(0,1,2,3,4)
val yss = $list{List(int)}(ys, ys)
val ((*void*)) = myprint<List(List(int))> (yss)
val ((*void*)) = print_newline((*void*))

(* ****** ****** *)

extern
fun{a:t@ype} myprint2 (x: a): int

(* ****** ****** *)
//
(*
implement(a)
myprint2<List(a)> (xs) =
case+ xs of
| list_nil () => 0
| list_cons (x, xs) =>
    (myprint<a> (x); 1 + myprint2(xs))
*)
//
(* ****** ****** *)
//
implement(a)
myprint2<List(a)> (xs) =
case+ xs of
| list_nil () => 0
| list_cons (x, xs) =>
    (myprint<a> (x); 1 + myprint2<List(a)> (xs))
//
(* ****** ****** *)
//
(*
implement(a)
myprint2<List(a)>
  (xs) = let
//
fun
aux
(xs: List(a)): int =
//
case+ xs of
| list_nil () => 0
| list_cons (x, xs) => (myprint<a>(x); 1 + aux(xs))
//
in
  aux (xs)
end // end of [myprint2<List(a)>]
*)
//
(* ****** ****** *)
//
val xs =
$list{int}(0,1,2,3,4,5,6,7,8,9)
//
val n0 = myprint2<List(int)>(xs)
val () = print_newline((*void*))
val () = println! ("length(xs) = ", n0)
//
(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

(* end of [myprint.dats] *)

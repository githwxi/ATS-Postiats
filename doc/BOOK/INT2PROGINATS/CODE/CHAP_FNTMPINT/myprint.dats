(* ****** ****** *)
//
// For use in INT2PROGINATS
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
| list_cons (x, xs) => (myprint<a> (x); myprint<List(a)> (xs))
//
(* ****** ****** *)

(*
fun
myprint_List_int (xs: List(int)): void = myprint<List(int)> (xs)
*)

(* ****** ****** *)
//
val xs =
$list{int}(0,1,2,3,4,5,6,7,8,9)
//
val ((*void*)) = myprint<List(int)>(xs)
val ((*void*)) = print_newline((*void*))
//
(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

(* end of [myprint.dats] *)

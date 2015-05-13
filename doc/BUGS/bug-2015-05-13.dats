(*
** Bug causing erroneous
** compilation of template instances
*)

(* ****** ****** *)

(*
** Source:
** Reported by aren-2015-05-13
*)

(* ****** ****** *)

typedef path = List (int)
typedef pathlst = List (path)

(* ****** ****** *)
//
(*
implement
{a}(*tmp*)
print_list
  (xs) = println! ("print_list<a>")
*)
//
staload _ = "./bug-2015-05-13-2.dats"
//
implement
print_list<path>
  (xs) = println! ("print_list<path>")
//
(* ****** ****** *)

implement
main0 () =
{
//
val xs = list_cons{int}(100, list_nil)
val xss = list_cons{path}(xs, list_nil)
//
val () = print_list<int> (xs)
val () = print_list<path> (xss)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bug-2015-05-13.dats] *)

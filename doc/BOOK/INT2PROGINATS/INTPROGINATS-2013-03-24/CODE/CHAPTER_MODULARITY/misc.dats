(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

(*
fun fact (x: int): int =
  if x > 0 then x * fact (x-1) else 1
*)

(*
extern fun fact (x: int): int
implement fact (x) = if x > 0 then x * fact (x-1) else 1
*)

extern val fact: (int) -> int
implement fact (x) = if x > 0 then x * fact (x-1) else 1

(* ****** ****** *)

extern fun{a:t@ype}{b:t@ype}
list0_fold_left (f: (a, b) -<cloref1> a, init: a, xs: list0 b): a

implement{a}{b}
list0_fold_left (f, init, xs) = let
  fun loop (init: a, xs: list0 b):<cloref1> a =
    case+ xs of
    | list0_cons (x, xs) => loop (f (init, x), xs)
    | list0_nil () => init
  // end of [loop]
in
  loop (init, xs)
end // end of [list0_fold_left]

(* ****** ****** *)

implement main () = () where {
  val () = println! ("fact(10) = ", fact 10)
} // end of [main]

(* ****** ****** *)

(* end of [misc.dats] *)
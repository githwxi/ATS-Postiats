(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun fact (n: int): int
extern
fun fact2 (n: int, res: int): int = "ext#fact2_in_c"

implement fact (n) = fact2 (n, 1)

%{
int
fact2_in_c (int n, int res)
{
  while (n > 0) { res *= n ; n -= 1 ; } ; return res ;
}
%}

(* ****** ****** *)

implement
main0 () =
{
//
val N = 12
//
val () = println! ("fact(", N, ") = ", fact(N))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [factext.dats] *)

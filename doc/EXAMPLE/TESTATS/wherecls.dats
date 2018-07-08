(* ****** ****** *)
//
// HX-2015-02-05:
// For testing where-clauses
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun fact1
  ( n: Nat ) : int
  = loop(n, 0, 1) where
{
    fun loop
      { n, i: nat | i <= n }
      ( n: int n, i: int i, res: int ) : int
      = if i >= n then res else loop(n, i+1, (i+1)*res)
} (* end of [where] *)

(* ****** ****** *)

fun fact2
  ( n: Nat ) : int
  = loop(n, 0, 1) where
    fun loop
      { n, i: nat | i <= n }
      ( n: int n, i: int i, res: int ) : int
      = if i >= n then res else loop(n, i+1, (i+1)*res)
  end // end of [where]

(* ****** ****** *)

implement
main0((*void*)) =
{
  val () = assertloc (fact1(10) = fact2(10))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [wherecls.dats] *)

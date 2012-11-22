//
// An implementation style that is often
// dubbed tail-recursion-modulo-allocation
//
// Author: Hongwei Xi (August 2007)
//

(* ****** ****** *)

fun intrange (
  m: int, n: int
) : List0(int) = let
//
typedef tres = List0(int)
//
fun loop (
  m: int, n: int
, res: &tres? >> tres
) : void =
  if m < n then let
    val () =
      res := list_cons{int}{0}(m, _)
    // end of [val]
    val list_cons (_, res1) = res
    val () = loop (m+1, n, res1)
    prval () = fold@ (res)
  in
    // nothing 
  end else
    res := list_nil ()
  // end of [if]
//
var res: tres
val () = loop (m, n, res)
//
in
  res
end // end of [intrange]

(* ****** ****** *)

implement
main (
  // argless
) = 0 where {
  #define M 0
  #define N 10
  val xs = intrange (M, N)
  val () = assertloc (list_length (xs) = N)
  val out = stdout_ref
  val () = fprint_list_sep<int> (out, xs, ", ")
  val () = fprint_newline (out)
} // end of [main]

(* ****** ****** *)

(* end of [make-list.dats] *)

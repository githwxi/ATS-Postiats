(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

extern
fun{a:t@ype} eq_elt_elt (x: a, y: a): bool

implement eq_elt_elt<int> (x, y) = eq_int_int (x, y)
implement eq_elt_elt<double> (x, y) = eq_double_double (x, y)

(* ****** ****** *)

fun{a:t@ype}
listeq (xs: list0 a, ys: list0 a): bool =
  case+ (xs, ys) of
  | (list0_cons (x, xs), list0_cons (y, ys)) => 
      if eq_elt_elt (x, y) then listeq (xs, ys) else false
  | (list0_nil (), list0_nil ()) => true
  | (_, _) => false
// end of [listeq]

(* ****** ****** *)

fun{a:t@ype}
listeqf (
  xs: list0 a, ys: list0 a, eq: (a, a) -> bool
) : bool =
  case+ (xs, ys) of
  | (list0_cons (x, xs), list0_cons (y, ys)) => 
      if eq (x, y) then listeqf (xs, ys, eq) else false
  | (list0_nil (), list0_nil ()) => true
  | (_, _) => false
// end of [listeqf]

(* ****** ****** *)

implement main () = () where {
  val xs = list0_cons (1, list0_cons (2, list0_cons (3, list0_nil)))
  val () = assertloc (listeq<int> (xs, xs))
  val () = assertloc (listeqf<int> (xs, xs, lam (x, y) => x = y))
  val () = println! ("[listeq] is tested successfully!")
} // end of [main]

(* ****** ****** *)

(* end of [listeq.dats] *)

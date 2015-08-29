//
// For testing $d2ctype
//
(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

implement
{a}(*tmp*)
list_length(xs) = let
//
fun aux 
  : $d2ctype(list_length<a>) = (
//
lam(xs) =>
  case+ xs of
  | list_nil() => 0 | list_cons(_, xs) => 1 + aux(xs)
//
) (* end of [aux] *)
//
in
  aux(xs)
end // end of [list_length]

(* ****** ****** *)

implement
{a}(*tmp*)
list_append(xs, ys) = let
//
fun aux 
  : $d2ctype(list_append<a>) =
(
//
lam(xs, ys) => let
//
  prval () = lemma_list_param(ys)
//
in
  case+ xs of
  | list_nil() => ys
  | list_cons(x, xs) => list_cons(x, aux(xs, ys))
end // end of [let] // end of [lam]
//
)
//
in
  aux(xs, ys)
end // end of [list_append]

(* ****** ****** *)

implement
main0 () = let
  val xs = cons(1, cons(2, cons(3, nil{int}))) in
  assertloc (length(list_append(xs, xs)) = 2 * length(xs))
end // end of [main0]

(* ****** ****** *)

(* end of [d2ctype.dats] *)

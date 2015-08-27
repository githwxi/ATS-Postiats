//
// For testing $d2ctype
//
(* ****** ****** *)

implement
{a}(*tmp*)
list_length(xs) = let
//
fun aux 
  : $d2ctype(list_length<a>) = lam(xs) =>
  case+ xs of
  | list_nil() => 0 | list_cons(_, xs) => 1 + aux(xs)
//
in
  aux(xs)
end // end of [list_length]

(* ****** ****** *)

implement
{a}(*tmp*)
list_append(xs) = let
//
fun aux 
  : $d2ctype(list_append<a>) = lam(xs, ys) =>
(
  case+ xs of
  | list_nil() => ys
  | list_cons(x, xs) => list_cons(x, aux(xs, ys))
)
//
in
  aux(xs, ys)
end // end of [list_append]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [d2ctype.dats] *)

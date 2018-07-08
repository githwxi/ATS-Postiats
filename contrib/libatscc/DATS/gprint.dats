(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/gprint.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
{}(*tmp*)
gprint_flush
  ((*void*)) = ()
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gprint_unit(_) = ()
//
(* ****** ****** *)
//
implement{}
gprint_list$beg() = gprint_string "("
implement{}
gprint_list$end() = gprint_string ")"
implement{}
gprint_list$sep() = gprint_string ", "
//
(* ****** ****** *)

implement
{a}(*tmp*)
gprint_list
  (xs) = let
//
fun
loop
(
  xs: List(a), i: int
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  (
    if i > 0
      then gprint_list$sep();
    // end of [if]
    gprint_val<a>(x); loop(xs, i+1)
  )
) (* end of [loop] *)
//
in
//
gprint_list$beg(); loop(xs, 0); gprint_list$end()
//
end // end of [gprint_list]

implement
(a)(*tmp*)
gprint_val<List(a)> (xs) = gprint_list<a> (xs)

(* ****** ****** *)

implement
{a}(*tmp*)
gprint_arrayref
  {n}(xs, asz) = let
//
prval() =
lemma_arrayref_param(xs)
//
fun
loop
{ i:nat
| i <= n
} (i: int(i)): void =
(
//
if (
i < asz
) then let
  val () =
  if i > 0
    then gprint_array$sep()
  // end of [if]
in
  gprint_val<a>(xs[i]); loop(i+1)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
in
//
gprint_array$beg(); loop(0); gprint_array$end()
//
end // end of [gprint_arrayref]

(* ****** ****** *)

(* end of [gprint.dats] *)

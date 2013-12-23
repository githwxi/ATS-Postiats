(*
** A package for finite sets of integers
*)

(* ****** ****** *)

staload "intset.sats"

(* ****** ****** *)
//
// a set of integers is represented as an ordered list
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list0.dats"

(* ****** ****** *)

assume intset = list0 (int)

(* ****** ****** *)

implement intset_empty = list0_nil
implement intset_make_sing (x) = list0_cons (x, list0_nil)

(* ****** ****** *)

implement
intset_make_list (xs) = let
  fun loop (xs: list0 int, res: intset): intset =
    case+ xs of
    | list0_cons (x, xs) => loop (xs, intset_add (res, x))
    | list0_nil () => res
  // end of [loop]
in
  loop (xs, list0_nil)
end // end of [intset_make_list]

implement intset_listize (xs) = xs

(* ****** ****** *)

implement intset_size (xs) = list0_length<int> (xs)

(* ****** ****** *)

implement
intset_ismem (xs, x0) =
  case+ xs of
  | list0_cons (x, xs) =>
      if x = x0 then true else intset_ismem (xs, x0)
  | list0_nil () => false
// end of [intset_ismem]

(* ****** ****** *)

implement
intset_add (xs, x0) =
  case+ xs of
  | list0_cons (x, xs1) =>
      if x0 < x then
        list0_cons (x0, xs)
      else if x0 > x then
        list0_cons (x, intset_add (xs1, x0))
      else xs
  | list0_nil () =>
      list0_cons (x0, list0_nil)
// end of [intset_add]

(* ****** ****** *)

implement
intset_del (xs, x0) =
  case+ xs of
  | list0_cons (x, xs1) =>
      if x0 < x then xs
      else if x0 > x then
        list0_cons (x, intset_del (xs1, x0))
      else xs1
  | list0_nil () =>
      list0_cons (x0, list0_nil)
// end of [intset_del]

(* ****** ****** *)

implement
intset_union (xs1, xs2) =
  case+ (xs1, xs2) of
  | (list0_cons (x1, xs11), list0_cons (x2, xs21)) =>
      if x1 < x2 then
        list0_cons (x1, intset_union (xs11, xs2))
      else if x1 > x2 then
        list0_cons (x2, intset_union (xs1, xs21))
      else list0_cons (x1, intset_union (xs11, xs21))
  | (list0_nil (), _) => xs2
  | (_, list0_nil ()) => xs1
// end of [intset_union]
  
(* ****** ****** *)

implement
intset_inter (xs1, xs2) =
  case+ (xs1, xs2) of
  | (list0_cons (x1, xs11), list0_cons (x2, xs21)) =>
      if x1 < x2 then
        intset_inter (xs11, xs2)
      else if x1 > x2 then
        intset_inter (xs1, xs21)
      else list0_cons (x1, intset_inter (xs11, xs21))
  | (list0_nil (), _) => list0_nil
  | (_, list0_nil ()) => list0_nil
// end of [intset_inter]
  
(* ****** ****** *)

implement
intset_differ (xs1, xs2) =
  case+ (xs1, xs2) of
  | (list0_cons (x1, xs11), list0_cons (x2, xs21)) =>
      if x1 < x2 then
        list0_cons (x1, intset_differ (xs11, xs2))
      else if x1 > x2 then
        intset_differ (xs1, xs21)
      else intset_differ (xs11, xs21)
  | (list0_nil (), _) => list0_nil
  | (_, list0_nil ()) => xs1
// end of [intset_differ]
  
(* ****** ****** *)

(* end of [intset.dats] *)

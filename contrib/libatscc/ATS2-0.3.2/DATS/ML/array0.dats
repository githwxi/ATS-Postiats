(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
//
staload
"./../../SATS/ML/array0.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
assume
array0_vt0ype_type
  (a:vt0p) = arrszref(a)
//
(* ****** ****** *)
//
implement
array0_make_elt
  (asz, x0) = arrszref_make_elt(asz, x0)
//
(* ****** ****** *)

implement
array0_size{a}(A) = arrszref_size{a}(A)
implement
array0_length{a}(A) = arrszref_size{a}(A)

(* ****** ****** *)

implement
array0_get_at(A, i) = arrszref_get_at(A, i)
implement
array0_set_at(A, i, x) = arrszref_set_at(A, i, x)
implement
array0_exch_at(A, i, x) = arrszref_exch_at(A, i, x)

(* ****** ****** *)
//
implement
array0_exists
  (A, pred) =
  arrszref_exists_cloref(A, pred)
//
implement
array0_exists_method
  (A) = lam(pred) => array0_exists(A, pred)
//
(* ****** ****** *)
//
implement
array0_forall
  (A, pred) =
  arrszref_forall_cloref(A, pred)
//
implement
array0_forall_method
  (A) = lam(pred) => array0_forall(A, pred)
//
(* ****** ****** *)

implement
array0_find_index
(
  A, pred
) =
loop(0, A.size()) where
{
fun
loop(i: Nat, n: int): intGte(~1) =
(
  if i < n
    then
    (
      if pred(i) then i else loop(i+1, n)
    ) else ~1
)
} (* end of [array0_find_index] *)

(* ****** ****** *)
//
implement
array0_app
  (A, fwork) =
  array0_foreach(A, fwork)
//
implement
array0_foreach
  (A, fwork) =
  arrszref_foreach_cloref(A, fwork)
//
implement
array0_foreach_method
  (A) = lam(fwork) => array0_foreach(A, fwork)
//
(* ****** ****** *)

(* end of [array0.dats] *)

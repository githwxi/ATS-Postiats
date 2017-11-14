(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/arrayref.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
arrayref_exists_cloref
  (A, n, pred) =
(
int_exists_cloref(n, $UN.cast{cfun1(int,bool)}(pred))
)
implement
arrayref_forall_cloref
  (A, n, pred) =
(
int_forall_cloref(n, $UN.cast{cfun1(int,bool)}(pred))
)
//
implement
arrayref_foreach_cloref
  (A, n, fwork) =
(
int_foreach_cloref(n, $UN.cast{cfun1(int,void)}(fwork))
)
//
(* ****** ****** *)
//
// HX: array-with-size
//
(* ****** ****** *)
//
implement
arrszref_make_elt
  {a}(n, x0) = let
//
val A =
  arrayref_make_elt{a}(n, x0)
//
in
  arrszref_make_arrayref{a}(A, n)
end (* end of [arrszref_make_elt] *)
//
(* ****** ****** *)
//
implement
arrszref_exists_cloref
  {a}(A, pred) = let
  val asz = arrszref_size(A)
in
//
int_exists_cloref
  (asz, $UN.cast{cfun1(int,bool)}(pred))
//
end // end of [arrszref_exists_cloref]
//
implement
arrszref_forall_cloref
  {a}(A, pred) = let
  val asz = arrszref_size(A)
in
//
int_forall_cloref
  (asz, $UN.cast{cfun1(int,bool)}(pred))
//
end // end of [arrszref_forall_cloref]
//
(* ****** ****** *)
//
implement
arrszref_foreach_cloref
  {a}(ASZ, fwork) = let
  val asz = arrszref_size(ASZ)
in
//
int_foreach_cloref
  (asz, $UN.cast{cfun1(int,void)}(fwork))
//
end // end of [arrszref_foreach_cloref]
//
implement
arrszref_foreach_method
  {a}(ASZ) =
(
  lam(fwork) => arrszref_foreach_cloref{a}(ASZ, fwork)
) (* end of [mtrxszref_foreach_method] *)
//
(* ****** ****** *)
//
implement
arrszref_tabulate_cloref
  {a}(asz, fopr) = let
//
val fopr = $UN.cast(fopr)
//
in
//
$UN.cast (
//
arrszref_make_arrayref
  (arrayref_tabulate_cloref{a?}(asz, fopr), asz)
//
)
end (* end of [arrszref_tabulate] *)
//
(* ****** ****** *)

(* end of [arrayref.dats] *)

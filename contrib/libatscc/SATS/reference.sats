(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
fun
ref{a:vt0p}(x: a): ref(a) = "mac#%"
//
fun
ref_make_elt
  {a:vt0p}(x: a): ref(a) = "mac#%"
//
fun
ref_make_type_elt
 {a:vt0p}(TYPE(a), x: a): ref(a) = "mac#%"
//
(* ****** ****** *)
//
fun
ref_get_elt{a:t0p}(r: ref a): a = "mac#%"
fun
ref_set_elt{a:t0p}(r: ref a, x0: a): void = "mac#%"
//
fun
ref_exch_elt{a:vt0p}(r: ref a, x0: a): (a) = "mac#%"
//
(* ****** ****** *)

overload [] with ref_get_elt of 100
overload [] with ref_set_elt of 100

(* ****** ****** *)

(* end of [reference.sats] *)

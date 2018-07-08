(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/option.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
option_some(x) = Some(x)
implement
option_none((*void*)) = None(*void*)
//
(* ****** ****** *)
//
implement
option_unsome
  (opt) =
  let val+Some(x) = opt in x end
//
(* ****** ****** *)
//
implement
option_is_some(opt) =
(
case+ opt of
| Some _ => true | None () => false
) (* end of [option_is_some] *)
//
(* ****** ****** *)
//
implement
option_is_none(opt) =
(
case+ opt of
| None () => true | Some _ => false
) (* end of [option_is_none] *)
//
(* ****** ****** *)

(* end of [option.dats] *)

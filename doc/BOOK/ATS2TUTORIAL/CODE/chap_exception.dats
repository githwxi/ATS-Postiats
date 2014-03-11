(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun{a:t@ype}
list_find_rightmost
  (List (a), (a) -<cloref1> bool): Option_vt (a)
//
(* ****** ****** *)

implement{a}
list_find_rightmost
  (xs, pred) = let
//
fun aux
(
  xs: List(a)
) : Option_vt (a) =
  case+ xs of
  | nil () => None_vt ()
  | cons (x, xs) => let
      val res = aux (xs)
    in
      case+ res of
      | Some_vt _ => res
      | ~None_vt () =>
          if pred (x) then Some_vt (x) else None_vt ()
        // end of [None]
    end (* end of [cons] *)
//
in
  aux (xs)
end // end of [list_find_rightmost]

(* ****** ****** *)

implement{a}
list_find_rightmost
  (xs, pred) = let
//
exception Found of (a)
//
fun aux
(
  xs: List(a)
) : void =
  case+ xs of
  | nil () => ()
  | cons (x, xs) => let
      val () = aux (xs)
    in
      if pred (x) then $raise Found(x) else ()
    end (* end of [cons] *)
//
in
//
try let
  val () = aux (xs)
in
  None_vt ()
end with
  | ~Found(x) => Some_vt (x)
//
end // end of [list_find_rightmost]

(* ****** ****** *)

implement
main0 () = () where
{
//
val xs = $list_vt{int}(0, 1, 2, 3, 4, 5)
//
var pred =
  lam@ (x: int): bool =<clo> (0 <= x && x <= 4)
//
val-~Some_vt(4) =
list_find_rightmost<int>
(
  $UNSAFE.list_vt2t(xs)
, $UNSAFE.cast{(int)-<cloref>bool}(addr@pred)
) (* end of [val] *)
//
val () = list_vt_free (xs)
//
val () = println! ("The code has passed minimal testing.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [chap_exception.dats] *)


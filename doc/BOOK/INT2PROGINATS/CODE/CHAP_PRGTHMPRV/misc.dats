(*
** Some code used in the book INTPROGINATS
*)

(* ****** ****** *)

(*
//
// This implementation can now be handled by ATS2.
//
*)

fun{
a:t@ype
} list_concat{m,n:nat}
  (xss: list (list (a, n), m)): list (a, m * n) =
  case+ xss of
  | list_cons (xs, xss) => list_append<a> (xs, list_concat xss)
  | list_nil () => list_nil ()
// end of [list_concat]

(* ****** ****** *)

fun{
a:t@ype
} list_concat{m,n:nat}
(
  xss: list (list (a, n), m)
) : [p:nat] (MUL (m, n, p) | list (a, p)) =
  case+ xss of
  | list_cons (xs, xss) => let
      val (pf | res) = list_concat (xss)
    in
      (MULind pf | list_append<a> (xs, res))
    end
  | list_nil () => (MULbas () | list_nil ())
// end of [list_concat]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [misc.dats] *)

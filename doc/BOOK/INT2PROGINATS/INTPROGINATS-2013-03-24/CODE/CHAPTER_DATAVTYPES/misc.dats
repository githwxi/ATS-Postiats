(*
**
** Some code used in the book PROGINATS
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)

fun{a:t@ype}
find_rightmost {n:nat} .<n>.
  (xs: list (a, n), P: (a) -<cloref> bool): Option_vt (a) =
  case+ xs of
  | list_cons (x, xs) => let
      val opt = find_rightmost (xs, P)
    in
      case opt of
      | ~None_vt () => if P (x) then Some_vt (x) else None_vt ()
      | _ => opt
    end // end of [list_cons]
  | list_nil () => None_vt ()
// end of [find_rightmost]

(* ****** ****** *)

fn{a:t@ype}
list_optcons {b:bool} {n:nat} (
  opt: option_vt (a, b), xs: list (a, n)
) : list (a, n+int_of_bool(b)) =
  case+ opt of
  | ~Some_vt (x) => list_cons (x, xs) | ~None_vt () => xs
// end of [list_optcons]

(* ****** ****** *)

(* end of [misc.dats] *)

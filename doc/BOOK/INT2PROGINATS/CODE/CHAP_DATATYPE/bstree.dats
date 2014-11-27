(*
** Some code used
** in the book INT2PROGINATS
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

datatype bstree =
  | E of () | B of (bstree, string, bstree)
// end of [bstree]

(* ****** ****** *)

fun bstree_search
  (t0: bstree, k0: string): bool =
(
case+ t0 of
| E () => false
| B (t1, k, t2) => let
    val sgn = compare (k0, k)
  in
    case+ 0 of
    | _ when sgn < 0 => bstree_search (t1, k0)
    | _ when sgn > 0 => bstree_search (t2, k0)
    | _ (*k0 = k*) => true
  end // end of [B]
) (* end of [bstree_search] *)

(* ****** ****** *)

fun bstree_insert
  (t0: bstree, k0: string): bstree =
(
case+ t0 of
| E () => B (E, k0, E)
| B (t1, k, t2) => let
    val sgn = compare (k0, k)
  in
    case+ 0 of
    | _ when sgn < 0 => B (bstree_insert (t1, k0), k, t2)
    | _ when sgn > 0 => B (t1, k, bstree_insert (t2, k0))
    | _ (*k0 = k*) => t0 // [k0] found and no actual insertion
  end // end of [B]
) (* end of [bstree_insert] *)

(* ****** ****** *)

fun bstree_preorder
(
  t0: bstree, fwork: string -<cloref1> void
) : void =
(
case+ t0 of
| E () => ()
| B (t1, k, t2) =>
  {
    val () = bstree_preorder (t1, fwork)
    val () = fwork (k)
    val () = bstree_preorder (t2, fwork)
  }
) (* end of [bstree_preorder] *)

(* ****** ****** *)

val () =
{
//
val bst = E ()
val bst = bstree_insert (bst, "a")
val bst = bstree_insert (bst, "z")
val bst = bstree_insert (bst, "b")
val bst = bstree_insert (bst, "y")
val bst = bstree_insert (bst, "c")
val bst = bstree_insert (bst, "x")
val bst = bstree_insert (bst, "a")
val bst = bstree_insert (bst, "b")
val bst = bstree_insert (bst, "c")
//
val () = assertloc (bstree_search(bst, "y"))
val () = assertloc (not(bstree_search(bst, "o")))
//
val () = print ("bst = ")
val () = bstree_preorder (bst, lam k => print (k))
val () = print_newline ((*void*))
//
} (* end of [val] *)

(* ****** ****** *)

implement main () = 0

(* ****** ****** *)

(* end of [bstree.dats] *)

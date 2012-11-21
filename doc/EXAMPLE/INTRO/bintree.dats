//
// Implementation of binary trees
//
// Author: Hongwei Xi (gmhwxi AT gmail.com)
//

(* ****** ****** *)

(*
** [datavtype] for [dataviewtype]
*)
datavtype
bintree (a:t@ype) =
  | BTnil of () | BTcons of (bintree a, a, bintree a)
// end of [bintree]

(* ****** ****** *)

extern
fun{a:t@ype}
bintree_size (bt: !bintree a): int

implement{a}
bintree_size (bt) = let
  macdef size (bt) = bintree_size ,(bt)
in
//
case+ bt of
| BTnil () => 0
| BTcons (bt1, _, bt2) => 1 + (size (bt1) + size (bt2))
//
end // end of [bintree_size]

(* ****** ****** *)

extern
fun{a:t@ype}
bintree_height (bt: !bintree a): int

implement{a}
bintree_height (bt) = let
  macdef height (bt) = bintree_height ,(bt)
in
//
case+ bt of
| BTnil () => 0
| BTcons (bt1, _, bt2) => 1 + max (height (bt1), height (bt2))
//
end // end of [bintree_height]

(* ****** ****** *)

extern
fun{a:t@ype}
bintree_free (bt: bintree a): void

implement{a}
bintree_free (bt) = let
  macdef free (bt) = bintree_free ,(bt)
in
//
case+ bt of
| ~BTnil () => ()
| ~BTcons (bt1, _, bt2) => (free bt1; free bt2)
//
end // end of [bintree_free]

(* ****** ****** *)

(* end of [bintree.dats] *)

(* ****** ****** *)
//
// Implementation of binary trees
//
// Author: Hongwei Xi (gmhwxi AT gmail.com)
//
(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/integer.dats"

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
bintree_copy (bt: !bintree a): bintree a

implement{a}
bintree_copy (bt) = let
  macdef copy (bt) = bintree_copy ,(bt)
in
//
case+ bt of
| BTnil () => BTnil{a}()
| BTcons (bt1, x, bt2) => BTcons (copy(bt1), x, copy(bt2))
//
end // end of [bintree_copy]

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

implement
main0 () =
{
//
typedef T = int
//
val bt0 = BTnil{T}()
val bt0_2 = bintree_copy (bt0)
val bt1 = BTcons{T}(bt0, 1, bt0_2)
val bt1_2 = bintree_copy (bt1)
val bt2 = BTcons{T}(bt1, 2, bt1_2)
//
val () = assertloc (bintree_size(bt2) = 3)
val () = assertloc (bintree_height(bt2) = 2)
//
val () = bintree_free (bt2)
//
} // end of [main0]

(* ****** ****** *)

(* end of [bintree.dats] *)

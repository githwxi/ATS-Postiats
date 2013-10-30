//
// Implementing Game-of-24
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./GameOf24.sats"

(* ****** ****** *)

extern
fun task_reduce
  (x: cardset, res: &List0(cardset) >> _): void
// end of [task_reduce]

(* ****** ****** *)

implement
task_reduce
  (x, res) = let
//
typedef res = List0(cardset)
//
fun auxdo
(
  x: cardset, i: int, j: int, res: &res >> _
) : void = let
//
val ci = x[i] and cj = x[j]
//
typedef cs = cardset
//
val y = cardset_remove2_add1 (x, i, j, ci+cj)
val ((*void*)) = res := list_cons{cs}(y, res)
val y = cardset_remove2_add1 (x, i, j, ci-cj)
val ((*void*)) = res := list_cons{cs}(y, res)
val y = cardset_remove2_add1 (x, i, j, cj-ci)
val ((*void*)) = res := list_cons{cs}(y, res)
val y = cardset_remove2_add1 (x, i, j, ci*cj)
val ((*void*)) = res := list_cons{cs}(y, res)
val y = cardset_remove2_add1 (x, i, j, ci/cj)
val ((*void*)) = res := list_cons{cs}(y, res)
val y = cardset_remove2_add1 (x, i, j, cj/ci)
val ((*void*)) = res := list_cons{cs}(y, res)
//
in
  // nothing
end // end of [auxdo]
//
fnx loop1
(
  x: cardset, n:int, i: int, res: &res >> _
) : void =
(
if i+1 < n then loop2 (x, n, i, i+1, res) else ()
)
and loop2
(
  x: cardset, n:int, i: int, j: int, res: &res >> _
) : void = let
in
//
if j < n then let
//
val (
) = auxdo (x, i, j, res)
//
in
  loop2 (x, n, i, j+1, res)
end else
(
  loop1 (x, n, i+1, res)
) // end of [if]
//
end // end of [loop2]
//
in
  loop1 (x, cardset_size (x), 0, res)
end // end of [task_reduce]

(* ****** ****** *)

extern
fun tasklst_reduce
  (xs: List0(cardset), res: &List0(cardset) >> _): void
// end of [tasklst_reduce]

(* ****** ****** *)

implement
tasklst_reduce
  (xs, res) = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val (
    ) = task_reduce (x, res)
  in
    tasklst_reduce (xs, res)
  end // end of [tasklst_reduce]
| list_nil () => ()
//
end // end of [tasklst_reduce]

(* ****** ****** *)

#define EPSILON 1E-8
fun is24 (v: double): bool = abs(v - 24.0) < EPSILON

(* ****** ****** *)

implement
play24 (n1, n2, n3, n4) = let
//
val c1 = card_make_int (n1)
val c2 = card_make_int (n2)
val c3 = card_make_int (n3)
val c4 = card_make_int (n4)
//
fun f (i:int):<cloref1> card =
(
case+ i of
| 0 => c1 | 1 => c2 | 2 => c3 | _ => c4
)
//
val x0 = cardset_tabulate (4, f)
//
var res: List0(cardset)
val xs = list_cons{cardset}(x0, list_nil)
//
val () = res := list_nil{cardset}()
val () = tasklst_reduce (xs, res)
val xs = list_vt2t (list_reverse (res))
//
val () = res := list_nil{cardset}()
val () = tasklst_reduce (xs, res)
val xs = list_vt2t (list_reverse (res))
//
val () = res := list_nil{cardset}()
val () = tasklst_reduce (xs, res)
val xs = list_vt2t (list_reverse (res))
//
implement
list_mapopt$fopr<cardset><card> (x) =
(
let val c = x[0] in
  if is24 (card_get_val (c)) then Some_vt{card}(c) else None_vt()
end // end of [let]
)
//
val out = stdout_ref
//
val res_sol = list_mapopt<cardset><card> (xs)
//
in
  list_vt2t (res_sol)
end // end of [play24]

(* ****** ****** *)

(* end of [GameOf24_solve.dats] *)

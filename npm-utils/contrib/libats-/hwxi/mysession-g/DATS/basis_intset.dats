(*
** integer sets
*)

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/basis_intset.sats"
//
(* ****** ****** *)

assume
intset(n:int, xs:iset) = List0(int)

(* ****** ****** *)
//
implement
{}(*tmp*)
intset_nil() = list_nil()
//
implement
{}(*tmp*)
intset_int(x) = list_sing(x)
//
implement
{}(*tmp*)
intset_int2(x1, x2) = $list{int}(x1, x2)
//
implement
{}(*tmp*)
intset_int3(x1, x2, x3) = $list{int}(x1, x2, x3)
//
(* ****** ****** *)

implement
{}(*tmp*)
intset_add_elt
  (xs, x0) = let
//
fun
aux
(
  xs: List0(int)
, res: List0_vt(int)
) : List0_vt(int) =
(
case+ xs of
| list_nil() =>
    cons_vt(x0, res)
  // list_nil
| list_cons(x, xs) =>
    if x < x0
      then aux(xs, cons_vt(x, res))
      else (
        if x > x0
          then
          list_revapp2_vt
            (xs, cons_vt(x, cons_vt(x0, res)))
          // end of [then]
          else
          list_revapp2_vt(xs, cons_vt(x0, res))
      ) (* end of [else] *)
   // end of [list_cons]
)
//
in
  list_vt2t(list_vt_reverse(aux(xs, nil_vt())))
end // end of [intset_add_elt]

(* ****** ****** *)

implement
{}(*tmp*)
intset_union
  (xs1, xs2) = let
//
fnx
aux0
(
  xs1: List0(int)
, xs2: List0(int)
, res: List0_vt(int)
) : List0_vt(int) =
(
case+ xs1 of
| list_nil() => list_revapp2_vt(xs2, res)
| list_cons(x1, xs1) => aux1(x1, xs1, xs2, res)
)
//
and
aux1
(
  x1: int
, xs1: List0(int)
, xs2: List0(int)
, res: List0_vt(int)
) : List0_vt(int) =
(
case+ xs2 of
| list_nil() =>
    list_revapp2_vt(xs1, cons_vt(x1, res))
  // end of [list_nil]
| list_cons(x2, xs2) => aux2(x1, xs1, x2, xs2, res)
)
//
and
aux2
(
  x1: int
, xs1: List0(int)
, x2: int
, xs2: List0(int)
, res: List0_vt(int)
) : List0_vt(int) =
(
//
if x1 < x2
  then
  aux1(x2, xs2, xs1, cons_vt(x1, res))
  else (
    if x1 > x2
      then
      aux1(x1, xs1, xs2, cons_vt(x2, res))
      else aux0(xs1, xs2, cons_vt(x1, res))
  ) (* end of [else] *)
) (* end of [aux2] *)
//
in
  list_vt2t(list_vt_reverse(aux0(xs1, xs2, nil_vt())))
end // end of [intset_union]

(* ****** ****** *)

implement
{}(*tmp*)
intset_intersect
  (xs1, xs2) = let
//
fnx
aux0
(
  xs1: List0(int)
, xs2: List0(int)
, res: List0_vt(int)
) : List0_vt(int) =
(
case+ xs1 of
| list_nil() => res
| list_cons(x1, xs1) => aux1(x1, xs1, xs2, res)
)
//
and
aux1
(
  x1: int
, xs1: List0(int)
, xs2: List0(int)
, res: List0_vt(int)
) : List0_vt(int) =
(
case+ xs2 of
| list_nil() => res
| list_cons(x2, xs2) => aux2(x1, xs1, x2, xs2, res)
)
//
and
aux2
(
  x1: int
, xs1: List0(int)
, x2: int
, xs2: List0(int)
, res: List0_vt(int)
) : List0_vt(int) =
(
//
if x1 < x2
  then aux1(x2, xs2, xs1, res)
  else (
    if x1 > x2
      then aux1(x1, xs1, xs2, res)
      else aux0(xs1, xs2, cons_vt(x1, res))
  ) (* end of [else] *)
) (* end of [aux2] *)
//
in
  list_vt2t(list_vt_reverse(aux0(xs1, xs2, nil_vt())))
end // end of [intset_intersect]

(* ****** ****** *)

implement
{}(*tmp*)
intset_ncomplement
  (xs, n) = let
//
fun
aux1
(
  i: int
, res: List0_vt(int)
) : List0_vt(int) =
(
//
if (i < n)
  then aux1(i+1, cons_vt(i, res)) else res
//
) (* end of [aux1] *)
//
and
aux2
(
  i: int
, x0: int
, xs: List0(int)
, res: List0_vt(int)
) : List0_vt(int) = (
//
if
(i < x0)
then (
  aux2(i+1, x0, xs, cons_vt(i, res))
) else (
  case+ xs of
  | list_nil() => aux1(i+1, res)
  | list_cons(x, xs) => aux2(i+1, x, xs, res)
) (* end of [else] *)
//
) (* end of [aux2] *)
//
val ys = (
//
case+ xs of
| list_nil() => aux1(0, nil_vt)
| list_cons(x, xs) => aux2(0, x, xs, nil_vt)
//
) : List0_vt(int)
//
in
  list_vt2t(list_vt_reverse(ys))
end // end of [intset_ncomplement]

(* ****** ****** *)

implement
{}(*tmp*)
intset_foreach_cloref
  (xs, fwork) = let
in
  list_foreach_cloref(xs, $UN.cast(fwork))
end // end of [intset_foreach_cloref]

(* ****** ****** *)

implement
{}(*tmp*)
intset2_foreach_cloref
  {n}(xs, ys, fwork) = let
//
fun
aux
(
  x: int, ys: List0(int)
) : void =
(
case+ ys of
| list_nil() => ()
| list_cons(y, ys) => let
    val x =
      $UN.cast{natLt(n)}(x)
    val y =
      $UN.cast{natLt(n)}(y)
    val ((*void*)) = fwork(x, y) in aux(x, ys)
  end (* end of [list_cons] *)
)
//
fun
auxlst
(
  xs: List0(int), ys: List0(int)
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  (
    let val () = aux(x, ys) in auxlst(xs, ys) end
  ) (* end of [list_cons] *)
)
in
  auxlst(xs, ys)  
end // end of [intset2_foreach_cloref]

(* ****** ****** *)

implement
{}(*tmp*)
cintset_foreach_cloref
  {n}(n, xs, fwork) = let
//
fun
aux1
(
  i: natLte(n)
): void = (
//
if i < n then
  let val () = fwork(i) in aux1(i+1) end
) (* end of [aux] *)
//
fun
aux2
(
  i: natLt(n)
, xs: List0(int)
) : void =
(
case+ xs of
| list_nil() =>
  let val () = fwork(i) in aux1(i+1) end
| list_cons(x, xs) => aux3(i, x, xs)
)
//
and
aux3
(
  i: natLte(n)
, x: int, xs: List0(int)
) : void =
if
(i < x)
then let
//
val i =
  $UN.cast{natLt(n)}(i)
//
val ((*void*)) = fwork(i)
//
in
  aux3(i+1, x, xs)
//
end // end of [then]
else let
  val i = i + 1
in
  if i < n then aux2(i, xs) else ()
end // end of [else]
//
in
  if n > 0 then aux2(0, xs) else ()
end // end of [intset_foreach_cloref]

(* ****** ****** *)
//
implement{}
print_intset(xs) = fprint_intset(stdout_ref, xs)
implement{}
prerr_intset(xs) = fprint_intset(stderr_ref, xs)
//
implement{}
fprint_intset(out, xs) = fprint_list_sep<int>(out, xs, "+")
//
(* ****** ****** *)

(* end of [basis_intset.dats] *)

(* ****** ****** *)

(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/stream.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
{}(*tmp*)
stream_sing(x) =
  stream_cons(x, stream_make_nil())
//
(* ****** ****** *)
//
implement
{}(*tmp*)
stream_make_nil() =
  $delay(stream_nil())
//
implement
{}(*tmp*)
stream_make_sing(x0) =
  $delay(
    stream_cons(x0, stream_make_nil())
  )(*$delay*)
//
(* ****** ****** *)
//
implement
stream_make_list(xs) = $delay
(
case+ xs of
| list_nil() => stream_nil()
| list_cons(x, xs) =>
    stream_cons(x, stream_make_list(xs))
) (* end of [stream_make_list] *)
//
implement
stream_make_list0(xs) =
  stream_make_list(g1ofg0_list(xs))
//
(* ****** ****** *)

implement
stream_nth_opt
  {a}(xs, n) = let
//
fun
loop
(
  xs: stream(a), n: intGte(0)
) : Option_vt(a) =
(
case+ !xs of
| stream_nil
    () => None_vt()
  // stream_nil
| stream_cons
    (x, xs) =>
  (
    if n > 0
      then loop(xs, pred(n)) else Some_vt(x)
    // end of [if]
  )
) (* end of [loop] *)
//
in
  loop (xs, n)
end // end of [stream_nth_opt]

(* ****** ****** *)

implement
stream_length
  {a}(xs) = loop(xs, 0) where
{
//
fun
loop
(
  xs: stream(a), res: intGte(0)
) : intGte(0) =
(
  case+ !xs of
  | stream_nil() => res
  | stream_cons(_, xs) => loop(xs, res+1)
)
//
} (* end of [stream_length] *)

(* ****** ****** *)
//
(*
implement
stream2list
  {a}(xs) =
  aux(xs) where
{
//
fun
aux
(xs: stream(a)): List0(a) =
(
case+ !xs of
| stream_nil() => list_nil()
| stream_cons(x, xs) => list_cons(x, aux(xs))
)
//
}
*)
//
implement
stream2list
  {a}(xs) =
(
list_reverse
  (stream2list_rev(xs))
)
//
(* ****** ****** *)
//
implement
stream2list_rev
  {a}(xs) =
  loop(xs, list_nil) where
{
//
fun
loop
(
  xs: stream(a), ys: List0(a)
) : List0(a) =
(
case+ !xs of
| stream_nil() => ys
| stream_cons(x, xs) => loop(xs, list_cons(x, ys))
)
//
} (* end of [stream2list_rev] *)
//
(* ****** ****** *)
//
implement
stream_takeLte
  (xs, n) = $delay
(
//
if
(n > 0)
then (
case+ !xs of
| stream_nil() =>
    stream_nil(*void*)
  // end of [stream_nil]
| stream_cons(x, xs) =>
    stream_cons(x, stream_takeLte(xs, n-1))
  // end of [stream_cons]
) (* end of [then] *)
else stream_nil(*void*) // else
//
) (* end of [stream_takeLte] *)
//
implement
stream_takeLte_vt
  (xs, n) = $ldelay
(
//
if
(n > 0)
then (
case+ !xs of
| stream_nil() =>
    stream_vt_nil(*void*)
  // end of [stream_nil]
| stream_cons(x, xs) =>
    stream_vt_cons(x, stream_takeLte_vt(xs, n-1))
  // end of [stream_cons]
) (* end of [then] *)
else stream_vt_nil(*void*) // else
//
) (* end of [stream_takeLte_vt] *)
//
(* ****** ****** *)

implement
stream_take_opt
  {a}{n}(xs, n) = let
//
fun
auxmain
{i:nat | i <= n}
(
  xs: stream(a), i: int(i), res: list(a, i)
) : Option_vt(list(a, n)) =
(
//
if
(i < n)
then (
  case+ !xs of
  | stream_nil() => None_vt()
  | stream_cons(x, xs) => auxmain(xs, i+1, list_cons(x, res))
) (* end of [then] *)
else Some_vt(list_reverse(res))
//
) (* end of [auxmain] *)
//
in
  auxmain(xs, 0, list_nil())
end // end of [stream_take_opt]

(* ****** ****** *)

implement
stream_drop_opt
  {a}{n}(xs, n) = let
//
fun
auxmain
{i:nat | i <= n}
(
  xs: stream(a), i: int(i)
) : Option_vt(stream(a)) =
(
//
if
(i < n)
then (
case+ !xs of
| stream_nil() => None_vt()
| stream_cons(x, xs) => auxmain(xs, i+1)
) (* end of [then] *)
else Some_vt(xs) // end of [else]
//
) (* end of [auxmain] *)
//
in
  auxmain(xs, 0(*i*))
end // end of [stream_drop_opt]

(* ****** ****** *)

implement
stream_append
  (xs, ys) = $delay
(
  case+ !xs of
  | stream_nil() => !ys
  | stream_cons(x, xs) =>
      stream_cons(x, stream_append(xs, ys))
    // end of [stream_cons]
) (* end of [stream_append] *)

(* ****** ****** *)

implement
stream_concat
  (xss) = $delay
(
//
case+ !xss of
| stream_nil() =>
  stream_nil((*void*))
| stream_cons(xs, xss) =>
  (
  !(stream_append(xs, stream_concat(xss)))
  )
//
) (* end of [stream_concat] *)

(* ****** ****** *)
//
implement
stream_map_cloref
  {a}(xs, fopr) = $delay
(
//
case+ !xs of
| stream_nil() =>
  stream_nil((*void*))
| stream_cons(x, xs) =>
  stream_cons
    (fopr(x), stream_map_cloref(xs, fopr))
  // end of [stream_cons]
//
) (* end of [stream_map_cloref] *)
//
implement
stream_map_method
  {a}(xs, _) =
(
lam(fopr) => stream_map_cloref{a}(xs, fopr)
) (* stream_map_method *)
//
(* ****** ****** *)
//
implement
stream_scan_cloref
{res}{a}
(xs, r0, fopr) = $delay
(
//
case+ !xs of
| stream_nil() =>
  stream_nil()
| stream_cons(x, xs) =>
  stream_cons
  ( r0
  , stream_scan_cloref
      {res}{a}(xs, fopr(r0, x), fopr)
    // stream_scan_cloref
  ) (* end of [stream_cons] *)
//
) (* end of [stream_scan_cloref] *)
//
implement
stream_scan_method
{res}{a}(xs, _) =
(
lam(r0, fopr) =>
  stream_scan_cloref{res}{a}(xs, r0, fopr)
// end of [lam]
) (* stream_scan_method *)
//
(* ****** ****** *)
//
implement
stream_filter_cloref
  {a}(xs, pred) = $delay
(
//
case+ !xs of
| stream_nil
    ((*void*)) => stream_nil()
  // end of [stream_nil]
| stream_cons
    (x, xs) =>
  (
  if pred(x)
    then
    stream_cons (
      x, stream_filter_cloref(xs, pred)
    ) (* end of [then] *)
    else !(stream_filter_cloref(xs, pred))
  // end of [if]
  ) (* end of [stream_cons] *)
//
) (* end of [stream_filter_cloref] *)
//
implement
stream_filter_method
  {a}(xs) =
(
lam(pred) => stream_filter_cloref{a}(xs, pred)
) (* end of [stream_filter_method] *)
//
(* ****** ****** *)
//
implement
stream_forall_cloref
  {a}(xs, pred) =
(
//
case+ !xs of
| stream_nil() => true
| stream_cons(x, xs) =>
  (
    if pred(x)
      then stream_forall_cloref{a}(xs, pred)
      else false
    // end of [if]
  ) (* end of [stream_cons] *)
//
) (* end of [stream_forall_cloref] *)
//
implement
stream_forall_method
  {a}(xs) =
(
lam(pred) => stream_forall_cloref{a}(xs, pred)
) (* end of [stream_forall_method] *)
//
(* ****** ****** *)
//
implement
stream_exists_cloref
  {a}(xs, pred) =
(
//
case+ !xs of
| stream_nil() => false
| stream_cons(x, xs) =>
  (
    if pred(x)
      then (true)
      else stream_exists_cloref{a}(xs, pred)
    // end of [if]
  ) (* end of [stream_cons] *)
//
) (* end of [stream_exists_cloref] *)
//
implement
stream_exists_method
  {a}(xs) =
(
lam(pred) => stream_exists_cloref{a}(xs, pred)
) (* end of [stream_exists_method] *)
//
(* ****** ****** *)
//
implement
stream_foreach_cloref
  {a}(xs, fwork) =
(
case+ !xs of
| stream_nil() => ()
| stream_cons(x, xs) =>
  (
    fwork(x); stream_foreach_cloref(xs, fwork)
  ) (* end of [stream_cons] *)
) (* end of [stream_foreach_cloref] *)
//
implement
stream_foreach_method
  {a}(xs) =
(
  lam(fwork) => stream_foreach_cloref{a}(xs, fwork)
) (* end of [stream_foreach_method] *)
//
(* ****** ****** *)
//
implement
stream_iforeach_cloref
  {a}(xs, fwork) = let
//
fun
loop
(
  i: Nat,  xs: stream(a)
) : void =
(
case+ !xs of
| stream_nil() => ()
| stream_cons(x, xs) =>
  (
    fwork(i, x); loop(i+1, xs)
  ) (* end of [stream_cons] *)
) (* end of [loop] *)
//
in
  loop(0(*index*), xs)
end (* end of [stream_foreach_cloref] *)
//
implement
stream_iforeach_method
  {a}(xs) =
(
  lam(fwork) => stream_iforeach_cloref{a}(xs, fwork)
) (* end of [stream_iforeach_method] *)
//
(* ****** ****** *)

implement
stream_tabulate_cloref
  {a}(fopr) = auxmain(0) where
{
//
fun
auxmain
(
n0: intGte(0)
) : stream(a) =
(
  $delay(stream_cons(fopr(n0), auxmain(n0+1)))
) (* end of [auxmain] *)
//
} (* end of [stream_tabulate_cloref] *)

(* ****** ****** *)

implement
cross_stream_list
  {a,b}(xs, ys) = let
//
fun
auxmain
(
  x0: a, xs: stream(a)
, ys: List0(b), zs: List0(b)
) : stream($tup(a, b)) = $delay
(
  case+ zs of
  | list_nil() =>
      !(cross_stream_list(xs, ys))
  | list_cons(z0, zs) =>
      stream_cons(
        $tup(x0, z0), auxmain(x0, xs, ys, zs)
      ) (* stream_cons *)
) (* end of [auxmain] *)
//
in
//
$delay(
case !xs of
| stream_nil() => stream_nil()
| stream_cons(x, xs) => !(auxmain(x, xs, ys, ys))
) (* $delay *)
//
end // end of [cross_stream_list]

(* ****** ****** *)
//
implement
cross_stream_list0
  (xs, ys) =
  cross_stream_list(xs, g1ofg0(ys))
//
(* ****** ****** *)

implement
stream2cloref_exn
  {a}(xs) = let
//
val rxs =
  ref{stream(a)}(xs)
//
in
//
lam() => let
//
val xs = rxs[]
val-stream_cons(x, xs) = !xs
//
in
  rxs[] := xs; x
end // end of [lam]
//
end // end of [stream2cloref_exn]

(* ****** ****** *)

implement
stream2cloref_opt
  {a}(xs) = let
//
val rxs =
  ref{stream(a)}(xs)
//
in
//
lam() => let
  val xs = rxs[]
in
  case+ !xs of
  | stream_nil() => None_vt()
  | stream_cons(x, xs) => (rxs[] := xs; Some_vt(x))
end // end of [lam]
//
end // end of [stream2cloref_opt]

(* ****** ****** *)

implement
stream2cloref_last
  {a}(xs, x0) = let
//
val rxs =
  ref{stream(a)}(xs)
//
val rx0 = ref{a}(x0)
//
in
//
lam() => let
  val xs = rxs[]
in
  case+ !xs of
  | stream_nil
      () => rx0[]
    // end of [stream_nil]
  | stream_cons
      (x1, xs2) => (rxs[] := xs2; rx0[] := x1; x1)
    // end of [stream_cons]
end // end of [lam]
//
end // end of [stream2cloref]

(* ****** ****** *)

implement
stream_take_while_cloref
  {a}(xs, pred) = let
//
val $tup(xs, ys) =
  stream_rtake_while_cloref{a}(xs, pred)
//
in
//
  $tup(xs, list_reverse(ys))
//
end // end of [stream_take_while_cloref]

(* ****** ****** *)

implement
stream_rtake_while_cloref
  {a}(xs, pred) = let
//
fun
loop
(
  xs: stream(a)
, i0: intGte(0), res: List0(a)
) : $tup(stream(a), List0(a)) =
(
//
case+ !xs of
| stream_nil() =>
    $tup(xs, res)
| stream_cons(x, xs2) =>
    if pred(i0, x)
      then loop(xs2, i0+1, list_cons(x, res)) else $tup(xs, res)
    // end of [if]
//
) (* end of [loop] *)
//
in
//
  loop(xs, 0, list_nil((*void*)))
//
end // end of [stream_take_while_cloref]

(* ****** ****** *)
//
implement
stream_take_until_cloref
  {a}(xs, pred) =
(
stream_take_while_cloref(xs, lam(i, x) => ~pred(i, x))
) (* end of [stream_take_until_cloref] *)
//
implement
stream_rtake_until_cloref
  {a}(xs, pred) =
(
stream_rtake_while_cloref(xs, lam(i, x) => ~pred(i, x))
) (* end of [stream_take_until_cloref] *)
//
(* ****** ****** *)

implement
stream_list_xprod2
  {a,b}
(
  xs, ys
) = auxlst(xs, ys) where
{
//
fun
aux
(
  x: a, ys: List0(b)
) : stream($tup(a, b)) = $delay
(
  case+ ys of
  | list_nil() => stream_nil()
  | list_cons(y, ys) => stream_cons($tup(x, y), aux(x, ys))
)
fun
auxlst
(
  xs: List0(a), ys: List0(b)
): stream($tup(a, b)) = $delay
(
  case+ xs of
  | list_nil() => stream_nil()
  | list_cons(x, xs) => !(stream_append(aux(x, ys), auxlst(xs, ys)))
)
} (* end of [stream_list_xprod2] *)

(* ****** ****** *)

(* end of [stream.dats] *)

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
stream_vt_make_nil() =
$ldelay(stream_vt_nil())
//
(* ****** ****** *)
//
implement
{}(*tmp*)
stream_vt_make_cons(x, xs) =
$ldelay(
  stream_vt_cons(x, xs), $effmask_wrt(~xs)
)(*$ldelay*)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
stream_vt_sing(x0) =
stream_vt_cons(x0, stream_vt_make_nil())
//
implement
{}(*tmp*)
stream_vt_make_sing(x0) =
$ldelay
(
  stream_vt_cons(x0, stream_vt_make_nil())
) (* $ldelay *)
//
(* ****** ****** *)
//
implement
stream_vt_free{a}(xs) = ~(xs)
//
(* ****** ****** *)

implement
stream_vt2t
  {a}(xs) =
(
$effmask_all(aux(xs)) where
{
//
fun
aux
(
xs:
stream_vt(a)
) : stream(a) = let
//
val xs = $UN.castvwtp0{ptr}(xs)
//
in
//
$delay
(
let
//
val xs =
  $UN.castvwtp0{stream_vt(a)}(xs)
//
in
  case+ !xs of
  | ~stream_vt_nil() => stream_nil()
  | ~stream_vt_cons(x, xs) => stream_cons(x, aux(xs))
end // end of [let]
)
//
end // end of [aux]
//
} (* end of [where] *)
) (* end of [stream_vt2t] *)

(* ****** ****** *)

implement
stream_vt_takeLte
  {a}(xs, n0) =
(
$effmask_all
(auxmain(xs, n0)) where
{
//
fun
auxmain
(
xs: stream_vt(a), n0: Nat
) : stream_vt(a) = $ldelay
(
//
if
(n0 > 0)
then
(
case+ !xs of
| ~stream_vt_nil() =>
    stream_vt_nil()
| ~stream_vt_cons(x, xs) =>
    stream_vt_cons(x, auxmain(xs, n0-1))
)
else
(
  ~(xs); stream_vt_nil()
)
,
~(xs) // HX: called for freeing the stream!
//
) (* [$ldelay] *)
//
} (* end of [where] *)
) (* end of [stream_vt_takeLte] *)

(* ****** ****** *)

implement
stream_vt_length
  {a}(xs) =
  loop(xs, 0) where
{
//
fun
loop
(
xs: stream_vt(a), len: intGte(0)
) : intGte(0) =
(
case+ !xs of
| ~stream_vt_nil() => len
| ~stream_vt_cons(_, xs) => loop(xs, len+1)
) (* end of [loop] *)
//
} (* end of [stream_vt_length] *)

(* ****** ****** *)
//
(*
implement
stream2list_vt
  {a}(xs) =
  aux(xs) where
{
//
fun
aux
(xs: stream_vt(a)): List0_vt(a) =
(
case+ !xs of
| ~stream_vt_nil() => list_vt_nil()
| ~stream_vt_cons(x, xs) => list_vt_cons(x, aux(xs))
)
//
}
*)
(* ****** ****** *)
//
implement
stream2list_vt
  {a}(xs) =
  list_vt_reverse(stream2list_vt_rev(xs))
//
(* ****** ****** *)
//
implement
stream2list_vt_rev
  {a}(xs) =
  loop(xs, nil_vt()) where
{
//
fun
loop
(
xs: stream_vt(a), res: List0_vt(a)
) : List0_vt(a) =
(
case+ !xs of
| ~stream_vt_nil() => res
| ~stream_vt_cons(x, xs) => loop(xs, cons_vt(x, res))
) (* end of [loop] *)
//
} (* end of [stream2list_vt_rev] *)

(* ****** ****** *)

implement
stream_vt_append
  {a}
(
  xs, ys
) =
$effmask_all
(auxmain(xs, ys)) where
{
//
fun
auxmain
(
  xs: stream_vt(a)
, ys: stream_vt(a)
) : stream_vt(a) = $ldelay
(
(
  case+ !xs of
  | ~stream_vt_nil() => !ys
  | ~stream_vt_cons(x, xs) =>
      stream_vt_cons(x, auxmain(xs, ys))
    // end of [stream_vt_cons]
) : stream_vt_con(a)
, (~(xs); ~(ys)) // HX: for freeing the stream!
) (* end of [auxmain] *)
//
} (* end of [stream_vt_append] *)

(* ****** ****** *)

implement
stream_vt_concat
  {a}(xss) = let
//
fun
auxmain
(
  xss: stream_vt(stream_vt(a))
) : stream_vt(a) = $ldelay
(
//
case+ !xss of
| ~stream_vt_nil
    ((*void*)) => stream_vt_nil()
| ~stream_vt_cons
    (xs, xss) => !(stream_vt_append(xs, auxmain(xss)))
//
,
~(xss) // HX: called for freeing the stream!
) (* end of [auxmain] *)
//
in
  $effmask_all(auxmain(xss))
end (* end of [stream_vt_concat] *)

(* ****** ****** *)
//
implement
stream_vt_map_cloref
  {a}{b}
(
  xs, f0
) =
  auxmain(xs) where
{
//
fun
auxmain
(
xs: stream_vt(a)
) : stream_vt(b) = $ldelay
(
(
case+ !xs of
| ~stream_vt_nil() =>
    stream_vt_nil()
| ~stream_vt_cons(x, xs) =>
    stream_vt_cons(f0(x), auxmain(xs))
) : stream_vt_con(b)
,
~(xs) // called when the stream is freed
) (* end of [auxmain] *)
//
} (* end of [stream_vt_map_cloref] *)
//
implement
stream_vt_map_method
  (xs, _) =
(
  llam(f0) => stream_vt_map_cloref(xs, f0)
) (* end of [stream_vt_map_method] *)
//
(* ****** ****** *)
//
implement
stream_vt_mapopt_cloref
  {a}{b}
(
  xs, f0
) =
  auxmain(xs) where
{
//
fun
auxmain
(
xs: stream_vt(a)
) : stream_vt(b) = $ldelay
(
(
case+ !xs of
| ~stream_vt_nil() =>
    stream_vt_nil()
| ~stream_vt_cons(x, xs) =>
  (
    case+ f0(x) of
    | ~None_vt() => !(auxmain(xs))
    | ~Some_vt(y) =>
        stream_vt_cons(y, auxmain(xs))
      // end of [Some_vt]
  )
) : stream_vt_con(b)
,
~(xs) // called when the stream is freed
) (* end of [auxmain] *)
//
} (* end of [stream_vt_mapopt_cloref] *)
//
implement
stream_vt_mapopt_method
  (xs, _) =
(
  llam(f0) => stream_vt_mapopt_cloref(xs, f0)
) (* end of [stream_vt_map_method] *)
//
(* ****** ****** *)

implement
stream_vt_filter_cloref
  {a}(xs, p0) =
  auxmain(xs) where
{
//
fun
auxmain
(
xs: stream_vt(a)
) : stream_vt(a) = $ldelay
(
//
let
  val xs_con = !xs
in
//
case+ xs_con of
| ~stream_vt_nil
    ((*_*)) => stream_vt_nil()
  // end of [stream_vt_nil]
| ~stream_vt_cons
    (x, xs1) =>
  (
    if p0(x)
      then (
        stream_vt_cons(x, auxmain(xs1))
      ) (* end of [then] *)
      else (
        !(auxmain(xs1))
      ) (* end of [else] *)
    // end of [if]
  ) (* end of [stream_vt_cons] *)
//
end : stream_vt_con(a) // end of [let]
//
,
//
~(xs) // called when the stream is freed
//
) (* end of auxmain *)
//
} (* end of [stream_vt_filter_cloref] *)
//
implement
stream_vt_filter_method
  (xs) =
(
llam(p0) =>
  stream_vt_filter_cloref(xs, p0)
) (* end of [stream_vt_filter_method] *)
//
(* ****** ****** *)
//
implement
stream_vt_exists_cloref
  {a}(xs, pred) = loop(xs) where
{
//
fun
loop
(
  xs: stream_vt(a)
) : bool =
(
  case+ !xs of
  | ~stream_vt_nil() => false
  | ~stream_vt_cons(x, xs) =>
      if pred(x) then (~xs; true) else loop(xs)
    // stream_vt_cons
)
//
} (* end of [stream_vt_exists_cloref] *)
//
implement
stream_vt_exists_method
  (xs) =
(
llam(pred) =>
  stream_vt_exists_cloref(xs, pred)
) (* end of [stream_vt_exists_method] *)
//
(* ****** ****** *)
//
implement
stream_vt_forall_cloref
  {a}(xs, pred) = loop(xs) where
{
//
fun
loop
(
  xs: stream_vt(a)
) : bool =
(
  case+ !xs of
  | ~stream_vt_nil() => true
  | ~stream_vt_cons(x, xs) =>
      if pred(x) then loop(xs) else (~xs; false)
    // stream_vt_cons
)
//
} (* end of [stream_vt_forall_cloref] *)
//
implement
stream_vt_forall_method
  (xs) =
(
llam(pred) =>
  stream_vt_forall_cloref(xs, pred)
) (* end of [stream_vt_forall_method] *)
//
(* ****** ****** *)
//
implement
stream_vt_foreach_cloref
  {a}(*poly*)
  (xs, fwork) =
  loop(xs) where
{
//
fun
loop
(
  xs: stream_vt(a)
) : void =
(
case+ !xs of
| ~stream_vt_nil() => ()
| ~stream_vt_cons(x, xs) =>
    (fwork(x); loop(xs))
)
//
} (* end of [stream_vt_foreach_cloref] *)
//
implement
stream_vt_foreach_method
  (xs) =
(
llam(fwork) =>
  stream_vt_foreach_cloref(xs, fwork)
) (* end of [stream_vt_foreach_method] *)
//
(* ****** ****** *)
//
implement
stream_vt_iforeach_cloref
  {a}(*poly*)
  (xs, fwork) =
  loop(0, xs) where
{
//
fun
loop
(
  i: Nat, xs: stream_vt(a)
) : void =
(
case+ !xs of
| ~stream_vt_nil() => ()
| ~stream_vt_cons(x, xs) =>
    (fwork(i, x); loop(i+1, xs))
)
//
} (* end of [stream_vt_iforeach_cloref] *)
//
implement
stream_vt_iforeach_method
  (xs) =
(
llam(fwork) =>
  stream_vt_iforeach_cloref(xs, fwork)
) (* end of [stream_vt_iforeach_method] *)
//
(* ****** ****** *)
//
implement
stream_vt_rforeach_cloref
  {a}(*poly*)
  (xs, fwork) =
  auxmain(xs) where
{
//
fun
auxmain
(
  xs: stream_vt(a)
) : void =
(
case+ !xs of
| ~stream_vt_nil() => ()
| ~stream_vt_cons(x, xs) =>
    (auxmain(xs); fwork(x))
)
//
} (* end of [stream_vt_rforeach_cloref] *)
//
implement
stream_vt_rforeach_method
  (xs) =
(
llam(fwork) =>
  stream_vt_rforeach_cloref(xs, fwork)
) (* end of [stream_vt_rforeach_method] *)
//
(* ****** ****** *)

implement
stream_vt_tabulate_cloref
  {a}(fopr) = auxmain(0) where
{
//
fun
auxmain
(
n0: intGte(0)
) : stream_vt(a) =
(
$ldelay(stream_vt_cons(fopr(n0), auxmain(n0+1)))
) (* end of [auxmain] *)
//
} (* end of [stream_tabulate_cloref] *)

(* ****** ****** *)

(* end of [stream_vt.dats] *)

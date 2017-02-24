(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../basics.sats"
staload "./../SATS/intrange.sats"
*)

(* ****** ****** *)
//
implement
int_repeat_lazy
  (n0, fwork) =
(
//
int_repeat_cloref(n0, lazy2cloref(fwork))
//
) (* end of [int_repeat_lazy] *)
//
(* ****** ****** *)
//
implement
int_repeat_cloref
  (n0, fwork) = let
//
fun
loop
(
  n: int, fwork: cfun0(void)
) : void = (
//
if n > 0
  then (fwork(); loop(n-1, fwork)) else ()
//
) (* end of [loop] *)
//
in
  loop (n0, fwork)
end // end of [int_repeat_cloref]
//
implement
int_repeat_method
  (n0) =
  lam(fwork) => int_repeat_cloref(n0, fwork)
//
(* ****** ****** *)
//
implement
int_exists_cloref
  (n0, pred) =
(
  intrange_exists_cloref(0, n0, pred)
)
implement
int_forall_cloref
  (n0, pred) =
(
  intrange_forall_cloref (0, n0, pred)
)
//
implement
int_foreach_cloref
  (n0, pred) =
(
  intrange_foreach_cloref (0, n0, pred)
)
//
(* ****** ****** *)
//
implement
int_exists_method
  (n0) = lam(f) => int_exists_cloref(n0, f)
implement
int_forall_method
  (n0) = lam(f) => int_forall_cloref(n0, f)
//
implement
int_foreach_method
  (n0) = lam(f) => int_foreach_cloref(n0, f)
//
(* ****** ****** *)
//
implement
int_foldleft_cloref
  {res}
  (n0, ini, fopr) =
(
  intrange_foldleft_cloref{res}(0, n0, ini, fopr)
)
//
implement
int_foldleft_method
  {res}(n0, ini) =
(
lam(fopr) => int_foldleft_cloref{res}(n0, ini, fopr)
) (* int_foldleft_method *)
//
(* ****** ****** *)
//
implement
int_list_map_cloref
  {a}{n}(n0, fopr) = let
//
fun
aux
{ i:nat
| i <= n
} (i: int(i)): list(a, n-i) = (
//
if
(i < n0)
then list_cons(fopr(i), aux(i+1))
else list_nil()
// end of [if]
)
//
in
  aux(0)
end // end of [int_list_map_cloref]
//
implement
int_list_map_method
  {a}{n}(n0, tres) =
(
//
lam(fopr) =>
  int_list_map_cloref{a}{n}(n0, fopr)
//
) (* end of [int_list_map_method] *)
//
(* ****** ****** *)
//
implement
int_list0_map_cloref
  {a}(n0, fopr) = let
//
val n0 = g1ofg0(n0)
//
in
//
if
(n0 >= 0)
then
g0ofg1
(
  int_list_map_cloref(n0, fopr)
) (* g0ofg1 *)
else list0_nil(*void*)
//
end // end of [int_list0_map_cloref]
//
implement
int_list0_map_method
  {a}(n0, tres) =
(
//
lam(fopr) =>
  int_list0_map_cloref{a}(n0, fopr)
//
) (* end of [int_list0_map_method] *)
//
(* ****** ****** *)

#if
defined(ATSCC_STREAM)
//
implement
int_stream_map_cloref
  {a}(n0, fopr) = let
//
fun
aux
{i:nat}
(
  i: int(i)
) : stream(a) = $delay(
//
if
(i < n0)
then (
  stream_cons(fopr(i), aux(i+1))
) else stream_nil()
// end of [if]
)
//
in
  aux(0)
end // end of [aux]
//
implement
int_stream_map_method
  {a}(n0, tres) =
(
//
lam(fopr) =>
  int_stream_map_cloref{a}(n0, fopr)
//
) (* end of [int_stream_map_method] *)
//
#endif // ATSCC_STREAM

(* ****** ****** *)

#if
defined(ATSCC_STREAM_VT)
//
implement
int_stream_vt_map_cloref
  {a}(n0, fopr) = let
//
fun
aux
{i:nat}
(
  i: int(i)
) : stream_vt(a) = $ldelay
(
//
if
(i < n0)
then (
  stream_vt_cons(fopr(i), aux(i+1))
) else stream_vt_nil((*void*))
// end of [if]
) : stream_vt_con(a) // [aux]
//
in
  aux(0)
end // end of [aux]
//
implement
int_stream_vt_map_method
  {a}(n0, tres) =
(
//
llam(fopr) =>
  int_stream_vt_map_cloref{a}(n0, fopr)
//
) (* end of [int_stream_vt_map_method] *)
//
#endif // ATSCC_STREAM_VT

(* ****** ****** *)
//
implement
int2_exists_cloref
  (n1, n2, pred) =
(
  intrange2_exists_cloref (0, n1, 0, n2, pred)
)
implement
int2_forall_cloref
  (n1, n2, pred) =
(
  intrange2_forall_cloref (0, n1, 0, n2, pred)
)
//
implement
int2_foreach_cloref
  (n1, n2, pred) =
(
  intrange2_foreach_cloref (0, n1, 0, n2, pred)
)
//
(* ****** ****** *)

implement
intrange_exists_cloref
  (l, r, pred) = let
//
fun
loop
(
  l: int, r: int, pred: cfun1(int, bool)
) : bool = (
//
if l < r
  then (
    if pred(l) then true else loop (l+1, r, pred)
  ) else false
//
) (* end of [loop] *)
//
in
  loop (l, r, pred)
end // end of [intrange_exists_cloref]
//
implement
intrange_exists_method(lr) =
(
lam(pred) =>
  intrange_exists_cloref(lr.0, lr.1, pred)
) (* intrange_exists_method *)
//
(* ****** ****** *)

implement
intrange_forall_cloref
  (l, r, pred) = let
//
fun
loop
(
  l: int, r: int, pred: cfun1(int, bool)
) : bool = (
//
if l < r
  then (
    if pred(l) then loop(l+1, r, pred) else false
  ) else true
//
) (* end of [loop] *)
//
in
  loop (l, r, pred)
end // end of [intrange_forall_cloref]
//
implement
intrange_forall_method(lr) =
(
lam(pred) =>
  intrange_forall_cloref(lr.0, lr.1, pred)
) (* intrange_forall_method *)
//
(* ****** ****** *)

implement
intrange_foreach_cloref
  (l, r, fwork) = let
//
fun
loop (
  l: int, r: int, fwork: cfun1(int, void)
) : void = (
//
if (l < r)
then let
  val () = fwork(l) in loop(l+1, r, fwork)
end // end of [then]
else ((*void*)) // else
//
) (* end of [loop] *)
//
in
  loop(l, r, fwork)
end // end of [intrange_foreach_cloref]
//
implement
intrange_foreach_method(lr) =
(
lam(fwork) =>
  intrange_foreach_cloref(lr.0, lr.1, fwork)
) (* intrange_foreach_method *)
//
(* ****** ****** *)

implement
intrange_foldleft_cloref
  {res}
  (l, r, ini, fopr) = let
//
fun
loop
(
  l: int, r: int
, ini: res, f: cfun2(res, int, res)
) : res = (
//
if l < r then loop(l+1, r, f(ini, l), fopr) else ini
//
) (* end of [loop] *)
//
in
  loop(l, r, ini, fopr)
end // end of [intrange_foldleft_cloref]

(* ****** ****** *)
//
implement
intrange_foldleft_method
  {res}
  ( $tup(l, r), ini ) =
(
  lam(fopr) =>
    intrange_foldleft_cloref{res}(l, r, ini, fopr)
  // end of [lam]
)
//
(* ****** ****** *)

implement
intrange2_exists_cloref
  (l1_, r1_, l2_, r2_, pred) = let
//
// HX-2016-07-26:
// loop1 and loop2 need to have
// the same number of arguments
// in order to support atscc2clj
//
fnx
loop1
(
  l1: int, r1: int
, l2: int, r2: int
, f: cfun2 (int, int, bool)
) : bool = (
//
if l1 < r1
  then loop2(l1, r1, l2, r2, pred) else false
//
) (* end of [loop1] *)
//
and
loop2
(
  l1: int, r1: int
, l2: int, r2: int
, pred: cfun2 (int, int, bool)
) : bool = (
//
if (
l2 < r2
) then (
//
if (
pred(l1, l2)
) then true
  else loop2(l1, r1, l2+1, r2, pred)
// end of [if]
) else loop1(l1+1, r1, l2_, r2_, pred)
//
) (* end of [loop2] *)
//
in
  loop1(l1_, r1_, l2_, r2_, pred)
end // end of [intrange2_exists_cloref]

(* ****** ****** *)

implement
intrange2_forall_cloref
  (l1_, r1_, l2_, r2_, pred) = let
//
// HX-2016-07-26:
// loop1 and loop2 need to have
// the same number of arguments
// in order to support atscc2clj
//
fnx
loop1
(
  l1: int, r1: int
, l2: int, r2: int
, pred: cfun2 (int, int, bool)
) : bool = (
//
if l1 < r1
  then loop2 (l1, r1, l2, r2, pred) else true
//
) (* end of [loop1] *)
//
and
loop2
(
  l1: int, r1: int
, l2: int, r2: int
, pred: cfun2 (int, int, bool)
) : bool = (
//
if (
l2 < r2
) then
(
if (
pred(l1, l2)
) then loop2(l1, r1, l2+1, r2, pred)
  else false
// end of [if]
) else loop1(l1+1, r1, l2_, r2_, pred)
//
) (* end of [loop2] *)
//
in
  loop1 (l1_, r1_, l2_, r2_, pred)
end // end of [intrange2_forall_cloref]

(* ****** ****** *)

implement
intrange2_foreach_cloref
  (l1_, r1_, l2_, r2_, fwork) = let
//
// HX-2016-07-26:
// loop1 and loop2 need to have
// the same number of arguments
// in order to support atscc2clj
//
fnx
loop1
(
  l1: int, r1: int
, l2: int, r2: int
, fwork: cfun2 (int, int, void)
) : void = (
//
if l1 < r1
  then loop2(l1, r1, l2, r2, fwork)
  else ((*void*))
//
) (* end of [loop1] *)
//
and
loop2
(
  l1: int, r1: int
, l2: int, r2: int
, fwork: cfun2 (int, int, void)
) : void = (
//
if (
l2 < r2
) then (
//
fwork(l1, l2);
loop2(l1, r1, l2+1, r2, fwork)
//
) else (
  loop1(succ(l1), r1, l2_, r2_, fwork)
) (* end of [else] *)
//
) (* end of [loop2] *)
//
in
  loop1 (l1_, r1_, l2_, r2_, fwork)
end // end of [intrange2_foreach_cloref]

(* ****** ****** *)

(* end of [intrange.dats] *)

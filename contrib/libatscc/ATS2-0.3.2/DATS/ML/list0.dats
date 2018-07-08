(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload
"./../../SATS/ML/list0.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
{}(*tmp*)
list0_sing(x) =
  list0_cons(x, list0_nil())
//
implement
{}(*tmp*)
list0_pair(x, y) =
  list0_cons(x, list0_cons(y, list0_nil()))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
list0_is_nil(xs) =
(
case+ xs of
| list0_nil() => true | _ =>> false
)
implement
{}(*tmp*)
list0_is_cons(xs) =
(
case+ xs of
| list0_cons _ => true | _ =>> false
)
//
(* ****** ****** *)
//
implement
list0_head_opt
  {a}(xs) =
(
case+ xs of
| list0_nil() => None_vt()
| list0_cons(x, _) => Some_vt(x)
) (* end of [list0_head_opt] *)
//
(* ****** ****** *)
//
implement
list0_tail_opt
  {a}(xs) =
(
case+ xs of
| list0_nil() => None_vt()
| list0_cons(_, xs) => Some_vt(xs)
) (* end of [list0_tail_opt] *)
//
(* ****** ****** *)
//
implement
list0_length{a}(xs) =
  list_length{a}($UN.cast{List0(a)}(xs))
//
(* ****** ****** *)

implement
list0_last_opt
  {a}(xs) = let
//
fun
loop
(
  x0: a, xs: list0(a)
) : a =
(
case+ xs of
| list0_nil() => x0
| list0_cons(x1, xs) => loop(x1, xs)
)
//
in
  case+ xs of
  | list0_nil() => None_vt()
  | list0_cons(x, xs) => Some_vt(loop(x, xs))
end // end of [list0_last_opt]

(* ****** ****** *)
//
implement
list0_get_at_opt
  (xs, n) =
(
case+ xs of
| list0_nil() =>
    None_vt()
  // list0_nil
| list0_cons(x, xs) =>
  if n > 0
    then list0_get_at_opt(xs, n-1) else Some_vt(x)
  // end of [list0_cons]
) (* end of [list0_get_at_opt] *)
//
(* ****** ****** *)

implement
list0_make_elt
  (n, x) = let
//
val n = g1ofg0(n)
//
in
//
if n >= 0
  then g0ofg1(list_make_elt(n, x)) else list0_nil()
//
end // end of [list0_make_elt]

(* ****** ****** *)
//
implement
list0_make_intrange_2
  (l, r) = $UN.cast(list_make_intrange_2(l, r))
implement
list0_make_intrange_3
  (l, r, d) = $UN.cast(list_make_intrange_3(l, r, d))
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
fprint_list0
  (out, xs) = let
//
fun
loop
(
  xs: list0(a), i0: int
) : void =
(
//
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) =>
  (
    if i0 > 0
      then fprint_list0$sep<>(out);
    // end of [if]
    fprint_val<a>(out, x); loop(xs, i0+1)
  ) (* end of [list0_cons] *)
//
) (* end of [loop] *)
//
in
  loop (xs, 0)
end // end of [fprint_list0]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_list0$sep
  (out) =
(
  fprint_string(out, ", ")
)
//
(* ****** ****** *)

implement
{a}(*tmp*)
fprint_list0_sep
  (out, xs, sep) = let
//
implement
fprint_list0$sep<>
  (out) =
(
  fprint_string(out, ", ")
)
//
in
  fprint_list0<a> (out, xs)
end // end of [fprint_list0_sep]

(* ****** ****** *)
//
implement
list0_snoc{a}(xs, x0) =
(
g0ofg1{a}
(
  list_snoc{a}(g1ofg0(xs), x0)
)
)
implement
list0_extend{a}(xs, x0) =
(
g0ofg1{a}
(
  list_extend{a}(g1ofg0(xs), x0)
)
) // list0_extend
//
(* ****** ****** *)
//
implement
list0_append
  {a}(xs, ys) =
(
g0ofg1
(
list_append{a}
  (g1ofg0{a}(xs), g1ofg0{a}(ys))
)
) // list0_append
//
(* ****** ****** *)
//
implement
mul_int_list0
  {a}(m, xs) =
(
g0ofg1{a}
  (mul_int_list{a}(m, g1ofg0(xs)))
)
//
(* ****** ****** *)
//
implement
list0_reverse{a}(xs) =
(
g0ofg1(list_reverse{a}(g1ofg0(xs)))
)
//
implement
list0_reverse_append{a}(xs, ys) =
(
g0ofg1
(
list_reverse_append{a}(g1ofg0(xs), g1ofg0(ys))
)
)
//
(* ****** ****** *)
//
implement
list0_concat{a}
  (xss) =
(
  g0ofg1{a}(list_concat{a}($UN.cast(xss)))
) // list0_concat
//
(* ****** ****** *)

implement
list0_remove_at_opt
  {a}
(
  xs, i0
) = aux(xs, 0) where
{
//
fun
aux
(
xs: list0(a)
,
i0: intGte(0)
) : Option_vt(list0(a)) =
(
case+ xs of
| list0_nil() =>
    None_vt()
  // list0_nil
| list0_cons(x, xs) =>
  if i0 > 0
    then let
      val opt = aux(xs, i0-1)
    in
      case+ opt of
      | ~None_vt() => None_vt()
      | ~Some_vt(xs) => Some_vt(list0_cons(x, xs))
    end // end of [then]
    else Some_vt(xs) // end of [else]
  // end of [if]
)
//
} (* end of [list0_remove_at_opt] *)

(* ****** ****** *)
//
implement
list0_exists
  (xs, pred) =
  list_exists(g1ofg0(xs), pred)
//
implement
list0_exists_method
  {a}(xs) =
  lam(pred) => list0_exists{a}(xs, pred)
//
(* ****** ****** *)
//
implement
list0_iexists
  (xs, pred) =
  list_iexists(g1ofg0(xs), pred)
//
implement
list0_iexists_method
  {a}(xs) =
  lam(pred) => list0_iexists{a}(xs, pred)
//
(* ****** ****** *)
//
implement
list0_forall
  (xs, pred) =
  list_forall(g1ofg0(xs), pred)
//
implement
list0_forall_method
  {a}(xs) =
  lam(pred) => list0_forall{a}(xs, pred)
//
(* ****** ****** *)
//
implement
list0_iforall
  (xs, pred) =
  list_iforall(g1ofg0(xs), pred)
//
implement
list0_iforall_method
  {a}(xs) =
  lam(pred) => list0_iforall{a}(xs, pred)
//
(* ****** ****** *)
//
implement
list0_app{a}
  (xs, fwork) =
  list0_foreach{a}(xs, fwork)
implement
list0_foreach{a}
  (xs, fwork) =
  list_foreach{a}(g1ofg0(xs), fwork)
//
implement
list0_foreach_method
  {a}(xs) =
  lam(fwork) => list0_foreach{a}(xs, fwork)
//
(* ****** ****** *)
//
implement
list0_iforeach{a}
  (xs, fwork) =
  list_iforeach{a}(g1ofg0(xs), fwork)
//
implement
list0_iforeach_method
  {a}(xs) =
  lam(fwork) => list0_iforeach{a}(xs, fwork)
//
(* ****** ****** *)
//
implement
list0_rforeach{a}
  (xs, fwork) =
  list_rforeach{a}(g1ofg0(xs), fwork)
//
implement
list0_rforeach_method
  {a}(xs) =
  lam(fwork) => list0_rforeach{a}(xs, fwork)
//
(* ****** ****** *)
//
implement
list0_filter
  {a}(xs, pred) =
  g0ofg1(list_filter(g1ofg0(xs), pred))
//
implement
list0_filter_method
  {a}(xs) =
  lam(pred) => list0_filter{a}(xs, pred)
//
(* ****** ****** *)
//
implement
list0_labelize
  {x}(xs) =
  g0ofg1(list_labelize(g1ofg0(xs)))
//
(* ****** ****** *)
//
implement
list0_map
  {a}{b}
  (xs, fopr) =
  g0ofg1(list_map(g1ofg0(xs), fopr))
//
implement
list0_map_method
  {a}{b}(xs, _) =
  lam(fopr) => list0_map{a}{b}(xs, fopr)
//
(* ****** ****** *)
//
implement
list0_imap
  {a}{b}
  (xs, fopr) =
  g0ofg1(list_imap(g1ofg0(xs), fopr))
//
implement
list0_imap_method
  {a}{b}(xs, _) =
  lam(fopr) => list0_imap{a}{b}(xs, fopr)
//
(* ****** ****** *)
//
implement
list0_map2
{a1,a2}{b}
( xs1
, xs2
, fopr
) = g0ofg1
(
  list_map2(g1ofg0(xs1), g1ofg0(xs2), fopr)
) (* g0ofg1 *)
//
(* ****** ****** *)
//
implement
list0_mapcons
  {a}(x0, xss) =
(
case+ xss of
| list0_nil() =>
  list0_nil()
| list0_cons(xs, xss) =>
  list0_cons
  (list0_cons(x0, xs), list0_mapcons(x0, xss))
)
//
(* ****** ****** *)

implement
list0_tabulate
  {a}(n0, fopr) =
  auxmain(0) where
{
//
fun
auxmain
(i: int): list0(a) =
(
if
(i < n0)
then
list0_cons
(fopr(i), auxmain(i+1)) else list0_nil((*void*))
)
//
} (* end of [list0_tabulate] *)

(* ****** ****** *)

implement
list0_find_opt
  (xs, pred) =
(
case+ xs of
| list0_nil() =>
  None_vt((*void*))
| list0_cons(x, xs) =>
  if pred(x)
    then Some_vt(x)
    else list0_find_opt(xs, pred)
  // end of [if]
) (* end of [list0_find_opt] *)

implement
list0_find_opt_method
  {a}(xs) =
(
  lam(pred) => list0_find_opt{a}(xs, pred)
) (* end of [list0_find_opt_method] *)

(* ****** ****** *)

implement
list0_find_suffix
  (xs, pred) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs1) =>
  if pred(xs)
    then (xs)
    else list0_find_suffix(xs1, pred)
  // end of [if]
) (* end of [list0_find_suffix] *)

implement
list0_find_suffix_method
  {a}(xs) =
(
  lam(pred) => list0_find_suffix{a}(xs, pred)
) (* end of [list0_find_suffix_method] *)

(* ****** ****** *)

implement
list0_zip
  {a,b}
  (xs, ys) = let
//
fun
aux :
$d2ctype
(list0_zip) =
lam(xs, ys) =>
(
case+ xs of
| nil0() => nil0()
| cons0(x, xs) =>
  (
    case+ ys of
    | nil0() => nil0()
    | cons0(y, ys) => cons0($tup(x, y), aux(xs, ys))
  ) (* end of [cons0] *)
)
//
in
  aux{a,b}(xs, ys)
end // end of [list0_zip]

(* ****** ****** *)

implement
list0_zipwith
  {a1,a2}{b}
  (xs, ys, fopr) = let
//
fun
aux :
$d2ctype
(list0_zipwith) =
lam(xs, ys, fopr) =>
(
case+ xs of
| nil0() => nil0()
| cons0(x, xs) =>
  (
    case+ ys of
    | nil0() => nil0()
    | cons0(y, ys) =>
      cons0(fopr(x, y), aux(xs, ys, fopr))
  ) (* end of [cons0] *)
)
//
in
  aux{a1,a2}{b}(xs, ys, fopr)
end // end of [list0_zipwith]

implement
list0_zipwith_method
  {a1,a2}{b}(xs, ys) =
(
  lam(fopr) => list0_zipwith{a1,a2}{b}(xs, ys, fopr)
) (* end of [list0_zipwith_method] *)

(* ****** ****** *)

implement
list0_foldleft
  {res}{a}
  (xs, init, fopr) = let
//
fun
aux
(
  res: res, xs: list0(a)
) : res =
  case+ xs of
  | list0_nil() => res
  | list0_cons(x, xs) => aux(fopr(res, x), xs)
//
in
  aux(init, xs)
end // end of [list0_foldleft]

(* ****** ****** *)

implement
list0_foldright
  {a}{res}
  (xs, fopr, sink) = let
//
fun
aux
(
  xs: list0(a), res: res
) : res =
(
case+ xs of
| list0_nil() => res
| list0_cons(x, xs) => fopr(x, aux(xs, sink))
) (* end of [aux] *)
//
in
  aux(xs, sink)
end // end of [list0_foldright]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_sort_1(xs) =
  g0ofg1(list_sort_1<a>(g1ofg0(xs)))
//
implement
list0_sort_2(xs, cmp) =
  g0ofg1(list_sort_2(g1ofg0(xs), cmp))
//
(* ****** ****** *)
//
implement
list0_mergesort
  {a}(xs, cmp) =
  g0ofg1(list_mergesort(g1ofg0(xs), cmp))
//
(* ****** ****** *)
//
implement
streamize_list0_zip
  {a,b}(xs, ys) =
(
  streamize_list_zip{a,b}(g1ofg0(xs), g1ofg0(ys))
)
implement
streamize_list0_cross
  {a,b}(xs, ys) =
(
  streamize_list_cross{a,b}(g1ofg0(xs), g1ofg0(ys))
)
//
(* ****** ****** *)

#if
defined(ATSCC_STREAM_VT)
#then
//
implement
streamize_list0_nchoose
  {a}(xs, n) = let
//
fun
auxmain
(
xs: list0(a), n: intGte(0)
) : stream_vt(list0(a)) = $ldelay
(
//
if
(n > 0)
then
(
case+ xs of
| list0_nil() =>
    stream_vt_nil()
  // list0_nil
| list0_cons(x0, xs1) => let
    val res1 =
      auxmain(xs1, n-1)
    // end of [val]
    val res2 = auxmain(xs1, n)
  in
    !(
      // lazy_vt_force
      stream_vt_append
      (
        stream_vt_map_cloref
          {list0(a)}{list0(a)}
          (res1, lam(ys) => list0_cons(x0, ys)), res2
      ) // stream_vt_append
    ) (* lazy_vt_force *)
  end // end of [list0_cons]
) (* end of [then] *)
else
(
  stream_vt_cons(list0_nil, stream_vt_make_nil((*void*)))
) (* end of [else] *)
//
) : stream_vt_con(list0(a)) // auxmain
//
in
  $effmask_all(auxmain(xs, n))
end (* end of [streamize_list0_nchoose] *)
//
#endif // ATSCC_STREAM_VT

(* ****** ****** *)

#if
defined(ATSCC_STREAM_VT)
#then
//
implement
streamize_list0_nchoose_rest
  {a}(xs, n) = let
//
typedef
tuplist =
$tup(list0(a), list0(a))
//
fun
auxmain
(
xs: list0(a), n: intGte(0)
) : stream_vt(tuplist) = $ldelay
(
//
if
(n > 0)
then
(
case+ xs of
| list0_nil() =>
    stream_vt_nil()
  // list0_nil
| list0_cons(x0, xs1) => let
    val res1 =
      auxmain(xs1, n-1)
    // end of [val]
    val res2 = auxmain(xs1, n)
  in
    !(
      // lazy_vt_force
      stream_vt_append
      ( stream_vt_map_cloref
          {tuplist}{tuplist}
        (
          res1
        , lam(ysys) => $tup(list0_cons(x0, ysys.0), ysys.1)
        )
      , stream_vt_map_cloref
          {tuplist}{tuplist}
        (
          res2
        , lam(ysys) => $tup(ysys.0, list0_cons(x0, ysys.1))
        )
      ) // stream_vt_append
    ) (* lazy_vt_force *)
  end // end of [list0_cons]
) (* end of [then] *)
else stream_vt_cons($tup(list0_nil, xs), stream_vt_make_nil())
//
) : stream_vt_con(tuplist) // auxmain
//
in
  $effmask_all(auxmain(xs, n))
end (* end of [streamize_list0_nchoose_rest] *)
//
#endif // ATSCC_STREAM_VT

(* ****** ****** *)

(* end of [list0.dats] *)

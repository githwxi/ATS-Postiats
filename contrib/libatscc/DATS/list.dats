(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/list.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
{}(*tmp*)
list_is_nil(xs) =
(
case+ xs of list_nil() => true | _ =>> false
)
implement
{}(*tmp*)
list_is_cons(xs) =
(
case+ xs of list_cons _ => true | _ =>> false
)
//
(* ****** ****** *)
//
implement
list_make_elt
  {x}(n, x) =
  loop(n, list_nil()) where
{
//
fun
loop
{i,j:nat} .<i>.
(
i0: int(i), res: list(x, j)
) :<> list(x, i+j) =
(
if i0 > 0
  then loop(i0-1, list_cons{x}(x, res))
  else res
)
//
} (* end of [list_make_elt] *)
//
(* ****** ****** *)
//
implement
list_make_intrange_2
  (l, r) = list_make_intrange_3 (l, r, 1)
//
(* ****** ****** *)

implement
list_make_intrange_3
  (l, r, d) = let
//
fun loop1
(
  n: int, x: int, d: intGt(0), res: List0(int)
) : List0(int) =
  if n > 0 then loop1 (n-1, x - d, d, list_cons (x, res)) else res
fun loop2
(
  n: int, x: int, d: intGt(0), res: List0(int)
) : List0(int) =
  if n > 0 then loop2 (n-1, x + d, d, list_cons (x, res)) else res
//
in
//
case+ 0 of
| _ when d > 0 =>
    if l < r then let
      val d =
        $UN.cast{intGt(0)}(d)
      // end of [val]
      val n = (r - l + d - 1) / d
    in
      loop1 (n, l + (n - 1) * d, d, list_nil)
    end else list_nil ()
| _ when d < 0 =>
    if l > r then let
      val d =
        $UN.cast{intGt(0)}(~d)
      val n = (l - r + d - 1) / d
    in
      loop2 (n, l - (n - 1) * d, d, list_nil)
    end else list_nil ()
| _ (* d = 0 *) => list_nil ()
//
end // end of [list_make_intrange_3]

(* ****** ****** *)
//
implement
{a}(*tmp*)
fprint_list
  (out, xs) = let
//
fun
loop
(
  xs: List(a), i: int
) : void =
(
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  (
    if i > 0
      then fprint_list$sep<>(out);
    // end of [if]
    fprint_val<a>(out, x); loop(xs, i+1)
  ) (* end of [list_cons] *)
//
) (* end of [loop] *)
//
in
  loop (xs, 0)
end // end of [fprint_list]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_list$sep
  (out) = fprint_string (out, ", ")
//
(* ****** ****** *)

implement
{a}(*tmp*)
fprint_list_sep
  (out, xs, sep) = let
//
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<a> (out, xs)
end // end of [fprint_list_sep]

(* ****** ****** *)

implement
list_length
  {a}(xs) = let
//
fun
loop{i,j:int}
(
  xs: list(a, i), j: int(j)
) : int(i+j) =
(
case+ xs of
| list_nil () => j
| list_cons (_, xs) => loop (xs, j+1)
) (* end of [loop] *)
//
in
  loop (xs, 0)
end // end of [list_length]

(* ****** ****** *)
//
implement
list_length_gte
{x}(xs, n2) =
  (list_length_compare{x}(xs, n2) >= 0)
//
implement
list_length_compare
{x}(xs, n2) =
  loop(xs, n2) where
{
//
fun
loop
{i:nat;j:int} .<i>.
(xs: list(x, i), j: int j) :<> int(sgn(i-j)) =
(
if
(j < 0)
then 1 else
(
case+ xs of
| list_cons
    (_, xs) => loop(xs, j-1)
  // list_cons
| _ (*list_nil*) =>> (if j = 0 then 0 else ~1)
)
) (* end of [loop] *)
//
prval() = lemma_list_param(xs)
//
} (* end of [list_length_compare] *)

(* ****** ****** *)
//
implement
list_head(xs) =
let val+list_cons(x, _) = xs in x end
implement
list_tail(xs) =
let val+list_cons(_, xs) = xs in xs end
//
(* ****** ****** *)

implement
list_last(xs) = let
  val+list_cons(x, xs) = xs
in
  case+ xs of
  | list_nil() => x | list_cons _ =>> list_last(xs)
end // end of [list_last]

(* ****** ****** *)

implement
list_get_at
  {a}(xs, i) = (
//
if
(i = 0)
then let
  val+list_cons(x, xs) = xs in x
end // end of [then]
else let
  val+list_cons(_, xs) = xs in list_get_at(xs, i-1)
end // end of [else]
//
) (* end of [list_get_at] *)

(* ****** ****** *)
//
implement
list_snoc
  (xs, x0) =
  list_append(xs, list_sing(x0))
implement
list_extend
  (xs, x0) =
  list_append(xs, list_sing(x0))
//
(* ****** ****** *)

implement
list_append
  (xs, ys) = let
//
prval() = lemma_list_param(xs)
prval() = lemma_list_param(ys)
//
in
//
case+ xs of
| list_nil () =>  ys
| list_cons (x, xs) =>
    list_cons (x, list_append (xs, ys))
  // end of [list_cons]
//
end // end of [list_append]

(* ****** ****** *)
//
implement
mul_int_list
{a}{m,n}(m, xs) = let
//
fun
loop
{i,j:nat}
(
i0: int(i),
res: list(a, j*n)
) : list(a, (i+j)*n) =
if
(i0 > 0)
then
(
loop{i-1,j+1}
  (i0-1, list_append{a}(xs, res))
)
else
(
res where
{
  prval EQINT() = eqint_make{i,0}()
}
) (* end of [else] *)
//
in
  loop{m,0}(m, list_nil((*void*)))
end // end of [mul_int_list]
//
(* ****** ****** *)

implement
list_reverse{a}(xs) =
(
  list_reverse_append{a}(xs, list_nil(*void*))
) (* end of [list_reverse] *)

(* ****** ****** *)

implement
list_reverse_append
  {a}(xs, ys) = let
//
prval () = lemma_list_param (xs)
prval () = lemma_list_param (ys)
//
fun
loop{i,j:nat}
(
  xs: list(a, i), ys: list(a, j)
) : list(a, i+j) =
(
case+ xs of
| list_nil () => ys
| list_cons (x, xs) => loop (xs, list_cons (x, ys))
) (* end of [loop] *)
//
in
  loop (xs, ys)
end // end of [list_reverse_append]

(* ****** ****** *)

implement
list_concat
  {a}(xss) =
  auxlst(xss) where
{
//
fun
auxlst
(
  xss: List(List(a))
) : List0(a) =
(
//
case+ xss of
| list_nil() =>
  list_nil()
| list_cons
    (xs, xss) =>
  list_append
  (
    xs, auxlst(xss)
  ) where
  {
    prval () = lemma_list_param(xs)
  } (* end of [list_cons] *)
//
)
//
} (* end of [list_concat] *)

(* ****** ****** *)

implement
list_take(xs, i) =
(
//
if
i > 0
then let
  val+list_cons(x, xs) = xs
in
  list_cons(x, list_take(xs, i-1))
end // end of [then]
else list_nil() // end of [else]
//
) (* end of [list_take] *)

implement
list_drop(xs, i) =
(
//
if
i > 0
then let
  val+list_cons(_, xs) = xs in list_drop(xs, i-1)
end // end of [then]
else xs // end of [else]
//
) (* end of [list_drop] *)

(* ****** ****** *)

implement
list_split_at
  (xs, i) =
(
  $tup(list_take(xs, i), list_drop(xs, i))
) (* end of [list_split_at] *)

(* ****** ****** *)

implement
list_insert_at
  (xs, i, x0) = (
//
if
(i > 0)
then let
//
val+
list_cons(x, xs) = xs
//
in
//
list_cons
  (x, list_insert_at(xs, i-1, x0))
//
end // end of [then]
else list_cons(x0, xs)
//
) (* end of [list_insert_at] *)
  
(* ****** ****** *)

implement
list_remove_at
  (xs, i) = let
//
val+list_cons(x, xs) = xs
//
in
//
if
(i > 0)
then
list_cons
  (x, list_remove_at(xs, i-1))
// end of [then]
else xs // end of [else]
//
end (* end of [list_remove_at] *)

(* ****** ****** *)

implement
list_takeout_at
  (xs, i) = let
//
val+list_cons (x, xs) = xs
//
in
//
if
(i > 0)
then let
//
val $tup(x_rem, xs) =
  list_takeout_at (xs, i-1)
//
in
  $tup(x_rem, list_cons(x, xs))
end // end of [then]
else $tup(x, xs) // end of [else]
//
end (* end of [list_takeout_at] *)

(* ****** ****** *)
//  
implement
list_exists
  (xs, pred) =
(
  case+ xs of
  | list_nil() => false
  | list_cons(x, xs) =>
    (pred(x) || list_exists(xs, pred))
) (* end of [list_exists] *)
//
implement
list_exists_method
  {a}(xs) =
  lam(pred) => list_exists{a}(xs, pred)
//  
(* ****** ****** *)
//
implement
list_iexists
  {a}
(
  xs, pred
) = loop(0, xs) where
{
//
fun loop
(
  i: intGte(0), xs: List(a)
) : bool =
(
  case+ xs of
  | list_nil() => false
  | list_cons(x, xs) =>
    (pred(i, x) || loop(i+1, xs))
)
} (* end of [list_iexists] *)
//
implement
list_iexists_method
  {a}(xs) =
  lam(pred) => list_iexists{a}(xs, pred)
//  
(* ****** ****** *)
//
implement
list_forall
  (xs, pred) =
(
  case+ xs of
  | list_nil() => (true)
  | list_cons(x, xs) =>
    (pred(x) && list_forall(xs, pred))
) (* end of [list_forall] *)
//
implement
list_forall_method
  {a}(xs) =
  lam(pred) => list_forall{a}(xs, pred)
//
(* ****** ****** *)
//
implement
list_iforall
  {a}
(
  xs, pred
) = loop(0, xs) where
{
//
fun loop
(
  i: intGte(0), xs: List(a)
) : bool =
(
  case+ xs of
  | list_nil() => (true)
  | list_cons(x, xs) =>
    (pred(i, x) && loop(i+1, xs))
)
} (* end of [list_iforall] *)
//
implement
list_iforall_method
  {a}(xs) =
  lam(pred) => list_iforall{a}(xs, pred)
//  
(* ****** ****** *)
//
implement
list_app(xs, f) = list_foreach(xs, f)
//
implement
list_foreach
  (xs, f) = (
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (f(x); list_foreach(xs, f))
//
) (* end of [list_foreach] *)
//
implement
list_foreach_method
  {a}(xs) =
  lam(fwork) => list_foreach{a}(xs, fwork)
//  
(* ****** ****** *)
//
implement
list_iforeach
  {a}(xs, fwork) = let
//
fun
aux
(
  i: Nat, xs: List(a)
) : void =
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork(i, x); aux(i+1, xs))
//
in
  aux(0, xs)
end (* end of [list_iforeach] *)
//
implement
list_iforeach_method
  {a}(xs) =
  lam(fwork) => list_iforeach{a}(xs, fwork)
//  
(* ****** ****** *)
//
implement
list_rforeach
  (xs, f) = (
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (list_rforeach(xs, f); f(x))
//
) (* end of [list_rforeach] *)
//
implement
list_rforeach_method
  {a}(xs) = lam(fwork) => list_rforeach{a}(xs, fwork)
//  
(* ****** ****** *)

implement
list_filter
  {a}(xs, p) = aux(xs) where
{
//
fun
aux{n:int}
(
  xs: list(a, n)
) : listLte(a, n) =
  case+ xs of
  | list_nil() => list_nil()
  | list_cons(x, xs) =>
    (
      if p(x)
        then list_cons(x, aux(xs)) else aux(xs)
      // end of [if]
    ) // end of [list_cons]
//
} (* end of [list_filter] *)
//
implement
list_filter_method
  {a}(xs) =
  lam(pred) => list_filter{a}(xs, pred)
//  
(* ****** ****** *)
//
implement
list_labelize
  {a}(xs) =
  list_imap{a}(xs, lam(i, x) => $tup(i, x))
//
(* ****** ****** *)
//
implement
list_map
  {a}{b}
(
  xs, fopr
) = aux(xs) where
{
//
fun
aux
{n:nat} .<n>.
(
xs: list(a, n)
) : list(b, n) =
(
case+ xs of
| list_nil() =>
  list_nil()
| list_cons(x, xs) =>
  list_cons(fopr(x), aux(xs))
) (* end of [aux] *)
//
prval () = lemma_list_param(xs)
//
} (* end of [list_map] *)
//
implement
list_map_method
  {a}(xs, _) =
  lam(fopr) => list_map{a}(xs, fopr)
//
(* ****** ****** *)
//
implement
list_imap
  {a}{b}
(
  xs, fopr
) = aux(0, xs) where
{
//
fun
aux
{n:nat} .<n>.
(
i0: Nat,
xs: list(a, n)
) : list(b, n) =
(
case+ xs of
| list_nil() =>
  list_nil()
| list_cons(x, xs) =>
  list_cons(fopr(i0, x), aux(i0+1, xs))
) (* end of [aux] *)
//
prval () = lemma_list_param(xs)
//
} (* end of [list_imap] *)
//
implement
list_imap_method
  {a}(xs, _) = lam(fopr) => list_imap{a}(xs, fopr)
//
(* ****** ****** *)
//
implement
list_map2
(
  xs1, xs2, fopr
) = let
//
prval() =
lemma_list_param(xs1)
prval() =
lemma_list_param(xs2)
//
in
//
case+ xs1 of
| list_nil() =>
  list_nil()
| list_cons(x1, xs1) =>
  (
    case+ xs2 of
    | list_nil() =>
      list_nil()
    | list_cons(x2, xs2) =>
      list_cons(fopr(x1, x2), list_map2(xs1, xs2, fopr))
  )
//
end (* end of [list_map2] *)
//
(* ****** ****** *)

implement
list_foldleft
  {res}{a}
  (xs, init, fopr) = let
//
fun
loop
(
   res: res, xs: List(a)
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) => loop(fopr(res, x), xs)
)
//
in
  loop(init, xs)
end // end of [list_foldleft]
//
implement
list_foldleft_method
  {a}(xs, init) =
  lam(fopr) => list_foldleft{a}(xs, init, fopr)
//
(* ****** ****** *)

implement
list_ifoldleft
  {res}{a}
  (xs, init, fopr) = let
//
fun
loop
(
  i: Nat, res: res, xs: List(a)
) : res =
(
case+ xs of
| list_nil
    () => res
  // list_nil
| list_cons
    (x, xs) =>
    loop(i+1, fopr(i, res, x), xs)
  // list_cons
)
//
in
  loop(0(*index*), init, xs)
end // end of [list_ifoldleft]
//
implement
list_ifoldleft_method
  {a}(xs, init) =
(
  lam(fopr) => list_ifoldleft{a}(xs, init, fopr)
) (* list_ifoldleft_method *)
//
(* ****** ****** *)

implement
list_foldright
  {a}{res}
(
  xs, fopr, sink
) = aux(xs, sink) where
{
//
fun
aux
(
  xs: List(a), res: res
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) => fopr(x, aux(xs, res))
)
//
} (* end of [list_foldright] *)
//
implement
list_foldright_method
  {a}{res}(xs, sink) =
  lam(fopr) => list_foldright{a}{res}(xs, fopr, sink)
//
(* ****** ****** *)

implement
list_ifoldright
  {a}{res}
(
  xs, fopr, sink
) = aux(0, xs, sink) where
{
//
fun
aux
(
  i: Nat, xs: List(a), res: res
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) => fopr(i, x, aux(i+1, xs, res))
)
//
} (* end of [list_foldright] *)
//
implement
list_ifoldright_method
  {a}{res}(xs, sink) =
(
lam(fopr) => list_ifoldright{a}{res}(xs, fopr, sink)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list_sort_1(xs) =
(
  list_sort_2{a}
    (xs, lam(x1, x2) => gcompare_val_val<a>(x1, x2))
  // end of [list_sort_2]
) (* list_sort_1 *)
//
(* ****** ****** *)
//
implement
list_mergesort
{a}(xs, cmp) = let
//
fun
msort
{n:int}
(
xs: list(a, n), n: int(n)
) : list(a, n) =
(
if
(n < 2)
then xs
else let
  val n2 = half(n)
  val
  $tup(xs1, xs2) =
  list_split_at(xs, n2)
in
  merge(msort(xs1, n2), msort(xs2, n-n2))
end // end of [then]
) (* end of [msort] *)
//
and
merge
{n1,n2:int}
(
xs10: list(a, n1)
,
xs20: list(a, n2)
) : list(a, n1+n2) =
(
case+ xs10 of
| list_nil() => xs20
| list_cons(x10, xs11) =>
  (
    case+ xs20 of
    | list_nil() => xs10
    | list_cons(x20, xs21) => let
        val sgn = cmp(x10, x20)
      in
        if
        (sgn <= 0)
        then list_cons(x10, merge(xs11, xs20))
        else list_cons(x20, merge(xs10, xs21))
      end // end of [list_cons]
  )
)
//
in
  msort(xs, list_length(xs))
end // end of [list_mergesort]
//
(* ****** ****** *)
//
#if
defined
(ATSCC_STREAM_VT)
#then
//
implement
streamize_list_elt
  {a}(xs) = let
//
fun
auxmain
(
xs: List(a)
) : stream_vt(a) = $ldelay
(
//
case+ xs of
| list_nil() => stream_vt_nil()
| list_cons(x, xs) => stream_vt_cons(x, auxmain(xs))
//
) (* end of [auxmain] *)
//
in
  $effmask_all(auxmain(xs))
end
//
#endif // if-defined(ATSCC_STREAM_VT)
//
(* ****** ****** *)

#if
defined
(ATSCC_STREAM_VT)
#then
//
implement
streamize_list_zip
  {a,b}(xs, ys) = let
//
fun
auxmain
(
  xs: List(a), ys: List(b)
) : stream_vt($tup(a, b)) = $ldelay
(
  case+ xs of
  | list_nil() =>
    stream_vt_nil()
  | list_cons(x, xs) =>
    (
      case+ ys of
      | list_nil() =>
        stream_vt_nil()
      | list_cons(y, ys) =>
        stream_vt_cons($tup(x, y), auxmain(xs, ys))
    ) (* end of [list_cons] *)
) : stream_vt_con($tup(a, b)) // auxmain
//
in
  $effmask_all(auxmain(xs, ys))
end // end of [streamize_list_zip]
//
#endif // if-defined(ATSCC_STREAM_VT)

(* ****** ****** *)

#if
defined
(ATSCC_STREAM_VT)
#then
//
implement
streamize_list_cross
  {a,b}(xs, ys) = let
//
fun
auxone
(
  x0: a, ys: List(b)
) : stream_vt($tup(a, b)) = $ldelay
(
case+ ys of
| list_nil() =>
  stream_vt_nil()
| list_cons(y, ys) =>
  stream_vt_cons($tup(x0, y), auxone(x0, ys))
) : stream_vt_con($tup(a, b))
//
fun
auxmain
(
  xs: List(a), ys: List(b)
) : stream_vt($tup(a, b)) = $ldelay
(
  case+ xs of
  | list_nil() =>
      stream_vt_nil()
    // end of [list_nil]
  | list_cons(x0, xs) =>
      !(stream_vt_append(auxone(x0, ys), auxmain(xs, ys)))
    // end of [list_cons]
) : stream_vt_con($tup(a, b)) // auxmain
//
in
  $effmask_all(auxmain(xs, ys))
end // end of [streamize_list_cross]
//
#endif // if-defined(ATSCC_STREAM_VT)

(* ****** ****** *)

(* end of [list.dats] *)

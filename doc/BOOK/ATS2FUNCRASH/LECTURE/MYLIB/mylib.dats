(* ****** ****** *)
//
// For use in
// Crash into ATS
//
(* ****** ****** *)
//
(*
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
*)
//
(* ****** ****** *)
//
(*
symelim iseqz
symelim isneqz
*)
//
symelim .head
symelim .tail
//
symelim .drop
symelim .take
//
symelim .foreach
symelim .foldleft
symelim .foldright
//
(* ****** ****** *)
//
extern
fun{}
int_foreach
( n0: int
, fwork: cfun(int, void)): void
extern
fun{}
int_foreach_method
(n0: int)(fwork: cfun(int, void)): void
//
overload .foreach with int_foreach_method of 100
//
(* ****** ****** *)

implement
{}(*tmp*)
int_foreach
  (n0, fwork) =
  loop(0) where
{
//
fun loop(i: int): void =
  if i < n0 then (fwork(i); loop(i+1))
//
} (* end of [int_foreach] *)

implement
{}(*tmp*)
int_foreach_method(n0) =
lam(fwork) => int_foreach<>(n0, fwork)

(* ****** ****** *)
//
extern
fun
{res:t@ype}
int_foldleft
( n0: int
, res: res
, fopr: cfun(res, int, res)): res
extern
fun
{res:t@ype}
int_foldleft_method
(n0: int, ty: TYPE(res))
(res: res, fopr: cfun(res, int, res)): res
//
overload .foldleft with int_foldleft_method of 100
//
(* ****** ****** *)
//
implement
{res}(*tmp*)
int_foldleft
  (n0, res, fopr) =
  loop(res, 0) where
{
//
fun loop(res: res, i: int): res =
  if i < n0
    then loop(fopr(res, i), i+1) else res
  // end of [if]
//
} (* end of [int_foldleft] *)
//
implement
{res}(*tmp*)
int_foldleft_method(n0, ty) =
lam(res, fopr) => int_foldleft<res>(n0, res, fopr)
//
(* ****** ****** *)
//
extern
fun{}
int_cross_foreach
(m: int, n: int, fwork: cfun(int, int, void)): void
//
implement
{}(*tmp*)
int_cross_foreach
  (m, n, fwork) =
  int_foreach(m, lam(i) => int_foreach(n, lam(j) => fwork(i, j)))
//
(* ****** ****** *)
//
// For list0-values
//
(* ****** ****** *)
//
extern
fun{}
list0_is_nil{a:t@ype}(list0(a)): bool
extern
fun{}
list0_is_cons{a:t@ype}(list0(a)): bool
//
implement
{}(*tmp*)
list0_is_nil(xs) =
(case+ xs of list0_nil() => true | _ => false)
implement
{}(*tmp*)
list0_is_cons(xs) =
(case+ xs of list0_cons _ => true | _ => false)
//
overload iseqz with list0_is_nil of 100
overload isneqz with list0_is_cons of 100
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_length(xs0: list0(INV(a))): int
//
(*
implement
list0_length
(
case+ xs0 of
| list0_nil() => 0
| list0_cons(x0, xs1) => 1 + list0_length<a>(xs1)
) (* end of [list0_length] *)
*)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_append
(xs: list0(INV(a)), ys: list0(a)): list0(a)
//
extern
fun
{a:t@ype}
list0_concat(xs: list0(list0(INV(a)))): list0(a)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_reverse(xs: list0(INV(a))): list0(a)
and
list0_revappend
(xs: list0(INV(a)), ys: list0(a)): list0(a)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_head_exn(xs: list0(INV(a))): (a)
extern
fun
{a:t@ype}
list0_tail_exn(xs: list0(INV(a))): list0(a)
//
implement
{a}(*tmp*)
list0_head_exn(xs) =
let val-list0_cons(x0, _) = xs in x0 end
implement
{a}(*tmp*)
list0_tail_exn(xs) =
let val-list0_cons(_, xs) = xs in xs end
//
overload .head with list0_head_exn of 100
overload .tail with list0_tail_exn of 100
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_get_at_exn
(xs: list0(INV(a)), n: int): a
//
implement
{a}(*tmp*)
list0_get_at_exn
  (xs, n) =
(
case- xs of
(*
| list0_nil() =>
  $raise ListSubscriptExn()
*)
| list0_cons(x, xs) =>
  if n <= 0
    then x else list0_get_at_exn<a>(xs, n-1)
  // end of [list0_cons]
)
//
overload [] with list0_get_at_exn of 100
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_drop_exn(list0(INV(a)), int): list0(a)
extern
fun
{a:t@ype}
list0_take_exn(list0(INV(a)), int): list0(a)
//
implement
{a}(*tmp*)
list0_drop_exn
  (xs, n) =
(
if
n > 0
then let
//
val-
list0_cons(_, xs) = xs
//
in
  list0_drop_exn<a>(xs, n-1)
//
end // end of [then]
else (xs) // end of [else]
//
) (* list0_drop_exn *)
//
implement
{a}(*tmp*)
list0_take_exn
  (xs, n) =
(
if
n > 0
then let
//
val-
list0_cons(x, xs) = xs
//
in
  list0_cons(x, list0_take_exn(xs, n-1))
end // end of [then]
else list0_nil() // end of [else]
//
) (* list0_take_exn *)
//
overload .drop with list0_drop_exn of 100
overload .take with list0_take_exn of 100
//
(* ****** ****** *)
//
extern
fun
{r:t@ype}
{a:t@ype}
list0_foldleft
(
xs: list0(INV(a)), r0: r, fopr: cfun(r, a, r)
) : (r) // end of [list0_foldleft]
//
implement
{r}{a}
list0_foldleft
(xs, r0, fopr) =
  loop(xs, r0) where
{
fun
loop(xs: list0(a), r0: r): r =
case+ xs of
| list0_nil() => r0
| list0_cons(x, xs) => loop(xs, fopr(r0, x))
}
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{r:t@ype}
list0_foldright
(
xs: list0(INV(a)), fopr: cfun(a, r, r), r0: r
) : (r) // end of [list0_foldright]
//
implement
{a}{r}
list0_foldright
( xs
, fopr, r0) =
auxlst(xs) where
{
fun
auxlst
(xs: list0(a)): r =
(
case+ xs of
| list0_nil() => r0
| list0_cons(x, xs) => fopr(x, auxlst(xs))
) (* end of [auxlst] *)
}
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_length(xs) =
  list0_foldleft<int><a>(xs, 0, lam(r, _) => r + 1)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_append(xs, ys) =
  list0_foldright<a><list0(a)>
  (xs, lam(x, ys) => list0_cons(x, ys), ys)
//
implement
{a}(*tmp*)
list0_concat(xss) =
  list0_foldright<list0(a)><list0(a)>
  (xss, lam(xs, res) => list0_append(xs, res), list0_nil())
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
list0_reverse(xs) =
  list0_revappend<a>(xs, list0_nil())
//
implement
{a}(*tmp*)
list0_revappend(xs, ys) =
  list0_foldleft<list0(a)><a>(xs, ys, lam(ys, x) => list0_cons(x, ys))
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
fprint_val
(out: FILEref, x0: a): void
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
print_list0
(xs: list0(INV(a))): void
extern
fun
{a:t@ype}
fprint_list0
(out: FILEref, xs: list0(INV(a))): void
//
overload print with print_list0 of 100
overload fprint with fprint_list0 of 100
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
print_list0(xs) =
fprint_list0<a>(stdout_ref, xs)
//
implement
{a}(*tmp*)
fprint_list0(out, xs) = let
//
fun
loop(i: int, xs: list0(a)): void =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) =>
  (
    if i > 0
      then fprint(out, ", ");
    // end of [if]
    fprint_val<a>(out, x); loop(i+1, xs)
  )
)
//
in
  loop(0, xs)
end // end of [fprint_list0]
//
(* ****** ****** *)

extern
fun
{a:t@ype}
{b:t@ype}
list0_map
(xs: list0(INV(a)), fopr: cfun(a, b)): list0(b)
extern
fun
{a:t@ype}
{b:t@ype}
list0_mapopt
(xs: list0(INV(a)), fopr: cfun(a, option0(b))): list0(b)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_foreach
(xs: list0(INV(a)), fwork: cfun(a, void)): void
//
(* ****** ****** *)

extern
fun
{a:t@ype}
list0_filter
(xs: list0(INV(a)), pred: cfun(a, bool)): list0(a)

(* ****** ****** *)

implement
{a}{b}
list0_map
(
  xs, fopr
) = auxlst(xs) where
{
//
fun
auxlst
(xs: list0(a)): list0(b) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  list0_cons(fopr(x), auxlst(xs))
)
//
} (* end of [list0_map] *)

(* ****** ****** *)

implement
{a}{b}
list0_mapopt
(
  xs, fopr
) = auxlst(xs) where
{
//
fun
auxlst
(xs: list0(a)): list0(b) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  (
  case+ fopr(x) of
  | None0() => auxlst(xs)
  | Some0(y) => list0_cons(y, auxlst(xs))
  )
)
//
} (* end of [list0_mapopt] *)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_mapcons
( x0: a
, xss: list0(list0(a))): list0(list0(a))
//
implement
{a}(*tmp*)
list0_mapcons
  (x0, xss) =
(
list0_map<list0(a)><list0(a)>(xss, lam(xs) => list0_cons(x0, xs))
) (* list0_mapcons *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
list0_mapjoin
( xs: list0(INV(a))
, fopr: cfun(a, list0(b))): list0(b)
//
implement
{a}{b}
list0_mapjoin
  (xs, fopr) =
(
  list0_concat<b>(list0_map<a><list0(b)>(xs, fopr))
)
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_foreach
(
  xs, fwork
) = loop(xs) where
{
//
fun
loop
(xs: list0(a)): void =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => (fwork(x); loop(xs))
)
//
} (* end of [list0_foreach] *)

(* ****** ****** *)

implement
{a}(*tmp*)
list0_filter
(
  xs, test
) = auxlst(xs) where
{
//
fun
auxlst
(xs: list0(a)): list0(a) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  if test(x)
    then list0_cons(x, auxlst(xs)) else auxlst(xs)
  // end of [if]
)
//
} (* end of [list0_filter] *)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
int_list0_map
( n: int
, fopr: cfun(int, a)): list0(a)
extern
fun
{a:t@ype}
int_list0_mapopt
( n: int
, fopr: cfun(int, option0(a))): list0(a)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
int_list0_map
  (n, fopr) =
  auxmain(0) where
{
fun
auxmain
(
 i: int
) : list0(a) =
if
(i < n)
then
(
  list0_cons(fopr(i), auxmain(i+1))
) else list0_nil((*void*))
} (* end of [int_list0_map] *)
//
implement
{a}(*tmp*)
int_list0_mapopt
  (n, fopr) =
  auxmain(0) where
{
//
fun
auxmain
(
 i: int
) : list0(a) =
if
(i < n)
then
(
  case+ fopr(i) of
  | None0() => auxmain(i+1)
  | Some0(x) => list0_cons(x, auxmain(i+1))
) else list0_nil((*void*))
//
} (* end of [int_list0_mapopt] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_find_index
(xs: list0(INV(a)), test: cfun(a, bool)): int
//
implement
{a}(*tmp*)
list0_find_index
  (xs, test) = let
//
fun
loop
(xs: list0(a), i: int): int =
(
case+ xs of
| list0_nil() => ~1
| list0_cons(x, xs) =>
  if test(x) then i else loop(xs, i+1)
)
//
in
  loop(xs, 0)
end // end of [list0_find_index]
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_exists
(xs: list0(INV(a)), test: cfun(a, bool)): bool
extern
fun
{a:t@ype}
list0_forall
(xs: list0(INV(a)), test: cfun(a, bool)): bool
//
implement
{a}(*tmp*)
list0_exists(xs, test) =
list0_find_index<a>(xs, test) >= 0
implement
{a}(*tmp*)
list0_forall(xs, test) =
list0_find_index<a>(xs, lam(x) => not(test(x))) < 0
//
(* ****** ****** *)
//
extern
fun
{a,b:t@ype}
list0_cross
( xs: list0(INV(a))
, ys: list0(INV(b))): list0($tup(a, b))
//
implement
{a,b}(*tmp*)
list0_cross
  (xs, ys) = let
//
typedef ab = $tup(a, b)
//
in
//
list0_concat
(
list0_map<a><list0(ab)>
  (xs, lam(x) => list0_map<b><ab>(ys, lam(y) => $tup(x, y)))
) (* end of [list0_concat] *)
//
end // end of [list0_cross]
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
list0_imap
(xs: list0(INV(a)), fopr: cfun(int, a, b)): list0(b)
//
implement
{a}{b}
list0_imap
(
  xs, fopr
) = auxlst(0, xs) where
{
//
fun
auxlst
(i: int, xs: list0(a)): list0(b) =
(
case+ xs of
| list0_nil() => list0_nil()
| list0_cons(x, xs) => list0_cons(fopr(i, x), auxlst(i+1, xs))
)
//
} (* end of [list0_imap] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_iforeach
(xs: list0(INV(a)), fwork: cfun(int, a, void)): void
//
implement
{a}(*tmp*)
list0_iforeach
(
  xs, fwork
) = loop(0, xs) where
{
//
fun
loop
(i: int, xs: list0(a)): void =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => (fwork(i, x); loop(i+1, xs))
)
//
} (* end of [list0_iforeach] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_iexists
(xs: list0(INV(a)), test: cfun(int, a, bool)): bool
extern
fun
{a:t@ype}
list0_iforall
(xs: list0(INV(a)), test: cfun(int, a, bool)): bool
//
implement
{a}(*tmp*)
list0_iexists
(xs, test) =
loop(0, xs) where
{
fun loop(i: int, xs: list0(a)): bool =
  case+ xs of
  | list0_nil() => false
  | list0_cons(x, xs) =>
    if test(i, x) then true else loop(i+1, xs)
}
//
implement
{a}(*tmp*)
list0_iforall
(xs, test) =
loop(0, xs) where
{
fun loop(i: int, xs: list0(a)): bool =
  case+ xs of
  | list0_nil() => true
  | list0_cons(x, xs) =>
    if test(i, x) then loop(i+1, xs) else false
}
//
(* ****** ****** *)

extern
fun {
a,b:t@ype
} list0_zip
  (xs: list0(a), ys: list0(b)): list0($tup(a, b))
//
implement
{a,b}
list0_zip(xs, ys) =
(
case xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  (
    case+ ys of
    | list0_nil() =>
      list0_nil()
    | list0_cons(y, ys) =>
      list0_cons($tup(x, y), list0_zip<a,b>(xs, ys))
  )
)

(* ****** ****** *)

extern
fun
{a
,b:t@ype}
{c:t@ype}
list0_map2
(xs: list0(a), ys: list0(b), fopr: cfun(a, b, c)): list0(c)
//
implement
{a,b}{c}
list0_map2
(xs, ys, fopr) =
(
case xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x, xs) =>
  (
    case+ ys of
    | list0_nil() =>
      list0_nil()
    | list0_cons(y, ys) =>
      list0_cons(fopr(x, y), list0_map2<a,b><c>(xs, ys, fopr))
  ) (* end of [list0_cons] *)
)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_merge
( xs: list0(a)
, ys: list0(a), cmp: cfun(a, a, int)): list0(a)
//
implement
{a}(*tmp*)
list0_merge
(xs0, ys0, cmp) = let
//
fun
auxlst
( xs0: list0(a)
, ys0: list0(a)
) : list0(a) = (
//
case+ xs0 of
| list0_nil() => ys0
| list0_cons
    (x1, xs1) => (
    case+ ys0 of
    | list0_nil() => xs0
    | list0_cons
        (y1, ys1) => let
        val sgn = cmp(x1, y1)
      in
        if (sgn <= 0)
          then list0_cons(x1, auxlst(xs1, ys0))
          else list0_cons(y1, auxlst(xs0, ys1))
        // end of [if]
      end // end of [list0_cons]
  ) (* end of [list0_cons] *)
//
) (* end of [auxlst] *)
//
in
  auxlst(xs0, ys0)
end // end of [list0_merge]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_mergesort
(xs: list0(a), cmp: cfun(a, a, int)): list0(a)
//
implement
{a}(*tmp*)
list0_mergesort
  (xs, cmp) = let
//
// It is assumed
// that length(xs) = n
//
fun
msort
(xs: list0(a), n: int): list0(a) =
if
(n >= 2)
then let
  val n1 = n / 2
  val xs1 = list0_take_exn(xs, n1)
  val xs2 = list0_drop_exn(xs, n1)
in
  list0_merge<a>(msort(xs1, n1), msort(xs2, n-n1), cmp)
end // end of [then]
else (xs) // end of [else]
//
in
  msort(xs, list0_length<a>(xs))
end // end of [list0_mergesort]

(* ****** ****** *)
//
macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())
//
(* ****** ****** *)

extern
fun
{a:t@ype}
list0_choose2
(xs: list0(a)): list0($tup(a, a))
//
extern
fun
{a:t@ype}
list0_choose2
(xs: list0(a)): list0($tup(a, a))
//
implement
{a}(*tmp*)
list0_choose2
  (xs) = let
//
typedef aa = $tup(a, a)
//
in
//
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs) =>
  list0_append<aa>
  (list0_map<a><aa>(xs, lam(x) => $tup(x0, x)), list0_choose2(xs))
//
end // end of [list0_choose2]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
list0_nchoose
(xs: list0(a), n: int): list0(list0(a))
//
extern
fun
{a:t@ype}
list0_nchoose_rest
(xs: list0(INV(a)), n: int): list0($tup(list0(a), list0(a)))
//
(* ****** ****** *)

implement
{a}(*tmp*)
list0_nchoose
  (xs, n) =
  auxlst(xs, n) where
{
//
typedef xs = list0(a)
//
fun
auxlst
(
xs: xs, n: int
) : list0(xs) =
(
if
(n <= 0)
then
list0_sing(list0_nil())
else
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs) =>
  list0_append<xs>(list0_mapcons(x0, auxlst(xs, n-1)), auxlst(xs, n))
) (* end of [else] *)
)
//
} (* end of [list0_nchoose] *)

(* ****** ****** *)

implement
{a}(*tmp*)
list0_nchoose_rest
  (xs, n) =
  auxlst(xs, n) where
{
//
typedef xs = list0(a)
typedef xsxs = $tup(xs, xs)
//
fun
auxlst
(
xs: xs, n: int
) : list0(xsxs) =
(
if
(n <= 0)
then
list0_sing
($tup(list0_nil(), xs))
else
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x0, xs) => let
    val res1 =
    list0_map<xsxs><xsxs>
    ( auxlst(xs, n-1)
    , lam($tup(xs1, xs2)) => $tup(list0_cons(x0, xs1), xs2)
    )
    val res2 =
    list0_map<xsxs><xsxs>
    ( auxlst(xs, n-0)
    , lam($tup(xs1, xs2)) => $tup(xs1, list0_cons(x0, xs2))
    )
  in
    list0_append<xsxs>(res1, res2)
  end // end of [list0_cons]
) (* end of [else] *)
)
//
} (* end of [list0_nchoose_rest] *)

(* ****** ****** *)
//
extern
fun
int_stream_from(n: int): stream(int)
//
implement
int_stream_from(n) =
  $delay(stream_cons(n, int_stream_from(n+1)))
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
stream_make_list0(xs: list0(INV(a))): stream(a)
//
implement
{a}(*tmp*)
stream_make_list0(xs) = $delay
(
case+ xs of
| list0_nil() => stream_nil()
| list0_cons(x, xs) => stream_cons(x, stream_make_list0<a>(xs))
)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
stream_get_at_exn
  (xs: stream(a), n: int): a
//
overload [] with stream_get_at_exn
//
implement
{a}(*tmp*)
stream_get_at_exn
  (xs, n) =
(
case- !xs of
(*
| stream_nil() =>
  (
    $raise StreamSubscriptExn()
  )
*)
| stream_cons(x, xs) =>
  (
    if n <= 0 then x else stream_get_at_exn<a>(xs, n-1)
  )
)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
stream_append
(xs: stream(a), ys: stream(a)): stream(a)
//
implement
{a}(*tmp*)
stream_append
(xs, ys) = $delay
(
case+ !xs of
| stream_nil() => !ys
| stream_cons(x, xs) =>
  stream_cons(x, stream_append<a>(xs, ys))
)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
stream_concat
  (xss: stream(stream(a))): stream(a)
//
implement
{a}(*tmp*)
stream_concat(xss) = $delay
(
case+ !xss of
| stream_nil() =>
  stream_nil()
| stream_cons(xs, xss) =>
  !(stream_append<a>(xs, stream_concat<a>(xss)))
)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
stream_map
(xs: stream(a), fopr: cfun(a, b)): stream(b)
//
implement
{a}{b}
stream_map
  (xs, fopr) = $delay
(
case+ !xs of
| stream_nil() =>
  stream_nil()
| stream_cons(x, xs) =>
  stream_cons(fopr(x), stream_map<a><b>(xs, fopr))
)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
stream_filter
(xs: stream(a), test: cfun(a, bool)): stream(a)
//
implement
{a}(*tmp*)
stream_filter
  (xs, test) = $delay
(
case+ !xs of
| stream_nil() =>
  stream_nil()
| stream_cons(x, xs) =>
  if test(x)
    then
    stream_cons
      (x, stream_filter<a>(xs, test))
    // end of [then]
    else !(stream_filter<a>(xs, test))
  // end of [if]
)
//
(* ****** ****** *)

(* end of [mylib.dats] *)

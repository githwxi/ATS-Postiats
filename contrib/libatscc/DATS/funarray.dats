(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/funarray.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)

datatype
brauntree
  (a:t@ype+, int) =
  | E (a, 0) of ()
  | {n1,n2:nat | n2 <= n1; n1 <= n2+1}
    B (a, n1+n2+1) of (a, brauntree (a, n1), brauntree (a, n2))
// end of [brauntree]

stadef bt = brauntree

(* ****** ****** *)
//
assume
funarray_t0ype_int_type
  (a:t@ype, n:int) = brauntree(a, n)
//
(* ****** ****** *)

implement
funarray_make_nil((*void*)) = E(*void*)

(* ****** ****** *)

implement
funarray_size
  {a}(A) = let
//
fun
diff
{ nl,nr:nat
| nr <= nl && nl <= nr+1
} .<nr>. 
(
  nr: int(nr), t0: bt (a, nl)
) : int (nl-nr) =
(
case+ t0 of
| E () => 0
| B (_, tl, tr) =>
   if nr > 0
     then let
       val nr2 = half(nr)
     in
       if nr > nr2 + nr2 then diff (nr2, tl) else diff (nr2-1, tr)
     end // end of [then]
     else 1 // end of [else]
  // end of [diff]
) (* end of [diff] *)
//
fun
size
{n:nat} .<n>.
(
  t0: bt (a, n)
) : int(n) =
(
case+ t0 of
| E () => 0
| B (_, tl, tr) => let
    val nr = size(tr)
    val d1 = 1 + diff(nr, tl)
  in
    2 * nr + d1
  end // end of [B]
  // end of [size]
) (* end of [size] *)
//
prval() = lemma_funarray_param(A)
//
in
  size(A)
end // end of [funarray_size]
//
(* ****** ****** *)

implement
funarray_get_at
  {a}{n}(A, i) = let
//
fun
get_at
{
n,i:nat| i < n
} .<n>.
(
  t0: bt (a, n), i: int i
) : a =
(
if
i > 0
then let
  val i2 = half(i)
in
  if i > i2 + i2
    then let
      val+B(_, tl, _) = t0 in get_at (tl, i2)
    end // end of [then]
    else let
      val+B(_, _, tr) = t0 in get_at (tr, i2-1)
    end // end of [else]
end // end of [then]
else let
  val+B(x, _, _) = t0 in x
end // end of [else]
) (* end of [get_at] *)
//
in
  get_at(A, i)
end // end of [funarray_get_at]

(* ****** ****** *)

implement
funarray_set_at
  {a}{n}(A, i, x0) = let
//
fun
set_at
{
  n,i:nat | i < n
} .<n>.
(
  t0: bt (a, n), i: int i, x0: a
) : bt (a, n) =
(
if
i > 0
then let
  val i2 = half(i)
  val+B(x, tl, tr) = t0
in
  if i > i2 + i2
    then B(x, set_at (tl, i2, x0), tr)
    else B(x, tl, set_at (tr, i2-1, x0))
  // end of [if]
end // end of [then]
else let
  val+B(_, t1, t2) = t0 in B(x0, t1, t2)
end // end of [else]
//
) (* end of [set_at] *)
//
in
  set_at(A, i, x0)
end // end of [funarray_set_at]

(* ****** ****** *)

implement
funarray_insert_l
  {a}{n}(A, x0) = let
//
fun
ins_l
{n:nat} .<n>.
(
  t0: bt (a, n), x0: a
) :<> bt (a, n+1) =
(
case+ t0 of
| E () => B (x0, E (), E ())
| B (x, tl, tr) => B (x0, ins_l (tr, x), tl)
) (* end of [ins_l] *)
//
prval() = lemma_funarray_param(A)
//
in
  ins_l(A, x0)
end // end of [funarray_insert_l]

(* ****** ****** *)

implement
funarray_insert_r
  {a}{n}(A, n, x0) = let
//
fun
ins_r
{n:nat} .<n>.
(
  t0: bt (a, n), n: int n, x0: a
) : bt (a, n+1) =
(
//
if
n > 0
then let
  val n2 = half(n)
  val+B(x, tl, tr) = t0
in
  if n > n2 + n2
    then B(x, ins_r (tl, n2, x0), tr)
    else B(x, tl, ins_r (tr, n2-1, x0))
  // end of [if]
end // end of [then]
else B (x0, E (), E ())
//
) (* end of [ins_r] *)
//
prval() = lemma_funarray_param(A)
//
in
  ins_r(A, n, x0)
end // end of [funarray_insert_r]

(* ****** ****** *)

implement
funarray_remove_l
  {a}{n}(A) = let
//
fun
rem_l
{n:pos} .<n>.
(
  t0: bt (a, n)
) : $tup(bt (a, n-1), a) =
(
case+ t0 of
| B(x, E(), _) => $tup(E(), x)
| B(xl, tl, tr) =>> let
    val $tup(tl, x0) = rem_l(tl) in $tup(B(xl, tr, tl), x0) 
  end // end of [lorem]
)
//
in
  rem_l(A)
end // end of [funarray_remove_l]

(* ****** ****** *)

implement
funarray_remove_r
  {a}{n}(A, n) = let
//
fun
rem_r
{n:pos} .<n>.
(
  t0: bt (a, n), n: int n
) : $tup(bt (a, n-1), a) = let
//
val n2 = half(n); val+ B (x, tl, tr) = t0
//
in
//
case+ tl of
| E() => $tup(E(), x)
| B _ =>
  if n > n2 + n2
    then let
      val $tup(tr, x0) = rem_r(tr, n2) in $tup(B(x, tl, tr), x0)
    end // end of [then]
    else let
      val $tup(tl, x0) = rem_r(tl, n2) in $tup(B(x, tl, tr), x0)
    end // end of [else]
  // end of [if]
//
end // end of [rem_r]
//
in
  rem_r(A, n)
end // end of [funarray_remove_r]

(* ****** ****** *)

(* end of [funarray.dats] *)

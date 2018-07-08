(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.funarray"
//
#define
ATS_DYNLOADFLAG 0 // no dynloading
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)
//
staload "libats/SATS/funarray.sats"
//
(* ****** ****** *)

datatype
brauntree
  (a:t@ype+, int) =
  | E(a, 0) of ()
  | {n1,n2:nat | n2 <= n1; n1 <= n2+1}
    B(a, n1+n2+1) of
    (a, brauntree(a, n1), brauntree(a, n2))
// end of [brauntree]

stadef bt = brauntree

(* ****** ****** *)
//
assume
farray_t0ype_int_type
  (a:t@ype, n:int) = brauntree(a, n)
//
(* ****** ****** *)

implement
{}(*tmp*)
farray_is_nil(A) =
(
case+ A of
| E _ => true | B _ => false
)
implement
{}(*tmp*)
farray_isnot_nil(A) =
(
case+ A of
| E _ => false | B _ => true
)

(* ****** ****** *)

implement
{a}(*tmp*)
farray_size
  (A) = let
//
fun
diff
{ nl,nr:nat
| nr <= nl && nl <= nr+1
} .<nr>. 
(
  nr: int(nr), t0: bt(a, nl)
) : int (nl-nr) =
(
case+ t0 of
| E () => 0
| B (_, tl, tr) =>
   if nr > 0
     then let
       val
       nr2 = half(nr)
     in
       if
       (nr > nr2+nr2)
       then diff(nr2, tl) else diff(nr2-1, tr)
     end // end of [then]
     else 1 // end of [else]
  // end of [diff]
) (* end of [diff] *)
//
fun
size
{n:nat} .<n>.
(
  t0: bt(a, n)
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
prval() = lemma_farray_param(A)
//
in
  $effmask_all(size(A))
end // end of [farray_size]
//
(* ****** ****** *)

implement
{}(*tmp*)
farray_nil((*void*)) = E(*void*)
implement
{}(*tmp*)
farray_make_nil((*void*)) = E(*void*)

(* ****** ****** *)

implement
{a}(*tmp*)
farray_make_list
  (xs) =
  auxmain(xs) where
{
//
fnx
aux01
{n:nat} .<n>.
( xs0: list(a, n)
, res0: &ptr? >> list(a, (n+1)/2)
, res1: &ptr? >> list(a, (n+0)/2)
) :<!wrt> void =
(
case+ xs0 of
| list_nil() =>
  {
    val () = res0 := list_nil()
    val () = res1 := list_nil()
  }
| list_cons(x0, xs1) =>
  (
  case+ xs1 of
  | list_nil() =>
    {
      val () = res1 := list_nil()
      val () = res0 := list_sing(x0)
    }
  | list_cons(x1, xs2) =>
    {
      val () =
      (res0 := list_cons{a}{0}(x0, _))
      val () =
      (res1 := list_cons{a}{0}(x1, _))
      val+list_cons(_, res0_tl) = res0
      val+list_cons(_, res1_tl) = res1
      val () = aux01(xs2, res0_tl, res1_tl)
      prval () = fold@(res0) and () = fold@(res1)
    }
  )
)
//
fun
auxmain:
$d2ctype
(
farray_make_list<a>
) = lam(xs) =>
(
case+ xs of
| list_nil() => E()
| list_cons(x0, xs) => let
    var res0: ptr
    and res1: ptr
    val ((*void*)) =
    $effmask_wrt(aux01(xs, res0, res1))
  in
    B(x0, auxmain(res0), auxmain(res1))
  end // end of [list_cons]
)
//
} (* end of [farray_make_list] *)

(* ****** ****** *)

implement
{a}(*tmp*)
farray_get_at
  {n}(A, i) = let
//
fun
get_at
{
n,i:nat| i < n
} .<n>.
(
  t0: bt(a, n), i: int i
) : a =
(
if
i > 0
then let
  val i2 = half(i)
in
//
if
(i > i2 + i2)
then let
  val+B(_, tl, _) = t0 in get_at(tl, i2)
end // end of [then]
else let
  val+B(_, _, tr) = t0 in get_at(tr, i2-1)
end // end of [else]
//
end // end of [then]
else let
  val+B(x, _, _) = t0 in x
end // end of [else]
) (* end of [get_at] *)
//
in
  $effmask_all(get_at(A, i))
end // end of [farray_get_at]

(* ****** ****** *)

implement
{a}(*tmp*)
farray_set_at
  {n}(A, i, x0) = let
//
fun
set_at
{
  n,i:nat | i < n
} .<n>.
(
  t0: bt(a, n), i: int i, x0: a
) :<> bt(a, n) =
(
if
(i > 0)
then let
  val i2 = half(i)
  val+B(x, tl, tr) = t0
in
  if i > i2 + i2
    then B(x, set_at(tl, i2, x0), tr)
    else B(x, tl, set_at(tr, i2-1, x0))
  // end of [if]
end // end of [then]
else let
  val+B(_, tl, tr) = t0 in B(x0, tl, tr)
end // end of [else]
//
) (* end of [set_at] *)
//
in
  A := set_at(A, i, x0)
end // end of [farray_set_at]

(* ****** ****** *)

implement
{a}(*tmp*)
farray_getopt_at
  {n}(A, i) = let
//
prval () =
lemma_farray_param(A)
//
fun
getopt_at
{n,i:nat} .<n>.
(
t0: bt(a, n), i: int i
) : option_vt(a, i < n) =
(
case+ t0 of
| E() =>
  None_vt()
| B(x0, tl, tr) =>
  (
  if
  (i = 0)
  then (
    Some_vt(x0)
  ) else let
    val i2 = half(i)
  in
    if i > i2 + i2
      then getopt_at(tl, i2)
      else getopt_at(tr, i2-1)
    // end of [if]
  end // end of [else]
  ) (* end of [B] *)
) (* end of [getopt_at] *)
//
in
  $effmask_all(getopt_at(A, i))
end // end of [farray_getopt_at]

(* ****** ****** *)

implement
{a}(*tmp*)
farray_setopt_at
  {n}(A, i, x0) = let
//
fun
setopt_at
{n,i:nat} .<n>.
(
t0: bt(a, n), i: int(i)
,
x0: a, opt: &bool? >> bool(i < n)
) :<!wrt> bt(a, n) =
(
case+ t0 of
| E() =>
  E() where
  {
    val () = opt := false
  }
| B(x1, tl, tr) =>
  (
  if
  (i > 0)
  then let
    val i2 = half(i)
  in
    if
    (i > i2 + i2)
    then let
      val tl =
      setopt_at(tl, i2, x0, opt)
    in
      if opt then B(x1, tl, tr) else t0
    end // end of [then]
    else let
      val tr =
      setopt_at(tr, i2-1, x0, opt)
    in
      if opt then B(x1, tl, tr) else t0
    end // end of [else]
  end // end of [then]
  else let
    val () = opt := true in B(x0, tl, tr)
  end // end of [else]
  ) (* end of [B] *)
//
) (* end of [set_at] *)
//
prval () = lemma_farray_param(A)
//
in
  let
    var opt: bool
  in
    A := setopt_at(A, i, x0, opt); opt
  end (* end of [let] *)
end // end of [farray_setopt_at]

(* ****** ****** *)

implement
{a}(*tmp*)
farray_insert_l
  {n}(A, x0) = let
//
fun
ins_l
{n:nat} .<n>.
(
  t0: bt(a, n), x0: a
) :<> bt(a, n+1) =
(
case+ t0 of
| E() => B(x0, E(), E())
| B(x, tl, tr) => B(x0, ins_l (tr, x), tl)
) (* end of [ins_l] *)
//
prval() = lemma_farray_param(A)
//
in
  A := ins_l(A, x0)
end // end of [farray_insert_l]

(* ****** ****** *)

implement
{a}(*tmp*)
farray_insert_r
  {n}(A, n, x0) = let
//
fun
ins_r
{n:nat} .<n>.
(
  t0: bt(a, n), n: int n, x0: a
) : bt(a, n+1) =
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
else B(x0, E(), E())
//
) (* end of [ins_r] *)
//
prval() = lemma_farray_param(A)
//
in
  A := ins_r(A, n, x0)
end // end of [farray_insert_r]

(* ****** ****** *)

implement
{a}(*tmp*)
farray_remove_l
  {n}(A) = let
//
fun
rem_l
{n:pos} .<n>.
(
  t0: &bt(a, n) >> bt(a, n-1)
) : a =
(
case+ t0 of
| B(x, E(), _) => (t0 := E(); x)
| B(xl, tl, tr) =>> let
    var tl = tl
    val x0 = rem_l(tl) in (t0 := B(xl, tr, tl); x0)
  end // end of [lorem]
)
//
in
  rem_l(A)
end // end of [farray_remove_l]
//
(* ****** ****** *)

implement
{a}(*tmp*)
farray_remove_r
  {n}(A, n) = let
//
fun
rem_r
{n:pos} .<n>.
(
  t0: &bt(a, n) >> bt(a, n-1), n: int n
) : a = let
//
val n2 = half(n); val+B(x, tl, tr) = t0
//
in
//
case+ tl of
| E() => (t0 := E(); x)
| B _ =>
  if n > n2 + n2
    then let
      var tr = tr
      val x0 = rem_r(tr, n2) in t0 := B(x, tl, tr); x0
    end // end of [then]
    else let
      var tl = tl
      val x0 = rem_r(tl, n2) in t0 := B(x, tl, tr); x0
    end // end of [else]
  // end of [if]
//
end // end of [rem_r]
//
in
  rem_r(A, n)
end // end of [farray_remove_r]

(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_farray$sep
  (out) = fprint_string(out, ", ")
//
(* ****** ****** *)

implement
{a}(*tmp*)
fprint_farray
  (out, A) = let
//
typedef tenv = int
//
var env: tenv = (0)
//
implement(a2)
farray_foreach$fwork<a2><tenv>
  (x, env) = () where
{
//
val () =
if env > 0
  then fprint_farray$sep<>(out)
// end of [val]
//
val () = env := env + 1
val () = fprint_val<a>(out, $UN.cast{a}(x))
//
} (* end of [farray_foreach$fwork] *)
//
in
  farray_foreach_env<a><tenv>(A, env)
end // end of [fprint_farray]

(* ****** ****** *)

implement
{a}(*tmp*)
farray_listize
  {n}(A) =
  auxmain(A) where
{
//
fnx
aux01
{m,n:nat}
(
xs: list_vt(a, m)
,
ys: list_vt(a, n)
,
res: &ptr? >> list_vt(a, m+n)
) : void =
(
case+ xs of
| ~list_vt_nil() =>
    (res := ys)
| @list_vt_cons(x, xs_tl) =>
  (
    case+ ys of
    | ~list_vt_nil() =>
        (fold@(xs); res := xs)
    | @list_vt_cons
        (y, ys_tl) =>
      {
        val xs_tl_ = xs_tl
        val ys_tl_ = ys_tl
        val () = (res := xs)
        val () = (xs_tl := ys)
        val () = aux01(xs_tl_, ys_tl_, ys_tl)
        prval () = fold@(xs_tl); prval () = fold@(res)
      }
  )
)
//
fun
auxmain:
$d2ctype
(
farray_listize<a>
) = lam(t0) =>
(
  case+ t0 of
  | E() =>
    list_vt_nil()
  | B(x0, tl, tr) => let
      var res: ptr
      val ((*void*)) =
      aux01(auxmain(tl), auxmain(tr), res)
    in
      list_vt_cons(x0, res)
    end // end of [B]
)
//
} (* end of [farray_listize] *)

(* ****** ****** *)

implement
{a}(*tmp*)
farray_foreach
  (A) = let
//
var env: void = ()
//
in
//
farray_foreach_env<a><void>(A, env)
//
end // end of [farray_foreach]

(* ****** ****** *)

implement
{a}{env}(*tmp*)
farray_foreach_env
  (A, env) =
  list_vt_free<a>(xs) where
{
//
implement
list_vt_foreach$cont<a><env>
  (x, env) =
  farray_foreach$cont<a><env>(x, env)
//
implement
list_vt_foreach$fwork<a><env>
  (x, env) =
  farray_foreach$fwork<a><env>(x, env)
//
val xs = farray_listize<a>(A)
val () =
  list_vt_foreach_env<a><env>(xs, env)
//
} (* end of [farray_foreach_env] *)

(* ****** ****** *)
//
implement
{a}{env}(*tmp*)
farray_foreach$cont(x, env) = (true)
//
(* ****** ****** *)

(* end of [funarray_braunt.dats] *)

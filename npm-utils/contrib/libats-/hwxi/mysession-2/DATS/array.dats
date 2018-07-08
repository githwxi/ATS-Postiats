(*
** Arrays
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
 "./../SATS/basis.sats"
//
staload
  "./../SATS/array.sats"
//
staload "./basis_chan0.dats"
//
(* ****** ****** *)

implement
{}(*tmp*)
chanpos_arrsz
  {a}{n}(chp, n) = let
//
typedef
ss = chsnd(int)::ssarray(a,n)
prval () =
  $UN.castview2void{chanpos(ss)}(chp)
//
in
  chanpos_send<int> (chp, n)
end // end of [chanpos_arrsz]

(* ****** ****** *)

implement
{}(*tmp*)
channeg_arrsz
  {a}(chn) = asz where
{
//
prval
[n:int](_) = g1ofg0(0)
//
typedef
ss = chsnd(int)::ssarray(a,n)
prval () =
  $UN.castview2void{channeg(ss)}(chn)
//
val
asz = channeg_send_val<int> (chn)
//
val
[n:int]
asz = $UN.cast{intGte(0)}(asz)
//
prval () =
  $UN.castview2void{channeg(ssarray(a,n))}(chn)
//
} (* end of [channeg_arrsz] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
ssarray2list(chn, n) =
  list_vt2t(ssarray2list_vt(chn, n))
//
(* ****** ****** *)

implement
{a}(*tmp*)
list2ssarray
  (xs) = let
//
fun
fserv{n:int}
(
  chp: chanpos(ssarray(a, n)), xs: list(a, n)
) : void =
(
case+ xs of
| list_nil () => let
    prval () =
    chanpos_array_nil(chp)
  in
    chanpos_nil_wait<> (chp)
  end // end of [nil]
| list_cons (x, xs) => let
    prval () =
    chanpos_array_cons(chp)
    val () = chanpos_send<a> (chp, x)
  in
    fserv(chp, xs)
  end // end of [cons]
) (* end of [fserv] *)
//
in
  channeg_create_exn(llam(chp) => fserv(chp, xs))
end // end of [list2ssarray]

(* ****** ****** *)

implement
{a}(*tmp*)
list2ssarray_vt
  (xs) = let
//
fun
fserv{n:int}
(
  chp: chanpos(ssarray(a, n)), xs: list_vt(a, n)
) : void =
(
case+ xs of
| ~nil_vt () => let
    prval () =
    chanpos_array_nil(chp)
  in
    chanpos_nil_wait<> (chp)
  end // end of [nil]
| ~cons_vt (x, xs) => let
    prval () =
    chanpos_array_cons(chp)
    val () = chanpos_send<a> (chp, x)
  in
    fserv(chp, xs)
  end // end of [cons]
) (* end of [fserv] *)
//
in
  channeg_create_exn(llam(chp) => fserv(chp, xs))
end // end of [list2ssarray_vt]

(* ****** ****** *)

implement
{a}(*tmp*)
ssarray2list_vt
  {n}(chn, n) = xs where
{
//
prval
() = $UN.prop_assert{n >= 0}()
//
val xs =
channeg_array_takeout_list<a> (chn, n)
//
prval () = channeg_array_nil (chn)
val ((*closed*)) = channeg_nil_close<> (chn)
//
} (* end of [ssarray2list_vt] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channeg_array_takeout_list
  (chn, i) = let
//
vtypedef
chan(n:int) = channeg(ssarray(a, n))
//
fun
loop{n:int}{i:nat | i <= n}
(
  chn: !chan(n) >> chan(n-i)
, i: int(i), res: &ptr? >> list_vt(a, i)
) : void =
(
//
if
i > 0
then let
  val () =
  res :=
    list_vt_cons{a}{0}(_, _)
  // end of [val]
  val list_vt_cons(x0, res1) = res
  prval () =
    channeg_array_cons(chn)
  val () =
    x0 := channeg_send_val (chn)
  val () = loop (chn, i-1, res1)
  prval ((*folded*)) = fold@(res)
in
  // nothing
end // end of [then]
else let
  val () = res := list_vt_nil()
in
  // nothing
end // end of [else]
//
) (* end of [loop] *)
//
var res: ptr // uninitialized
//
in
  loop (chn, i, res); res
end // end of [channeg_array_takeout_list]

(* ****** ****** *)

(* end of [array.dats] *)

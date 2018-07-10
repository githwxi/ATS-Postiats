(* ****** ****** *)
//
// HX-2018-07-09:
// Modifying Deech's version to
// get to the range of C++ performance
//
// HX-2018-07-10: templatizing the code
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"
#staload
STDLIB = "libats/libc/SATS/stdlib.sats"

(* ****** ****** *)

datavtype
treap_vt(a:t@ype+) =
| treap_vt_nil of ()
| treap_vt_cons of
  (a, int, treap_vt(a), treap_vt(a))

(* ****** ****** *)

extern
fun
{a:t@ype}
free_treap(xs: treap_vt(a)): void

implement
{a}
free_treap(t0) =
(
case+ t0 of
| ~treap_vt_nil() => ()
| ~treap_vt_cons(_,_, tl, tr) =>
   (free_treap<a>(tl); free_treap<a>(tr))
)

(* ****** ****** *)

extern
fun
{a:t@ype}
treap_merge2
(
  tl: treap_vt(INV(a))
, tr: treap_vt(INV(a))): treap_vt(a)

implement
{a}
treap_merge2
(tl, tr) = let
//
fun loop
(
  tl: treap_vt(a),
  tr: treap_vt(a),
  res: &ptr? >> treap_vt(a)
) : void =
(
case+ tl of
| ~treap_vt_nil() =>
   (res := tr)
| @treap_vt_cons
   (tl_x, tl_y, tll, tlr) =>
  (
    case+ tr of
    | ~treap_vt_nil() =>
       (fold@tl; res := tl)
    | @treap_vt_cons
       (tr_x, tr_y, trl, trr) =>
      (
        if
        (tl_y < tr_y)
        then let
          val tlr_ = tlr
        in
          res := tl; fold@tr;
          loop(tlr_, tr, tlr); fold@res
        end
        else let
          val trl_ = trl
        in
          res := tr;
          fold@tl; loop(tl, trl_, trl); fold@res
        end
      )
  )
)
in
  let var res: ptr in loop(tl, tr, res); res end
end // end of [treap_merge2]

(* ****** ****** *)

extern
fun
{a:t@ype}
treap_split2
(
t0: treap_vt(INV(a)), x0: a
) : (treap_vt(a), treap_vt(a))

implement
{a}
treap_split2
  (t0, x0) = let
//
vtypedef
treap_vt = treap_vt(a)
//
fun
loop
(
t0: treap_vt, x0: a
,
tl_res: &treap_vt? >> _
,
tr_res: &treap_vt? >> _) : void =
(
case+ t0 of
| ~treap_vt_nil() =>
   ( tl_res := treap_vt_nil()
   ; tr_res := treap_vt_nil() )
| @treap_vt_cons
   (tx, ty, tl, tr) => let
    val sgn = gcompare_val_val<a>(tx, x0)
  in
    if
    (sgn < 0)
    then let
      val tr_ = tr
    in
      tl_res := t0;
      loop(tr_, x0, tr, tr_res); fold@(tl_res)
    end
    else let
      val tl_ = tl
    in
      tr_res := t0;
      loop(tl_, x0, tl_res, tl); fold@(tr_res)
    end
  end // end of [treap_vt_cons]
)
//
in
  let var tl_res: treap_vt? and tr_res: treap_vt? in loop(t0, x0, tl_res, tr_res); (tl_res, tr_res) end
end

(* ****** ****** *)

extern
fun
{a:t@ype}
treap_merge3
( lt : treap_vt(INV(a)),
  eq : treap_vt(INV(a)),
  gt : treap_vt(INV(a))): treap_vt(a)

implement
{a}(*tmp*)
treap_merge3(lt,eq,gt) =
treap_merge2<a>(treap_merge2<a>(lt,eq),gt)

(* ****** ****** *)

extern
fun
{a:t@ype}
treap_split3
(
xs: treap_vt(a), x0: a
) : (treap_vt(a), treap_vt(a), treap_vt(a))

implement
{a}
treap_split3
  (xs, x0) = let
  val+ (lt, eg) = treap_split2<a>(xs, x0)
  val+ (eq, gt) = treap_split2<a>(eg, gsucc_val<a>(x0))
in
  (lt, eq, gt)
end // end of [treap_split3]

(* ****** ****** *)

extern
fun
{a:t@ype}
treap_has_value
(
t0: treap_vt(INV(a)), x0: a
): (treap_vt(a), bool)

implement
{a}
treap_has_value
  (xs, x0) = let
  val+(lt,eq,gt) = treap_split3<a>(xs, x0)
in
  case+ eq of
  | ~treap_vt_nil() =>
     (treap_merge2<a>(lt, gt), false)
  | @treap_vt_cons _ =>
     (fold@eq; (treap_merge3<a>(lt, eq, gt), true))
end // end of [treap_has_value]

(* ****** ****** *)

extern
fun
{a:t@ype}
new_treap
(x0: a): treap_vt(a)

implement
{a}
new_treap(x0) =
treap_vt_cons
( x0
, $UNSAFE.cast2int(i0)
, treap_vt_nil(), treap_vt_nil()
) where
{
  val i0 = $STDLIB.random()
}

(* ****** ****** *)

extern
fun
{a:t@ype}
treap_insert
(xs: treap_vt(INV(a)), x0: a): treap_vt(a)

implement
{a}
treap_insert
  (xs, x0) = let
  val+(lt,eq,gt) = treap_split3<a>(xs, x0)
in
  case+ eq of
  | ~treap_vt_nil() =>
     treap_merge3<a>(lt,new_treap(x0), gt)
  | @treap_vt_cons _ =>
     (fold@eq; treap_merge3<a>(lt, eq, gt))
end // end of [treap_insert]

(* ****** ****** *)

extern
fun
{a:t@ype}
treap_erase
(xs: treap_vt(INV(a)), x0: a) : treap_vt(a)

implement
{a}
treap_erase
  (xs, x0) = let
  val+(lt,eq,gt) = treap_split3<a>(xs, x0)
in
  free_treap<a>(eq); treap_merge2<a>(lt, gt)
end

(* ****** ****** *)


implement
main0(argc,argv) = let
//
typedef a = int
vtypedef treap_vt = treap_vt(a)
//
fun loop
(
  xs: treap_vt,
  x0: a, state: int, res: int
): int =
(
case+ x0 of
| _ when x0 < 1000000 => let
    val x0 = gsucc_val<a>(x0)
    val state = (state*57+43) mod 10007
  in
    case+ (x0 mod 3) of
    | 0 =>
      loop(treap_insert(xs, state), x0,state,res)
    | 1 =>
      (
        loop(treap_erase(xs,state), x0,state,res)
      )
    | _ => let
        val+
        (xs, found) =
        treap_has_value(xs,state)
      in
        if found then
          loop(xs, x0, state, res+1) else loop(xs, x0, state, res)
        // end of [if]
      end
  end
| _ (* exit *) => (free_treap(xs); res)
)
//
in
  println! (loop(treap_vt_nil(), 1, 5, 0))
end

(* ****** ****** *)

(* end of [treap_man.dats] *)

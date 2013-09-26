(*
**
** Automatic Differentiation
**
** The code is essentially translated fro
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2008
**
*)

(* ****** ****** *)
//
// HX-2012-11-26: ported to ATS/Postiats
//
(* ****** ****** *)
//
// HX-2012-06-21: compiled to run with ATS/Postiats
//
(* ****** ****** *)
//
// HX-2012-06-21:
// By the current standard, the following code looks
// a bit ugly. However, it does shed some light on coding
// in ATS during its early development.
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload M = "libc/SATS/math.sats"

(* ****** ****** *)

datatype dualnum =
  | Base of double
  | Bundle of (int, dualnum, dualnum)
// end of [dualnum]

(* ****** ****** *)

typedef
dualnumlst (n:int) = list (dualnum, n)
typedef dualnumlst = [n:nat] dualnumlst (n)
typedef dualnum1 = dualnumlst(1) and dualnum2 = dualnumlst(2)

(* ****** ****** *)

val _0: dualnum = Base (0.0)
val _1: dualnum = Base (1.0)
val _2: dualnum = Base (2.0)
val __1: dualnum = Base (~1.0)

(* ****** ****** *)

fn epsilon
  (p: dualnum): int =
(
  case+ p of Base _ => 0 | Bundle (e, _, _) => e
) // end of [epsilon]

fn primal
(
  e: int, p: dualnum
) : dualnum = case+ p of
  | Base _ => p | Bundle (e1, x, _) => if e1 < e then p else x
// end of [primal]

fn perturbe
(
  e: int, p: dualnum
) : dualnum = begin
  case+ p of
  | Base _ => _0
  | Bundle (e1, _, x') => if e1 < e then _0 else x'
end // end of [perturbe]

(* ****** ****** *)

local

val EPSILON = ref_make_elt<int> (0)

in (* in of [local] *)

fn derivative
(
  f: dualnum -<cloref1> dualnum, x: dualnum
) : dualnum = let
  val e = !EPSILON + 1
  val () = !EPSILON := e
  val result = perturbe (e, f (Bundle (e, x, _1)))
  val () = !EPSILON := e - 1
in
  result
end // end of [derivative]

end // end of [local]

(* ****** ****** *)

fun print_dualnum
  (p: dualnum): void =
(
case+ p of
| Bundle
    (_, x, _) => print_dualnum x
| Base (x) =>
    $extfcall (void, "printf", "%.18g", x)
) // end of [print_dualnum]
overload print with print_dualnum

fn print_dualnumlst
  (ps: dualnumlst): void = let
//
fun loop
(
  i: int, ps: dualnumlst
) : void =
(
case+ ps of
| list_cons (p, ps) =>
  (
    if i > 0 then print ", "; print_dualnum p; loop (i+1, ps)
  ) // end of [list_cons]
| list_nil ((*void*)) => ()
) (* end of [loop] *)
//
in
  loop (0, ps)
end // end of [print_dualnumlst]

(* ****** ****** *)

extern fun
neg_dualnum (p: dualnum): dualnum
extern fun
recip_dualnum (p: dualnum): dualnum
extern fun
add_dualnum_dualnum (p1: dualnum, p2: dualnum): dualnum
extern fun
sub_dualnum_dualnum (p1: dualnum, p2: dualnum): dualnum
extern fun
mul_dualnum_dualnum (p1: dualnum, p2: dualnum): dualnum
extern fun
div_dualnum_dualnum (p1: dualnum, p2: dualnum): dualnum

(* ****** ****** *)

overload ~ with neg_dualnum
overload + with add_dualnum_dualnum
overload - with sub_dualnum_dualnum
overload * with mul_dualnum_dualnum
overload / with div_dualnum_dualnum

(* ****** ****** *)

implement
neg_dualnum (p) =
(
case+ p of
| Bundle
    (e, x, x') => Bundle (e, ~x, ~x')
| Base (x) => Base (~x)
)
// end of [neg_dualnum]

(* ****** ****** *)

implement
add_dualnum_dualnum
  (p1, p2) = let
in
//
case+ p1 of
| Bundle (e1, x1, x1') => (
  case+ p2 of
  | Bundle
      (e2, x2, x2') => let
      val e = (if e1 <= e2 then e2 else e1): int
      val x = primal (e, p1) + primal (e, p2)
      val x' = perturbe (e, p1) + perturbe (e, p2)
    in
      Bundle (e, x, x')
    end
  | Base (x2) => Bundle (e1, x1 + p2, x1')
  ) // end of [Bundle]
| Base x1 => (
  case+ p2 of
  | Bundle
      (e2, x2, x2') => Bundle (e2, p1 + x2, x2')
  | Base (x2) => Base (x1 + x2)
  ) // end of [Base]
//
end // end of [add_dualnum_dualnum]

(* ****** ****** *)

implement
sub_dualnum_dualnum
  (p1, p2) = let
in
//
case+ p1 of
| Bundle
    (e1, x1, x1') => (
  case+ p2 of
  | Bundle
      (e2, x2, x2') => let
      val e = (if e1 <= e2 then e2 else e1): int
      val x = primal (e, p1) - primal (e, p2)
      val x' = perturbe (e, p1) - perturbe (e, p2)
    in
      Bundle (e, x, x')
    end
  | Base x2 => Bundle (e1, x1 - p2, x1')
  ) // end of [Bundle]
| Base (x1) => (
  case+ p2 of
  | Bundle
      (e2, x2, x2') => Bundle (e2, p1 - x2, ~x2')
  | Base x2 => Base (x1 - x2)
  ) // end of [Base]
//
end // end of [sub_dualnum_dualnum]

(* ****** ****** *)

implement
mul_dualnum_dualnum
  (p1, p2) = let
in
//
case+ p1 of
| Bundle (e1, x1, x1') => (
  case+ p2 of
  | Bundle
      (e2, x2, x2') => let
      val e = (if e1 <= e2 then e2 else e1): int
      val x1 = primal (e, p1) and x2 = primal (e, p2)
      val x = x1 * x2
      val x' = x1 * perturbe (e, p2) + x2 * perturbe (e, p1)
    in
      Bundle (e, x, x')
    end
  | Base (x2) => Bundle (e1, x1 * p2, p2 * x1')
  ) // end of [Bundle]
| Base x1 => (
  case+ p2 of
  | Bundle
      (e2, x2, x2') => Bundle (e2, p1 * x2, p1 * x2')
  | Base x2 => Base (x1 * x2)
  ) // end of [Base]
//
end // end of [mul_dualnum_dualnum]

(* ****** ****** *)

implement
recip_dualnum (p) =
(
case+ p of
| Bundle (e, x, x') =>
    Bundle (e, recip_dualnum x, (~x') / (x * x))
| Base x => Base (1.0 / x)
) // end of [recip_dualnum_dualnum]

implement
div_dualnum_dualnum (p1, p2) = p1 * (recip_dualnum p2)

(* ****** ****** *)

extern fun
sqrt_dualnum (p: dualnum): dualnum

implement
sqrt_dualnum (p) = let
in
//
case+ p of
| Bundle
    (e, x, x') => let
    val x_sqrt = sqrt_dualnum (x)
    val x'_sqrt = x' / (x_sqrt + x_sqrt)
  in
    Bundle (e, x_sqrt, x'_sqrt)
  end
| Base (x) => Base ($M.sqrt_double (x))
//
end // end of [sqrt_dualnum]

(* ****** ****** *)

extern fun
lt_dualnum_dualnum (p1: dualnum, p2: dualnum): bool
overload < with lt_dualnum_dualnum

implement
lt_dualnum_dualnum (p1, p2) = let
in
//
case+ p1 of
| Bundle (_, x1, _) => (
  case+ p2 of Bundle (_, x2, _) => x1 < x2 | Base x2 => x1 < p2
  )
| Base x1 => (
  case+ p2 of Bundle (_, x2, _) => p1 < x2 | Base x2 => x1 < x2
  )
//
end // end of [lt_dualnum_dualnum]

(* ****** ****** *)

extern fun
lte_dualnum_dualnum (p1: dualnum, p2: dualnum): bool
overload <= with lte_dualnum_dualnum

implement
lte_dualnum_dualnum (p1, p2) = let
in
//
case+ p1 of
| Bundle (_, x1, _) => (
  case+ p2 of Bundle (_, x2, _) => x1 <= x2 | Base x2 => x1 <= p2
  )
| Base x1 => (
  case+ p2 of Bundle (_, x2, _) => p1 <= x2 | Base x2 => x1 <= x2
  )
//
end // end of [lte_dualnum_dualnum]

(* ****** ****** *)

extern fun
gt_dualnum_dualnum (p1: dualnum, p2: dualnum): bool
overload > with gt_dualnum_dualnum
implement
gt_dualnum_dualnum (p1, p2) = lt_dualnum_dualnum (p2, p1)

(* ****** ****** *)

fn square (p: dualnum): dualnum = p * p

(* ****** ****** *)

fn list_tabulate{n:nat}
(
  f: !natLt n -<cloptr1> dualnum, n: int n
) : dualnumlst n = let
//
fun loop {
  i:int | ~1 <= i; i < n
} .<i+1>. (
  f: !natLt n -<cloptr1> dualnum, i: int i, res: dualnumlst (n-i-1)
) : dualnumlst (n) =
  if i >= 0 then loop (f, i-1, list_cons{dualnum}(f(i), res)) else res
// end of [loop]
//
in
  loop (f, n-1, list_nil ())
end // end of [list_tabulate]

(* ****** ****** *)

fun vplus
  {n:nat} .<n>. (
  us: dualnumlst n, vs: dualnumlst n
) : dualnumlst n =
  case+ us of
  | list_cons (u, us) => let
      val+list_cons (v, vs) = vs
    in
      list_cons{dualnum}(u + v, vplus (us, vs))
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [vplus]

fun vminus
  {n:nat} .<n>. (
  us: dualnumlst n, vs: dualnumlst n
) : dualnumlst n =
  case+ us of
  | list_cons (u, us) => let
      val+list_cons (v, vs) = vs
    in
      list_cons{dualnum}(u - v, vminus (us, vs))
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [vminus]

fun vscale {n:nat}
  (k: dualnum, xs: dualnumlst n): dualnumlst n =
  case+ xs of
  | list_cons (x, xs) => list_cons{dualnum}(k * x, vscale (k, xs))
  | list_nil () => list_nil ()
// end of [vscale]

(* ****** ****** *)

fn magnitude_squared
  (xs: dualnumlst): dualnum = let
//
fun aux {n:nat} .<n>.
  (xs: dualnumlst n, res: dualnum): dualnum =
(
  case+ xs of list_cons (x, xs) => aux (xs, res + x * x) | _ => res
)
//
in
  aux (xs, _0)
end // end of [magnitude_squared]

fn magnitude
(
  xs: dualnumlst
) : dualnum =
  sqrt_dualnum (magnitude_squared xs)
// end of [magnitude]

fn distance{n:nat}
(
  us: dualnumlst n, vs: dualnumlst n
): dualnum =
  magnitude (vminus (us, vs))
// end of [distance]

(* ****** ****** *)

fun list_nth_get {n:nat} .<n>.
  (xs: dualnumlst n, i: natLt n): dualnum =
(
  if i > 0 then begin
    let val+list_cons (_, xs) = xs in list_nth_get (xs, i-1) end
  end else begin
    let val+list_cons (x, _) = xs in x end
  end (* end of [if] *)
) // end of [list_nth_get]

fun list_nth_set {n:nat} .<n>.
  (xs: dualnumlst n, i: natLt n, x0: dualnum): dualnumlst n =
(
  if i > 0 then let
    val+list_cons (x, xs) = xs
  in
    list_cons{dualnum}(x, list_nth_set (xs, i-1, x0))
  end else begin
    let val+list_cons (_, xs) = xs in list_cons{dualnum}(x0, xs) end
  end (* end of [if] *)
) // end of [list_nth_set]

(* ****** ****** *)

fn gradient{n:nat}
  (f: dualnumlst n -<cloref1> dualnum, xs: dualnumlst n)
  : dualnumlst n = let
//
val fi =
  lam (
    i: natLt n
  ): dualnum =<cloptr1>
  derivative (
    lam xi => f (list_nth_set (xs, i, xi)), list_nth_get (xs, i)
  ) // end of [derivative]
// end of [val]
//
val gxs =
list_tabulate (fi, list_length xs)
val (
) = cloptr_free (fi) where
{
  extern fun cloptr_free {a:vtype} (f: a): void = "atspre_mfree_gc"
} // end of [val]
(*
val () =
(
  print "gradient: xs = "; print_dualnumlst xs; print_newline ();
  print "gradient: gxs = "; print_dualnumlst gxs; print_newline ();
) // end of [val]
*)
in
  gxs
end // end of [gradient]

(* ****** ****** *)

val PRECISION = Base (1e-5)

fn multivariate_argmin{n:nat}
(
  f: dualnumlst n -<cloref1> dualnum, xs: dualnumlst n
) : dualnumlst n = let
//
macdef g (xs) = gradient (f, ,(xs))
//
fun loop
(
  f: dualnumlst n -<cloref1> dualnum
, xs: dualnumlst n, fxs: dualnum, gxs: dualnumlst n, eta: dualnum, i: int
) :<fun1> dualnumlst n = let
  macdef g (xs) = gradient (f, ,(xs))
in
//
if magnitude gxs <= PRECISION then xs
else if i = 10 then loop (f, xs, fxs, gxs, _2 * eta, 0)
else let
  val xs' = vminus (xs, vscale (eta, gxs))
in
  if distance (xs, xs') <= PRECISION then
    xs
  else let
    val fxs' = f (xs')
  in
    if fxs' < fxs then
      loop (f, xs', fxs', g xs', eta, i+1)
    else
      loop (f, xs, fxs, gxs, eta / _2, 0)
    // end of [if]
  end // end of [if]
end // end of [if]
//
end // end of [loop]
//
in
  loop (f, xs, f xs, g xs, PRECISION, 0)
end // end of [multivariate_argmin]

fn
multivariate_argmax{n:nat}
(
  f: dualnumlst n -<cloref1> dualnum, xs: dualnumlst n
) : dualnumlst n =
  multivariate_argmin (lam xs => ~(f xs), xs)
// end of [multivariate_argmax]

(* ****** ****** *)

fn multivariate_max{n:nat}
  (f: dualnumlst n -<cloref1> dualnum, xs: dualnumlst n): dualnum =
  f (multivariate_argmax (f, xs))
// end of [multivariate_max]

(* ****** ****** *)

fn saddle (): void = let
//
val start = $lst{dualnum} (_1, _1)
//
val xy1_star: dualnum2 = let
  fn f1 (
    xy1: dualnum2
  ) :<cloref1> dualnum = let
    val+list_pair (x1, y1) = xy1
    val sum = x1 * x1 + y1 * y1
    fn f2 (
      xy2: dualnum2
    ) :<cloref1> dualnum = let
      val+list_pair (x2, y2) = xy2
    in
      sum - (x2 * x2 + y2 * y2)
    end // end of [f2]
  in
    multivariate_max (f2, start)
  end // end of [f1]
in
  multivariate_argmin (f1, start)
end // end of [xy1_star]
//
val+list_pair (x1_star, y1_star) = xy1_star
//
val xy2_star: dualnum2 = let
  val sum = x1_star * x1_star + y1_star * y1_star
  fn f3 (
    xy2: dualnum2
  ) :<cloref1> dualnum = let
    val+list_pair (x2, y2) = xy2
  in
    sum - (x2 * x2 + y2 * y2)
  end // end of [f3]
in
  multivariate_argmax (f3, start)
end // end of [xy2_star]
//
val+list_pair (x2_star, y2_star) = xy2_star
//
in (* in of [let] *)
//
println! (x1_star); println! (y1_star);
println! (x2_star); println! (y2_star);
//
end // end of [saddle]

(* ****** ****** *)

fn particle () = let
//
fn naive_euler
  (w: dualnum): dualnum = let
//
val _10 = Base 10.0
val delta_t = Base 1e-1
val charge1 = $lst{dualnum}(_10, _10 - w)
val charge2 = $lst{dualnum}(_10, _0)
val charges = $lst{dualnum2} (charge1, charge2)
//
fun p
(
  xs: dualnum2
) :<cloref1> dualnum = let
  fun aux (
    charges: List dualnum2, res: dualnum
  ) :<cloref1> dualnum =
  (
    case+ charges of
    | list_cons (charge, charges) =>
        aux (charges, res + recip_dualnum (distance (xs, charge)))
    | list_nil () => res
  ) // end of [aux]
in
  aux (charges, _0)
end // end of [p]
//
fun loop
(
  xs: dualnum2
, xs_dot: dualnum2
) :<cloref1> dualnum = let
  val xs_Dot = vscale (__1, gradient (p, xs))
  val xs_new = vplus (xs, vscale (delta_t, xs_dot))
in
  if list_nth_get (xs_new, 1) > _0 then
    loop (xs_new, vplus (xs_dot, vscale (delta_t, xs_Dot)))
  else let
    val delta_t_f = ~(list_nth_get (xs, 1) / list_nth_get (xs_dot, 1))
    val xs_t_f = vplus (xs, vscale (delta_t_f, xs_dot))
  in
    square (list_nth_get (xs_t_f, 0))
  end // end of [if]
end // end of [loop]
//
val xs_initial = $lst{dualnum}(_0, Base 8.0)
val xs_dot_initial = $lst{dualnum}(Base 0.75, _0)
//
in
  loop (xs_initial, xs_dot_initial)
end // end [naive_euler]
//
val w0 = _0
val ws_star = let
//
fn f (ws: dualnum1):<cloref1> dualnum =
(
  let val+list_sing (w) = ws in naive_euler (w) end
) // end of [f]
//
in
  multivariate_argmin (f, $lst{dualnum}(w0))
end // end of [val]

val list_sing (w_star) = ws_star

in (* in of [let] *)
//
  println! (w_star)
//
end // end of [particle]

(* ****** ****** *)

(*
//
// saddle:
// 8.2463248261403561e-06
// 8.2463248261403561e-06
// 8.2463248261403561e-06
// 8.2463248261403561e-06
//
// particle:
// 0.20719187464861194
//
*)

(* ****** ****** *)

implement
main0 () =
{
  val () = saddle () // test
  val () = particle () // test
} // end of [main0]

(* ****** ****** *)

(* end of [autodiff.dats] *)

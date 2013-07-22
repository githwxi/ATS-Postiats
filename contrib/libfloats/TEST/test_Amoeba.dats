//
// A naive implementation of
// of the Nelder-Mead downhill simplex algorithm
//
(* ****** ****** *)

staload "libats/SATS/gmatrix.sats"
staload "libfloats/SATS/lamatrix.sats"

// *** TODO ***
// *** Ref counts


(*
** Nelder-Mead algorithm.
**
** Input: S: matrix of n+1 n-entry vectors as an input
**        simplex; composed of type 'a'. S may be altered
**        as a result of running the algorithm.
**
**        f: function of an 1 x n vector, to be minimized.
**           reutrns type 'b', typically a double.
**
**        (* TODO: *)
**        //Need a named structure for these.
**        alpha: reflection
**        gamma: expansion
**        rho: contraction
**        sigma: shrink       
**        ftol: stop the algorithm when the objective change is < ftol
**        tol: stop the algorithm with dist(curr_min_pt,pre_min_pt) < tol
**
** Output: vector giving the smallest observed value of f.
*)

(* ****** ****** *)

extern
fun
{a,b:t0p}
LAg_NelderMead 
  {mo:mord}{n:int}
(
  S: !LAgmat(a, mo, n+1, n) >> _
, f: LAgvec(a, n) -> b
, n: int int(n) 
): LAgvec(a,n) 

(* ****** ****** *)

extern
fun
{a,b:t0p}
order
  {mo:mord}{n:int}
(
  S: !LAgmat(a, mo, n+1, n)
, f: LAgvec(a, n) -> b 
, f_of_S: !LAgvec(b, n+1) >> _
): LAgvec(a,n)

(* ****** ****** *)

extern
fun
{a:t0p}
center
  {mo:mord}{n:int}
(
  S: !LAgmat(a, mo, n+1, n) 
, Smid: !LAgvec(a, n) >> _
): LAgvec(a,n)

(* ****** ****** *)

extern
fun
{a,b:t0p}
reflect
  {mo:mord}{n:int}
(
  S: !LAgmat(a, mo, n+1, n) 
, f: LAgvec(a, n) -> b 
, Smid: !LAgvec(a, n) >> _
, ref_pt: !LAgvec(a, n) >> _
): LAgvec(a,n)

(* ****** ****** *)

extern
fun
{a,b:t0p}
expand
  {mo:mord}{n:int}
(
  S: !LAgmat(a, mo, n+1, n) 
, f: LAgvec(a, n) -> b 
, Smid: !LAgvec(a, n) >> _
, ref_pt: !LAgvec(a, n) >> _
): LAgvec(a,n)

(* ****** ****** *)



(* ****** ****** *)


#define gint gnumber_int
//Don't need these but may need similar:
#define mul00 mul00_LAgmat_LAgmat
#define mul01 mul01_LAgmat_LAgmat
#define mul10 mul10_LAgmat_LAgmat
#define mul11 mul11_LAgmat_LAgmat

(* ****** ****** *)

implement{a,b}
LAg_NelderMead 
  {mo}{n}
(
  S, f
) = let
//
// how to use: exp: &double? >> double
var fmin: b?

local
implement
LAgvec_tabulate$fopr<b>
  (i) = f(LAgvec(i))
  (i) = gnumber_int<b>(   0   )
in
var f_of_S = LAgvec_tabulate<b> (n+1)
end

local
implement
LAgvec_tabulate$fopr<a>
  (i) = gnumber_int<a>(   0   )
in
var Smid = LAgvec_tabulate<a> (n)
var ref_pt = LAgvec_tabulate<a> (n)
var cen_pt = LAgvec_tabulate<a> (n)
var exp_pt = LAgvec_tabulate<a> (n)
end

// Actually, just initialize everything and
// declare the functions as funs for now, since they 
// act as closures

end // end of [LAg_NelderMead]

(* ****** ****** *)

(* end of [test_Amoeba.dats] *)

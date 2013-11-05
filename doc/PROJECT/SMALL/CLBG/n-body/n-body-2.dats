(*
** The Computer Language Benchmarks Game
** http://benchmarksgame.alioth.debian.org/
**
** contributed by Will Blair (2013-11)
** converted from C code by Mark C. Lewis' submission
**
** How to compile:
** patscc -pipe -O3 -fomit-frame-pointer \
**   -march=native -msse3 -mfpmath=sse -o n-body-2 n-body-2.dats -lm
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload _ = "prelude/DATS/gnumber.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/math.sats"
staload _ = "libc/DATS/math.dats"

(* ****** ****** *)

typedef v3d (a:t@ype) = @[a][3]

(* ****** ****** *)

extern
fun{a:t@ype}
vector3d_diff
(
  res: &v3d(a?) >> v3d(a), v1: &v3d(a), v2: &v3d(a)
) : void // end of [vector3d_diff]

symintr vdiff
overload vdiff with vector3d_diff

(* ****** ****** *)

extern 
fun{a:t@ype}
vector3d_dist (res: &v3d(a)): a

symintr vdist
overload vdist with vector3d_dist

(* ****** ****** *)

typedef _m128 = $extype "__m128"
typedef _m128d = $extype "__m128d"

(* ****** ****** *)

extern
fun _mm_loadl_pd (_m128d?, &double): _m128d = "mac#"
extern
fun _mm_loadh_pd (_m128d?, &double): _m128d = "mac#"

(* ****** ****** *)

extern
fun _mm_rsqrt_ps (_: _m128): _m128 = "mac#"
extern
fun _mm_cvtpd_ps (_: _m128d): _m128 = "mac#"
extern
fun _mm_cvtps_pd (_: _m128): _m128d = "mac#"
extern
fun _mm_set1_pd (_: double): _m128d = "mac#"

(* ****** ****** *)

extern
fun _mm_store_pd{l:addr}
  (pf: !double @ l | _: ptr l, _: _m128d) : void = "mac#"
// end of [_mm_store_pd]

(* ****** ****** *)
//
%{^
#define add_m128d_m128d(a,b) ((a)+(b))
#define sub_m128d_m128d(a,b) ((a)-(b))
#define mul_m128d_m128d(a,b) ((a)*(b))
#define div_m128d_m128d(a,b) ((a)/(b))
%}
//
extern
fun add_m128d_m128d (_: _m128d, _: _m128d): _m128d = "mac#"
extern
fun sub_m128d_m128d (_: _m128d, _: _m128d): _m128d = "mac#"
extern
fun mul_m128d_m128d (_: _m128d, _: _m128d): _m128d = "mac#"
extern
fun div_m128d_m128d (_: _m128d, _: _m128d): _m128d = "mac#"
//
overload + with add_m128d_m128d of 20
overload - with sub_m128d_m128d of 20
overload * with mul_m128d_m128d of 20
overload / with div_m128d_m128d of 20
//
(* ****** ****** *)

typedef planet =
$extype_struct "planet_t" of
{
  x= v3d(double), fill= double,
  v= v3d(double), mass= double
} // end of [planet]

typedef rel_t =
$extype_struct "rel_t" of
{
  dx= v3d(double), fill= double
}

typedef planetarr (n:int) = @[planet][n]

#define PI 3.1415926535898
#define SOLAR_MASS (4.0 * PI * PI)

(* ****** ****** *)

infix 0 += -= // for similar C notation
macdef += (x, d) = (,(x) := ,(x) + ,(d))
macdef -= (x, d) = (,(x) := ,(x) - ,(d))

(* ****** ****** *)

implement{a}
vector3d_diff
  (res, l, r) = let
//
macdef gsub = gsub_val<a>
//
prval (
) = __assert (res) where
{
  extern praxi __assert (&v3d(a?) >> v3d(a)): void
} (* end of [prval] *)
//
in
  res.[0] := gsub (l.[0], r.[0]);
  res.[1] := gsub (l.[1], r.[1]);
  res.[2] := gsub (l.[2], r.[2]);
end

(* ****** ****** *)

implement
vector3d_dist<double> (v) = let
//
val v_0 = v.[0] and v_1 = v.[1] and v_2 = v.[2]
//
in
  sqrt (v_0*v_0 + v_1*v_1 + v_2*v_2)
end

implement
vector3d_dist<_m128d> (v) = let
//
val v_0 = v.[0] and v_1 = v.[1] and v_2 = v.[2]
//
in
  _mm_cvtps_pd(_mm_rsqrt_ps(_mm_cvtpd_ps(v_0*v_0 + v_1*v_1 + v_2*v_2)))
end

(* ****** ****** *)

extern
fun{a:vt0p}{env:vt0p}
array_iforeach_pair$element (i: size_t, x: &a, env: &env >> _): void

implement{a}{env}
array_iforeach_pair$element(i, x, env) = ()

extern
fun{a:vt0p}{env:vt0p}
array_iforeach_pair$fwork (i: size_t, a0: &a, a1: &a, env: &env >> _): void

(*
  array_iforeach_pair: 
    Perform some action on each pair of items in an array.
    Optionally, a callback can be given for each individual element as well
*)
fun{a:vt0p}{env:vt0p}
array_iforeach_pair_env{n0:nat}
(
  arr: &(@[a][n0]), n: size_t n0, env: &env >> _
) : void = let
  fun outer_loop {l:addr} {n:nat | n <= n0} .<n>. (
    pf: !array_v (a, l, n) | p: ptr l, n: size_t n, i: size_t, e: &env
  ) : void =
    if n = 0 then () else let
      prval (pfh, pftail) = array_v_uncons (pf)
      //
      fun inner_loop
        {l1:addr} {m:nat | m <= n} .<m>.
      (
        pfpiv: !(a @ l), pf: !array_v (a, l1, m)
      | pivot: ptr l, tail: ptr l1, m: size_t m, i: size_t, e: &env
      ) : void =
        if m = 0 then
          ()
        else let
          prval (pfh, pftail) = array_v_uncons (pf)
          val () = array_iforeach_pair$fwork<a><env> (i, !pivot, !tail, e)
          val () = inner_loop
            (pfpiv, pftail | pivot, ptr_succ<a> (tail), pred (m), succ (i), e);
          prval () = pf := array_v_cons (pfh, pftail)
        in
          // nothing
        end
      //
    in 
      array_iforeach_pair$element<a><env> (i, !p, e);
      inner_loop (pfh, pftail | p, ptr_succ<a> (p), pred (n), i, e);
      outer_loop (pftail | ptr_succ<a> (p), pred (n), i + pred (n), e);
      pf := array_v_cons (pfh, pftail)
    end // end of [if]
 in
   outer_loop (view@ arr | addr@ arr, n, i2sz(0), env)
 end

(* ****** ****** *)

(*
  Useful for static variables
*)
extern
praxi initialize_lemma {a:t@ype} (_: &a? >> a): void

(* ****** ****** *)

typedef
distarr = @[rel_t][1000]
typedef
planetarr (n:int) = @[planet][n]

(* ****** ****** *)

local 
//
var rel = @[rel_t][1000]()
// All static variables are initialized
prval () = initialize_lemma (rel)
//
in
//
val rel' = ref_make_viewptr (view@rel | addr@rel)
//
end (* end of [local] *)

(* ****** ****** *)

fun advance
  {n:pos | n <= 5} .<>.
(
  bodies: &planetarr(n), n: int n, dt: double
): void = {
  val (vbox (pfr) | r) = ref_get_viewptr{distarr}(rel')
  //
  implement
  array_iforeach_pair$fwork<planet><distarr> (i, l, r, rel) = {
    val i = $UN.cast{natLt(n)}(i)
    val () = vdiff<double> (rel.[i].dx, l.x, r.x)
  }
  //
  val () = $effmask_all (
    array_iforeach_pair_env<planet><distarr> (bodies, i2sz(n), !r)
  )
  //
  val N = (n*pred(n))/2
  val () = assertloc (N >= 0)
  val () = assertloc (N < (1000 - 1))
  //
  fun loop_pairs
    {ls,ld:addr}
    {n0,n:nat | n0 <= n}
  (
    src: !array_v (rel_t, ls, n)
  , dst: !array_v (double, ld, n)
  | s: ptr ls, d: ptr ld, n: size_t n0
  ) : void =
    if n < 2 then () else {
      var dx = @[_m128d][3]()
      //
      implement
      array_initize$init<_m128d>
        (i, dx) = {
        val i = $UN.cast{natLt(3)}(i)
        val (pfl, freel | l) = $UN.ptr0_vtake {rel_t} (s)
        val (pfh, freeh | h) = $UN.ptr0_vtake {rel_t} (ptr_succ<rel_t>(s))
        val () = dx := _mm_loadl_pd (dx, !l.dx.[i])
        val () = dx := _mm_loadh_pd (dx, !h.dx.[i])
        prval () = freel (pfl)
        prval () = freeh (pfh)
      }
      val () = array_initize<_m128d> (dx, i2sz(3))
      //
      prval (pfs, pfss) = array_v_uncons (src)
      prval (pfd, pfdd) = array_v_uncons (dst)
      //
      prval (pfs', pfss) = array_v_uncons (pfss)
      prval (pfd', pfdd) = array_v_uncons (pfdd)
      //
      val dsquared = dx.[0] * dx[0] + dx.[1] * dx.[1] + dx.[2] * dx.[2]
      val distance = _mm_cvtps_pd(_mm_rsqrt_ps(_mm_cvtpd_ps(dsquared)))
      //
      val distance = let
        fun revise_distance
          (d: _m128d, i: int): _m128d =
          if i = 2 then d else let
            val d = d * _mm_set1_pd (1.5) - ((_mm_set1_pd(0.5) * dsquared) * d) * (d * d)
          in
            revise_distance (d, succ (i))
          end
      in
        revise_distance (distance, 0)
      end // end of [val]
      //
      val dmag =
        _mm_set1_pd (dt) / (dsquared) * distance
      val () = _mm_store_pd (pfd | d, dmag)
      //
      val () = loop_pairs (
        pfss, pfdd | ptr_add<rel_t> (s, 2), ptr_add<double> (d, 2), n-i2sz(2)
      )
      prval () = src := array_v_cons (pfs, array_v_cons (pfs', pfss))
      prval () = dst := array_v_cons (pfd, array_v_cons (pfd', pfdd))
    }
  //
  val p = $extval (ptr, "&mag[0]")
  val (pf_mag, free | p_mag) = $UN.ptr_vtake{@[double][1000]}(p)
  //
  val () = $effmask_all (loop_pairs (pfr , pf_mag | r, p_mag, i2sz(N)))
  //
  implement
  array_iforeach_pair$fwork<planet><distarr>
    (i, p0, p1, rel) =
  {
    val i = $UN.cast{natLt(1000)}(i)
    val p = $extval (ptr, "&mag[0]")
    val (pf_mag, free | p_mag) = $UN.ptr_vtake{@[double][1000]}(p)
    val mag = !p_mag.[i]
    val scale0 = p0.mass * mag
    val scale1 = p1.mass * mag
    prval () = free (pf_mag)
    //
    fun loop {i:nat | i <= 3} (
      i: size_t i, v0: &(@[double][3]), v1: &(@[double][3]),
      dx: &(@[double][3])
    ): void =
      if i = i2sz(3) then
        ()
      else let
        val () = v0.[i] -= dx.[i] * scale1
        val () = v1.[i] += dx.[i] * scale0
      in
        loop (succ (i), v0, v1, dx)
      end
    //
    val () = loop (i2sz(0), p0.v, p1.v, rel.[i].dx)
  }
  val () = $effmask_all (
    array_iforeach_pair_env<planet><distarr> (bodies, i2sz(n), !r)
  )
  //
  implement
  array_foreach$fwork<planet><void> (p, v) =
  {
    implement
    array_foreach2$fwork<double,double><void> (x, v, dummy) = {
      val () = x += dt * v
    }
    val _ = array_foreach2<double,double> (p.x, p.v, i2sz(3))
  }
  //
  val _ = $effmask_all (array_foreach<planet> (bodies, i2sz(n)))
  prval () = free (pf_mag);
} // end of [advance]

(* ****** ****** *)

fun energy
  {n:pos | n <= 5} .<>.
(
  bodies: &planetarr (n), n: int n
) :<!wrt> double = let
//
var e : double = 0.0
//
implement 
array_iforeach_pair$element<planet><double>
  (i, body, e) = {
//
val (
) = e +=
  body.mass * (
  body.v.[0] * body.v.[0] + 
  body.v.[1] * body.v.[1] + 
  body.v.[2] * body.v.[2] ) / 2.0
}
implement
array_iforeach_pair$fwork<planet><double>
  (i, p0, p1, e) = let
  var dx : v3d(double) = @[double][3]()
  val () = vdiff<double> (dx, p0.x, p1.x)
  val distance = vdist<double> (dx)
in
  e -= (p0.mass * p1.mass) / distance
end
  
val _ = $effmask_all
(
  array_iforeach_pair_env<planet><double> (bodies, i2sz(n), e)
)
//
in
  e
end // end of [energy]

(* ****** ****** *)

fn offmoment {n:pos}
  (bodies: &planetarr n, n: int n):<!wrt> void = {
//  
implement
array_foreach$fwork<planet><planet> (curr, sun) =
{
//
val bmass = curr.mass
implement
array_foreach2$fwork<double,double><void>
  (bv, sv, dummy) = sv -= bv * bmass / SOLAR_MASS
val _ = array_foreach2<double,double> (curr.v, sun.v, i2sz(3))
//
}
//
val _ = $effmask_all
(
  array_foreach_env<planet><planet> (bodies, i2sz(n), bodies.[0])
)
//
} // end of [offmoment]

#define N 5

sta l_theBodies: addr
extern prval pfbox_theBodies: vbox (planetarr(N) @ l_theBodies)
val p_theBodies = $extval (ptr (l_theBodies), "&theBodies[0]")

implement
main0 (
  argc, argv
) = () where {
  val () = assert (argc >= 2)
  val n = g0string2int_int (argv[1])
  val () = assert (n >= 2)
  prval vbox (pf0) = pfbox_theBodies
  val () = offmoment (!p_theBodies, N)
  val e_beg = energy (!p_theBodies, N)
  val _ = $effmask_ref (
    $extfcall (int, "printf", "%.9f\n", e_beg)
  )
  var i: int // unintialized ()
  val dt = 0.01
  val () = $effmask_all (
    for (i := 0; i < n; i := i + 1) advance (!p_theBodies, N, dt)
  )
  val e_fin = energy (!p_theBodies, N)
  val _ = $effmask_ref (
    $extfcall (int, "printf", "%.9f\n", e_fin)
  )
} // end of [main0]

(* ****** ****** *)

%{^

#include <immintrin.h>

#define PI 3.141592653589793
#define SOLAR_MASS ( 4 * PI * PI )
#define DAYS_PER_YEAR 365.24

typedef
struct
planet {
  double x[3], fill, v[3], mass;
} planet_t ;

#define NBODY 5

typedef
struct {
  double dx[3], fill;
} rel_t ;

static  __attribute__((aligned(16))) double mag[1000];

static
planet_t
theBodies[NBODY] = {
   /* sun */
   {
      .x = { 0., 0., 0. },
      .v = { 0., 0., 0. },
      .mass = SOLAR_MASS
   },
   /* jupiter */
   {
      .x = { 4.84143144246472090e+00,
         -1.16032004402742839e+00,
         -1.03622044471123109e-01 },
      .v = { 1.66007664274403694e-03 * DAYS_PER_YEAR,
         7.69901118419740425e-03 * DAYS_PER_YEAR,
         -6.90460016972063023e-05 * DAYS_PER_YEAR },
      .mass = 9.54791938424326609e-04 * SOLAR_MASS
   },
   /* saturn */
   {
      .x = { 8.34336671824457987e+00,
         4.12479856412430479e+00,
         -4.03523417114321381e-01 },
      .v = { -2.76742510726862411e-03 * DAYS_PER_YEAR,
         4.99852801234917238e-03 * DAYS_PER_YEAR,
         2.30417297573763929e-05 * DAYS_PER_YEAR },
      .mass = 2.85885980666130812e-04 * SOLAR_MASS
   },
   /* uranus */
   {
      .x = { 1.28943695621391310e+01,
         -1.51111514016986312e+01,
         -2.23307578892655734e-01 },
      .v = { 2.96460137564761618e-03 * DAYS_PER_YEAR,
         2.37847173959480950e-03 * DAYS_PER_YEAR,
         -2.96589568540237556e-05 * DAYS_PER_YEAR },
      .mass = 4.36624404335156298e-05 * SOLAR_MASS
   },
   /* neptune */
   {
      .x = { 1.53796971148509165e+01,
         -2.59193146099879641e+01,
         1.79258772950371181e-01 },
      .v = { 2.68067772490389322e-03 * DAYS_PER_YEAR,
         1.62824170038242295e-03 * DAYS_PER_YEAR,
         -9.51592254519715870e-05 * DAYS_PER_YEAR },
      .mass = 5.15138902046611451e-05 * SOLAR_MASS
   }
} ;

%}

(* ****** ****** *)

(* end of [n-body-2.dats] *)

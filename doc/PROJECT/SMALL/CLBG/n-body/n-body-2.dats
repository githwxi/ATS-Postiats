(*
** The Computer Language Benchmarks Game
** http://benchmarksgame.alioth.debian.org/
**
** contributed by Will Blair
** converted from C code from Mark C. Lewis' submission
**
** compilation command:
**   patscc -msse2 -mfpmath=sse -O3 n-body.dats -o n-body -lm
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

staload "libc/SATS/math.sats"
staload _ = "libc/DATS/math.dats"

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

abst@ype vector_t0ype (a:t@ype, n:int) = @[a][n]
typedef vector (a:t@ype, n:int) = vector_t0ype (a, n)

abst@ype vector3d (a:t@ype)

assume vector_t0ype (a:t@ype, n:int) = @[a][n]
assume vector3d (a:t@ype) = vector (a, 3)

symintr vdiff

extern
fun {a:t@ype}
vector3d_difference (
  res: &vector3d(a?) >> vector3d(a) , v1: &vector3d(a), v2: &vector3d(a)
): void

overload vdiff with vector3d_difference

symintr vdistance

extern 
fun {a:t@ype}
vector3d_distance (res: &vector3d(a)): a

overload vdistance with vector3d_distance

(* ****** ****** *)

typedef _m128d = $extype "__m128d"
typedef _m128 = $extype "__m128"

extern
fun _mm_loadl_pd (_: _m128d?, _: &double): _m128d = "mac#"

extern
fun _mm_loadh_pd (_: _m128d, _: &double): _m128d = "mac#"

extern
fun _mm_rsqrt_ps (_: _m128): _m128 = "mac#"

extern
fun _mm_cvtpd_ps (_: _m128d): _m128 = "mac#"

extern
fun _mm_cvtps_pd (_: _m128): _m128d = "mac#"

extern
fun _mm_set1_pd (_: double): _m128d = "mac#"

extern
fun _mm_store_pd {l:addr} (
  pf: !double @ l | _: ptr l, _: _m128d
): void = "mac#"

extern
fun _m128d_mul_m128d (_: _m128d, _: _m128d): _m128d = "mac#"

overload * with _m128d_mul_m128d of 20

extern
fun _m128d_add_m128d (_: _m128d, _: _m128d): _m128d = "mac#"

overload + with _m128d_add_m128d of 20

extern
fun _m128d_sub_m128d (_: _m128d, _: _m128d): _m128d = "mac#"

overload - with _m128d_sub_m128d of 20

extern
fun _m128d_div_m128d (_: _m128d, _: _m128d): _m128d = "mac#"

overload / with _m128d_div_m128d of 20

(* ****** ****** *)

typedef planet = $extype_struct "struct planet" of {
  x= vector3d (double),
  fill= double,
  v = vector3d (double),
  mass= double
} // end of [planet]

typedef rel_t = $extype_struct "rel_t" of {
  dx= vector3d (double),
  fill= double
}

typedef planetarr (n:int) = @[planet][n]

#define PI 3.1415926535898
#define SOLAR_MASS (4.0 * PI * PI)

(* ****** ****** *)

infix 0 += -=  // for similar C notation
macdef += (x, d) = (,(x) := ,(x) + ,(d))
macdef -= (x, d) = (,(x) := ,(x) - ,(d))

(* ****** ****** *)

implement vector3d_difference<double> (res, l, r) = let
  fun loop {ld,ll,lr: addr} {n:nat | n <= 3} .<n>. (
    pfd: !array_v (double?, ld, n) >> array_v (double, ld, n), pfl: !array_v (double, ll, n), pfr: !array_v (double, lr, n) |
    d: ptr ld,  l: ptr ll, r: ptr lr, n: size_t n
  ):<!wrt> void = 
    if n = 0 then {
      prval () = pfd := array_v_unnil_nil (pfd)
    }
    else let
      prval (pfdh, pfdd) = array_v_uncons (pfd)
      prval (pflh, pfll) = array_v_uncons (pfl)
      prval (pfrh, pfrr) = array_v_uncons (pfr)
      val () = !d := !l - !r
    in
      loop (pfdd, pfll, pfrr | 
        ptr_succ<double>(d), ptr_succ<double>(l), ptr_succ<double>(r), pred (n)
      );
      pfd := array_v_cons (pfdh, pfdd);
      pfl := array_v_cons (pflh, pfll);
      pfr := array_v_cons (pfrh, pfrr);
    end
in
  loop (view@ res, view@ l, view@ r | addr@ res, addr@ l, addr@ r, i2sz(3))
end

implement vector3d_distance<double> (v) = let
  var dsum : double = 0.0
  //
  implement array_foreach$fwork<double><double> (v_i, sum) =
    sum += v_i * v_i
  //
  val _ = array_foreach_env<double><double> (v, i2sz(3), dsum)
in
  sqrt (dsum)
end


implement vector3d_distance<_m128d> (v) = let
  var dsum : _m128d = _mm_set1_pd (0.0)
  //
  implement array_foreach$fwork<_m128d><_m128d> (v_i, sum) =
    sum += v_i * v_i
  //
  val _ = array_foreach_env<_m128d><_m128d> (v, i2sz(3), dsum)
in
  _mm_cvtps_pd(_mm_rsqrt_ps(_mm_cvtpd_ps(dsum)))
end

(* ****** ****** *)

extern
fun {a:viewt@ype}{env:viewt@ype}
array_iforeach_pair$element (
  i: size_t, x: &a, env: &env
): void

implement{a}{env} array_iforeach_pair$element(i, x, env) = ()

extern
fun {a:viewt@ype}{env:viewt@ype}
array_iforeach_pair$fwork (
  i: size_t, a0: &a, a1: &a, env: &env
): void

(*
  array_iforeach_pair: 
    Perform some action on each pair of items in an array.
    Optionally, a callback can be given for each individual element as well
*)
fun {a:viewt@ype} {env:viewt@ype}
array_iforeach_pair_env {n0:nat} (
  arr: &(@[a][n0]), n: size_t n0, env: &env
): void = let
  fun outer_loop {l:addr} {n:nat | n <= n0} .<n>. (
    pf: !array_v (a, l, n) | p: ptr l, n: size_t n, i: size_t, e: &env
  ): void =
    if n = 0 then
      ()
    else let
      prval (pfh, pftail) = array_v_uncons (pf)
      //
      fun inner_loop {l1:addr} {m:nat | m <= n} .<m>. (
        pfpiv: !(a @ l), pf: !array_v (a, l1, m) | 
        pivot: ptr l, tail: ptr l1, m: size_t m, i: size_t, e: &env
      ): void =
        if m = 0 then
          ()
        else let
          prval (pfh, pftail) = array_v_uncons (pf)
          val () = array_iforeach_pair$fwork<a><env> (i, !pivot, !tail, e)
        in
          inner_loop (pfpiv, pftail | 
            pivot, ptr_succ<a> (tail), pred (m), succ (i), e
          );
          pf := array_v_cons (pfh, pftail)
        end
      //
    in 
      array_iforeach_pair$element<a><env> (i, !p, e);
      inner_loop (pfh, pftail | p, ptr_succ<a> (p), pred (n), i, e);
      outer_loop (pftail | ptr_succ<a> (p), pred (n), i + pred (n), e);
      pf := array_v_cons (pfh, pftail)
    end
 in
  outer_loop (view@ arr | addr@ arr, n, i2sz(0), env)
 end

(* ****** ****** *)

(*
  Useful for static variables
*)
extern
praxi initialize_lemma {a:t@ype} (_: &a? >> a): void

extern 
praxi array_length_lemma {a:t@ype} {n,i:nat} (
  _: @[a][n], _: size_t i
): [i < n] void

(* ****** ****** *)

typedef planetarr (n:int) = @[planet][n]

typedef distances = @[rel_t][1000]

local 
  var rel = @[rel_t][1000]()
  
  // All static variables are initialized
  prval () = initialize_lemma (rel)
in
  val rel' = ref_make_viewptr (view@ rel | addr@ rel)
end

fun advance {n:pos | n <= 5} .<>. (
  bodies: &planetarr(n), nbodies: int n, dt: double
): void = {
  val (vbox (pfr) | r) = ref_get_viewptr {distances} (rel')
  //
  implement array_iforeach_pair$fwork<planet><distances> (i, l, r, rel) = {
    val i = g1ofg0 (i)
    prval () = array_length_lemma (rel, i)
    val () = vdiff<double> (rel.[i].dx, l.x, r.x)
  }
  //
  val () = $effmask_all (
    array_iforeach_pair_env<planet><distances> (bodies, i2sz(nbodies), !r)
  )
  //
  val N = ((nbodies - 1) * (nbodies))/2
  val () = assertloc (N < (1000 - 1))
  val () = assertloc (N >= 0)
  //
  fun loop_pairs {ls,ld:addr} {n0,n:nat | n0 <= n} (
    source: !array_v (rel_t, ls, n), dest: !array_v (double, ld, n) |
      s: ptr ls, d: ptr ld, n: size_t n0
  ): void =
    if n < 2 then
      ()
    else {
      var dx = @[_m128d][3]()
      //
      implement array_initize$init<_m128d> (i, dx) = {
        val i = g1ofg0 (i)
        val (pfl, freel | l) = $UN.ptr0_vtake {rel_t} (s)
        val (pfh, freeh | h) = $UN.ptr0_vtake {rel_t} (ptr_succ<rel_t>(s))
        prval () = array_length_lemma (!l.dx, i)
        prval () = array_length_lemma (!h.dx, i)
        val () = dx := _mm_loadl_pd (dx, !l.dx.[i])
        val () = dx := _mm_loadh_pd (dx, !h.dx.[i])
        prval () = freel (pfl)
        prval () = freeh (pfh)
      }
      val () = array_initize<_m128d> (dx, i2sz(3))
      //
      prval (pfs, pfss) = array_v_uncons (source)
      prval (pfd, pfdd) = array_v_uncons (dest)
      //
      prval (pfs', pfss) = array_v_uncons (pfss)
      prval (pfd', pfdd) = array_v_uncons (pfdd)
      //
      val dsquared = dx.[0] * dx[0] + dx.[1] * dx.[1] + dx.[2] * dx.[2]
      val distance = _mm_cvtps_pd(_mm_rsqrt_ps(_mm_cvtpd_ps(dsquared)))
      //
      val distance = revise_distance (distance, 0) where {
        fun revise_distance (
          d: _m128d, i: int
        ): _m128d =
          if i = 2 then
            d
          else let
            val distance = d * _mm_set1_pd (1.5) 
              - ((_mm_set1_pd(0.5) * dsquared) * d)
              * (d * d)
          in
            revise_distance (distance, succ (i))
          end
      }
      //
      val dmag = _mm_set1_pd (dt) / (dsquared) * distance
      
      val () = _mm_store_pd (pfd | d, dmag)
      //
      val () = loop_pairs (pfss, pfdd |
        ptr_add<rel_t> (s, 2), ptr_add<double> (d, 2), n - i2sz(2)
      )
      prval () = source := array_v_cons (pfs, array_v_cons (pfs', pfss))
      prval () = dest := array_v_cons (pfd, array_v_cons (pfd', pfdd))
   }
  //
  val p = $extval (ptr, "&mag[0]")
  val (pf_mag, free | p_mag) = $UN.ptr_vtake{@[double][1000]} (p)
  
  val () = $effmask_all (
    loop_pairs (pfr , pf_mag | r, p_mag, i2sz(N))
  )
  implement 
    array_iforeach_pair$fwork<planet><distances> (i, p0, p1, rel) = {
    val i = g1ofg0 (i)
    prval () = array_length_lemma (rel, i)
    //
    val p = $extval (ptr, "&mag[0]")
    val (pf_mag, free | p_mag) = $UN.ptr_vtake{@[double][1000]} (p)
    prval () = array_length_lemma (!p_mag, i)
        
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
    array_iforeach_pair_env<planet><distances> (bodies, i2sz(nbodies), !r)
  )
  //
  implement array_foreach$fwork<planet><void> (p, v) = {
    implement array_foreach2$fwork<double,double><void> (x, v, dummy) = {
      val () = x += dt * v
    }
    val _ = array_foreach2<double,double> (p.x, p.v, i2sz(3))
  }
  val _ = $effmask_all (
    array_foreach<planet> (bodies, i2sz(nbodies))
  )
  prval () = free (pf_mag);
} // end of [advance]

fun energy {n:pos | n <= 5} .<>. (
  bodies: &planetarr (n), nbodies: int n
):<!wrt> double = let
  var e : double = 0.0
  implement 
    array_iforeach_pair$element<planet><double> (i, body, e) = {
      val () = e += body.mass * (
        body.v.[0] * body.v.[0] + 
        body.v.[1] * body.v.[1] + 
        body.v.[2] * body.v.[2]
      ) / 2.0
  }
  implement
    array_iforeach_pair$fwork<planet><double> (i, p0, p1, e) = let
      var dx : vector3d(double) = @[double][3]()
      val () = vdiff<double> (dx, p0.x, p1.x)
      val distance = vdistance<double> (dx)
  in
    e -= (p0.mass * p1.mass) / distance
  end
  
  val _ = $effmask_all (
    array_iforeach_pair_env<planet><double> (bodies, i2sz(nbodies), e)
  )
in
  e
end // end of [energy]

fn offmoment {n:pos}
  (bodies: &planetarr n, n: int n):<!wrt> void = {
  
  implement array_foreach$fwork<planet><planet> (curr, sun) = {
    val bmass = curr.mass
    implement array_foreach2$fwork<double,double><void> (bv, sv, dummy) =
      sv -= bv * bmass / SOLAR_MASS
    //
    val _ = array_foreach2<double,double> (curr.v, sun.v, i2sz(3))
  }
  val _ = $effmask_all (
    array_foreach_env<planet><planet> (bodies, i2sz(n), bodies.[0])
  )
} // end of [offmoment]

#define N 5

sta l_theBodies: addr
extern prval pfbox_theBodies: vbox (planetarr(N) @ l_theBodies)
val p_theBodies = $extval (ptr (l_theBodies), "&theBodies[0]")

implement main0 (argc, argv) = () where {
  val () = assert (argc = 2)
  val str = argv[1]
  val n = g1string2int<intknd>(str)
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

struct planet {
  double x[3], fill, v[3], mass;
};

#define NBODY 5

typedef struct {
    double dx[3], fill;
} rel_t;

static  __attribute__((aligned(16))) double mag[1000];

static struct planet theBodies[NBODY] = {
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

inline __m128d _m128d_mul_m128d (__m128d a, __m128d b) {
   return a * b;
}

inline __m128d _m128d_add_m128d (__m128d a, __m128d b) {
   return a + b;
}

inline __m128d _m128d_sub_m128d (__m128d a, __m128d b) {
   return a - b;
}

inline __m128d _m128d_div_m128d (__m128d a, __m128d b) {
   return a / b;
}
%}
(*
** The Computer Language Benchmarks Game
** http://benchmarksgame.alioth.debian.org/
**
** contributed by Hongwei Xi
**
** compilation command:
**   patscc -msse2 -mfpmath=sse -O3 n-body.dats -o n-body -lm
*)

(* ****** ****** *)
//
// Ported to ATS2 by WB-2013-11-01
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload "libc/SATS/math.sats"
staload _ = "libc/DATS/math.dats"
//
(* ****** ****** *)

typedef
planet = @{
  x= double, y= double, z= double
, vx= double, vy= double, vz= double
, mass= double
} // end of [planet]

typedef planetarr (n:int) = @[planet][n]

(* ****** ****** *)

infix 0 += -=  // for similar C notation
macdef += (x, d) = (,(x) := ,(x) + ,(d))
macdef -= (x, d) = (,(x) := ,(x) - ,(d))

fn advance {n:pos}
  (bodies: &planetarr n, n: int n, dt: double):<!wrt> void = () where {  
  fun loop_inner
    {l1:addr} {n2:nat} {l2:addr} .<n2>.
  (
      pf1: !planet @ l1, pf2: !planetarr n2 @ l2
    | p1: ptr l1, p2: ptr l2, n2: int n2, dt: double
  ) :<!wrt> void =
    if n2 > 0 then let
      prval (pf21, pf22) = array_v_uncons {planet} (pf2)
      val dx = p1->x - p2->x and dy = p1->y - p2->y and dz = p1->z - p2->z
      val dist2 = dx * dx + dy * dy + dz * dz
      val dist = sqrt (dist2)
      val mag = dt / (dist * dist2)
//
      val mass = p2->mass
      val () = p1->vx -= dx * mass * mag
      val () = p1->vy -= dy * mass * mag
      val () = p1->vz -= dz * mass * mag
//
      val mass = p1->mass
      val () = p2->vx += dx * mass * mag
      val () = p2->vy += dy * mass * mag
      val () = p2->vz += dz * mass * mag
//
      val () = loop_inner (pf1, pf22 | p1, ptr_succ<planet> (p2) , n2-1, dt)
      prval () = pf2 := array_v_cons {planet} (pf21, pf22)
    in
      // empty
    end // end of [if]
  // end of [loop_inner]
  fun loop_outer {n1:pos} {l1:addr} .<n1>. (
      pf1: !planetarr n1 @ l1 | p1: ptr l1, n1: int n1, dt: double
    ) :<!wrt> void =
    if n1 >= 2 then let
      prval (pf11, pf12) = array_v_uncons {planet} (pf1)
      val p2 = ptr_succ<planet>(p1) and n2 = n1-1
      val () = loop_inner (pf11, pf12 | p1, p2, n2, dt)
      val () = loop_outer (pf12 | p2, n2, dt)
      prval () = pf1 := array_v_cons {planet} (pf11, pf12)
    in
      // empty
    end // end of [if]
  // end of [loop_outer]
  val () = loop_outer (view@ bodies | addr@ bodies, n, dt)
  fun loop {n1:nat} {l1:addr} .<n1>. (
      pf1: !planetarr n1 @ l1 | p1: ptr l1, n1: int n1, dt: double
    ) :<!wrt> void =
    if n1 > 0 then let
      prval (pf11, pf12) = array_v_uncons {planet} (pf1)
      val () = p1->x += dt * p1->vx
      val () = p1->y += dt * p1->vy
      val () = p1->z += dt * p1->vz
      val () = loop (pf12 | ptr_succ<planet> (p1), n1-1, dt)
      prval () = pf1 := array_v_cons {planet} (pf11, pf12)
    in
      // empty
    end // end of [if]
  // end of [loop]
  val () = loop (view@ bodies | addr@ bodies, n, dt)
} // end of [advance]

fn energy {n:pos}
  (bodies: &planetarr n, n: int n):<!wrt> double = e where {
  fun loop_inner
    {l1:addr} {n2:nat} {l2:addr} .<n2>. (
      pf1: !planet @ l1, pf2: !planetarr n2 @ l2
    | p1: ptr l1, p2: ptr l2, n2: int n2, e: &double
    ) :<!wrt> void =
    if n2 > 0 then let
      prval (pf21, pf22) = array_v_uncons {planet} (pf2)
      val dx = p1->x - p2->x
      and dy = p1->y - p2->y
      and dz = p1->z - p2->z
      val dist = sqrt (dx * dx + dy * dy + dz * dz)
      val () = e -= (p1->mass * p2->mass) / dist
      val () = loop_inner (pf1, pf22 | p1, ptr_succ<planet>(p2), n2-1, e)
      prval () = pf2 := array_v_cons {planet} (pf21, pf22)
    in
      // empty
    end // end of [if]
  // end of [loop_inner]
  fun loop_outer {n1:nat} {l1:addr} .<n1>. (
      pf1: !planetarr n1 @ l1 | p1: ptr l1, n1: int n1, e: &double
    ) :<!wrt> void =
    if n1 > 0 then let
      prval (pf11, pf12) = array_v_uncons {planet} (pf1)
      val vx = p1->vx and vy = p1->vy and vz = p1->vz
      val () = e += 0.5 * p1->mass * (vx * vx + vy * vy + vz * vz)
      val p2 = ptr_succ<planet>(p1) and n2 = n1-1
      val () = loop_inner (pf11, pf12 | p1, p2, n2, e)
      val () = loop_outer (pf12 | p2, n2, e)
      prval () = pf1 := array_v_cons {planet} (pf11, pf12)
    in
      // empty
    end // end of [loop_outer]
  // end of [loop_outer]
  var e: double = 0.0
  val () = loop_outer (view@ bodies | addr@ bodies, n, e)  
} // end of [energy]

(* ****** ****** *)

#define PI 3.1415926535898
#define SOLAR_MASS (4.0 * PI * PI)

typedef point = @{x=double, y=double, z=double}

fn offmoment {n:pos}
(
  bodies: &planetarr n, n: int n
) :<!wrt> void = () where {
//
var p: point = @{x=0.0, y=0.0, z=0.0}
//  
implement
array_foreach$fwork<planet><point> (planet, p) = {
  val mass = planet.mass
  val () = p.x += planet.vx * mass
  val () = p.y += planet.vy * mass
  val () = p.z += planet.vz * mass    
}
//  
val sz = $effmask_all (
  array_foreach_env<planet><point> (bodies, i2sz(n), p)
)
val () = bodies.[0].vx := ~ p.x / SOLAR_MASS
val () = bodies.[0].vy := ~ p.y / SOLAR_MASS
val () = bodies.[0].vz := ~ p.z / SOLAR_MASS    
//
} (* end of [offset] *)

(* ****** ****** *)

#define N 5

sta l_theBodies: addr
extern prval pfbox_theBodies: vbox (planetarr(N) @ l_theBodies)
val p_theBodies = $extval (ptr (l_theBodies), "&theBodies[0]")

implement
main0 (argc, argv) =
{
  val () = assertloc (argc >= 2)
  val n = g1string2int (argv[1])
  val () = assertloc (n >= 2)
  prval vbox (pf_theBodies) = pfbox_theBodies
  val () = offmoment (!p_theBodies, N)
  val e_beg = energy (!p_theBodies, N)
  val () = ignoret ($extfcall (int, "printf", "%.9f\n", e_beg))
  var i: int // unintialized ()
  val dt = 0.01
  val () = for (i := 0; i < n; i := i + 1) advance (!p_theBodies, N, dt)
  val e_fin = energy (!p_theBodies, N)
  val () = ignoret ($extfcall (int, "printf", "%.9f\n", e_fin))
} (* end of [main0] *)

(* ****** ****** *)
//
// reuse some existing C code for initialization
//
(* ****** ****** *)

%{^ // put at the beginning

#define PI 3.1415926535898
#define SOLAR_MASS (4.0 * PI * PI)
#define DAYS_PER_YEAR 365.24

#define NBODY 5

struct planet {
  double x; double y; double z;
  double vx; double vy; double vz; double mass;
} ;

struct planet theBodies[NBODY] = {
  { /* sun */
    0, 0, 0, 0, 0, 0, SOLAR_MASS
  }
, { /* jupiter */
    4.84143144246472090e+00,
   -1.16032004402742839e+00,
   -1.03622044471123109e-01,
    1.66007664274403694e-03 * DAYS_PER_YEAR,
    7.69901118419740425e-03 * DAYS_PER_YEAR,
   -6.90460016972063023e-05 * DAYS_PER_YEAR,
    9.54791938424326609e-04 * SOLAR_MASS
  }
, {  /* saturn */
    8.34336671824457987e+00,
    4.12479856412430479e+00,
   -4.03523417114321381e-01,
   -2.76742510726862411e-03 * DAYS_PER_YEAR,
    4.99852801234917238e-03 * DAYS_PER_YEAR,
    2.30417297573763929e-05 * DAYS_PER_YEAR,
    2.85885980666130812e-04 * SOLAR_MASS
  }
, { /* uranus */
    1.28943695621391310e+01,
   -1.51111514016986312e+01,
   -2.23307578892655734e-01,
    2.96460137564761618e-03 * DAYS_PER_YEAR,
    2.37847173959480950e-03 * DAYS_PER_YEAR,
   -2.96589568540237556e-05 * DAYS_PER_YEAR,
    4.36624404335156298e-05 * SOLAR_MASS
  }
, { /* neptune */
    1.53796971148509165e+01,
   -2.59193146099879641e+01,
    1.79258772950371181e-01,
    2.68067772490389322e-03 * DAYS_PER_YEAR,
    1.62824170038242295e-03 * DAYS_PER_YEAR,
   -9.51592254519715870e-05 * DAYS_PER_YEAR,
    5.15138902046611451e-05 * SOLAR_MASS
  }
} ;

%}

(* ****** ****** *)

(* end of [n-body.dats] *)

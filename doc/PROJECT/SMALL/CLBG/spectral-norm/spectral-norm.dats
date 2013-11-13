(*
** The Great Computer Language Shootout
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
**
** compilation command:
**   atscc -O3 -msse2 spectral-norm.dats -o spectral-norm -lm
**
*)

(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-11-13
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload M = "libc/SATS/math.sats"
staload _(*M*) = "libc/DATS/math.dats"

(* ****** ****** *)

macdef A(i,j) = // macro definition
  1.0 / ((,(i) + ,(j)) * (,(i) +,(j) + 1) / 2 + ,(i) + 1)

(* ****** ****** *)

%{^
static inline
atstype_ptr darr_make (atstype_int n) {
  atstype_double *p0 ;
  p0 = malloc(n * sizeof(atstype_double)) ; if (!p0) exit (1) ;
  return p0 ;
}

static inline
atstype_ptr darr_make_elt (atstype_int n, atstype_double f) {
  int i;
  atstype_double *p0, *p ;
  p0 = darr_make (n) ; for (i = 0, p = p0; i < n; ++i, ++p) *p = f ;
  return p0 ;
}

static inline
atsvoid_t0ype darr_free (atstype_ptr A) { free (A) ; return ; }

%}

(* ****** ****** *)

abst@ype darr (n:int)

(* ****** ****** *)

local

assume darr (n:int) = @[double][n]

in // in of [local]

extern fun darr_make {n:nat}
  (n: int n): [l:addr] (darr n @ l | ptr l) = "mac#darr_make"
extern fun darr_make_elt {n:nat}
  (n: int n, f: double): [l:addr] (darr n @ l | ptr l) = "mac#darr_make_elt"
extern fun darr_free {n:nat}
  {l:addr} (pf: darr n @ l | p: ptr l): void = "mac#darr_free"

fn darr_get {n:nat} (A: &darr n, i: natLt n): double = A[i]
fn darr_set {n:nat} (A: &darr n, i: natLt n, f: double): void = A[i] := f
  
end // end of [local]

(* ****** ****** *)

overload [] with darr_get; overload [] with darr_set

(* ****** ****** *)

infix 0 +=; macdef += (x, d) = (,(x) := ,(x) + ,(d))

fn eval_A_times_u {N:nat}
  (N: int N, u: &darr N, Au: &darr N): void = let
  var i: natLte N; var j: natLte N = 0
in
  for (i := 0; i < N; i += 1) begin
    Au[i] := 0.0 ; j := 0 ;
    while* (i: natLt N) => (j < N) (Au[i] += A(i,j) * u[j]; j += 1) ;
  end (* end of [for] *)
end // end of [eval_A_times_u]

fn eval_At_times_u {N:nat}
  (N: int N, u: &darr N, Au: &darr N): void = let
  var i: natLte N; var j: natLte N = 0
in
  for (i := 0; i < N; i += 1) begin
    Au[i] := 0.0 ; j := 0 ;
    while* (i: natLt N) => (j < N) (Au[i] += A(j,i) * u[j]; j += 1) ;
  end (* end of [for] *)
end // end of [eval_At_times_u]

(* ****** ****** *)

fn eval_AtA_times_u {N:nat}
  (N: int N, u: &darr N, AtAu: &darr N): void = let
  val (pf_v | p_v) = darr_make (N)
in
  eval_A_times_u(N, u, !p_v); eval_At_times_u (N, !p_v, AtAu);
  darr_free (pf_v | p_v)
end // end of [eval_AtA_times_u]

(* ****** ****** *)

#define TIMES 10

(* ****** ****** *)

implement
main0 (argc, argv) = let
  val () = assertloc (argc >= 2)
  val [N:int] N = g1ofg0(g0string2int(argv[1]))
  val () = assert_errmsg (
    N >= 0, "The input integer needs to be a natural number.\n"
  )
  val (pf_u | p_u) = darr_make_elt (N, 1.0)
  val (pf_v | p_v) = darr_make_elt (N, 0.0)
  var i: Nat = 0; val () = while (i < TIMES) begin
    eval_AtA_times_u (N, !p_u, !p_v); eval_AtA_times_u (N, !p_v, !p_u); i += 1;
  end
  var vBv: double = 0.0 and vv: double = 0.0
//
  var i: Nat = 0
  val () = while (i < N) let
    val ui = darr_get (!p_u, i) and vi = darr_get (!p_v, i)
  in
    vBv += ui*vi; vv += vi*vi; i += 1
  end // end of [where] // end of [val]
//
  val () = (darr_free (pf_u | p_u); darr_free (pf_v | p_v))
  val _ = $extfcall (int, "printf", "vBv = %f and vv = %f\n", vBv, vv)
  val _ = $extfcall (int, "printf", "%0.9f\n", $M.sqrt (vBv/vv))
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [spectral-norm.dats] *)

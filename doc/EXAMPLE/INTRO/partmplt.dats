//
// Some code involving partial templates
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start time: June, 2013
//
(* ****** ****** *)

staload
INT = "prelude/DATS/integer.dats"
staload
FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/gorder.dats"
staload _ = "prelude/DATS/gnumber.dats"

(* ****** ****** *)

abst@ype cmplx (a: t@ype) = @(a, a)

(* ****** ****** *)

extern
fun{a:t0p}
cmplx_make (r: a, i: a):<> cmplx (a)
extern
fun{a:t0p} cmplx_real (x: cmplx a):<> a
extern
fun{a:t0p} cmplx_imag (x: cmplx a):<> a

extern
fun{a:t0p}
fprint_cmplx (out: FILEref, z: cmplx a): void
overload fprint with fprint_cmplx

(* ****** ****** *)

local

assume cmplx (a) = @(a, a)

in (* in of [local] *)

implement{a}
cmplx_make (r, i) = @(r, i)

implement{a} cmplx_real (z) = z.0
implement{a} cmplx_imag (z) = z.1

end // end of [local]

(* ****** ****** *)

implement(a)
gmul_val<cmplx(a)>
  (z1, z2) = let
//
macdef + = gadd_val<a>
macdef - = gsub_val<a>
macdef * = gmul_val<a>
//
val r1 = cmplx_real<a> (z1)
val i1 = cmplx_imag<a> (z1)
val r2 = cmplx_real<a> (z2)
val i2 = cmplx_imag<a> (z2)
//
in
  cmplx_make (r1 * r2 - i1 * i2, r1 * i2 + i1 * r2)
end // end of [gmul_val]

(* ****** ****** *)

implement{a}
fprint_cmplx (out, z) = let
//
val r = cmplx_real<a> (z)
val i = cmplx_imag<a> (z)
//
in
  fprint (out, "(r=");
  fprint_val<a> (out, r);
  fprint (out, ", i=");
  fprint_val<a> (out, i);
  fprint (out, ")")
end // end of [fprint_cmplx]

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
//
val z_i = cmplx_make<int> (1, 1)
val zz_i = gmul_val<cmplx(int)> (z_i, z_i)
//
val () = fprintln! (out, "zz_i = ", zz_i)
//
val z_d = cmplx_make<double> (1.0, 1.0)
val zz_d = gmul_val<cmplx(double)> (z_d, z_d)
//
val () = fprintln! (out, "zz_d = ", zz_d)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [partmplt.dats] *)

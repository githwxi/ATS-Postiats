(* ****** ****** *)
(*
** For writing ATS code
** that translates into PHP
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_matrixref_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_php.sats"
//
#staload "./../SATS/integer.sats"
//
#staload "./../SATS/PHParref.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/intrange.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/matrixref.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/matrixref.dats"
//
(* ****** ****** *)
//
(*
assume
matrixref_vt0ype_type(a, m, n) = PHParray(a)
*)
//
(* ****** ****** *)
//
implement
matrixref_make_elt
  {a}{m,n}(m, n, x) = let
  val mn = $UN.cast{Nat}(m*n)
in
//
$UN.cast
{matrixref(a,m,n)}(PHParref_make_elt(mn, x))
//
end // end of [matrixref_make_elt]
//
(* ****** ****** *)

implement
matrixref_get_at
  {a}(A, i, n, j) = let
//
val A =
$UN.cast{PHParref(a)}(A) in PHParref_get_at(A, i*n+j)
//
end // end of [matrixref_get_at]

(* ****** ****** *)

implement
matrixref_set_at
  {a}(A, i, n, j, x) = let
//
val A =
$UN.cast{PHParref(a)}(A) in PHParref_set_at(A, i*n+j, x)
//
end // end of [matrixref_set_at]

(* ****** ****** *)

%{^
//
function
ats2phppre_mtrxszref_make_matrixref
  ($matrix, $nrow, $ncol)
{
  return array($matrix, $nrow, $ncol);
}
//
function
ats2phppre_mtrxszref_get_nrow($MSZ) { return $MSZ[1]; }
function
ats2phppre_mtrxszref_get_ncol($MSZ) { return $MSZ[2]; }
//
function
ats2phppre_mtrxszref_get_at
  ($MSZ, $i, $j)
{
  $nrow = $MSZ[1];
  $ncol = $MSZ[2];
  if ($i < 0) throw new RangeException("mtrxszref_get_at");
  if ($j < 0) throw new RangeException("mtrxszref_get_at");
  if ($i >= $nrow) throw new RangeException("mtrxszref_get_at");
  if ($j >= $ncol) throw new RangeException("mtrxszref_get_at");
  return ats2phppre_PHParref_get_at($MSZ[0], $i*$ncol+$j);
}
//
function
ats2phppre_mtrxszref_set_at
  ($MSZ, $i, $j, $x0)
{
  $nrow = $MSZ[1];
  $ncol = $MSZ[2];
  if ($i < 0) throw new RangeException("mtrxszref_set_at");
  if ($j < 0) throw new RangeException("mtrxszref_set_at");
  if ($i >= $nrow) throw new RangeException("mtrxszref_set_at");
  if ($j >= $ncol) throw new RangeException("mtrxszref_set_at");
  ats2phppre_PHParref_set_at($MSZ[0], $i*$ncol+$j, $x0); return;
}
//
%} // end of [%{^]

(* ****** ****** *)

(* end of [matrixref.dats] *)

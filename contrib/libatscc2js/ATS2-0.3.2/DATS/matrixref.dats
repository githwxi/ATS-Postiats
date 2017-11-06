(* ****** ****** *)
(*
** For writing ATS code
** that translates into Javascript
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_matrixref_"
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
#staload "./../basics_js.sats"
//
#staload "./../SATS/integer.sats"
//
#staload "./../SATS/JSarray.sats"
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
matrixref_vt0ype_type(a, m, n) = JSarray(a)
*)
//
(* ****** ****** *)

%{^
//
function
ats2jspre_matrixref_make_elt
  (m, n, x)
{
  var A, i, j;
  A = new Array(m*n);
  for (i = 0; i < m; i += 1)
  {
    for (j = 0; j < n; j += 1) A[i*n+j] = x;
  }
  return A;
}
//
%} // end of [%{^]

(* ****** ****** *)

implement
matrixref_get_at
  {a}(A, i, n, j) = let
  val A = $UN.cast{JSarray(a)}(A) in JSarray_get_at(A, i*n+j)
end // end of [matrixref_get_at]

(* ****** ****** *)

implement
matrixref_set_at
  {a}(A, i, n, j, x) = let
  val A = $UN.cast{JSarray(a)}(A) in JSarray_set_at(A, i*n+j, x)
end // end of [matrixref_set_at]

(* ****** ****** *)

%{^
//
function
ats2jspre_mtrxszref_make_matrixref
  (M, m, n)
{
  return { matrix: M, nrow: m, ncol: n };
}
//
function
ats2jspre_mtrxszref_get_nrow(MSZ) { return MSZ.nrow; }
function
ats2jspre_mtrxszref_get_ncol(MSZ) { return MSZ.ncol; }
//
function
ats2jspre_mtrxszref_get_at
  (MSZ, i, j)
{
  var nrow = MSZ.nrow;
  var ncol = MSZ.ncol;
  if (i < 0) throw new RangeError("mtrxszref_get_at");
  if (j < 0) throw new RangeError("mtrxszref_get_at");
  if (i >= nrow) throw new RangeError("mtrxszref_get_at");
  if (j >= ncol) throw new RangeError("mtrxszref_get_at");
  return MSZ.matrix[i*ncol+j];
}
//
function
ats2jspre_mtrxszref_set_at
  (MSZ, i, j, x0)
{
  var nrow = MSZ.nrow;
  var ncol = MSZ.ncol;
  if (i < 0) throw new RangeError("mtrxszref_set_at");
  if (j < 0) throw new RangeError("mtrxszref_set_at");
  if (i >= nrow) throw new RangeError("mtrxszref_set_at");
  if (j >= ncol) throw new RangeError("mtrxszref_set_at");
  return (MSZ.matrix[i*ncol+j] = x0);
}
//
%} // end of [%{^]

(* ****** ****** *)

(* end of [matrixref.dats] *)

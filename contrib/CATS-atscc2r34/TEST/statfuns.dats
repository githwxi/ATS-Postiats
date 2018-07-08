(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "my_dynload"
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include "{$LIBATSCC2R34}/mylibies.hats"
//
(* ****** ****** *)
//
val xs =
R34vector_tabulate_fun
{int}(100, lam(i) => (i+1)*(i+1))
//
val () =
$extfcall(void, "message", "mean = ", mean(xs))
val () =
$extfcall(void, "message", "median = ", median(xs))
val () =
$extfcall(void, "message", "variance = ", variance(xs))
//
(* ****** ****** *)
//
val xs =
R34vector_tabulate_fun
{int}(10, lam(i) => (i-1)*(i-1))
val ys =
R34vector_tabulate_fun
{int}(10, lam(i) => (i+1)*(i+1))
//
(* ****** ****** *)
//
val
xsys = cbind(xs, ys)
//
val () = print!("xsys = ")
val () = $extfcall(void, "str", xsys)
//
val
xsxsys = cbind(xs, xsys)
val () = print!("xsxsys = ")
val () = $extfcall(void, "str", xsxsys)
//
val
xsxsysys = cbind(xsxsys, ys)
val () = print!("xsxsysys = ")
val () = $extfcall(void, "str", xsxsysys)
//
(* ****** ****** *)

overload t with transpose

(* ****** ****** *)

val t_xsys = rbind(t(xs), t(ys))
val () = $extfcall(void, "str", t_xsys)
val t_xsxsys = rbind(t(xs), t_xsys)
val () = $extfcall(void, "str", t_xsxsys)
val t_xsxsysys = rbind(t_xsxsys, t(ys))
val () = $extfcall(void, "str", t_xsxsysys)

(* ****** ****** *)
//
val M23 =
R34matrix_tabulate_fun(2, 3, lam(i, j) => 1+max(i, j))
val M32 =
R34matrix_tabulate_fun(3, 2, lam(i, j) => 1+max(i, j))
//
val M22 = matmult(M23, M32)
val M33 = matmult(M32, M23)
//
val () = print!("M23 = ")
val () = $extfcall(void, "str", M23)
val () = print!("M32 = ")
val () = $extfcall(void, "str", M32)
val () = print!("M22 = ")
val () = $extfcall(void, "str", M22)
val () = print!("M33 = ")
val () = $extfcall(void, "str", M33)
//
(* ****** ****** *)
//
val cp_M33 = crossprod(M23)
val tcp_M22 = tcrossprod(M23)
//
val () = print!("cp_M33 = ")
val () = $extfcall(void, "str", cp_M33)
val () = print!("tcp_M22 = ")
val () = $extfcall(void, "str", tcp_M22)
//
(*
val inv_cp_M33 = solve(int2double(cp_M33))
val () = print!("inv_cp_M33 = ")
val () = $extfcall(void, "str", inv_cp_M33)
*)
//
val inv_tcp_M22 = solve(int2double(tcp_M22))
val () = print!("inv_tcp_M22 = ")
val () = $extfcall(void, "str", inv_tcp_M22)
//
(* ****** ****** *)

val () = print!("dotprod(xs, xs) = ")
val () = $extfcall(void, "str", dotprod(xs, xs))
val () = print!("tcrossprod(xs, xs) = ")
val () = $extfcall(void, "str", tcrossprod(xs, xs))

(* ****** ****** *)

val xs = R34vector_tabulate_fun{int}(10, lam(i) => i+1)
val () = $extfcall(void, "str", sample_rep(xs, length(xs)))
val () = $extfcall(void, "str", sample_norep(xs, length(xs)))

(* ****** ****** *)

%{^
######
if
(!
(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
my_dynload()
%} // end of [%{$]

(* ****** ****** *)

(* end of [statsfun.dats] *)

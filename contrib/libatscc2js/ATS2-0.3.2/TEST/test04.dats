(* ****** ****** *)
//
// For testing libatscc2js
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "test02_dynload"
//
#define ATS_STATIC_PREFIX "_test02_"
//
(* ****** ****** *)
//
#include "./../staloadall.hats"
//
#staload "./../SATS/print.sats"
#staload _ = "./../DATS/print.dats"
//
(* ****** ****** *)

(* ****** ****** *)
//
val A0 =
arrayref_make_elt{int}(10, 0)
val () =
arrayref_foreach_cloref
(A0, 10, lam(i) => A0[i] := i*i)
val () =
arrayref_foreach_cloref
(A0, 10, lam(i) => println!("A0[",i,"]=",A0[i]))
//
(* ****** ****** *)
//
val A1 =
arrszref_make_elt{int}(10, 0)
val () =
A1.foreach()(lam(i) => A1[i] := i*i)
val () =
A1.foreach()(lam(i) => println!("A1[",i,"]=",A1[i]))
//
(* ****** ****** *)
//
val A1 =
array0_make_elt{int}(10, 0)
val () =
A1.foreach()(lam(i) => A1[i] := i*i)
val () =
A1.foreach()(lam(i) => println!("A1[",i,"]=",A1[i]))
//
(* ****** ****** *)
//
val M0 =
matrixref_make_elt{int}(2, 5, 0)
val () =
matrixref_foreach_cloref
(M0, 2, 5, lam(i, j) => M0[i,5,j] := i*j)
val () =
matrixref_foreach_cloref
( M0, 2, 5
, lam(i, j) =>
  println!("M0[", i, ",", j, "]=", M0[i,5,j]))
//
(* ****** ****** *)
//
val M1 =
matrix0_make_elt{int}(2, 5, 0)
val () =
M1.foreach()(lam(i, j) => M1[i,j] := i*j)
val () =
M1.foreach()
(lam(i, j) => println!("M1[", i, ",", j, "]=", M1[i,j]))
//
(* ****** ****** *)
//
val M1 =
mtrxszref_make_elt{int}(2, 5, 0)
val () =
M1.foreach()(lam(i, j) => M1[i,j] := i*j)
val () =
M1.foreach()
(lam(i, j) => println!("M1[", i, ",", j, "]=", M1[i,j]))
//
(* ****** ****** *)
//
(*
val M1_55 = M1[5,5] // Uncaught RangeException
*)
//
(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./../output/libatscc2js_all.js').toString());
eval(fs.readFileSync('./../CATS/PRINT/print_store_cats.js').toString());
//
%} // end of [%{^]

(* ****** ****** *)

%{$
//
test02_dynload();
process.stdout.write(ats2jspre_the_print_store_join());
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [test04.dats] *)

(* ****** ****** *)
(*
** DivideConquer:
** Fibonacci numbers
**
*)
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "test01_dynload"
//
#define ATS_STATIC_PREFIX "_test01_"
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
#staload
"{$LIBATSCC2JS}/SATS/print.sats"
//
(* ****** ****** *)
//
#staload
"./../DATS/DivideConquer.dats"
//
(* ****** ****** *)
//
extern
fun Fibonacci(int): int
//
(* ****** ****** *)

assume input_t0ype = int
assume output_t0ype = int

(* ****** ****** *)
//
implement
DivideConquer$base_test<>
  (n) =
(
if n >= 2 then false else true
)
//
(* ****** ****** *)
//
implement
DivideConquer$base_solve<>
  (n) = n
//
(* ****** ****** *)
//
implement
DivideConquer$divide<>
  (n) =
(
cons0
(n-1, cons0(n-2, nil0()))
)
//
(* ****** ****** *)

implement
DivideConquer$conquer$combine<>
  (_, rs) = r1 + r2 where
{
//
val-list0_cons(r1, rs) = rs
val-list0_cons(r2, rs) = rs
//
}

(* ****** ****** *)

implement
Fibonacci(n) = let
//
val () =
println!
(
  "Fibonacci(", n, ")"
)
//
(*
implement
DivideConquer$solve_rec<>
  (n) = Fibonacci(n)
*)
//
in
  DivideConquer$solve<>(n)
end // end of [Fibonacci]

(* ****** ****** *)
//
val () =
{
val () =
println! ("Fibonacci(10) = ", Fibonacci(10))
val () =
println! ("Fibonacci(20) = ", Fibonacci(20))
(*
//
// HX: it takes a bit too long:
//
val () =
println! ("Fibonacci(30) = ", Fibonacci(30))
//
*)
} (* end of [val] *)
//
(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./../../../output/libatscc2js_all.js').toString());
eval(fs.readFileSync('./../../../CATS/PRINT/print_store_cats.js').toString());
%} // end of [%{^]

(* ****** ****** *)

%{$
test01_dynload();
process.stdout.write(ats2jspre_the_print_store_join());
%} // end of [%{$]

(* ****** ****** *)

(* end of [test01.dats] *)

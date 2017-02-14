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

#define :: list_cons

(* ****** ****** *)

val xs =
(
  0 :: 1 :: 2 :: 3 :: 4 :: 5 :: 6 :: 7 :: 8 :: 9 :: nil()
) : List0 (int)

(* ****** ****** *)

val () = println! ("xs = ", xs)
val () = println! ("xs + xs = ", xs + xs)

(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./../output/libatscc2js_all.js').toString());
eval(fs.readFileSync('./../CATS/PRINT/print_store_cats.js').toString());
%} // end of [%{^]

(* ****** ****** *)

%{$
test02_dynload();
process.stdout.write(ats2jspre_the_print_store_join());
%} // end of [%{$]

(* ****** ****** *)

(* end of [test02.dats] *)

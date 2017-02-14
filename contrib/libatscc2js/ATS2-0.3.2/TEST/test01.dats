(* ****** ****** *)
//
// For testing libatscc2js
//
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
#include "./../staloadall.hats"
//
#staload "./../SATS/print.sats"
//
(* ****** ****** *)

val () = assertloc("between".indexOf("tween") = 2)
val () = assertloc("between".indexOf("tween", 3) < 0)

(* ****** ****** *)
//
val () =
  3*delay(println!("Hello, world!"))
val () =
  repeat(3, $delay(println!("Hello, world!")))
val () =
  (3).foreach()(lam(i) => println!(i, ": Hello, world!"))
//
(* ****** ****** *)
//
val () =
print_string
(
  JSarray_join(JSarray_make_list(3*list_sing("Hello, world!\n")))
)
//
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
test01_dynload();
process.stdout.write(ats2jspre_the_print_store_join());
%} // end of [%{$]

(* ****** ****** *)

(* end of [test01.dats] *)

(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Node.js
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun f91 : int -> int = "mac#f91"
//
implement
f91 (x) = if x >= 101 then x - 10 else f91(f91(x+11))
//
(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./libatscc2js/CATS/basics_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/integer_cats.js').toString());
%} // end of [%{^]

(* ****** ****** *)

%{$
//
(
function()
{
//
var argc =
  process.argv.length
//
if (argc <= 2)
{
  console.log("Usage: f91 <int>"); return;
}
//
var arg = process.argv[2]
var arg = parseInt(arg, 10)
//
console.log("f91(%d) = %d", arg, f91(arg)); return;
//
} /* end of [main_js] */
) () ;
%} // end of [%{$]

(* ****** ****** *)

(* end of [f91.dats] *)

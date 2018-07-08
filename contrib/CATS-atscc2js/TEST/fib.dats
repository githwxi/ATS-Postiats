(* ****** ****** *)
//
// HX-2014-08:
// A running example:
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
#staload
"{$LIBATSCC2JS}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun
fib : int -> int = "mac#fib"
//
implement
fib (n) = let
//
fun aux (ff: '(int, int), n: int): int =
  if n > 0 then aux ( '(ff.1, ff.0 + ff.1), n-1 ) else ff.0
//
in
  aux ( '(0, 1), n )
end // end of [fib]
//
(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
//
eval(fs.readFileSync('./libatscc2js/CATS/integer_cats.js').toString());
//
%} // end of [%{^]

(* ****** ****** *)

%{$
//
(
function()
{
var arg = process.argv[2]
var arg = parseInt(arg, 10)
//
console.log("fib(10) =", fib(arg))
//
}
) ()
%} // end of [%{$]

(* ****** ****** *)

(* end of [fib.dats] *)

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
#staload
"{$LIBATSCC2JS}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun
rtfind (f: int -> int): int = "mac#"
//
implement
rtfind (f) = let
//
fun loop
(
  f: int -> int, i: int
) : int =
  if f (i) = 0 then i else loop (f, i+1)
//
in
  loop (f, 0(*i*))
end // end of [rtfind]

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
var
poly0 = function(x) { return x*x + x - 6 ; }
console.log('rtfind(lambda x: x*x + x - 6) = %d', rtfind(poly0))
//
var
poly1 = function(x) { return x*x + 2*x - 99 ; }
console.log('rtfind(lambda x: x*x - 2*x - 99) = %d', rtfind(poly1))
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [rtfind.dats] *)

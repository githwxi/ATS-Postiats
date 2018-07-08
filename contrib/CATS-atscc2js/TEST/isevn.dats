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
fnx isevn_ (n: int): bool =
  if n > 0 then isodd_(n-1) else true
and isodd_ (n: int): bool =
  if n > 0 then isevn_(n-1) else false
//
(* ****** ****** *)
//
extern
fun isevn
  : (int) -> bool = "mac#isevn"
extern
fun isodd
  : (int) -> bool = "mac#isodd"
//
implement isevn (n) = isevn_(n)
implement isodd (n) =
  if n > 0 then isevn_(n-1) else false
//
(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./libatscc2js/CATS/integer_cats.js').toString());
%}

(* ****** ****** *)

%{$
console.log("isevn(100) =", isevn(100))
console.log("isodd(101) =", isodd(101))
%} // end of [%{$]


(* ****** ****** *)

(* end of [isevn.dats] *)

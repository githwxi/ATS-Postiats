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
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun acker : (int, int) -> int = "mac#acker"
//
implement
acker (m, n) =
(
case+
  (m, n) of 
| (0, _) => n + 1
| (_, 0) => acker(m-1, 1)
| (_, _) => acker(m-1, acker(m, n-1)) 
)
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
if (argc <= 3)
{
  console.log("Usage: acker <int> <int>"); return;
}
//
var m = process.argv[2]
var n = process.argv[3]
//
console.log("acker(%d, %d) = %d", m, n, acker(m, n));
//
return;
//
} /* end of [main_js] */
) () ;
%} // end of [%{$]

(* ****** ****** *)

(* end of [acker.dats] *)

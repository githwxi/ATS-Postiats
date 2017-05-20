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
staload
"{$LIBATSCC2JS}/SATS/integer.sats"
//
(* ****** ****** *)
//
dataprop FIB (int, int) =
  | FIB0 (0, 0) | FIB1 (1, 1)
  | {n:nat} {r0,r1:int}
    FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
// end of [FIB]
//
(* ****** ****** *)
//
extern
fun fibats{n:nat}
  : int(n) -> [r:int] (FIB(n,r) | int(r)) = "mac#fibats"
//
implement
fibats{n}(n) = let
//
fun loop
  {i:nat | i <= n}{r0,r1:int} .<n-i>.
(
  pf0: FIB (i, r0)
, pf1: FIB (i+1, r1)
| ni: int (n-i), r0: int r0, r1: int r1
) : [r:int] (FIB (n, r) | int r) =
(
  if ni > 0 then
    loop {i+1} (pf1, FIB2 (pf0, pf1) | ni - 1, r1, r0 + r1)
  else (pf0 | r0)
) (* end of [loop] *)
//
in
  loop {0} (FIB0 (), FIB1 () | n, 0, 1)
end // end of [fibats]
//
(* ****** ****** *)

%{^
//
// file inclusion:
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
//
var argc =
  process.argv.length
//
if (argc <= 2)
{
  console.log("Usage: fibats <int>>"); return;
}
//
var x = process.argv[2]
//
console.log("fibats(%d) = %d", x, fibats(x));
//
return;
//
} /* end of [main_js] */
) () ;
%} // end of [%{$]

(* ****** ****** *)

(* end of [fibats.dats] *)

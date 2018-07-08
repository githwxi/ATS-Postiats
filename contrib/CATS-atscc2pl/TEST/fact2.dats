(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Perl5
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2PL_targetloc
"$PATSHOME\
/contrib/libatscc2pl/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2PL}/SATS/float.sats"
//
(* ****** ****** *)
//
extern
fun
fact : double -> double = "mac#fact"
//
implement
fact(n) = let
//
fun loop
(
  n: double, res: double
) : double =
  if n > 0.0 then loop(n-1.0, n*res) else res
//
in
  loop(n, 1.0)
end // end of [fact]

(* ****** ****** *)

%{^
require "./libatscc2pl/libatscc2pl_all.pl";
%} // end of [%{^]

(* ****** ****** *)

%{$
//
$fact12 = fact(12); print "fact(12) = $fact12\n";
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact2.dats] *)

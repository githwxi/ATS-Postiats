(* ****** ****** *)
//
// HX-2014-11:
// A running example
// from ATS2 to Perl5
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
"{$LIBATSCC2PL}/basics_pl.sats"
staload
"{$LIBATSCC2PL}/SATS/integer.sats"
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
extern
fun fact : int -> int = "mac#fact"
//
implement
fact(n) = if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)

%{^
require "./libatscc2pl/libatscc2pl_all.pl";
%} // end of [%{^]

(* ****** ****** *)

%{$
//
$fact10 = fact(10); print "fact(10) = $fact10\n";
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact.dats] *)

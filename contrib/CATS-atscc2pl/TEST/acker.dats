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
"{$LIBATSCC2PL}/SATS/integer.sats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
extern
fun acker 
  : (int, int) -> int = "mac#acker"
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
require "./libatscc2pl/libatscc2pl_all.pl";
%} // end of [%{^]

(* ****** ****** *)

%{$
//
$acker33 = acker(3, 3); print "acker(3, 3) = $acker33\n";
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [acker.dats] *)

(* ****** ****** *)
//
// HX-2016-07
// A running example
// from ATS2 to Clojure
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2CLJ_targetloc
"$PATSHOME\
/contrib/libatscc2clj/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2CLJ}/staloadall.hats"
//
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
//
extern 
fun
main0_ats
(
  m: int, n: int
) : void = "mac#acker_main0_ats"
//
implement
main0_ats(m, n) =
{
//
val () =
println! ("acker(", m, ", ", n, ") = ", acker(m, n))
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)

%{$
;;
(acker_main0_ats 3 3)
;;
%} // end [%{$]

(* ****** ****** *)

(* end of [acker.dats] *)

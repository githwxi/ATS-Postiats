(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to PHP
//
(* ****** ****** *)
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOME\
/contrib/libatscc2php/ATS2-0.3.2"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
staload
"{$LIBATSCC2PHP}/SATS/integer.sats"
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

(* end of [acker.dats] *)

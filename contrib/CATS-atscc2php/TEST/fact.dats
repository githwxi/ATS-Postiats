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
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2PHP}/basics_php.sats"
staload
"{$LIBATSCC2PHP}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun fact : int -> int = "mac#fact"
//
implement
fact (n) = if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)

(* end of [fact.dats] *)

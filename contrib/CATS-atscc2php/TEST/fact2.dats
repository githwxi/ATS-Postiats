(* ****** ****** *)
//
// HX-2014-08:
// A running example:
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
#define ATS_STATIC_PREFIX "fact2__"
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
fun fact2 : int -> int = "mac#fact2"
//
implement
fact2 (n) = let
//
fun loop (n: int, res: int): int =
  if n > 0 then loop (n-1, n*res) else res
//
in
  loop (n, 1)
end // end of [fact2]

(* ****** ****** *)

(* end of [fact2.dats] *)

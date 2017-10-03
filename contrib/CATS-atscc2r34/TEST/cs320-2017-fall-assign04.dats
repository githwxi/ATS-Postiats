(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 1
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include "{$LIBATSCC2R34}/mylibies.hats"
//
(* ****** ****** *)

#define
NDX100_fname "./DATA/NDX100-index.csv"

(* ****** ****** *)

val
NDX100_dframe =
$extfcall
( R34dframe(double)
, "read.csv"
, NDX100_fname, $literal("header=TRUE")
)

(* ****** ****** *)

val
NDX100_dframe_names =
$extfcall(R34vector(string), "names", NDX100_dframe)

(* ****** ****** *)

(* end of [cs320-2017-fall-assign04.dats] *)

(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)
//
// HX-2016-07:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload "./../basics_scm.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/intrange.sats"
//
(* ****** ****** *)

(* end of [intrange.sats] *)

(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
#staload "./../basics_py.sats"
//
#include "{$LIBATSCC}/SATS/qlistref.sats"
//
(* ****** ****** *)

(* end of [qlistref.sats] *)

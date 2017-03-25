(*
** For writing ATS code
** that translates into Perl
*)

(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_PACKNAME
"ATSCC2PL.qlistref"
#define
ATS_EXTERN_PREFIX "ats2plpre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/qlistref.sats"
//
(* ****** ****** *)

(* end of [qlistref.sats] *)

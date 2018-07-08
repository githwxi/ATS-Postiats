(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/slistref.sats"
//
(* ****** ****** *)

(* end of [slistref.sats] *)

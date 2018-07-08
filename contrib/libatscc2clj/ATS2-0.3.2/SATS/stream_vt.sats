(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
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
staload "./../basics_clj.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/stream_vt.sats"
//
(* ****** ****** *)

(* end of [stream_vt.sats] *)

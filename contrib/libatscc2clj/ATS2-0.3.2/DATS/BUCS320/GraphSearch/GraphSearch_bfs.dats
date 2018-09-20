(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_BUCS320_"
#define
ATS_STATIC_PREFIX "_ats2cljpre_BUCS320_GraphSearch_bfs_"
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
staload "./../../../basics_clj.sats"
//
staload "./../../../SATS/bool.sats"
staload "./../../../SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./../../../SATS/qlistref.sats"
//
macdef
qlistref_insert = qlistref_enqueue
macdef
qlistref_takeout_opt = qlistref_dequeue_opt
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/DATS/BUCS320/GraphSearch/GraphSearch_bfs.dats"
//
(* ****** ****** *)

(* end of [GraphSearch_bfs.dats] *)

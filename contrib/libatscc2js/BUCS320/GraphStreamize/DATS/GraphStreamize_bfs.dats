(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX
"ats2js_bucs320_"
#define
ATS_STATIC_PREFIX
"_ats2js_bucs320_graphstreamize_bfs_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
//
(* ****** ****** *)
//
#include
  "{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)
//
macdef
qlistref_insert = qlistref_enqueue
macdef
qlistref_takeout_opt = qlistref_dequeue_opt
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/BUCS320/GraphStreamize/DATS/GraphStreamize_bfs.dats"
//
(* ****** ****** *)

(* end of [GraphStreamize_bfs.dats] *)

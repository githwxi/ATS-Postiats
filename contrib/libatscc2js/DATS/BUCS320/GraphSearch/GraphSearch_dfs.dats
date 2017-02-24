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
ATS_EXTERN_PREFIX "ats2jspre_BUCS320_"
#define
ATS_STATIC_PREFIX "_ats2jspre_BUCS320_GraphSearch_dfs_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload "./../../../basics_js.sats"
//
#staload "./../../../SATS/bool.sats"
#staload "./../../../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../../../SATS/slistref.sats"
//
macdef
slistref_insert = slistref_push
macdef
slistref_takeout_opt = slistref_pop_opt
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/DATS/BUCS320/GraphSearch/GraphSearch_dfs.dats"
//
(* ****** ****** *)

(* end of [GraphSearch_dfs.dats] *)

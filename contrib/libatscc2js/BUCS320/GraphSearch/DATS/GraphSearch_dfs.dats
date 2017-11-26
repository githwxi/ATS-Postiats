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
"_ats2js_bucs320_graphsearch_dfs_"
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
slistref_insert = slistref_push
macdef
slistref_takeout_opt = slistref_pop_opt
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/BUCS320/GraphSearch/DATS/GraphSearch_dfs.dats"
//
(* ****** ****** *)

(* end of [GraphSearch_dfs.dats] *)

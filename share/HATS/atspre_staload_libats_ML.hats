(*
** This is mostly for
** staloading ATSLIB/libats/ML
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// AuthorEmail: gmhwxiATgmailCOM
//
(* ****** ****** *)

#ifndef SHARE_ATSPRE_STALOAD_LIBATS_ML
#define SHARE_ATSPRE_STALOAD_LIBATS_ML 1

(* ****** ****** *)

#define
PATSLIBATS_targetloc "$PATSHOME/libats"

(* ****** ****** *)

staload "{$PATSLIBATS}/ML/SATS/basis.sats"

(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/list0.sats"
//
staload "{$PATSLIBATS}/ML/SATS/option0.sats"
//
staload "{$PATSLIBATS}/ML/SATS/array0.sats"
//
staload "{$PATSLIBATS}/ML/SATS/matrix0.sats"
//
staload "{$PATSLIBATS}/ML/SATS/string.sats"
staload "{$PATSLIBATS}/ML/SATS/strarr.sats"
//
staload "{$PATSLIBATS}/ML/SATS/gvalue.sats"
//
staload "{$PATSLIBATS}/ML/SATS/filebas.sats"
staload "{$PATSLIBATS}/ML/SATS/intrange.sats"
//
staload "{$PATSLIBATS}/ML/SATS/stdlib.sats"
//
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/list0.dats"
//
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/option0.dats"
//
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/array0.dats"
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/matrix0.dats"
//
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/string.dats"
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/strarr.dats"
//
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/filebas.dats"
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/intrange.dats"
//
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/stdlib.dats"
//
(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/funmap.sats"
staload "{$PATSLIBATS}/ML/SATS/funset.sats"
//
staload _ = "{$PATSLIBATS}/DATS/funmap_avltree.dats"
staload _ = "{$PATSLIBATS}/DATS/funset_avltree.dats"
//
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/funmap.dats"
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/funset.dats"
//
(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/dynarray.sats"
staload _(*anon*) = "{$PATSLIBATS}/DATS/dynarray.dats"
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/dynarray.dats"
//
(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/hashtblref.sats"
//
staload _(*anon*) = "{$PATSLIBATS}/DATS/qlist.dats"
staload _(*anon*) = "{$PATSLIBATS}/DATS/hashfun.dats"
staload _(*anon*) = "{$PATSLIBATS}/DATS/linmap_list.dats"
staload _(*anon*) = "{$PATSLIBATS}/DATS/hashtbl_chain.dats"
staload _(*anon*) = "{$PATSLIBATS}/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)

#endif // SHARE_ATSPRE_STALOAD_LIBATS_ML

(* ****** ****** *)

(* end of [atslib_staload_libats_ML.hats] *)

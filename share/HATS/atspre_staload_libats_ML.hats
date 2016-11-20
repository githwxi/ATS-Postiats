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
staload "{$PATSLIBATS}/ML/SATS/stream.sats"
staload "{$PATSLIBATS}/ML/SATS/stream_vt.sats"
//
staload "{$PATSLIBATS}/ML/SATS/filebas.sats"
staload "{$PATSLIBATS}/ML/SATS/intrange.sats"
//
(* ****** ****** *)
//
staload _ = "{$PATSLIBATS}/ML/DATS/list0.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/option0.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/array0.dats"
staload _ = "{$PATSLIBATS}/ML/DATS/matrix0.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/string.dats"
staload _ = "{$PATSLIBATS}/ML/DATS/strarr.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/stream.dats"
staload _ = "{$PATSLIBATS}/ML/DATS/stream_vt.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/filebas.dats"
staload _ = "{$PATSLIBATS}/ML/DATS/intrange.dats"
//
(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/stdlib.sats"
staload _ = "{$PATSLIBATS}/ML/DATS/stdlib.dats"
//
(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/funmap.sats"
staload "{$PATSLIBATS}/ML/SATS/funset.sats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/funmap.dats"
staload _ = "{$PATSLIBATS}/DATS/funmap_avltree.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/funset.dats"
staload _ = "{$PATSLIBATS}/DATS/funset_avltree.dats"
//
(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/dynarray.sats"
//
staload _ = "{$PATSLIBATS}/DATS/dynarray.dats"
staload _ = "{$PATSLIBATS}/ML/DATS/dynarray.dats"
//
(* ****** ****** *)
//
staload "{$PATSLIBATS}/ML/SATS/qlistref.sats"
staload "{$PATSLIBATS}/ML/SATS/slistref.sats"
//
staload "{$PATSLIBATS}/ML/SATS/hashtblref.sats"
//
(* ****** ****** *)
//
staload _ = "{$PATSLIBATS}/DATS/qlist.dats"
staload _ = "{$PATSLIBATS}/DATS/hashfun.dats"
staload _ = "{$PATSLIBATS}/DATS/linmap_list.dats"
staload _ = "{$PATSLIBATS}/DATS/hashtbl_chain.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/qlistref.dats"
staload _ = "{$PATSLIBATS}/ML/DATS/slistref.dats"
//
staload _ = "{$PATSLIBATS}/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)

#endif // SHARE_ATSPRE_STALOAD_LIBATS_ML

(* ****** ****** *)

(* end of [atslib_staload_libats_ML.hats] *)

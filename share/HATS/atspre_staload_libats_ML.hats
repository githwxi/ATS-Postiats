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

#ifndef
SHARE_ATSPRE_STALOAD_LIBATS_ML
#define
SHARE_ATSPRE_STALOAD_LIBATS_ML 1

(* ****** ****** *)
//
#define
LIBATS_targetloc "$PATSHOME/libats"
#define
LIBATSML_targetloc "$PATSHOME/libats/ML"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/basis.sats"
//
(* ****** ****** *)
//
// HX-2017-12-30:
// Please do not move
// the following lines:
//
#staload
"{$LIBATSML}/SATS/atspre.sats"
#staload _ =
"{$LIBATSML}/DATS/atspre.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/string.sats"
#staload
"{$LIBATSML}/SATS/strarr.sats"
#staload _ =
"{$LIBATSML}/DATS/string.dats"
#staload _ =
"{$LIBATSML}/DATS/strarr.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/list0.sats"
#staload _ =
"{$LIBATSML}/DATS/list0.dats"
//
#staload
"{$LIBATSML}/SATS/list0_vt.sats"
#staload _ =
"{$LIBATSML}/DATS/list0_vt.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/option0.sats"
#staload _ =
"{$LIBATSML}/DATS/option0.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/array0.sats"
#staload
"{$LIBATSML}/SATS/matrix0.sats"
#staload _ =
"{$LIBATSML}/DATS/array0.dats"
#staload _ =
"{$LIBATSML}/DATS/matrix0.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/stream.sats"
#staload _ =
"{$LIBATSML}/DATS/stream.dats"
//
#staload
"{$LIBATSML}/SATS/stream_vt.sats"
#staload _ =
"{$LIBATSML}/DATS/stream_vt.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/gvalue.sats"
#staload _ =
"{$LIBATSML}/DATS/gvalue.dats"
//
#staload
"{$LIBATSML}/SATS/filebas.sats"
#staload _ =
"{$LIBATSML}/DATS/filebas.dats"
#staload _ =
"{$LIBATSML}/DATS/filebas_dirent.dats"
//
#staload
"{$LIBATSML}/SATS/intrange.sats"
#staload _ =
"{$LIBATSML}/DATS/intrange.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/stdlib.sats"
#staload _ =
"{$LIBATSML}/DATS/stdlib.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/funmap.sats"
#staload
"{$LIBATSML}/SATS/funset.sats"
//
#staload _ =
"{$LIBATSML}/DATS/funmap.dats"
#staload _ =
"{$LIBATSML}/DATS/funset.dats"
//
#staload _ =
"{$LIBATS}/DATS/funmap_avltree.dats"
#staload _ =
"{$LIBATS}/DATS/funset_avltree.dats"
//
(* ****** ****** *)
//
#staload _ =
"{$LIBATS}/DATS/dynarray.dats"
//
#staload
"{$LIBATSML}/SATS/dynarray.sats"
#staload _ =
"{$LIBATSML}/DATS/dynarray.dats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSML}/SATS/qlistref.sats"
#staload
"{$LIBATSML}/SATS/slistref.sats"
#staload _ =
"{$LIBATSML}/DATS/qlistref.dats"
#staload _ =
"{$LIBATSML}/DATS/slistref.dats"
//
(* ****** ****** *)
//
#staload _ =
"{$LIBATS}/DATS/qlist.dats"
#staload _ =
"{$LIBATS}/DATS/hashfun.dats"
#staload _ =
"{$LIBATS}/DATS/linmap_list.dats"
#staload _ =
"{$LIBATS}/DATS/hashtbl_chain.dats"
//
#staload
"{$LIBATSML}/SATS/hashtblref.sats"
#staload _ =
"{$LIBATSML}/DATS/hashtblref.dats"
//
(* ****** ****** *)
//
(*
//
// HX-2017-10-30:
// See ML/BOXED/staloadall.hats
//
#staload
"{$LIBATSML}/BOXED/funmap.dats"
#staload
"{$LIBATSML}/BOXED/funarray.dats"
#staload
"{$LIBATSML}/BOXED/hashtblref.dats"
*)
//
(* ****** ****** *)

#endif // SHARE_ATSPRE_STALOAD_LIBATS_ML

(* ****** ****** *)

(* end of [atslib_staload_libats_ML.hats] *)

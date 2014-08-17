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

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
staload "libats/ML/SATS/list0.sats"
//
staload "libats/ML/SATS/option0.sats"
//
staload "libats/ML/SATS/array0.sats"
//
staload "libats/ML/SATS/matrix0.sats"
//
staload "libats/ML/SATS/string.sats"
staload "libats/ML/SATS/strarr.sats"
//
staload "libats/ML/SATS/filebas.sats"
//
staload "libats/ML/SATS/stdlib.sats"
//
staload _(*anon*) = "libats/ML/DATS/list0.dats"
staload _(*anon*) = "libats/ML/DATS/option0.dats"
staload _(*anon*) = "libats/ML/DATS/array0.dats"
staload _(*anon*) = "libats/ML/DATS/matrix0.dats"
staload _(*anon*) = "libats/ML/DATS/string.dats"
staload _(*anon*) = "libats/ML/DATS/strarr.dats"
staload _(*anon*) = "libats/ML/DATS/filebas.dats"
staload _(*anon*) = "libats/ML/DATS/stdlib.dats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/funmap.sats"
//
staload "libats/ML/SATS/funset.sats"
//
staload _(*anon*) = "libats/ML/DATS/funmap.dats"
staload _(*anon*) = "libats/ML/DATS/funset.dats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/hashtblref.sats"
//
staload _ = "libats/DATS/hashfun.dats"
staload _ = "libats/DATS/linmap_list.dats"
staload _ = "libats/DATS/hashtbl_chain.dats"
staload _ = "libats/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)

(* end of [atslib_staload_libats_ML.hats] *)

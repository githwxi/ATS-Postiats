(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)
//
// Finding the declaration of a given declname
//
(* ****** ****** *)
//
staload "libatsynmark/SATS/libatsynmark.sats"
staload "libatsynmark/DATS/libatsynmark_psynmark.dats"
staload "libatsynmark/DATS/libatsynmark_pats2xhtml.dats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

local

implement
psynmark_process<> (psm, putc) =
  psynmark_process_xhtml_bground (psm, putc)
// end of [psynmark_process<>]

in // in of [local]

implement
string_pats2xhtmlize_bground
  (stadyn, synop) = string_pats2xhtmlize<> (stadyn, synop)
// end of [string_pats2xhtmlize_bground]

implement
charlst_pats2xhtmlize_bground
  (stadyn, synop) = charlst_pats2xhtmlize<> (stadyn, synop)
// end of [charlst_pats2xhtmlize_bground]

end // end of [local]

(* ****** ****** *)

(* end of [libatsynmark_pats2xhtml_bground.dats] *)

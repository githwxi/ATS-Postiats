(*
**
** Some utility functions for
** manipulating the syntax of ATS2
**
** Contributed by
** Hongwei Xi (gmhwxiATgmailDOTcom)
**
** Start Time: July, 2016
**
*)

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/libatsyntext.sats"
//
(* ****** ****** *)
//
implement
{}(*tmp*)
parse_from_stdin_toplevel
  (stadyn) =
  $PAR.parse_from_stdin_toplevel(stadyn)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
parse_from_fileref_toplevel
  (stadyn, filr) =
  $PAR.parse_from_fileref_toplevel(stadyn, filr)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
parse_from_filename_toplevel
  (stadyn, fil) =
  $PAR.parse_from_filename_toplevel(stadyn, fil)
implement
{}(*tmp*)
parse_from_filename_toplevel2
  (stadyn, fil) =
  $PAR.parse_from_filename_toplevel2(stadyn, fil)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
parse_from_givename_toplevel
  (stadyn, given, filref) =
  $PAR.parse_from_givename_toplevel(stadyn, given, filref)
//
(* ****** ****** *)

(* end of [libatsyntext.dats] *)

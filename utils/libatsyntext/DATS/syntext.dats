(* ****** ****** *)
(*
**
** Some utility functions for
** manipulating the syntax of ATS2
**
** Author: Hongwei Xi
** Start Time: July, 2016
** Authoremail: gmhwxiATgmailDOTcom
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
"./../SATS/syntext.sats"
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

(* end of [syntext.dats] *)

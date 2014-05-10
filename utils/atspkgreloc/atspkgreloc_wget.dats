(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: May, 2014 *)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/jsonats/SATS/jsonats.sats"
//
(* ****** ****** *)
//
staload _ = "libats/DATS/stringbuf.dats"
//
staload
_ = "{$LIBATSHWXI}/cstream/DATS/cstream.dats"
staload
_ = "{$LIBATSHWXI}/cstream/DATS/cstream_tokener.dats"
//
staload
_ = "{$LIBATSHWXI}/jsonats/DATS/jsonats.dats"
//
(* ****** ****** *)
//
extern
fun pkgreloc_jsonval (jsv: jsonval): void
extern
fun pkgreloc_jsonvalist (jsvs: jsonvalist): void
//
extern
fun pkgreloc_fileref (inp: FILEref): void
//
(* ****** ****** *)

implement
pkgreloc_jsonval
  (jsv) = let
//
fun auxmain
(
  source: string, target: string
) : void =
{
  val out = stdout_ref
  val ((*void*)) = fprint! (out, "$(WGET)", " ", source, " ", "--output", " ", target)
  val ((*void*)) = fprint_newline (out)
}
//
val opt1 =
  jsonval_object_get_key (jsv, "pkgreloc_source")
val opt2 =
  jsonval_object_get_key (jsv, "pkgreloc_target")
//
in
//
case+ opt1 of
| ~Some_vt (jsv_s) =>
  (
    case+ opt2 of
    | ~Some_vt (jsv_t) => let
        val-JSONstring (source) = jsv_s
        val-JSONstring (target) = jsv_t
      in
        auxmain (source, target)
      end // end of [Some_vt]
    | ~None_vt () => ((*void*))
  )
| ~None_vt ((*void*)) => option_vt_free (opt2)
//
end // end of [pkgreloc_jsonval]

(* ****** ****** *)

implement
pkgreloc_jsonvalist
  (jsvs) = let
//
implement(env)
list_foreach$fwork<jsonval><env> (x, env) = pkgreloc_jsonval (x)
//
in
  list_foreach<jsonval> (jsvs)
end // end of [pkgreloc_jsonvalist]

(* ****** ****** *)

implement
pkgreloc_fileref (inp) = let
//
val jsvs =
  jsonats_parsexnlst_fileref (inp)
//
in
  pkgreloc_jsonvalist (jsvs)
end // end of [pkgreloc_fileref]

(* ****** ****** *)

local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_fileref.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

implement
main{n}(argc, argv) = (0) where
{
//
var nfil: int = 0
//
fun loop
(
  argv: !argv(n)
, i: natLte(n), nfil: &int >> _
) : void =
(
if i < argc
  then let
    val inp = argv[i]
    val opt =
      fileref_open_opt (inp, file_mode_r)
    // end of [val]
  in
    case+ opt of
    | ~Some_vt (inp) => let
        val () = nfil := nfil + 1
        val () = pkgreloc_fileref (inp)
        val () = fileref_close (inp)
      in
        loop (argv, i+1, nfil)
      end // end of [Some_vt]
    | ~None_vt ((*void*)) => loop (argv, i+1, nfil)
   end // end of [then]
   else ((*void*)) // end of [else]
// end of [if]
)
//
val ((*void*)) = loop (argv, 1, nfil)
val ((*void*)) = if nfil = 0 then pkgreloc_fileref (stdin_ref)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [atspkgreloc_wget.dats] *)

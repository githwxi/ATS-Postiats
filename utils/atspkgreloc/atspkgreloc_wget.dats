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
fun wget_params
  (source: string, target: string): (int, string)
//
(* ****** ****** *)

local

fun
suffix_max{n1,n2:int}
(
  str1: string(n1), n1: size_t(n1)
, str2: string(n2), n2: size_t(n2)
) : sizeLte(min(n1,n2)) = let
//
fun auxmain
(
  p1: ptr, p2: ptr, n: size_t
) : size_t =
  if n > 0 then let
    val p1 = ptr_pred<char> (p1)
    val p2 = ptr_pred<char> (p2)
    val c1 = $UN.ptr0_get<char> (p1)
    val c2 = $UN.ptr0_get<char> (p2)
  in
    if c1 = c2 then auxmain (p1, p2, pred(n)) else n
  end else (n) // end of [if]
//
val p1 = ptr_add<char> (string2ptr(str1), n1)
val p2 = ptr_add<char> (string2ptr(str2), n2)
//
val n12 = min (n1, n2)
val n12_ = auxmain (p1, p2, n12)
//
in
  $UN.cast{sizeLte(min(n1,n2))}(n12 - n12_)
end // end of [suffix_max]

in (* in-of-local *)

implement
wget_params
  (source, target) = let
//
val source = g1ofg0 (source)
val target = g1ofg0 (target)
val n1 = string_length (source)
val n2 = string_length (target)
//
val n12 = suffix_max (source, n1, target, n2)
//
fun aux1
(
  p: ptr, n: size_t, res: int
) : int =
  if n > 0 then let
    val c = $UN.ptr0_get<char> (p)
  in
    if (c != '/')
      then aux1 (ptr_succ<char> (p), pred(n), res)
      else aux2 (ptr_succ<char> (p), pred(n), res)
    // end of [if]
  end else (res) // end of [if]
//
and aux2
(
  p: ptr, n: size_t, res: int
) : int =
  if n > 0 then let
    val c = $UN.ptr0_get<char> (p)
  in
    if (c != '/')
      then aux1 (ptr_succ<char> (p), pred(n), res+1)
      else aux1 (ptr_succ<char> (p), pred(n), res+0)
    // end of [if]
  end else (res+1) // end of [if]
//
val cut_dirs = aux1 (string2ptr(source), n1 - n12, 0)
val dir_prefix = string_make_substring (target, i2sz(0), n2-n12)
//
in
  (cut_dirs, strnptr2string(dir_prefix))
end // end of [wget_params]

end // end of [local]

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
  val (
    cut_dirs, dir_prefix
  ) = wget_params (source, target)
  val () =
  fprint! (out, "all:: ;"
  , " ", "$(WGET)"
  , " ", "--cut-dirs=", cut_dirs
  , " ", "--directory-prefix=\"", dir_prefix, "\""
  , " ", "\"", source, "\""
  ) (* end of [fprint!] *) // end of [val]
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
val () = fprint! (stdout_ref, "#\n", "WGET=wget -r --timestamping -nH\n", "#\n")
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

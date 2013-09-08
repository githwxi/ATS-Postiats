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
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: September, 2013
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*UN*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"

(* ****** ****** *)

staload TRENV1 = "./pats_trans1_env.sats"

(* ****** ****** *)

(*
typedef
pkginfo = @{
//
  pkgname=string
, pkgauthor=stropt
, pkgauthoremail=stropt
, pkgsrcloc=string
, pkgdstloc=stropt
//
} (* end of [pkginfo] *)
*)

(* ****** ****** *)

local
//
extern
fun __copy_string
  : (string) -> strptr1  = "mac#atspre_string_copy"
extern
fun __make_substring
  : (string, size_t, size_t) -> strptr1  = "mac#atspre_string_make_substring"
//
in (* in of [local] *)

extern
fun pkgsrcname_get_gurl
  (given: string, ngurl: int): Strptr1
implement
pkgsrcname_get_gurl
  (given, ngurl) = let
//
val start = $UN.cast2size(1)
val length = $UN.cast2size(ngurl - 2)
//
in
  __make_substring (given, start, length)
end // end of [pkgsrcname_get_gurl]

(* ****** ****** *)

extern
fun pkgsrcname_get2_gurl
  (given: string, ngurl: int): Strptr1
implement
pkgsrcname_get2_gurl
  (given, ngurl) = let
//
val p0 = $UN.cast2ptr (given)
val c1 = $UN.ptr0_get<char> (add_ptr_int (p0, 1))
//
in
//
case+ 0 of
| _ when
    c1 = '$' => let
    val start = $UN.cast2size(2)
    val length = $UN.cast2size(ngurl - 3)
    val key = __make_substring (given, start, length)
    val key2 = sprintf ("%s_targetloc", @($UN.castvwtp1{string}(key)))
    val () = strptr_free (key)
    val key2 = string_of_strptr (key2)
    val key2 = $SYM.symbol_make_string (key2)
    val opt2 = $TRENV1.the_e1xpenv_find (key2)
  in
    case+ opt2 of
    | ~Some_vt (e) => (
        case+ e.e1xp_node of
        | E1XPstring (x) => __copy_string (x)
        | _ (*nonstring*) => pkgsrcname_get_gurl (given, ngurl)
      ) (* end of [Some_vt] *)
    | ~None_vt ((*void*)) => pkgsrcname_get_gurl (given, ngurl)
  end // end of [variable]
//
| _ (*nonvariable*) => pkgsrcname_get_gurl (given, ngurl)
//
end // end of [pkgsrcname_get2_gurl]

(* ****** ****** *)

extern
fun pkgtarget_eval (given: string): string
implement
pkgtarget_eval
  (given) = let
//
val p0 = $UN.cast2ptr (given)
val c0 = $UN.ptr0_get<char> (p0)
//
fun auxtrav1
(
  p: ptr, n: int
) : int = let
  val c = $UN.ptr0_get<char> (p)
in
  if char_isalnum(c)
    then auxtrav1 (add_ptr_int (p, 1), n+1) else (n)
  // end of [if]
end (* end of [auxtrav1] *)
//
in
//
case+ c0 of
| _ when
    c0 = '$' => let
    val p1 = add_ptr_int (p0, 1)
    val nk = auxtrav1 (p1, 0(*n*))
    val start = $UN.cast2size(1)
    val length = $UN.cast2size(nk)
    val key = __make_substring (given, start, length)
    val key = string_of_strptr (key)
(*
    val () = println! ("pkgtarget_eval: key = ", key)
*)
    val key = $SYM.symbol_make_string (key)
    val opt = $TRENV1.the_e1xpenv_find (key)
  in
    case+ opt of
    | ~Some_vt (e) => (
        case+ e.e1xp_node of
        | E1XPstring (x) => let
            val pn = add_ptr_int (p1, nk)
            val given2 = sprintf("%s%s", @(x, $UN.cast{string}(pn)))
          in
            string_of_strptr (given2)
          end (* end of [E1XPstring] *)
        | _ (*nonstring*) => given
      ) (* end of [Some_vt] *)
    | ~None_vt ((*void*)) => given
  end // end of [variable]
| _ (*nonvariable*) => given
//
end // end of [pkgtarget_eval]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
$FIL.pkgsrcname_relocatize
  (given, ngurl) = let
//
extern
fun PATSHOME_get (): string = "ext#patsopt_PATSHOME_get"
extern
fun PATSHOMERELOC_get (): Stropt = "ext#patsopt_PATSHOMERELOC_get"
//
in
//
if ngurl >= 0 then let
//
  val dirsep = $FIL.theDirSep_get ()
//
  val gurl = pkgsrcname_get2_gurl (given, ngurl)
//
  val p0 = $UN.cast2ptr (given)
  val pn = add_ptr_int (p0, ngurl)
  val given2 = $UT.dirpath_append ($UN.castvwtp1{string}(gurl), $UN.cast{string}(pn), dirsep)
(*
  val () = println! ("pkgsrcname_relocatize: given2 = ", given2)
*)
//
  val () = strptr_free (gurl)
//
  val given2 = pkgtarget_eval (string_of_strptr(given2))
(*
  val () = println! ("pkgsrcname_relocatize: given2 = ", given2)
*)
//
in
  given2
end else given // end of [if]
//
end // end of [pkgsrcname_relocatize]

(* ****** ****** *)

(* end of [pats_filename_reloc.sats] *)

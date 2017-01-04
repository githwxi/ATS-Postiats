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

staload GLOB = "./pats_global.sats"

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload S1E = "./pats_staexp1.sats"

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
in (* in-of-local *)

(* ****** ****** *)
//
extern
fun
pkgsrcname_get_gurl0
  (given: string, ngurl: int): Strptr1
implement
pkgsrcname_get_gurl0
  (given, ngurl) = let
//
val start = $UN.cast2size(1)
val length = $UN.cast2size(ngurl - 2)
//
in
  __make_substring (given, start, length)
end // end of [pkgsrcname_get_gurl0]
//
(* ****** ****** *)
//
extern
fun
pkgsrcname_get_gurl1
  (given: string, ngurl: int): Strptr1
implement
pkgsrcname_get_gurl1
  (given, ngurl) = __copy_string ("$PATSRELOCROOT")
//
(* ****** ****** *)

extern
fun
pkgsrcname_get2_gurl0
  (given: string, ngurl: int): Strptr1
implement
pkgsrcname_get2_gurl0
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
    val key2 =
      sprintf ("%s_sourceloc", @($UN.castvwtp1{string}(key)))
    // end of [val]
    val () = strptr_free (key)
    val key2 = string_of_strptr (key2)
    val key2 = $SYM.symbol_make_string (key2)
    val opt2 = $TRENV1.the_e1xpenv_find (key2)
  in
    case+ opt2 of
    | ~None_vt() =>
        pkgsrcname_get_gurl0 (given, ngurl)
      // end of [None_vt]
    | ~Some_vt(e) => (
        case+ e.e1xp_node of
        | $S1E.E1XPstring(x) => __copy_string(x)
        | _ (*non-E1XPstring*) => pkgsrcname_get_gurl0(given, ngurl)
      ) (* end of [Some_vt] *)
  end // end of [variable]
//
| _ (*nonvariable*) => pkgsrcname_get_gurl0 (given, ngurl)
//
end // end of [pkgsrcname_get2_gurl0]

(* ****** ****** *)

extern
fun
pkgsrcname_get2_gurl1
  (given: string, ngurl: int): Strptr1
implement
pkgsrcname_get2_gurl1
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
    val key2 =
      sprintf ("%s_targetloc", @($UN.castvwtp1{string}(key)))
    // end of [val]
    val () = strptr_free (key)
    val key2 = string_of_strptr (key2)
(*
    val () = println! ("key2 = ", key2)
*)
    val key2 = $SYM.symbol_make_string (key2)
    val opt2 = $TRENV1.the_e1xpenv_find (key2)
  in
    case+ opt2 of
    | ~None_vt () =>
        pkgsrcname_get_gurl1 (given, ngurl)
      // end of [None_vt]
    | ~Some_vt (e) => (
        case+ e.e1xp_node of
        | $S1E.E1XPstring (x) => __copy_string (x)
        | _ (*non-E1XPstring*) => pkgsrcname_get_gurl1 (given, ngurl)
      ) (* end of [Some_vt] *)
  end // end of [variable]
//
| _ (*nonvariable*) => pkgsrcname_get_gurl1 (given, ngurl)
//
end // end of [pkgsrcname_get2_gurl1]

(* ****** ****** *)
//
extern
fun
pkgsrcname_eval
  (given: string): string
//
implement
pkgsrcname_eval
  (given) = let
//
#define NDEPTH 100
//
fun isalnum_ (c: char): bool =
  if char_isalnum(c) then true else (c = '_')
//
fun
auxtrav
(
  p0: ptr, n: int
) : int = let
  val c0 = $UN.ptr0_get<char>(p0)
in
//
if
isalnum_(c0)
then
(
  auxtrav(add_ptr_int(p0, 1), n+1)
) else (n) // end of [if]
//
end (* end of [auxtrav] *)
//
fun
auxeval0
(
  given: string, ndepth: int
) : string =
(
  if ndepth < NDEPTH
    then auxeval1(given, ndepth) else given
) (* end of [auxeval0] *)
//
and
auxeval1
(
  given: string, ndepth: int
) : string = let
//
val p0 = $UN.cast2ptr(given)
val c0 = $UN.ptr0_get<char>(p0)
//
(*
val () =
println!
  ("pkgsrcname_eval: auxeval1: given = ", given)
*)
in
//
case+ c0 of
| _ when
    c0 = '$' => let
    val p1 = add_ptr_int(p0, 1)
    val nk = auxtrav(p1, 0(*n*))
    val st0 = $UN.cast2size(1)
    val len = $UN.cast2size(nk)
    val key =
      __make_substring (given, st0, len)
    // end of [val]
    val key = string_of_strptr (key)
(*
    val () =
    println!
      ("pkgsrcname_eval: auxeval1: key = ", key)
    // end of [val]
*)
    val key = $SYM.symbol_make_string (key)
    val opt = $TRENV1.the_e1xpenv_find (key)
  in
    case+ opt of
    | ~None_vt() => given
    | ~Some_vt(e) =>
      (
        case+ e.e1xp_node of
        | $S1E.E1XPstring(x) => let
            val
            pnk = add_ptr_int(p1, nk)
            val
            given2 =
            sprintf("%s%s", @(x, $UN.cast{string}(pnk)))
          in
            auxeval0(string_of_strptr(given2), ndepth+1)
          end (* end of [E1XPstring] *)
        | _ (*non-E1XPstring*) => given
      ) (* end of [Some_vt] *)
  end // end of [variable]
| _ (*nonvariable*) => given
//
end // end of [auxeval1]
//
in
  auxeval0(given, 0(*ndepth*))
end // end of [pkgsrcname_eval]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
$FIL.pkgsrcname_relocatize
  (given, ngurl) = let
//
val srcd0c = $GLOB.the_ATSRELOC_get_decl()
//
extern
fun PATSHOME_get(): string = "ext#patsopt_PATSHOME_get"
extern
fun PATSHOMERELOC_get(): Stropt = "ext#patsopt_PATSHOMERELOC_get"
//
in
//
if
ngurl < 0
then let
  val ((*void*)) =
  if srcd0c > null then
  {
    val srcd0c = $UN.cast{$SYN.d0ecl}(srcd0c)
    val () = $TRENV1.the_atsreloc_insert(srcd0c, given)
  } (* end of [if] *) // end of [val]
in
  given // target
end // end of [then]
else let
//
  val p0 = $UN.cast2ptr(given)
  val p_ngurl = add_ptr_int(p0, ngurl)
  val p_ngurl = $UN.cast{string}(p_ngurl)
//
  val dirsep = $FIL.theDirSep_get ()
//
  val gurl_t = // target
    pkgsrcname_get2_gurl1(given, ngurl)
  val _gurl_t = $UN.castvwtp1{string}(gurl_t)
  val given2_t =
    $UT.dirpath_append(_gurl_t, p_ngurl, dirsep)
  val ((*freed*)) = strptr_free(gurl_t)
  val given2_t = pkgsrcname_eval(string_of_strptr(given2_t))
//
  val () =
  if srcd0c > null then
  {
    val gurl_s = // source
      pkgsrcname_get2_gurl0(given, ngurl)
    val _gurl_s = $UN.castvwtp1{string}(gurl_s)
    val given2_s =
      $UT.dirpath_append(_gurl_s, p_ngurl, dirsep)
    val ((*freed*)) = strptr_free(gurl_s)
    val given2_s = pkgsrcname_eval(string_of_strptr(given2_s))
    val srcd0c = $UN.cast{$SYN.d0ecl}(srcd0c)
    val ((*void*)) = $TRENV1.the_atsreloc_insert2(srcd0c, given2_s, given2_t)
  } (* end of [if] *) // end of [val]
//
in
  given2_t // target
end // end of [else]
//
end // end of [pkgsrcname_relocatize]

(* ****** ****** *)

(* end of [pats_filename_reloc.sats] *)

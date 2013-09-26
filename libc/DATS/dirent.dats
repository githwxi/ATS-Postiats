(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: March, 2013
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/dirent.sats"

(* ****** ****** *)

implement{}
dirent$PC_NAME_MAX ((*void*)) = 256

(* ****** ****** *)

implement{}
dirent_get_d_name_gc
  (ent) = let
//
val (
  fpf | str
) = dirent_get_d_name (ent)
val str2 = strptr1_copy (str)
prval () = fpf (str)
//
in
  str2
end // end of [dirent_get_d_name_gc]

implement{}
direntp_get_d_name_gc
  (entp) = let
//
val (
  pf, fpf | p
) = direntp_get_viewptr (entp)
val str2 = dirent_get_d_name_gc<> (!p)
prval () = minus_addback (fpf, pf | entp)
//
in
  str2
end // end of [direntp_get_d_name_gc]

(* ****** ****** *)

implement{}
compare_dirent_string
  (ent1, str2) = let
//
val
(
  fpf1 | str1
) = dirent_get_d_name (ent1)
val sgn = compare_string_string ($UN.strptr2string(str1), str2)
prval () = fpf1 (str1)
//
in
  sgn
end // end of [compare_dirent_string]

(* ****** ****** *)

%{
extern
atstype_ptr
atslib_opendir_exn
(
  atstype_string dname
) {
  DIR *dirp ;
  dirp = opendir((char*)dname) ;
  if (!dirp) ATSLIBfailexit("opendir") ;
  return dirp ; // [opendir] succeeded
} // end of [atslib_opendir_exn]
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_closedir_exn
(
  atstype_ptr dirp
) {
  int err = closedir((DIR*)dirp) ;
  if (err < 0) ATSLIBfailexit("closedir") ;
  return ; // [closedir] succeeded
} // end of [atslib_closedir_exn]
%}

(* ****** ****** *)

implement{}
readdir_r_gc
  (dirp) = let
//
val ofs = $extfcall
(
  Size_t
, "offsetof"
, $extval (int, "atslib_dirent_type")
, $extval (int, "d_name")
)
//
val bsz = ofs + i2sz(dirent$PC_NAME_MAX()+1)
val [l:addr] (pf, pfgc | p) = malloc_gc (bsz)
prval pf = $UN.castview0{(dirent?)@l}(pf)
var res: ptr
val err = readdir_r (dirp, !p, res)
//
in
//
if res > 0 then
  $UN.castvwtp0{Direntp1}@(pf, pfgc | p)
else let
  prval () = opt_clear{dirent}(!p)
  val () = ptr_free{dirent?}(pfgc, pf | p)
in
  $UN.castvwtp0{Direntp0}(the_null_ptr)
end (* end of [if] *)
//
end // end of [readdir_r_gc]

(* ****** ****** *)

(* end of [dirent.dats] *)

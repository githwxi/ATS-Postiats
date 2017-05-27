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
// Start Time: August, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_global.sats"

(* ****** ****** *)

#include "./pats_params.hats"

(* ****** ****** *)
//
staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"
//
(* ****** ****** *)

local
//
val
the_PACKNAME =
ref<Stropt>(stropt_none)
//
in (* in of [local] *)

implement
the_PACKNAME_get() = !the_PACKNAME
implement
the_PACKNAME_set (opt) = !the_PACKNAME := opt

end // end of [local]

implement
the_PACKNAME_set_name
  (ns) = the_PACKNAME_set(stropt_some(ns))
// end of [the_PACKNAME_set]
implement
the_PACKNAME_set_none
  ((*none*)) = the_PACKNAME_set(stropt_none)
// end of [the_PACKNAME_set_none]

(* ****** ****** *)

local
//
val the_ATSRELOC = ref<int>(0)
val the_ATSRELOC_decl = ref<ptr>(null)
//
in (* in-of-local *)
//
implement
the_ATSRELOC_get() = !the_ATSRELOC
implement
the_ATSRELOC_set(flag) = !the_ATSRELOC := flag
//
implement
the_ATSRELOC_get_decl() = let
  val d0c = !the_ATSRELOC_decl
  val ((*void*)) = !the_ATSRELOC_decl := null in d0c
end // end of [the_ATSRELOC_get_decl]
//
implement
the_ATSRELOC_set_decl(d0c) = !the_ATSRELOC_decl := d0c
//
end // end of [local]

(* ****** ****** *)

local
//
(*
//
// HX: it is no longer in use
//
val the_STALOADFLAG = ref<int> (0)
*)
val the_DYNLOADFLAG = ref<int>(0)
//
in (* in of [local] *)
//
(*
//
// HX-2014-06-06:
// [STALOADFLAG] is no longer in use
//
implement the_STALOADFLAG_get() = !the_STALOADFLAG
implement the_STALOADFLAG_set(flag) = !the_STALOADFLAG := flag
*)
//
implement
the_DYNLOADFLAG_get() = !the_DYNLOADFLAG
implement
the_DYNLOADFLAG_set(flag) = !the_DYNLOADFLAG := flag
//
end // end of [local]

(* ****** ****** *)

local
//
val
the_DYNLOADNAME =
ref<stropt>(stropt_none)
//
in (* in-of-local *)

implement
the_DYNLOADNAME_get
  () = !the_DYNLOADNAME
implement
the_DYNLOADNAME_set_none
  () = !the_DYNLOADNAME := stropt_none(*void*)
implement
the_DYNLOADNAME_set_name
  (name) = !the_DYNLOADNAME := stropt_some(name)

end // end of [local]

(* ****** ****** *)

local

val the_MAINATSFLAG = ref<int>(0)

in (* in of [local] *)

implement
the_MAINATSFLAG_get() = !the_MAINATSFLAG
implement
the_MAINATSFLAG_set(flag) = !the_MAINATSFLAG := flag

end // end of [local]

(* ****** ****** *)

local
//
val
the_STATIC_PREFIX =
  ref<stropt>(stropt_none)
//
in (* in-of-local *)
//
implement
the_STATIC_PREFIX_get
  () = !the_STATIC_PREFIX
implement
the_STATIC_PREFIX_set_none
  () = !the_STATIC_PREFIX := stropt_none
implement
the_STATIC_PREFIX_set_name
  (x) = !the_STATIC_PREFIX := stropt_some(x)
//
end // end of [local]  
  
(* ****** ****** *)

local
//
typedef
dirlst = List0(string)
//
val
the_IATS_dirlst =
ref<dirlst>(list_nil(*void*))
//
in (*in-of-local*)
//
implement
the_IATS_dirlst_get
  () = !the_IATS_dirlst
//
implement
the_IATS_dirlst_ppush
  (dir) = let
  val dirs = !the_IATS_dirlst
in
  !the_IATS_dirlst := list_cons(dir, dirs)
end // end of [the_IATS_dirlst_ppush]
//
(*
//
// HX-2017-02-01: reverted
// HX-2017-01-31: push from the back!
//
implement
the_IATS_dirlst_ppushb
  (dir) = let
  val dirs = !the_IATS_dirlst
in
  !the_IATS_dirlst :=
    list_of_list_vt(list_extend(dirs, dir))
end // end of [the_IATS_dirlst_ppushb]
*)
//
end // end of [local]

(* ****** ****** *)
(*
local
//
val rasmflag = ref<int> (1)
//
in
//
implement
the_ASSUME_check_get() = !rasmflag
implement
the_ASSUME_check_set(flag) = !rasmflag := flag
//
end // end of [local]
*)
(* ****** ****** *)

local
//
val rdbgflag = ref<int>(0)
//
in (*in-of-local*)
//
implement
the_DEBUGATS_dbgflag_get() = !rdbgflag
implement
the_DEBUGATS_dbgflag_set(flag) = !rdbgflag := flag
//
end // end of [local]

(* ****** ****** *)

local
//
val rdbgline = ref<int>(0)
//
in (*in-of-local*)
//
implement
the_DEBUGATS_dbgline_get() = !rdbgline
implement
the_DEBUGATS_dbgline_set(flag) = !rdbgline := flag
//
end // end of [local]

(* ****** ****** *)

local
//
val rtlcalopt = ref<int>(1)
//
in
//
implement
the_CCOMPATS_tlcalopt_get() = !rtlcalopt
implement
the_CCOMPATS_tlcalopt_set(flag) = !rtlcalopt := flag
//
end // end of [local]

(* ****** ****** *)

local
//
val
rmaxtmprecdepth = ref<int>(CCOMPENV_MAXTMPRECDEPTH)
//
in (*in-of-local*)
//
implement
the_CCOMPENV_maxtmprecdepth_get() = !rmaxtmprecdepth
implement
the_CCOMPENV_maxtmprecdepth_set(mtd) = !rmaxtmprecdepth := mtd
//
end // end of [local]

(* ****** ****** *)

(* end of [pats_global.dats] *)

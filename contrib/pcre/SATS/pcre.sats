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

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: December, 2013
*)

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.pcre"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_pcre_" // prefix for external names

(* ****** ****** *)

%{#
#include "pcre/CATS/pcre.cats"
%} // end of [%{#]

(* ****** ****** *)

/*
const char *pcre_version(void);
*/
fun pcre_version ((*void*)): string = "mac#%"

(* ****** ****** *)
//
absvtype pcreptr (l:addr) = ptr
//
vtypedef
pcreptr0 = [l:agez] pcreptr (l)
vtypedef
pcreptr1 = [l:addr | l > null] pcreptr (l)
//
(* ****** ****** *)
//
absvtype pcreptr_extra (l:addr) = ptr
//
vtypedef
pcreptr0_extra = [l:agez] pcreptr_extra (l)
vtypedef
pcreptr1_extra = [l:addr | l > null] pcreptr_extra (l)
//
(* ****** ****** *)

/*
pcre *pcre_compile
(
const char *pattern, int options,
const char **errptr, int *erroffset,
const unsigned char *tableptr
) ;
*/
fun pcre_compile
(
  pattern: RD(string)
, options: uint(*bits*)
, errptr: &ptr? >> ptr, erroffset: &int? >> int, tableptr: ptr
) : pcreptr0 = "mac#%" // end of [pcre_compile]

(* ****** ****** *)

/*
pcre *pcre_compile2
(
const char *pattern, int options,
int *errorcodeptr,
const char **errptr, int *erroffset,
const unsigned char *tableptr
) ;
*/
fun pcre_compile2
(
  pattern: RD(string)
, options: uint(*bits*)
, errorcodeptr: &int? >> int
, errptr: &ptr? >> ptr, erroffset: &int? >> int, tableptr: ptr
) : pcreptr0 = "mac#%" // end of [pcre_compile2]

(* ****** ****** *)

fun pcre_free (code: pcreptr0): void = "mac#%"
praxi pcre_free_null (code: pcreptr (null)): void

(* ****** ****** *)

/*
pcre_extra*
pcre_study (
  const pcre *code, int options, const char **errptr
) ; // pcre_study
*/
fun pcre_study
(
  pcre: !pcreptr1, options: uint, errptr: &ptr? >> ptr
) : pcreptr0_extra = "mac#%"

(* ****** ****** *)
               
/*
void pcre_free_study(pcre_extra *extra);
*/
fun pcre_free_study (extra: pcreptr0_extra): void = "mac#%"
praxi pcre_free_study_null (extra: pcreptr_extra (null)): void

(* ****** ****** *)

/*
int pcre_exec
(
const pcre *code, const pcre_extra *extra,
const char *subject, int length, int startoffset,
int options, int *ovector, int ovecsize
) ;
*/
fun
pcre_exec{n,n2:int}
(
  code: !pcreptr1, extra: !pcreptr0_extra
, subject: arrayref(char, n), length: int n
, startoffset: natLte(n), options: uint(*bits*)
, ovector: arrayref(int, n2), ovecsize: int(n2)
) : int = "mac#%" // end of [pcre_exec]

(* ****** ****** *)

(* end of [pcre.sats] *)

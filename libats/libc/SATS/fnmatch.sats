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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: March, 2013
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/fnmatch.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define
ATS_EXTERN_PREFIX "atslib_libats_libc_"
//
(* ****** ****** *)

#define RD(x) x // for commenting: read-only
#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)

macdef
FNM_MATCH = 0 // HX: match is found
macdef
FNM_NOMATCH = $extval (int, "FNM_NOMATCH") // HX: no match is found

(* ****** ****** *)

typedef fnmflags = int

(* ****** ****** *)

(*
FNM_NOESCAPE
If this flag is set, treat backslash as an ordinary character, instead of
an escape character.
*)
macdef
FNM_NOESCAPE = $extval (fnmflags, "FNM_NOESCAPE")

(*
FNM_PATHNAME
If this flag is set, match a slash in string only with a slash in pattern
and not by an asterisk '*' or a question mark (?) metacharacter, nor by a
bracket expression ([]) containing a slash.
*)
macdef
FNM_PATHNAME = $extval (fnmflags, "FNM_PATHNAME")
                                                  
(*
FNM_PERIOD
If this flag is set, a leading period in string has to be matched exactly
by a period in pattern.  A period is considered to be leading if it is the
first character in string, or if both FNM_PATHNAME is set and the period
immediately follows a slash.
*)
macdef
FNM_PERIOD = $extval (fnmflags, "FNM_PERIOD")

(*
FNM_FILE_NAME
This is a GNU synonym for FNM_PATHNAME.
*)
macdef
FNM_FILE_NAME = $extval (fnmflags, "FNM_FILE_NAME")

(*
FNM_LEADING_DIR
If this flag (a GNU extension) is set, the pattern is considered to be
matched if it matches an initial segment of string which is followed by a
slash.  This flag is mainly for the internal use of glibc and is only
implemented in certain cases.
*)
macdef
FNM_LEADING_DIR = $extval (fnmflags, "FNM_LEADING_DIR")
                                                                                                                                             
(*
FNM_CASEFOLD
If this flag (a GNU extension) is set, the pattern is matched
case-insensitively.
*)
macdef
FNM_CASEFOLD = $extval (fnmflags, "FNM_CASEFOLD")

(* ****** ****** *)

symintr fnmatch

fun fnmatch_null
(
  pattern: NSH(string), fname: NSH(string)
) :<> int = "mac#%" // end of [fnmatch]

fun fnmatch_flags
(
  pattern: NSH(string), fname: NSH(string), flags: fnmflags
) :<> int = "mac#%" // end of [fnmatch]

overload fnmatch with fnmatch_null
overload fnmatch with fnmatch_flags

(* ****** ****** *)

(* end of [fnmatch.sats] *)

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
** Start Time: August, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

%{#
#include "libxml2/CATS/parser.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libxml2"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

staload "./xmlheader.sats"

(* ****** ****** *)

/*
xmlDocPtr xmlParseDoc (const xmlChar *cur);
*/
fun xmlParseDoc
  (cur: !xmlStrptr1): xmlDocPtr0 = "mac#%"
// end of [xmlParseDoc]

(* ****** ****** *)

/*
xmlDocPtr xmlParseFile (const char *filename);
*/
fun xmlParseFile
  (filename: string): xmlDocPtr0 = "mac#%"
// end of [xmlParseFile]

(* ****** ****** *)

/*
xmlDocPtr xmlParseMemory (const char *buffer, int size);
*/
fun
xmlParseMemory{n:int}
  (buf: &array(char, n), size: int (n)): xmlDocPtr0 = "mac#%"
// end of [xmlParseMemory]

(* ****** ****** *)

(* end of [parser.sats] *)

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
#include "libxml2/CATS/HTMLparser.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libxml2"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

staload "./xmlheader.sats"

(* ****** ****** *)

stadef htmlDocPtr = xmlDocPtr
stadef htmlDocPtr0 = xmlDocPtr0
stadef htmlDocPtr1 = xmlDocPtr1

(* ****** ****** *)
//
abst@ype htmlParserOption = int
//
macdef
HTML_PARSE_RECOVER = $extval(htmlParserOption, "HTML_PARSE_RECOVER")
macdef
HTML_PARSE_NODEFDTD = $extval(htmlParserOption, "HTML_PARSE_NODEFDTD")
macdef
HTML_PARSE_NOERROR = $extval(htmlParserOption, "HTML_PARSE_NOERROR")
macdef
HTML_PARSE_NOWARNING = $extval(htmlParserOption, "HTML_PARSE_NOWARNING")
macdef
HTML_PARSE_PEDANTIC = $extval(htmlParserOption, "HTML_PARSE_PEDANTIC")
macdef
HTML_PARSE_NOBLANKS = $extval(htmlParserOption, "HTML_PARSE_NOBLANKS")
macdef
HTML_PARSE_NONET = $extval(htmlParserOption, "HTML_PARSE_NONET")
macdef
HTML_PARSE_NOIMPLIED = $extval(htmlParserOption, "HTML_PARSE_NOIMPLIED")
macdef
HTML_PARSE_COMPACT = $extval(htmlParserOption, "HTML_PARSE_COMPACT")
macdef
HTML_PARSE_IGNORE_ENC = $extval(htmlParserOption, "HTML_PARSE_IGNORE_ENC")
//
(* ****** ****** *)
//
abst@ype htmlStatus = int
//
macdef HTML_NA = $extval(htmlStatus, "HTML_NA")
macdef HTML_INVALID = $extval(htmlStatus, "HTML_INVALID")
macdef HTML_DEPRECATED = $extval(htmlStatus, "HTML_DEPRECATED")
macdef HTML_VALID = $extval(htmlStatus, "HTML_VALID")
macdef HTML_REQUIRED = $extval(htmlStatus, "HTML_REQUIRED")
//
(* ****** ****** *)

/*
htmlDocPtr
htmlParseDoc (xmlChar *cur,  const char *encoding) ;
*/
fun htmlParseDoc{l:addr}
  (xmlStrptr(l), Stropt(*encoding*)): htmlDocPtr0 = "mac#%"
// end of [htmlParseDoc]

(* ****** ****** *)

(* end of [HTMLparser.sats] *)

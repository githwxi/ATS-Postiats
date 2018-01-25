(* ****** ****** *)
//
// API in ATS for PCRE
//
(* ****** ****** *)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Start time: December, 2013
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)
//
%{#
//
#include \
"atscntrb-hx-libpcre/CATS/pcre.cats"
//
%} // end of [%{#]
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSCNTRB.pcre"
#define
ATS_EXTERN_PREFIX "atscntrb_pcre_" // prefix for external names
//
(* ****** ****** *)
//
/*
const char *pcre_version( void ) ;
*/
fun pcre_version((*void*)): string = "mac#%"
//
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
//
castfn
pcreptr2ptr {l:addr} (!pcreptr (l)): ptr (l)
castfn
pcreptr2ptr_extra {l:addr} (!pcreptr_extra (l)): ptr (l)
//
overload ptrcast with pcreptr2ptr
overload ptrcast with pcreptr2ptr_extra
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

macdef
PCRE_ERROR_NOMATCH =
$extval(int, "PCRE_ERROR_NOMATCH") // (-1)
macdef
PCRE_ERROR_NULL = $extval(int, "PCRE_ERROR_NULL") // (-2)
macdef
PCRE_ERROR_BADOPTION =
$extval(int, "PCRE_ERROR_BADOPTION") // (-3)
macdef
PCRE_ERROR_BADMAGIC =
$extval(int, "PCRE_ERROR_BADMAGIC")  // (-4)
macdef
PCRE_ERROR_UNKNOWN_OPCODE =
$extval(int, "PCRE_ERROR_UNKNOWN_OPCODE") // (-5)
(*
macdef
PCRE_ERROR_UNKNOWN_NODE =
$extval(int, "PCRE_ERROR_UNKNOWN_NODE") // (-5)  /* For backward compatibility */
*)
macdef
PCRE_ERROR_NOMEMORY =
$extval(int, "PCRE_ERROR_NOMEMORY") // (-6)
macdef
PCRE_ERROR_NOSUBSTRING =
$extval(int, "PCRE_ERROR_NOSUBSTRING") // (-7)
macdef
PCRE_ERROR_MATCHLIMIT =
$extval(int, "PCRE_ERROR_MATCHLIMIT") // (-8)
macdef
PCRE_ERROR_CALLOUT =
$extval(int, "PCRE_ERROR_CALLOUT") // (-9)  /* Never used by PCRE itself */
macdef
PCRE_ERROR_BADUTF8 =
$extval(int, "PCRE_ERROR_BADUTF8") // (-10)
macdef
PCRE_ERROR_BADUTF8_OFFSET =
$extval(int, "PCRE_ERROR_BADUTF8_OFFSET") // (-11)
macdef
PCRE_ERROR_PARTIAL =
$extval(int, "PCRE_ERROR_PARTIAL") // (-12)
macdef
PCRE_ERROR_BADPARTIAL =
$extval(int, "PCRE_ERROR_BADPARTIAL") // (-13)
macdef
PCRE_ERROR_INTERNAL =
$extval(int, "PCRE_ERROR_INTERNAL") // (-14)
macdef
PCRE_ERROR_BADCOUNT =
$extval(int, "PCRE_ERROR_BADCOUNT") // (-15)
macdef
PCRE_ERROR_DFA_UITEM =
$extval(int, "PCRE_ERROR_DFA_UITEM") // (-16)
macdef
PCRE_ERROR_DFA_UCOND =
$extval(int, "PCRE_ERROR_DFA_UCOND") // (-17)
macdef
PCRE_ERROR_DFA_UMLIMIT =
$extval(int, "PCRE_ERROR_DFA_UMLIMIT") // (-18)
macdef
PCRE_ERROR_DFA_WSSIZE =
$extval(int, "PCRE_ERROR_DFA_WSSIZE") // (-19)
macdef
PCRE_ERROR_DFA_RECURSE =
$extval(int, "PCRE_ERROR_DFA_RECURSE") // (-20)
macdef
PCRE_ERROR_RECURSIONLIMIT =
$extval(int, "PCRE_ERROR_RECURSIONLIMIT") // (-21)
macdef
PCRE_ERROR_NULLWSLIMIT =
$extval(int, "PCRE_ERROR_NULLWSLIMIT") // (-22)  /* No longer actually used */
macdef
PCRE_ERROR_BADNEWLINE =
$extval(int, "PCRE_ERROR_BADNEWLINE") // (-23)
macdef
PCRE_ERROR_BADOFFSET =
$extval(int, "PCRE_ERROR_BADOFFSET") // (-24)
macdef
PCRE_ERROR_SHORTUTF8 =
$extval(int, "PCRE_ERROR_SHORTUTF8") // (-25)

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
//
// HX-2013-12: some convenience functions
//
(* ****** ****** *)
//
fun{}
pcre_match_string
  (code: !pcreptr1, subject: string): int
fun{}
pcre_match_substring
{n:int}{st,ln:int | st+ln <= n}
(
  code: !pcreptr1
, subject: string(n), st: size_t(st), ln: size_t(ln)
) : int // end of [pcre_match_substring]
//
(* ****** ****** *)
//
fun
pcre_match2_substring
  {n:int}{st,ln:int | st+ln <= n}
(
  code: !pcreptr1
, subject: string(n), st: size_t(st), ln: size_t(ln)
, matched_beg: &int? >> int(n0), matched_end: &int? >> int(n1)
) : #[n0,n1:int | n0 <= n1; n1 <= st+ln] int
//
(* ****** ****** *)
//
fun
pcre_match3_substring
  {n:int}{st,ln:int | st+ln <= n}
(
  code: !pcreptr1
, subject: string(n), st: size_t(st), ln: size_t(ln)
, matched_beg: &int? >> int(n0), matched_end: &int? >> int(n1), err: &int? >> int
) : #[n0,n1:int | n0 <= n1; n1 <= st+ln] List0_vt(Strptr0)
//
(* ****** ****** *)

(* end of [pcre.sats] *)

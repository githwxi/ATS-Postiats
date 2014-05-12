(*
** Copyright (C) 2011 Chris Double.
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
** Time: September, 2012
** Author Hongwei Xi (gmhwxi AT gmail DOT com)
**
** The API is modified in the hope that it can be used more conveniently.
*)

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libevent"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

typedef SHR(x:type) = x // for commenting purpose
typedef NSH(x:type) = x // for commenting purpose

(* ****** ****** *)

typedef interr = intLte (0)

(* ****** ****** *)

absvt@ype
event = $extype"event_struct"

(* ****** ****** *)

absvtype eventp (l:addr) = ptr (l)
vtypedef eventp0 = [l:addr] eventp (l)
vtypedef eventp1 = [l:addr | l > null] eventp (l)

(* ****** ****** *)

prfun
eventp_is_gtez
  {l:addr} (p: !eventp(l)):<> [l >= null] void
// end of [eventp_is_gtez]

(* ****** ****** *)

fun eventp_null
  ((*void*)):<> eventp (null) = "mac#atspre_ptr_null"
// end of [eventp_null]

prfun eventp_free_null {l:alez} (p: eventp l):<> void

(* ****** ****** *)
//
castfn
eventp2ptr
  {l:addr}(!eventp(l)):<> ptr(l)
//
overload ptrcast with eventp2ptr
//
(* ****** ****** *)

fun
eventp_is_null
  {l:addr}
  (p: !eventp l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun eventp_isnot_null
  {l:addr}
  (p: !eventp l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with eventp_is_null
overload isneqz with eventp_isnot_null
//
(* ****** ****** *)

absvtype
eventp_base (l:addr) = ptr (l)
vtypedef
eventp0_base = [l:addr] eventp_base (l)
vtypedef
eventp1_base = [l:addr | l > null] eventp_base (l)

(* ****** ****** *)

prfun
eventp_base_is_gtez
  {l:addr} (p: !eventp_base l):<> [l >= null] void
// end of [eventp_base_is_gtez]

fun eventp_base_null
  ((*void*)):<> eventp_base (null) = "mac#atspre_ptr_null"

prfun
eventp_base_free_null {l:alez} (p: eventp_base (l)):<> void

(* ****** ****** *)
//
castfn
eventp2ptr_base
  {l:addr}(p: !eventp(l)):<> ptr(l)
//
overload ptrcast with eventp2ptr_base
//
(* ****** ****** *)

fun
eventp_base_is_null
  {l:addr}
  (p: !eventp_base l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun
eventp_base_isnot_null
  {l:addr}
  (p: !eventp_base l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with eventp_base_is_null
overload isneqz with eventp_base_isnot_null
//
(* ****** ****** *)

absvtype
eventp_config (l:addr) = ptr (l)
vtypedef
eventp0_config = [l:addr] eventp_config (l)
vtypedef
eventp1_config = [l:addr | l > null] eventp_config (l)

(* ****** ****** *)

prfun
eventp_config_is_gtez
  {l:addr} (p: !eventp_config l):<> [l >= null] void
// end of [eventp_config_is_gtez]

(* ****** ****** *)

fun
eventp_config_null
(
// argumentless
) :<> eventp_config (null) = "mac#atspre_ptr_null"

(* ****** ****** *)

prfun
eventp_config_free_null
  {l:addr | l <= null} (p: eventp_config l):<> void
// end of [eventp_config_free_null]

(* ****** ****** *)
//
castfn
eventp2ptr_config
  {l:addr}(p: eventp (l)):<> ptr (l)
//
overload ptrcast with eventp2ptr_config
//
(* ****** ****** *)

fun
eventp_config_is_null
  {l:addr}
  (p: !eventp_config l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun
eventp_config_isnot_null
  {l:addr}
  (p: !eventp_config l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with eventp_config_is_null
overload isneqz with eventp_config_isnot_null
//
(* ****** ****** *)

fun eventp_config_new (): eventp0_config = "mac#%"

fun eventp_config_free (p: eventp0_config): void = "mac#%"

fun eventp_config_avoid_method
  (cfg: !eventp1_config, method: NSH(string)): interr = "mac#%"
// end of [eventp_config_avoid_method]

(* ****** ****** *)

(* end of [event.sats] *)

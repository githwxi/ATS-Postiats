(*
** API in ATS for zlog
*)

(* ****** ****** *)

(*
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
** Author: Zhiqiang Ren
** Authoremail: aren AT bu DOT edu
** Start Time: October, 2012
*)

(* ****** ****** *)

(*
** Author: Hanwen Wu
** Authoremail: hwwu AT bu DOT edu
** Start Time: August, 2013
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: hwxi AT bu DOT edu
** Start Time: August, 2013
*)

(* ****** ****** *)

%{#
#include "zlog/CATS/zlog.cats"
%} // end of [%{#]

(* ****** ****** *)

#define
ATS_PACKNAME "ATSCNTRB.zlog"
#define
ATS_STALOADFLAG 0 // no need for staloading at run-time
#define
ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

abst@ype
zlog_level_t0ype = int

(* ****** ****** *)

typedef
zlog_level = zlog_level_t0ype

macdef
ZLOG_LEVEL_DEBUG = $extval (zlog_level, "ZLOG_LEVEL_DEBUG")
macdef
ZLOG_LEVEL_INFO = $extval (zlog_level, "ZLOG_LEVEL_INFO")
macdef
ZLOG_LEVEL_NOTICE = $extval (zlog_level, "ZLOG_LEVEL_NOTICE")
macdef
ZLOG_LEVEL_WARN = $extval (zlog_level, "ZLOG_LEVEL_WARN")
macdef
ZLOG_LEVEL_ERROR = $extval (zlog_level, "ZLOG_LEVEL_ERROR")
macdef
ZLOG_LEVEL_FATAL = $extval (zlog_level, "ZLOG_LEVEL_FATAL")

(* ****** ****** *)

absvt@ype
zlog_context_t0ype (n:int) = int
stadef zlgctx = zlog_context_t0ype
vtypedef zlgctx0 = [n:int] zlgctx (n)
vtypedef zlgctx1 = [n:int | n >= 0] zlgctx (n)

(* ****** ****** *)

castfn zlgctx2int {n:int} (!zlgctx(n)):<> int(n)

(* ****** ****** *)

absvtype
zlog_category_type (l:addr) = ptr(l)

(* ****** ****** *)

stadef zlgcat = zlog_category_type
vtypedef zlgcat0 = [l:agez] zlgcat (l)
vtypedef zlgcat1 = [l:addr | l > null] zlgcat (l)

(* ****** ****** *)

fun zlog_init
  (cfg: NSH(stropt)): zlgctx0 = "mac#%"
// end of [zlog_init]

(* ****** ****** *)

fun zlog_reload
  (!zlgctx1 >> _, cfg: NSH(stropt)): int(*err*) = "mac#%"
// end of [zlog_reload]

(* ****** ****** *)

fun zlog_fini (zlgctx0): void = "mac#%"

(* ****** ****** *)

fun zlog_profile (!zlgctx1): void = "mac#%"

(* ****** ****** *)

castfn zlgcat2ptr {l:addr} (!zlgcat (l)):<> ptr (l)

(* ****** ****** *)

fun zlog_get_category
  {n:int | n >= 0}
(
  ctx: !zlgctx (n), cname: NSH(string)
) : [l:addr]
(
  minus (zlgctx(n), zlgcat(l)) | zlgcat(l)
) = "mac#%" // endfun

(* ****** ****** *)

fun zlog_get_mdc
  (!zlgctx1, string(*key*)): vStrptr0 = "mac#%"
fun zlog_put_mdc
  (!zlgctx1, string(*key*), string(*val*)): int = "mac#%"

fun zlog_remove_mdc (!zlgctx1, string(*key*)): void = "mac#%"

fun zlog_clean_mdc (!zlgctx1): void = "mac#%"

(* ****** ****** *)

(* end of [zlog.sats] *)

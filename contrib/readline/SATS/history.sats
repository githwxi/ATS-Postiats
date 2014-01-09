(*
** API in ATS for GNU-readline
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
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)

(*
** Author: Brandon Barker
** Authoremail: bbarkerATgmailDOTcom
*)

(* ****** ****** *)

%{#
//
#include "readline/CATS/history.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.readline"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_readline_" // prefix for external names

(* ****** ****** *)

staload
TIME = "libc/SATS/time.sats"
typedef time_t = $TIME.time_t

(* ****** ****** *)

abstype charptr = ptr
abstype histdata_t = ptr

(* ****** ****** *)

absvtype HISTENTptr (l:addr) = ptr(l)
vtypedef HISTENTptr0 = [l:agez] HISTENTptr (l)
vtypedef HISTENTptr1 = [l:addr | l > null] HISTENTptr (l)

(* ****** ****** *)
//
vtypedef
vHISTENTptr(l:addr) = vttakeout0 (HISTENTptr(l))
//
vtypedef vHISTENTptr0 = [l:agez] vHISTENTptr (l)
vtypedef vHISTENTptr1 = [l:addr | l > null] vHISTENTptr (l)
//
(* ****** ****** *)

typedef
HISTENT =
$extype_struct
  "HIST_ENTRY" of
{
  line= charptr
, timestamp= charptr
, data= histdata_t
} (* end of [HISTENT] *)

(* ****** ****** *)
//
castfn
HISTENTptr2ptr
  {l:addr} (ent: !HISTENTptr(l)):<> ptr(l)
//
overload ptrcast with HISTENTptr2ptr
//
(* ****** ****** *)

praxi
HISTENTptr_free_null (HISTENTptr(null)): void

(* ****** ****** *)

fun add_history (line: !Strptr1): void = "mac#%"
fun add_history_time (line: !Strptr1): void = "mac#%"

(* ****** ****** *)

fun remove_history (int): HISTENTptr0 = "mac#%"

(* ****** ****** *)

fun free_history_entry (ent: HISTENTptr0): histdata_t = "mac#%"

(* ****** ****** *)

fun where_history ((*void*)): int = "mac#%"

(* ****** ****** *)

fun current_history ((*void*)): vHISTENTptr0 = "mac#%"

(* ****** ****** *)

fun history_total_bytes ((*void*)): int = "mac#%"

(* ****** ****** *)

fun history_get (ofs: int): vHISTENTptr0 = "mac#%"

(* ****** ****** *)

fun history_get_time (ent: !HISTENTptr0): time_t = "mac#%"

(* ****** ****** *)

fun history_set_pos (pos: int): int(*err*) = "mac#%"

(* ****** ****** *)

fun next_history ((*void*)): vHISTENTptr0 = "mac#%"
fun previous_history ((*void*)): vHISTENTptr0 = "mac#%"

(* ****** ****** *)

fun history_search (str: string, dir: int): int = "mac#%"
fun history_search_prefix (str: string, dir: int): int = "mac#%"
fun history_search_pos (str: string, dir: int, pos: int): int = "mac#%"

(* ****** ****** *)

(* end of [history.sats] *)

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
** Authoremail: brandonDOTbarkerATgmailDOTcom
*)

(* ****** ****** *)

%{#
//
#include "readline/CATS/readline.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.readline"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_readline_" // prefix for external names

(* ****** ****** *)

symintr readline

fun readline_string (prompt: string): Strptr0 = "mac#readline"
overload readline with readline_string of 0

fun readline_string_n
  (prompt: string): Strptr0 = "mac#readline"
overload readline with readline_string_n of 10

fun readline_strptr
  (prompt: strptr): Strptr0 = "mac#readline"
overload readline with readline_strptr of 100

fun readline_strptr_l
  {l:addr} (prompt: !strptr): Strptr0 = "mac#readline"
overload readline with readline_strptr_l of 1000


(* ****** ****** *)

(* end of [readline.sats] *)

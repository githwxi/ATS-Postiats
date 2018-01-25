(* ****** ****** *)
(*
** Author: Hongwei Xi
** Start Time: May, 2013
** Authoremail: gmhwxiATgmailDOTcom
*)
(* ****** ****** *)

%{#
#include \
"atscntrb-hx-libjson-c/CATS/printbuf.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSCNTRB.jsonc"
//
// HX: prefix for extern names
//
#define
ATS_EXTERN_PREFIX "atscntrb_jsonc_"
//
(* ****** ****** *)
//
staload JSON = "./json.sats"
//
stadef printbuf = $JSON.printbuf
stadef printbuf0 = $JSON.printbuf0
stadef printbuf1 = $JSON.printbuf1
//
(* ****** ****** *)
//
castfn
printbuf2ptr
  {l:addr}
  (prbuf: !printbuf(l)):<> ptr(l)
//
overload ptrcast with printbuf2ptr
//
(* ****** ****** *)

fun
printbuf_get_buf
  (pb: !printbuf1): vStrptr1 = "mac#%"
// end of [printbuf_get_buf]

(* ****** ****** *)

(*
struct printbuf *printbuf_new (void)
*)
fun printbuf_new(): printbuf0 = "mac#%"
 
(* ****** ****** *)

(*
void
printbuf_free (struct printbuf *pb)
*)
fun printbuf_free(pb: printbuf0): void = "mac#%"

(* ****** ****** *)

(*
void
printbuf_reset (struct printbuf *p)
*)
fun printbuf_reset(pb: !printbuf1): void = "mac#%"

(* ****** ****** *)

fun printbuf_length(pb: !printbuf1): intGte(0) = "mac#%"

(* ****** ****** *)

(*
int printbuf_memappend
  (struct printbuf *pb, const char *buf, int size)
*)
fun
printbuf_memappend
  (pb: !printbuf1, buf: Ptr1, size: intGte(0)): int = "mac#%"
// end of [printbuf_memappend]

(* ****** ****** *)

(*  
int printbuf_memset
  (struct printbuf *pb, int offset, int charvalue, int len)
*)
fun
printbuf_memset
(
  pb: !printbuf1, offset: int, charvalue: int, len: intGte(0)
) : int = "mac#%" // end of [printbuf_memset]

(* ****** ****** *)

(*
int sprintbuf (struct printbuf *p, const char *msg,...)
*)
    
(* ****** ****** *)

(* end of [printbuf.sats] *)

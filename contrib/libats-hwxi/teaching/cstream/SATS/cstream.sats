(*
** stream of characters
*)

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

absvtype
cstream_vtype(tkind) = ptr
vtypedef
cstream(tk:tkind) = cstream_vtype(tk)

(* ****** ****** *)

tkindef TKfun = "TKfun"
tkindef TKcloref = "TKcloref"
tkindef TKstring = "TKstring"
tkindef TKstrptr = "TKstrptr"
tkindef TKfileref = "TKfileref"
tkindef TKfileptr = "TKfileptr"

(* ****** ****** *)

vtypedef
cstream = [tk:tkind] cstream(tk)

(* ****** ****** *)

fun cstream_free (cstream): void

(* ****** ****** *)

fun cstream_get_char (!cstream): int

(* ****** ****** *)

fun cstream_make_fun (() -> int): cstream(TKfun)
fun cstream_make_cloref (() -<cloref1> int): cstream(TKcloref)

(* ****** ****** *)

fun cstream_make_string (string): cstream(TKstring)
fun cstream_make_strptr (Strptr1): cstream(TKstrptr)

(* ****** ****** *)
//
fun
cstream_make_fileref (FILEref): cstream(TKfileref)
fun
cstream_make_fileptr
  {l:agz}{m:fmode}
  (file_mode_lte (m, r) | FILEptr(l, m)): cstream(TKfileptr)
//
(* ****** ****** *)

(* end of [cstream.sats] *)

(*
** atslex: lexer for ATS
*)

(* ****** ****** *)

abstype charset_type = ptr
typedef charset = charset_type

(* ****** ****** *)
//
fun print_charset (cs: charset): void
fun prerr_charset (cs: charset): void
fun fprint_charset (out: FILEref, cs: charset): void
//
overload print with print_charset
overload prerr with prerr_charset
overload fprint with fprint_charset
//
(* ****** ****** *)

val charset_nil : charset
val charset_all : charset

(* ****** ****** *)

fun charset_sing (c: uchar): charset
fun charset_interval (c1: uchar, c2: uchar): charset

(* ****** ****** *)

fun charset_is_member (cs: charset, c: uchar): bool

(* ****** ****** *)

fun charset_comp (cs: charset): charset
fun charset_diff (cs1: charset, cs2: charset): charset

(* ****** ****** *)

fun charset_union (cs1: charset, cs2: charset): charset
fun charset_inter (cs1: charset, cs2: charset): charset

(* ****** ****** *)

(* end of [atslex.sats] *)

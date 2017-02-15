(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
//
(* ****** ****** *)

#staload "./../basics_php.sats"

(* ****** ****** *)
//
(*
val STDIN : PHPfilr = "mac#"
val STDOUT : PHPfilr = "mac#"
val STDERR : PHPfilr = "mac#"
*)
macdef STDIN = $extval (PHPfilr, "STDIN")
macdef STDOUT = $extval (PHPfilr, "STDOUT")
macdef STDERR = $extval (PHPfilr, "STDERR")
//
(* ****** ****** *)
//
fun fclose (PHPfilp0): bool = "mac#fclose"
fun fclose_checkret (ret: bool): void = "mac#%"
//
(* ****** ****** *)
//
fun fwrite_2
  (!PHPfilp0, inp: string): int = "mac#fwrite"
fun fwrite_3
  (!PHPfilp0, inp: string, maxlen: int): int = "mac#fwrite"
//
symintr fwrite
overload fwrite with fwrite_2
overload fwrite with fwrite_3
//
fun fwrite_checkret (nwrit: int): void = "mac#%"
//
(* ****** ****** *)
//
fun unlink_1 (fname: string): bool = "mac#unlink"
//
symintr unlink
overload unlink with unlink_1
//
(* ****** ****** *)

(* end of [filebas.sats] *)

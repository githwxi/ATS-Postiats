(*
** For writing ATS code
** that transpiles into PHP
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
macdef
STDIN = $extval(PHPfilr, "STDIN")
macdef
STDOUT = $extval(PHPfilr, "STDOUT")
macdef
STDERR = $extval(PHPfilr, "STDERR")
//
(* ****** ****** *)
//
fun
fclose_1(PHPfilp0): bool = "mac#%"
//
fun
fclose_checkret(ret: bool): void = "mac#%"
//
symintr fclose
overload fclose with fclose_1
//
(* ****** ****** *)
//
fun
unlink_1(fname: string): bool = "mac#%"
//
fun
unlink_checkret(ret: bool): void = "mac#%"
//
symintr unlink
overload unlink with unlink_1
//
(* ****** ****** *)
//
fun
fwrite_2
  (!PHPfilp0, inp: string): int = "mac#%"
fun
fwrite_3
  (!PHPfilp0, inp: string, maxlen: int): int = "mac#%"
//
fun fwrite_checkret(nwrit: int): void = "mac#%"
//
symintr fwrite
overload fwrite with fwrite_2
overload fwrite with fwrite_3
//
(* ****** ****** *)

(* end of [filebas.sats] *)

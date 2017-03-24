(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)
//
// HX-2016-06:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
//
(* ****** ****** *)

staload "./../basics_scm.sats"

(* ****** ****** *)

fun stdin_get(): SCMfilr = "mac#%"
fun stdout_get(): SCMfilr = "mac#%"
fun stderr_get() : SCMfilr = "mac#%"

(* ****** ****** *)

fun
fileref_close_input(inp: SCMfilr): void = "mac#%"
fun
fileref_open_input_exn(fname: string): void = "mac#%"

(* ****** ****** *)

fun
fileref_close_output(inp: SCMfilr): void = "mac#%"
fun
fileref_open_output_exn(fname: string): void = "mac#%"

(* ****** ****** *)
//
fun
write_char(c: char): void = "mac#%"
fun
fwrite_char(out: FILEref, c: char): void = "mac#%"
//
fun
write_SCMval(obj: SCMval): void = "mac#%"
fun
fwrite_SCMval(out: FILEref, x: SCMval): void = "mac#%"
//
symintr write
overload write with write_char
overload write with write_SCMval
//
symintr fwrite
overload fwrite with fwrite_char
overload fwrite with fwrite_SCMval
//
(* ****** ****** *)

(* end of [filebas.sats] *)

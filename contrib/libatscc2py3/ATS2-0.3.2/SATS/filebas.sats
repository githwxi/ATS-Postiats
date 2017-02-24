(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
//
(* ****** ****** *)

#staload "./../basics_py.sats"

(* ****** ****** *)
//
val stdin : PYfilr = "mac#%"
val stdout : PYfilr = "mac#%"
val stderr : PYfilr = "mac#%"
//
(* ****** ****** *)
//
fun
fileref_open_exn
  (path: string, fm: file_mode): PYfilr = "mac#%"
fun
fileref_open_opt
  (path: string, fm: file_mode): Option_vt(PYfilr) = "mac#%"
//
(* ****** ****** *)
//
fun
fileref_close(fil: PYfilr): void = "mac#%"
//
(* ****** ****** *)
//
fun
fileref_get_file_string(inp: PYfilr): string = "mac#%"
//
(* ****** ****** *)

(* end of [filebas.sats] *)

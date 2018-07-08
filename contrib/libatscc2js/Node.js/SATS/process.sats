(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)

(*
** Node.js/process
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2nodejs_"
//
(* ****** ****** *)
//
staload
"./../../basics_js.sats"
//
staload "./basics.sats";
staload "./fprint.sats";
//
(* ****** ****** *)

val process_stdin : NJSstream = "mac#%"
val process_stdout : NJSstream = "mac#%"
val process_stderr : NJSstream = "mac#%"

(* ****** ****** *)

val process_argv : JSarray(string) = "mac#%"

(* ****** ****** *)

val process_execPath : string = "mac#%"
val process_execArgv : JSarray(string) = "mac#%"

(* ****** ****** *)

(*
val process_env : Dictionary(string) = "mac#%"
*)

(* ****** ****** *)

val process_pid : int = "mac#%" // of the node

(* ****** ****** *)

val process_version : string = "mac#%"
(*
val process_versions : Dictionary(string) = "mac#%"
*)
(* ****** ****** *)

fun process_cwd (): string = "mac#%"
fun process_chdir (dir: string): void = "mac#%"

(* ****** ****** *)

fun process_getgid (): int = "mac#%"
fun process_setgid (id: int): void = "mac#%"

(* ****** ****** *)

fun process_getuid (): int = "mac#%"
fun process_setuid (id: int): void = "mac#%"

(* ****** ****** *)

fun process_uptime (): int = "mac#%"  
fun process_hrtime (): JSarray(int) = "mac#%"  
  
(* ****** ****** *)

(* end of [process.sats] *)

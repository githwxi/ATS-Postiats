(*
//
// For [libatsopt]
//
*)

(* ****** ****** *)

#define ATS_STALOADFLAG 0

(* ****** ****** *)
//
absprop
PATSHOME_set_p
//
fun
PATSHOME_set
(
// argumentless
) : (PATSHOME_set_p | void)
//
fun
PATSHOME_get
  (pf: PATSHOME_set_p | (*void*)) : string
//
(* ****** ****** *)
//
fun
the_prelude_load
(
  PATSHOME: string
) : void
  = "ext#libatsopt_the_prelude_load"
fun
the_prelude_load_if
(
  PATSHOME: string, flag: &int
) : void
  = "ext#libatsopt_the_prelude_load_if"
//
(* ****** ****** *)
//
fun
patsopt_main
  {n:pos}
(
  argc: int(n), argv: &(@[string][n])
) : void = "ext#libatsopt_patsopt_main"
//
(* ****** ****** *)
//
datatype
comarg =
| COMARGstring of string
| COMARGfilinp of string
//
typedef comarglst0 = List0(comarg)
typedef comarglst1 = List1(comarg)
//
(* ****** ****** *)
//
fun
string2file
  (content: string, nerr: &int >> int): string
//
(* ****** ****** *)
//
fun
patsopt_main_list
  {n:pos}(args: list(comarg, n)): int
//
(* ****** ****** *)
//
fun
libatsopt_dynloadall((*void*)): void = "ext#"
//
(* ****** ****** *)
//
datatype
patsoptres =
  | PATSOPTRESstdout of string // output to stdout
  | PATSOPTRESstderr of string // output to stderr
//
(* ****** ****** *)

(* end of [libatsopt_ext.sats] *)

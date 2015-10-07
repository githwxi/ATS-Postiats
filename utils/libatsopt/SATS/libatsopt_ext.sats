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
pervasive_load
(
  PATSHOME: string, given: string
) : void
  = "ext#libatsopt_pervasive_load"
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
patsopt_main_exn
  {n:pos}
(
  argc: int(n), argv: &(@[string][n])
) : void = "ext#libatsopt_patsopt_main"
//
fun
patsopt_main_opt
  {n:pos}
  (argc: int(n), argv: &(@[string][n])): bool
//
(* ****** ****** *)
//
datatype
comarg =
//
| COMARGstrlit of string
//
| COMARGstrinp of string
//
| COMARGprefil of string
| COMARGpostfil of string
//
typedef comarglst0 = List0(comarg)
typedef comarglst1 = List1(comarg)
//
(* ****** ****** *)
//
fun
patsopt_main_arglst
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

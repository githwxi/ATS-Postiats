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
(
  argc: int(n), argv: &(@[string][n])
) : bool = "ext#libatsopt_patsopt_main_opt"
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
comarg_strlit
  (x: string): comarg
  = "ext#libatsopt_comarg_strlit"
fun
comarg_strinp
  (x: string): comarg
  = "ext#libatsopt_comarg_strinp"
//
fun
comarg_prefil
  (x: string): comarg
  = "ext#libatsopt_comarg_prefil"
fun
comarg_postfil
  (x: string): comarg
  = "ext#libatsopt_comarg_postfil"
//
(* ****** ****** *)
//
fun
comarglst_nil
(
// argumentless
) : comarglst0 = "ext#libatsopt_comarglst_nil"
fun
comarglst_cons
(
  x: comarg, xs: comarglst0
) : comarglst1 = "ext#libatsopt_comarglst_cons"
//
(* ****** ****** *)
//
fun
libatsopt_dynloadall
  ((*void*)): void = "ext#libatsopt_dynloadall"
//
(* ****** ****** *)
//
datatype
patsoptres =
PATSOPTRES of
(
  int(*nerr*)
, string(*stdout*), string(*stderr*)
)
//
(* ****** ****** *)
//
fun
patsoptres_get_nerr
(
  res: patsoptres
) : int = "ext#libatsopt_patsoptres_get_nerr"
fun
patsoptres_get_stdout
(
  res: patsoptres
) : string = "ext#libatsopt_patsoptres_get_stdout"
fun
patsoptres_get_stderr
(
  res: patsoptres
) : string = "ext#libatsopt_patsoptres_get_stderr"
//
(* ****** ****** *)
//
fun
patsopt_main_arglst
  {n:pos}
(
  args: list(comarg, n)
) : int(*nerr*) = "ext#libatsopt_patsopt_main_arglst"
//
fun
patsoptres_main_arglst
  {n:pos}
(
  args: list(comarg, n)
) : patsoptres = "ext#libatsopt_patsoptres_main_arglst"
//
(* ****** ****** *)

(* end of [libatsopt_ext.sats] *)

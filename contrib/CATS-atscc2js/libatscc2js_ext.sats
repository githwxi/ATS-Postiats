(*
//
// For [libatscc2js]
//
*)

(* ****** ****** *)

#define ATS_STALOADFLAG 0

(* ****** ****** *)
//
fun
atscc2js_main0_exn
  {n:pos}
(
  argc: int(n), argv: &(@[string][n])
) : void = "ext#libatscc2js_atscc2js_main0"
//
fun
atscc2js_main0_opt
  {n:pos}
(
  argc: int(n), argv: &(@[string][n])
) : bool = "ext#libatscc2js_atscc2js_main0_opt"
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
  = "ext#libatscc2js_comarg_strlit"
fun
comarg_strinp
  (x: string): comarg
  = "ext#libatscc2js_comarg_strinp"
//
fun
comarg_prefil
  (x: string): comarg
  = "ext#libatscc2js_comarg_prefil"
fun
comarg_postfil
  (x: string): comarg
  = "ext#libatscc2js_comarg_postfil"
//
(* ****** ****** *)
//
fun
comarglst_nil
(
// argumentless
) : comarglst0 = "ext#libatscc2js_comarglst_nil"
fun
comarglst_cons
(
  x: comarg, xs: comarglst0
) : comarglst1 = "ext#libatscc2js_comarglst_cons"
//
(* ****** ****** *)
//
fun
libatscc2js_dynload
  ((*initialize*)): void = "ext#libatscc2js_dynload"
//
(* ****** ****** *)

datatype
atscc2jsres =
ATSCC2JSRES of
(
  int(*nerr*)
, string(*stdout*), string(*stderr*)
)

(* ****** ****** *)
//
fun
atscc2js_main0_arglst
  {n:pos}
(
  args: list(comarg, n)
) : int(*nerr*) = "ext#libatscc2js_atscc2js_main0_arglst"
//
(* ****** ****** *)

(* end of [libatscc2js_ext.sats] *)

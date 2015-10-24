(*
** A wrapper for patsopt
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"test_libatsopt_dynload"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

abstype emcc_int
abstype emcc_string

(* ****** ****** *)

abstype comarg
abstype comarglst

(* ****** ****** *)

extern
fun comarg_strlit(string): comarg
and comarg_strinp(string): comarg
and comarg_prefil(string): comarg
and comarg_postfil(string): comarg

(* ****** ****** *)
//
%{^
//
function
emcc_string(inp)
{
//
var
out = Module._malloc(inp.length+1);
//
Module.writeStringToMemory(inp, out); return out;
//
} // end of [emcc_string]
//
function
emcc_stringify(ptr) { return Pointer_stringify(ptr); }
//
%} // end of [%{^]
//
extern
fun
emcc_string
  (inp: string) : emcc_string = "mac#emcc_string"
//
extern
fun
emcc_stringify(emcc_string): string = "mac#emcc_stringify"
//
(* ****** ****** *)
//
extern
fun
_comarg_strlit
  (emcc_string): comarg
  = "mac#_libatsopt_comarg_strlit"
and
_comarg_strinp
  (emcc_string): comarg
  = "mac#_libatsopt_comarg_strinp"
and
_comarg_prefil
  (emcc_string): comarg
  = "mac#_libatsopt_comarg_prefil"
and
_comarg_postfil
  (emcc_string): comarg
  = "mac#_libatsopt_comarg_postfil"
//
extern
fun
_comarglst_nil
  ((*void*)): comarglst
  = "mac#_libatsopt_comarglst_nil"
and
_comarglst_cons
  (comarg, comarglst): comarglst
  = "mac#_libatsopt_comarglst_cons"
//
(* ****** ****** *)
//
implement
comarg_strlit(x) = _comarg_strlit(emcc_string(x))
implement
comarg_strinp(x) = _comarg_strinp(emcc_string(x))
implement
comarg_prefil(x) = _comarg_prefil(emcc_string(x))
implement
comarg_postfil(x) = _comarg_postfil(emcc_string(x))
//
(* ****** ****** *)
//
%{^
//
function
theExample_dats_get_value()
{
  return document.getElementById("theExample_dats").value;
}
function
theExample_dats_c_set_value(code)
{
  return document.getElementById("theExample_dats_c").value = code;
}
//
%} // end of [%{^]
//
extern
fun
theExample_dats_get_value(): string = "mac#"
extern
fun
theExample_dats_c_set_value(code: string): void = "mac#"
//
(* ****** ****** *)
//
abstype patsoptres
//
extern
fun
patsoptres_get_nerr(patsoptres): int
extern
fun
patsoptres_get_stdout(patsoptres): string
extern
fun
patsoptres_get_stderr(patsoptres): string
//
(* ****** ****** *)
//
implement
patsoptres_get_nerr(res) =
 $extfcall(int, "_libatsopt_patsoptres_get_nerr", res)
//
implement
patsoptres_get_stdout(res) =
emcc_stringify
(
 $extfcall(emcc_string, "_libatsopt_patsoptres_get_stdout", res)
)
//
implement
patsoptres_get_stderr(res) =
emcc_stringify
(
 $extfcall(emcc_string, "_libatsopt_patsoptres_get_stderr", res)
)
//
(* ****** ****** *)
//
extern
fun
theExample_button_onclick
  (arglst: comarglst): int
//
(* ****** ****** *)
//
implement
theExample_button_onclick
  (arglst) = nerr where
{
//
val () =
$extfcall(void, "_libatsopt_dynloadall")
//
val
res =
$extfcall
(
  int
, "_libatsopt_patsopt_main_arglst", arglst
) (* end of [val] *)
//
val
nerr = res
//
val
stdout =
$extfcall
  (string, "libatsopt_stdout_store_join")
val
stderr =
$extfcall
  (string, "libatsopt_stderr_store_join")
//
(*
//
val
res =
$extfcall
(
  patsoptres
, "_libatsoptres_patsopt_main_arglst", arglst
) (* end of [val] *)
//
val nerr = patsoptres_get_nerr(res)
val stdout = patsoptres_get_stdout(res)
val stderr = patsoptres_get_stderr(res)
//
*)
(*
//
val () = 
if nerr > 0 then
  alert("patsopt_main_arglst: nerr="+String(nerr))
// end of [if]
//
val () = 
if nerr > 0 then
(
  alert("patsoptres_main_arglst: nerr="+String(nerr))
) (* end of [if] *)
//
*)
//
val () =
  if (nerr = 0) then theExample_dats_c_set_value(stdout)
val () =
  if (nerr > 0) then theExample_dats_c_set_value(stderr)
//
} (* end of [theExample_button_onclick] *)
//
(* ****** ****** *)
//
extern
fun
theExample_button_cc_onclick
  ((*void*)): int = "mac#"
//
implement
theExample_button_cc_onclick
  () = nerr where
{
//
val arg1 =
  comarg_strlit("--dynamic")
val arg2 =
  comarg_strinp(theExample_dats_get_value())
//
val arglst = _comarglst_nil()
val arglst = _comarglst_cons(arg2, arglst)
val arglst = _comarglst_cons(arg1, arglst)
//
val nerr = theExample_button_onclick(arglst)
//
val ((*void*)) =
  if nerr > 0 then alert("There are errors!")
//
} // end of [theExample_button_cc_onclick]
//
(* ****** ****** *)
//
extern
fun
theExample_button_tc_onclick
  ((*void*)): int = "mac#"
//
implement
theExample_button_tc_onclick
  () = nerr where
{
//
val arg0 =
  comarg_strlit("-tc")
val arg1 =
  comarg_strlit("--dynamic")
val arg2 =
  comarg_strinp(theExample_dats_get_value())
//
val arglst = _comarglst_nil()
val arglst = _comarglst_cons(arg2, arglst)
val arglst = _comarglst_cons(arg1, arglst)
val arglst = _comarglst_cons(arg0, arglst)
//
val nerr = theExample_button_onclick(arglst)
//
val ((*void*)) =
  if nerr = 0 then alert("Well-typed!")
val ((*void*)) =
  if nerr > 0 then alert("There are errors!")
//
} (* end of [theExample_button_tc_onclick] *)

(* ****** ****** *)

%{$
/*
function
libatsopt_ext_js_eval()
{
  preRun();
  preMain();
  Module.callMain();
}
*/
function
the_libatsopt_main()
{
  jQuery(document).ready(function(){test_libatsopt_dynload();});
}
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [test_libatsopt.dats] *)

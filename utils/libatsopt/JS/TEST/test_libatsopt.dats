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

abstype emcc_comarg
abstype emcc_comarglst

(* ****** ****** *)

extern
fun comarg_strlit(string): emcc_comarg
and comarg_strinp(string): emcc_comarg
and comarg_prefil(string): emcc_comarg
and comarg_postfil(string): emcc_comarg

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
  (emcc_string): emcc_comarg
  = "mac#_libatsopt_comarg_strlit"
and
_comarg_strinp
  (emcc_string): emcc_comarg
  = "mac#_libatsopt_comarg_strinp"
and
_comarg_prefil
  (emcc_string): emcc_comarg
  = "mac#_libatsopt_comarg_prefil"
and
_comarg_postfil
  (emcc_string): emcc_comarg
  = "mac#_libatsopt_comarg_postfil"
//
extern
fun
_comarglst_nil
  ((*void*)): emcc_comarglst
  = "mac#_libatsopt_comarglst_nil"
and
_comarglst_cons
(
  emcc_comarg, emcc_comarglst
) : emcc_comarglst
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
function
theExample_patsopt_optstr_get_value()
{
  return document.getElementById("theExample_patsopt_optstr").value;
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
extern
fun
theExample_patsopt_optstr_get_value(): string = "mac#"
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
theExample_patsopt_getarg
  ((*void*)): emcc_comarglst
//
implement
theExample_patsopt_getarg
  ((*void*)) = let
//
val
code = theExample_dats_get_value()
//
val
comarg = comarg_strinp(code)
val
arglst = _comarglst_nil((*void*))
val
arglst = _comarglst_cons(comarg, arglst)
//
val
delim = " "
val
optstr =
theExample_patsopt_optstr_get_value()
val
optarr =
$extmcall(JSarray(string), optstr, "split", delim)
//
typedef
res = emcc_comarglst
//
fun
aux(n: int, xs: res): res =
(
//
if
n > 0
then let
  val n = n - 1
  val x =
    comarg_strlit(optarr[n])
  // end of [val]
in
  aux(n, _comarglst_cons(x, xs))
end // end of [then]
else xs // end of [else]
//
) (* end of [aux] *)
//
in
  aux(length(optarr), arglst)
end // end of [theExample_patsopt_getarg]

(* ****** ****** *)
//
extern
fun
theExample_patsopt_arglst
  (arglst: emcc_comarglst): int
//
extern
fun
theExample_patsopt_onclick(): int = "mac#"
//
(* ****** ****** *)
//
implement
theExample_patsopt_arglst
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
  if (nerr = 0)
    then theExample_dats_c_set_value(stdout)
  // end of [if]
val () =
  if (nerr > 0)
    then theExample_dats_c_set_value(stderr)
  // end of [if]
//
val () = if nerr = 0 then alert("Patsopt succeeded!")
val () = if nerr > 0 then alert("Patsopt yielded errors!")
//
} (* end of [theExample_patsopt_arglst] *)
//
(* ****** ****** *)
//
implement
theExample_patsopt_onclick() = 
  theExample_patsopt_arglst(theExample_patsopt_getarg())
//
(* ****** ****** *)
//
%{$
//
function
the_libatsopt_main()
{
  jQuery(document).ready(function(){test_libatsopt_dynload();});
}
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [test_libatsopt.dats] *)

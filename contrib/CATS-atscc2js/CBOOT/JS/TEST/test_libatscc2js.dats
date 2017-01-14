(*
** A wrapper for atscc2js
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"test_libatscc2js_dynload"
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
  = "mac#_libatscc2js_comarg_strlit"
and
_comarg_strinp
  (emcc_string): emcc_comarg
  = "mac#_libatscc2js_comarg_strinp"
and
_comarg_prefil
  (emcc_string): emcc_comarg
  = "mac#_libatscc2js_comarg_prefil"
and
_comarg_postfil
  (emcc_string): emcc_comarg
  = "mac#_libatscc2js_comarg_postfil"
//
extern
fun
_comarglst_nil
  ((*void*)): emcc_comarglst
  = "mac#_libatscc2js_comarglst_nil"
and
_comarglst_cons
(
  emcc_comarg, emcc_comarglst
) : emcc_comarglst
  = "mac#_libatscc2js_comarglst_cons"
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
theExample_dats_c_get_value()
{
  return document.getElementById("theExample_dats_c").value;
}
function
theExample_dats_js_set_value(code)
{
  return document.getElementById("theExample_dats_js").value = code;
}
//
function
theExample_atscc2js_optstr_get_value()
{
  return document.getElementById("theExample_atscc2js_optstr").value;
}
//
%} // end of [%{^]
//
extern
fun
theExample_dats_c_get_value(): string = "mac#"
extern
fun
theExample_dats_js_set_value(code: string): void = "mac#"
//
extern
fun
theExample_atscc2js_optstr_get_value(): string = "mac#"
//
(* ****** ****** *)
//
extern
fun
theExample_atscc2js_getarg
  ((*void*)): emcc_comarglst
//
implement
theExample_atscc2js_getarg
  ((*void*)) = let
//
val
code =
theExample_dats_c_get_value()
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
theExample_atscc2js_optstr_get_value()
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
end // end of [theExample_atscc2js_getarg]

(* ****** ****** *)
//
extern
fun
theExample_atscc2js_arglst
  (arglst: emcc_comarglst): int
//
extern
fun
theExample_atscc2js_onclick(): int = "mac#"
//
(* ****** ****** *)
//
implement
theExample_atscc2js_arglst
  (arglst) = nerr where
{
//
val () =
$extfcall(void, "_libatscc2js_dynload")
//
val
res =
$extfcall
(
  int
, "_libatscc2js_atscc2js_main0_arglst", arglst
) (* end of [val] *)
//
val
nerr = res
//
val
stdout =
$extfcall
  (string, "libatscc2js_stdout_store_join")
val
stderr =
$extfcall
  (string, "libatscc2js_stderr_store_join")
//
val () =
  if (nerr = 0)
    then theExample_dats_js_set_value(stdout)
  // end of [if]
val () =
  if (nerr > 0)
    then theExample_dats_js_set_value(stderr)
  // end of [if]
//
val () = if nerr = 0 then alert("Atscc2js finished normally!")
val () = if nerr >= 1 then alert("Atscc2js encountered an error!")
val () = if nerr >= 2 then alert("Atscc2js encountered some errors!")
//
} (* end of [theExample_atscc2js_arglst] *)
//
(* ****** ****** *)
//
implement
theExample_atscc2js_onclick() = 
  theExample_atscc2js_arglst(theExample_atscc2js_getarg())
//
(* ****** ****** *)
//
%{$
//
function
the_libatscc2js_main()
{
  jQuery(document).ready(function(){test_libatscc2js_dynload();});
}
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [test_libatscc2js.dats] *)

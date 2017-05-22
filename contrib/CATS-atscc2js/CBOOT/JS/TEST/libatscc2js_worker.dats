(* ****** ****** *)
//
// WebWorker for libatscc2js
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"the_libatscc2js_worker_start"
//
(* ****** ****** *)
//  
#define
LIBATSCC2JS_targetloc
"$PATSHOME\
/contrib/libatscc2js/ATS2-0.3.2"
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload "libats/ML/SATS/basis.sats"
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
staload
"{$LIBATSCC2JS}/DATS/Worker/channel.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/chanpos.dats"
//
(* ****** ****** *)

#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
#staload
"./../../../DATS/libatscc2js_ext.dats"
//
(* ****** ****** *)
//
datatype
comarg_ =
//
| COMARGstrlit_ of chmsg(string)
//
| COMARGstrinp_ of chmsg(string)
//
| COMARGprefil_ of chmsg(string)
| COMARGpostfil_ of chmsg(string)
//
typedef comarglst = list0(comarg)
//
(* ****** ****** *)
//
abstype emcc_int
abstype emcc_string
//
abstype emcc_comarg
abstype emcc_comarglst
//
(* ****** ****** *)
//
extern
castfn emcc_int(x: int): emcc_int
extern
castfn un_emcc_int(x: emcc_int): int
//
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
un_emcc_string(ptr) { return Pointer_stringify(ptr); }
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
un_emcc_string(emcc_string): string = "mac#un_emcc_string"
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
extern
fun
emcc_comarg
  (arg: comarg): emcc_comarg = "mac#emcc_comarg"
extern
fun
emcc_comarglst
  (args: comarglst): emcc_comarglst = "mac#emcc_comarglst"
//
(* ****** ****** *)
//
implement
emcc_comarg(arg) =
(
case+ arg of
| COMARGstrlit(x) => _comarg_strlit(emcc_string(x))
| COMARGstrinp(x) => _comarg_strinp(emcc_string(x))
| COMARGprefil(x) => _comarg_prefil(emcc_string(x))
| COMARGpostfil(x) => _comarg_postfil(emcc_string(x))
)
//
implement
emcc_comarglst(args) =
(
case+ args of
| list0_nil() =>
    _comarglst_nil()
| list0_cons(arg, args) =>
    _comarglst_cons(emcc_comarg(arg), emcc_comarglst(args))
)
//
(* ****** ****** *)
//
implement
chmsg_parse<comarg>(arg) = let
//
val xs =
  $UN.cast{JSarray(JSobj)}(arg)
val () =
  (xs[0] := $extfcall(JSobj, "parseInt", xs[0]))
//
val arg_ = $UN.cast{comarg_}(arg)
//
in
//
case+ arg_ of
//
| COMARGstrlit_(x) => COMARGstrlit(chmsg_parse(x))
| COMARGstrinp_(x) => COMARGstrinp(chmsg_parse(x))
| COMARGprefil_(x) => COMARGprefil(chmsg_parse(x))
| COMARGpostfil_(x) => COMARGpostfil(chmsg_parse(x))
//
end // end of [chmsg_parse]

(* ****** ****** *)
//
extern
fun
atscc2js_main0_arglst
  (emcc_comarglst): emcc_int
  = "mac#_libatscc2js_atscc2js_main0_arglst"
//
extern
fun
my_atscc2jsres_main_arglst
  (args: comarglst): atscc2jsres
//
implement
my_atscc2jsres_main_arglst
  (args) = let
//
val () =
$extfcall(void, "_libatscc2js_dynload")
//
in
//
case+ args of
| list0_nil() =>
    ATSCC2JSRES(0, "", "")
  // list0_nil
| list0_cons _ => let
    val
    args = emcc_comarglst(args)
    val
    nerr = atscc2js_main0_arglst(args)
    val
    stdout =
    $extfcall
      (string, "libatscc2js_stdout_store_join")
    // end of [val]
    val
    stderr =
    $extfcall
      (string, "libatscc2js_stderr_store_join")
    // end of [val]
  in
    ATSCC2JSRES(un_emcc_int(nerr), stdout, stderr)
  end // end of [list0_cons]
//
end (* end of [my_atscc2jsres_main_arglst] *)
//
(* ****** ****** *)
//
local
//
implement
{a}{b}
rpc_server_cont
  (chp, f) = chanpos0_close(chp)
//
in
//
val
chp = $UN.cast{chanpos()}(0)
//
val () =
chanpos0_send
( chp, 0
, lam(chp) =>
  rpc_server<comarglst><atscc2jsres>
    (chp, lam(args) =<cloref1> my_atscc2jsres_main_arglst(args))
  // end of [rpc_server] // end of [lam]
) (* end of [chanpos_send] *)
//
end // end of [local]

(* ****** ****** *)

%{$
//
function
the_libatscc2js_main() { return the_libatscc2js_worker_start(); }
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [libatscc2js_worker.dats] *)

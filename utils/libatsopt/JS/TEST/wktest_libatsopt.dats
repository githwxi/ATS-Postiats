(*
** A wrapper for patsopt
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"wktest_libatsopt_dynload"
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME\
/contrib/libatscc2js/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
staload
"{$LIBATSCC2JS}/DATS/Worker/channel.dats"
#include
"{$LIBATSCC2JS}/DATS/Worker/channeg.dats"
//
(* ****** ****** *)
//
(*
staload
"./../../DATS/libatsopt_ext.dats"
*)
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
datatype
patsoptres =
PATSOPTRES of
(
  int(*nerr*), string(*stdout*), string(*stderr*)
) (* end of [patsoptres] *)
//
(* ****** ****** *)

datatype
patsoptres_ =
PATSOPTRES_ of
(
  chmsg(int)(*nerr*)
, chmsg(string)(*stdout*), chmsg(string)(*stderr*)
)

(* ****** ****** *)

implement
chmsg_parse<patsoptres>
  (arg) = let
//
  val
  arg_ =
  $UN.cast{patsoptres_}(arg)
//
  val+
  PATSOPTRES_
    (nerr, stdout, stderr) = arg_
//
  val nerr = chmsg_parse<int>(nerr)
  val stdout = chmsg_parse<string>(stdout)
  val stderr = chmsg_parse<string>(stderr)
in
  PATSOPTRES(nerr, stdout, stderr)
end // end of [chmsg_parse<patsoptres>]

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

extern
fun
theExample_patsopt_getarg
  ((*void*)): comarglst1
//
implement
theExample_patsopt_getarg
  ((*void*)) = let
//
val
arglst = list_nil((*void*))
//
val
comarg =
COMARGstrinp
  (theExample_dats_get_value())
val
arglst = list_cons(comarg, arglst)
//
val
comarg =
COMARGprefil
(
  "#include \"share/atspre_staload.hats\""
)
val
arglst = list_cons(comarg, arglst)
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
typedef res = comarglst1
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
    COMARGstrlit(optarr[n])
  // end of [val]
in
  aux(n, list_cons{comarg}(x, xs))
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
(
  arglst: comarglst1
, fpost: (int) -<cloref1> void
) : void // end-of-function
//
implement
theExample_patsopt_arglst
  (args, fpost) = () where
{
//
val
chn =
channeg0_new_file
(
  "./libatsopt_ext_worker.js"
) (* end of [val] *)
//
(*
val () = alert("Worker is ready!")
*)
//
val () =
channeg0_send{int}
(
chn
,
lam(chn, res) =>
// theWorker is ready
channeg0_recv{comarglst1}
(
chn
,
args
,
lam(chn) =>
channeg0_send{patsoptres}
(
chn
,
lam(chn, res) => let
//
val
res =
chmsg_parse<patsoptres>(res)
//
val () = channeg0_close(chn)
//
val+
PATSOPTRES
  (nerr, stdout, stderr) = res
// end of [val]
(*
val () = alert("nerr = " + String(nerr))
*)
val () =
  if (nerr = 0)
    then theExample_dats_c_set_value(stdout)
  // end of [if]
val () =
  if (nerr > 0)
    then theExample_dats_c_set_value(stderr)
   // end of [if]
//
in
  fpost(nerr) // for the post action
end // end of [lam]
) (* send{patsoptres} *)
) (* recv{comarglst1} *)
) (* channeg_send{int} *)
//
} (* end of [theExample_patsopt_arglst] *)
//
(* ****** ****** *)
//
extern
fun
theExample_patsopt_onclick(): void = "mac#"
//
implement
theExample_patsopt_onclick() = let
//
val args = theExample_patsopt_getarg()
//
fun
fpost(nerr: int): void =
(
case+ nerr of
//
| 0 => alert("Patsopt finished normally!")
//
| 1 => alert("Patsopt encountered an error!")
//
| _ when nerr >= 2 => alert("Patsopt encountered some errors!")
//
| _ => ((*unused*))
) (* end of [fpost] *)
//
in
  theExample_patsopt_arglst(args, lam(nerr) => fpost(nerr))
end // end of [theExample_patsopt_onclick]

(* ****** ****** *)

%{$
//
function
the_libatsopt_main()
{
  jQuery(document).ready(function(){wktest_libatsopt_dynload();});
}
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [wktest_libatsopt.dats] *)

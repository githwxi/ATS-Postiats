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
staload
"./../../SATS/libatsopt_ext.sats"
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
extern
fun
theExample_button_onclick
  (args: comarglst1, fpost: (int) -<cloref1> void): void
//
(* ****** ****** *)
//
implement
theExample_button_onclick
  (args, fpost) = () where
{
//
val
chn =
channeg_new_file
(
  "./libatsopt_ext_worker.js"
) (* end of [val] *)
//
(*
val () = alert("Worker is ready!")
*)
//
val () =
channeg_send{int}
(
chn
,
lam(chn, res) =>
// theWorker is ready
channeg_recv{comarglst1}
(
chn
,
args
,
lam(chn) =>
channeg_send{patsoptres}
(
chn
,
lam(chn, res) => let
//
val
res =
chmsg_parse<patsoptres>(res)
//
val () = channeg_close(chn)
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
} (* end of [theExample_button_onclick] *)
//
(* ****** ****** *)
//
extern
fun
theExample_button_cc_onclick
  ((*void*)): void = "mac#"
//
implement
theExample_button_cc_onclick
  () = let
//
val arg1 =
  COMARGstrlit("--dynamic")
val arg2 =
  COMARGstrinp(theExample_dats_get_value())
//
val arglst = list_nil()
val arglst = list_cons(arg2, arglst)
val arglst = list_cons(arg1, arglst)
//
fun
fpost(nerr: int) =
(
case+ nerr of
| 0 => ()
| 1 => alert("An error is found!")
| _ when nerr >= 2 => alert("Some errors are found!")
| _ => ((*unused*))
) (* end of [fpost] *)
//
in
  theExample_button_onclick(arglst, lam(nerr) => fpost(nerr))
end // end of [theExample_button_cc_onclick]
//
(* ****** ****** *)
//
extern
fun
theExample_button_tc_onclick
  ((*void*)): void = "mac#"
//
implement
theExample_button_tc_onclick
  () = let
//
val arg0 =
  COMARGstrlit("-tc")
val arg1 =
  COMARGstrlit("--dynamic")
val arg2 =
  COMARGstrinp(theExample_dats_get_value())
//
val arglst = list_nil()
val arglst = list_cons(arg2, arglst)
val arglst = list_cons(arg1, arglst)
val arglst = list_cons(arg0, arglst)
//
fun
fpost(nerr: int) =
(
case+ nerr of
| 0 => alert("Well-typed!")
| 1 => alert("An error is found!")
| _ when nerr >= 2 => alert("Some errors are found!")
| _ => ((*unused*))
) (* end of [fpost] *)
//
in
  theExample_button_onclick(arglst, lam(nerr) => fpost(nerr))
end (* end of [theExample_button_tc_onclick] *)

(* ****** ****** *)

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

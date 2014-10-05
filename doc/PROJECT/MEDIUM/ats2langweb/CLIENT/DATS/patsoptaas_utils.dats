(*
//
// Utilities
// for patsoptaas
//
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: September, 2014
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "Patsoptaas_"
#define
ATS_STATIC_PREFIX "Patsoptaas_"

(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
staload "./../SATS/atslangweb.sats"
//
(* ****** ****** *)
//
staload _(*anon*) = "./patsopt_tcats.dats"
staload _(*anon*) = "./patsopt_atscc2js.dats"
//
(* ****** ****** *)
//
extern
fun
thePatsopt_source_get(): string = "mac#%"
extern
fun
thePatsopt_source_set(string): void= "mac#%"
//
%{^
function
Patsoptaas_thePatsopt_source_get()
{
//
return ace.edit("thePage2RBody").getSession().getValue();
//
} // end of [Patsoptaas_thePatsopt_source_get]
//
%} // end o [%{^]
//
(* ****** ****** *)
//
extern
fun
thePatsopt_output_get(): string = "mac#%"
extern
fun
thePatsopt_output_set(string): void= "mac#%"
//
%{^
//
var
Patsoptaas_thePatsopt_output_var = "**EMPTY**";
//
function
Patsoptaas_thePatsopt_output_get()
{
//
return Patsoptaas_thePatsopt_output_var;
//
} // end of [Patsoptaas_thePatsopt_output_get]
//
function
Patsoptaas_thePatsopt_output_set(str)
{
/*
alert
(
  "Patsoptaas_thePatsopt_output_set:\n" + str
); // end of [alert]
*/
Patsoptaas_thePatsopt_output_var = str; return;
//
} // end of [Patsoptaas_thePatsopt_output_set]
//
%} // end o [%{^]
//
(* ****** ****** *)
//
extern
fun
thePatsopt2js_output_get(): string = "mac#%"
extern
fun
thePatsopt2js_output_set(string): void= "mac#%"
//
%{^
//
var
Patsoptaas_thePatsopt2js_output_var = "";
//
function
Patsoptaas_thePatsopt2js_output_get()
{
//
return Patsoptaas_thePatsopt2js_output_var;
//
} // end of [Patsoptaas_thePatsopt2js_output_get]
//
function
Patsoptaas_thePatsopt2js_output_set(str)
{
/*
alert
(
  "Patsoptaas_thePatsopt2js_output_set:\n" + str
); // end of [alert]
*/
Patsoptaas_thePatsopt2js_output_var = str; return;
//
} // end of [Patsoptaas_thePatsopt2js_output_set]
//
%} // end o [%{^]
//
(* ****** ****** *)

extern
fun Compile_patsopt_reply(): void = "mac#%"
extern
fun Compile_patsopt_onclick(): void = "mac#%"

(* ****** ****** *)
//
extern
fun
Compile_patsopt2js_reply
  (reply: string): void = "mac#%"
//
extern
fun
Compile_patsopt2js_onclick(): void = "mac#%"
//
(* ****** ****** *)
//
%{^
//
function
Patsoptaas_Compile_patsopt2js_reply
  (reply)
{
  var comparr =
    JSON.parse(decodeURIComponent(reply));
  // end of [var]
  if(comparr[0]===0)
  {
    Patsoptaas_thePatsopt2js_output_set(comparr[1]);
    if(Patsoptaas_Patsopt2js_eval_flag()) eval(comparr[1]);
  }
  if(comparr[0] > 0)
  {
    alert("Patsoptaas: [Compile_patsopt2js] failed!");
  }
  return;
}
//
%} // end of [%{^]
//
implement
Compile_patsopt2js_onclick() = let
//
implement
patsopt_atscc2js_rpc$cname<> () =
  "SERVER/mycode/atslangweb_patsopt_atscc2js_0_.php"
//
implement
patsopt_atscc2js_rpc$reply<> (reply) = Compile_patsopt2js_reply (reply)
//
val mycode = thePatsopt_source_get ()
val ((*void*)) = patsopt_atscc2js_rpc (mycode)
//
in
  // nothing
end (* end of [Compile_patsopt2js_onclick] *)
//
(* ****** ****** *)
//
extern
fun
Evaluate_JS_onclick(): void = "mac#%"
//
%{^
//
function
Patsoptaas_Evaluate_JS_onclick()
{
//
  var
  mycode =
  Patsoptaas_thePatsopt2js_output_get();
//
  if(mycode)
  {
    eval(mycode);
  } else {
    alert("There is no generated JS code yet!");
  } // end of [if]
//
} // end of [Patsoptaas_Evaluate_JS_onclick]
//
%} // end of [%{^]
//
(* ****** ****** *)

(* end of [patsoptaas_utils.dats] *)

(*
//
// Various utilities
//
*)

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

#define ATS_EXTERN_PREFIX "atslangweb__"
#define ATS_STATIC_PREFIX "atslangweb__"

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
Home_hello_getval
  ((*void*)): string = "mac#"
extern
fun
Home_hello_reply
  (reply: string): void = "mac#"
//
extern
fun
Home_hello_onclick (): void = "mac#"
//
%{^
//
function
Home_hello_getval()
{
  return document.getElementById("hello_dats").value;
}
//
function
Home_hello_reply(reply)
{
  var comparr =
    JSON.parse(decodeURIComponent(reply));
  // end of [var]
  if (comparr[0]===0) eval(comparr[1]);
  if (comparr[0] > 0) alert("Compilation failed!");
  return;
}
//
%} // end of [%{^]
//
implement
Home_hello_onclick () = let
//
implement
patsopt_atscc2js_rpc$reply<>
  (reply) = Home_hello_reply (reply)
//
val mycode = Home_hello_getval ()
val ((*void*)) = patsopt_atscc2js_rpc (mycode)
//
in
  // nothing
end (* end of [HOME_hello_onclick] *)
//
(* ****** ****** *)
//
extern
fun
Home_listsub_getval
  ((*void*)): string = "mac#"
//
extern
fun
Home_listsub_reply
  (reply: string): void = "mac#"
//
extern
fun
Home_listsub_onclick (): void = "mac#"
//
%{^
//
function
Home_listsub_getval()
{
  return document.getElementById("listsub_dats").value;
}
//
function
Home_listsub_reply(reply)
{
  var comparr =
    JSON.parse(decodeURIComponent(reply));
  // end of [var]
  if (comparr[0]===0) alert ("Typechecking passed!");
  if (comparr[0] > 0) alert ("Typechecking failed!");
  return;
}
//
%} // end of [%{^]
//
implement
Home_listsub_onclick () = let
//
implement
patsopt_tcats_rpc$reply<>
  (reply) = Home_listsub_reply (reply)
//
val mycode = Home_listsub_getval ()
val ((*void*)) = patsopt_tcats_rpc (mycode)
//
in
  // nothing
end (* end of [HOME_listsub_onclick] *)
//
(* ****** ****** *)

(* end of [atslangweb_utils.dats] *)

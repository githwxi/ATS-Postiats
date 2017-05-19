(*
** For sending code to the server and
** then receiving the output from the
** server that syntax-hilites the sent code.
*)

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
staload
"{$LIBATSCC2JS}/SATS/Ajax/Ajax.sats"
//
(* ****** ****** *)
//
%{^
//
function
pats2xhtmlize_srcdoc_getsrc
  (srcdoc)
  { return srcdoc.textContent; }
//
function
pats2xhtmlize_srcdoc_update
  (srcdoc, resp)
  { return srcdoc.innerHTML = resp; }
//
%} (* end of [{%^] *)
//
extern
fun
pats2xhtmlize_srcdoc_getsrc
  (srcdoc: XMLDOC): string(*code*) = "mac#"
//
extern
fun
pats2xhtmlize_srcdoc_update
  (srcdoc: XMLDOC, resp: string): void = "mac#"
//
(* ****** ****** *)
//
%{^
//
function
pats2xhtmlize_waiting
  (srcdoc)
{
  var
  prompt = "<pre>Waiting...</pre>";
  return pats2xhtmlize_srcdoc_update(srcdoc, prompt);
} /* pats2xhtmlize_waiting */
//
function
pats2xhtmlize_do_response
(
  srcdoc, mycode, resp
) {
  var
  resparr =
  JSON.parse(decodeURIComponent(resp));
/*
  alert(resparr);
  alert(resparr[0]);
  alert(resparr[1]);
*/
//
  if(resparr[0]>0){
//
// HX-2016-07-25:
// Displaying the original source code in case of error:
//
    resparr[1] = "<pre>"+mycode+"</pre>";
  } /* end of [if] */
//
  return pats2xhtmlize_srcdoc_update(srcdoc, resparr[1]);
//
} /* pats2xhtmlize_do_response */
//
%} (* end of [%{^] *)
//
extern
fun
pats2xhtmlize_waiting
(
  srcdoc: XMLDOC, msg: string
) : void = "mac#" // end-of-fun
//
extern
fun
pats2xhtmlize_do_response
(
  srcdoc: XMLDOC, mycode: string, resp: string
) : void = "mac#" // end-of-fun
//
(* ****** ****** *)
//
extern
fun
pats2xhtmlize_eval
(
  stadyn: int, srcdoc: XMLDOC, code: string
) : void = "mac#" // end-of-function
//
(* ****** ****** *)

implement
pats2xhtmlize_eval
(
  stadyn, srcdoc, code
) = let
//
val
mycode =
pats2xhtmlize_srcdoc_getsrc(srcdoc)
//
val () =
pats2xhtmlize_waiting(srcdoc, "Waiting...")
//
val
xmlhttp =
XMLHttpRequest_new()
//
val ((*void*)) =
xmlhttp.onreadystatechange
(
lam((*void*)) =>
if (
xmlhttp.is_ready_okay()
) then
  pats2xhtmlize_do_response(srcdoc, mycode, xmlhttp.responseText())
// end of [if]
// end of [lam]
) (* xmlhttp.onreadystatechange *)
//
val
service_url =
(
"http://www.ats-lang.org/SERVER/MYCODE/atslangweb_pats2xhtml_eval_0_.php"
) (* service_url *)
//
val
((*void*)) =
xmlhttp.open
(
  "POST", service_url, true(*async*)
) (* xmlhttp.open *)
//
val
((*void*)) =
xmlhttp.setRequestHeader
(
  "Content-type", "application/x-www-form-urlencoded"
) (* xmlhttp.setRequestHeader *)
//
val
((*void*)) =
xmlhttp.send
(
  "stadyn="+String(stadyn)+"&"+"mycode="+encodeURIComponent(code)
) (* xmlhttp.send *)
//
in
  // nothing
end // end of [pats2xhtmlize_eval]

(* ****** ****** *)
//
extern
fun
pats2xhtmlize_process_one
(
  stadyn: int, srcdoc: XMLDOC
) : void = "mac#" // end-of-fun
//
implement
pats2xhtmlize_process_one
  (stadyn, srcdoc) =
(
//
pats2xhtmlize_eval
  (stadyn, srcdoc, pats2xhtmlize_srcdoc_getsrc(srcdoc))
//
) (* end of [pats2xhtmlize_process_one] *)
//
(* ****** ****** *)

%{$
function
pats2xhtmlize_process_all()
{
//
$('*').each(
  function() {
    if(this.tagName==='SATS2XHTML')pats2xhtmlize_process_one(0, this);
    if(this.tagName==='DATS2XHTML')pats2xhtmlize_process_one(1, this);return;
  } /* function */
) /* end of [each] */
//
} /* pats2xhtmlize_process_all */
%} (* end of [%{^] *)

(* ****** ****** *)

(* end of [pats2xhtmlize.dats] *)

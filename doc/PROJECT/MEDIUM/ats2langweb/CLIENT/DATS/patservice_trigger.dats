(*
//
// HX-2016-08-01:
// For triggering a pats-service
//
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "atslangweb_"
#define
ATS_STATIC_PREFIX "_atslangweb_patservice__"
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
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

#staload "./../SATS/atslangweb.sats"

(* ****** ****** *)
//  
extern
fun{}
thePreamble_atsccomp(): string
implement
{}(*tmp*)
thePreamble_atsccomp() = "\n\
#include\"share/atspre_define.hats\"\n\
#include\"share/atspre_staload.hats\"\n\
#include\"share/HATS/atspre_staload_libats_ML.hats\"\n\
" (* thePreamble_atscc2js *)
//
(* ****** ****** *)
//  
extern
fun{}
thePreamble_atscc2js(): string
implement
{}(*tmp*)
thePreamble_atscc2js() = "\n\
//\n\
#define\n\
LIBATSCC2JS_targetloc\n\
\"$PATSHOME\\\n\
/contrib/libatscc2js/ATS2-0.3.2\"\n\
//
#include\"{$LIBATSCC2JS}/staloadall.hats\"\n\
" (* thePreamble_atscc2js *)
//
(* ****** ****** *)
//
extern
fun{}
patservice_getval
  (key: string): string = "mac#%"
//
(* ****** ****** *)
//
extern
fun{}
patservice_prompt
(
 key: string, msg: string
) : void = "mac#%" // end-of-fun
//
implement
{}(*tmp*)
patservice_prompt(key, msg) = ()
//
(* ****** ****** *)
//
extern
fun{}
patservice_do_reply
(
  key: string, reply: string
) : void = "mac#%" // end-of-fun
//
implement
{}(*tmp*)
patservice_do_reply
  (key, reply) = () where
{
  val () = alert("reply(" + key + ") = " + reply)
} (* end of [patservice_do_reply] *)
//
(* ****** ****** *)
//
extern
fun{}
patservice_patsopt_tcats
  (key: string): void = "mac#%"
//
implement
{}(*tmp*)
patservice_patsopt_tcats
  (key) = ((*void*)) where
{
//
implement
patsopt_tcats_rpc$cname<>() =
(
"http://www.ats-lang.org/SERVER/MYCODE/atslangweb_patsopt_tcats_0_.php"
)
implement
patsopt_tcats_rpc$reply<>(reply) =
  patservice_do_reply<>(key, reply)
//
val mycode = patservice_getval<>(key)
val ((*void*)) = patsopt_tcats_rpc<>(mycode)
//
val ((*void*)) =
(
  patservice_prompt<>(key, "Patsopt-tc: waiting...")
) (* end of [val] *)
//
} (* end of [patservice_patsopt_tcats] *)
//
(* ****** ****** *)
//
extern
fun{}
patservice_patsopt_ccats
  (key: string): void = "mac#%"
//
implement
{}(*tmp*)
patservice_patsopt_ccats
  (key) = ((*void*)) where
{
//
implement
patsopt_ccats_rpc$cname<>() =
(
"http://www.ats-lang.org/SERVER/MYCODE/atslangweb_patsopt_ccats_0_.php"
)
implement
patsopt_ccats_rpc$reply<>(reply) =
  patservice_do_reply<>(key, reply)
//
val mycode = patservice_getval<>(key)
val ((*void*)) = patsopt_ccats_rpc<>(mycode)
//
val ((*void*)) =
(
  patservice_prompt<>(key, "Patsopt-cc: waiting...")
) (* end of [val] *)
//
} (* end of [patservice_patsopt_ccats] *)
//
(* ****** ****** *)
//
extern
fun{}
patservice_patsopt_cc2js
  (key: string): void = "mac#%"
//
implement
{}(*tmp*)
patservice_patsopt_cc2js
  (key) = ((*void*)) where
{
//
implement
patsopt_atscc2js_rpc$cname<>() =
(
"http://www.ats-lang.org/SERVER/MYCODE/atslangweb_patsopt_atscc2js_0_.php"
)
implement
patsopt_atscc2js_rpc$reply<>(reply) =
  patservice_do_reply<>(key, reply)
//
val mycode = patservice_getval<>(key)
val ((*void*)) = patsopt_atscc2js_rpc<>(mycode)
//
val ((*void*)) =
(
  patservice_prompt<>(key, "Patsopt-cc2js: waiting...")
) (* end of [val] *)
//
} (* end of [patservice_patsopt_atscc2js] *)
//
(* ****** ****** *)
//
extern
fun{}
patservice_pats2xhtml_eval
  (key: string): void = "mac#%"
//
implement
{}(*tmp*)
patservice_pats2xhtml_eval
  (key) = ((*void*)) where
{
//
implement
pats2xhtml_eval_rpc$cname<>() =
(
"http://www.ats-lang.org/SERVER/MYCODE/atslangweb_pats2xhtml_eval_0_.php"
)
implement
pats2xhtml_eval_rpc$reply<>(reply) =
  patservice_do_reply<>(key, reply)
//
val mycode = patservice_getval<>(key)
val ((*void*)) = pats2xhtml_eval_rpc<>(1(*dyn*), mycode)
//
} (* end of [patservice_pats2xhtml_eval] *)
//
(* ****** ****** *)

(* end of [patservice_trigger.dats] *)

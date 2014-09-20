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
//
(* ****** ****** *)
//
extern
fun
Home_hello_onclick (): void = "mac#%"
//
implement
Home_hello_onclick () = let
//
implement
patsopt_tcats_rpc$reply<>
  (reply) =
{
  val () = alert (reply)
} (* end of [patsopt_tcats_rpc$reply] *)
//
val code = "implement main () = 0"
val ((*void*)) = patsopt_tcats_rpc (code)
//
in
  // nothing
end (* end of [HOME_hello_onclick] *)
//
(* ****** ****** *)

(* end of [atslangweb_utils.dats] *)

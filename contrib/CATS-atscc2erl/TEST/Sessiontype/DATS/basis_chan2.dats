(* ****** ****** *)
//
// HX:
// For internal use:
// Un-session-typed channels
//
(* ****** ****** *)
//
// HX-2015-07:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "libats2erl_session_"
//
(* ****** ****** *)

absvtype chanpos2 = ptr
absvtype channeg2 = ptr

(* ****** ****** *)
//
extern
fun
chanpos2_send
  {a:vt0p}(chpos: !chanpos2, x: a): void = "mac#%"
and
channeg2_recv
  {a:vt0p}(chneg: !channeg2, x: a): void = "mac#%"
//
(* ****** ****** *)
//
extern
fun
chanpos2_recv{a:vt0p}(chpos: !chanpos2): (a) = "mac#%"
and
channeg2_send{a:vt0p}(chneg: !channeg2): (a) = "mac#%"
//
(* ****** ****** *)

(* end of [basis_chan2.dats] *)


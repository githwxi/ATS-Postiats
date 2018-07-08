(*
##
## ATS-extsolve-z3:
## Solving ATS-constraints with Z3
##
*)

(* ****** ****** *)
//
#ifdef
PATSOLVE_Z3_SOLVING
#then
#else
#include "./myheader.hats"
#endif // ifdef(PATSOLVE_Z3_SOLVING)
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

extern
fun
the_Z3_context_vget
(
// argumentless
) : (
  Z3_context -<prf> void | Z3_context
) = "ext#patsolve_the_Z3_context_vget"

(* ****** ****** *)

local
//
var
the_context : Z3_context
//  
val config = Z3_mk_config ()
(*
val config_ = $UN.castvwtp1{ptr}(config)
*)
//
val ((*void*)) =
(
  the_context :=
    Z3_mk_context_rc (config)
  // the_context
(*
  the_context := $extfcall(Z3_context, "Z3_mk_context", config_)
*)
) (* end of [val] *)
//
val ((*void*)) = Z3_del_config (config)
//
in
//
implement
the_Z3_context_vget
  ((*void*)) = let
//
prval fpf = __assert() where
{
  extern praxi __assert(): Z3_context -<prf> void
}
//
in
  (fpf | $UN.ptr0_get<Z3_context>(addr@the_context))
end // end of [the_Z3_context_vget]

end // end of [local]

(* ****** ****** *)

(* end of [patsolve_z3_solving_ctx.dats] *)

(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)

typedef
s2Var_struct = @{
  s2Var_stamp= stamp
} (* end of [s2Var_struct] *)

(* ****** ****** *)

local
//
assume
s2Var_type =
  ref (s2Var_struct)
//
in (* in-of-local *)

implement
s2Var_make(stamp) = let
//
val [l:addr] (
  pfat, pfgc | p
) = ptr_alloc<s2Var_struct> ()
//
val () = p->s2Var_stamp := stamp
//
in
  $UN.castvwtp0{s2Var}((pfat, pfgc | p))
end // end of [s2Var_make]

implement
s2Var_get_stamp (s2V) = !s2V.s2Var_stamp

end // end of [local]

(* ****** ****** *)
//
implement
fprint_s2Var
  (out, s2V) =
  fprint! (out, "s2Var(", s2V.stamp(), ")")
// end of [fprint_s2Var]
//
(* ****** ****** *)

(* end of [patsolve_cnstrnt_s2vvar.dats] *)

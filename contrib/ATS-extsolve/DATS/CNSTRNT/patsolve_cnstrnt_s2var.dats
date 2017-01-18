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
s2var_struct = @{
  s2var_srt= s2rt
, s2var_name= symbol
, s2var_stamp= stamp
//
, s2var_payload= ptr
//
} (* end of [s2var_struct] *)

(* ****** ****** *)

local
//
assume
s2var_type =
  ref (s2var_struct)
//
in (* in of [local] *)

implement
s2var_make
  (name, srt, stamp) = let
//
val [l:addr] (
  pfat, pfgc | p
) = ptr_alloc<s2var_struct> ()
//
val () = p->s2var_srt := srt
val () = p->s2var_name := name
val () = p->s2var_stamp := stamp
//
val () = p->s2var_payload := the_null_ptr
//
in
  $UN.castvwtp0{s2var}((pfat, pfgc | p))
end // end of [s2var_make]

(* ****** ****** *)
//
implement
s2var_get_srt (s2v) = !s2v.s2var_srt
//
implement
s2var_get_name (s2v) = !s2v.s2var_name
implement
s2var_get_stamp (s2v) = !s2v.s2var_stamp
//
(* ****** ****** *)
//
implement
s2var_is_impred
  (s2v) = s2rt_is_impred(!s2v.s2var_srt)
//
(* ****** ****** *)
//
implement
s2var_get_payload(s2v) = !s2v.s2var_payload
implement
s2var_set_payload(s2v, x) = (!s2v.s2var_payload := x)
//
(* ****** ****** *)

end // end of [local]

(* ****** ****** *)
//
implement
fprint_s2var
  (out, s2v) = fprint! (out, s2v.name())
// end of [fprint_s2var]
//
(*
implement
fprint_s2var
  (out, s2v) =
  fprint! (out, s2v.name(), "(", s2v.srt(), ")")
// end of [fprint_s2var]
*)
//
(* ****** ****** *)

(* end of [patsolve_cnstrnt_s2var.dats] *)

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
//
implement s2rt_int() = S2RTint()
implement s2rt_addr() = S2RTaddr()
implement s2rt_bool() = S2RTbool()
//
implement s2rt_real() = S2RTreal()
implement s2rt_float() = S2RTfloat()
implement s2rt_string() = S2RTstring()
//
(* ****** ****** *)

implement
s2rt_is_impred
  (s2t0) = (
//
case+ s2t0 of
//
| S2RTtype() => true
| S2RTvtype() => true 
//
| S2RTt0ype() => true
| S2RTvt0ype() => true
//
| S2RTprop() => true
| S2RTview() => true
//
| S2RTfun(_, s2t_res) => s2rt_is_impred(s2t_res)
//
| _(*rest-of-S2RT*) => false
//
) (* end of [s2rt_is_impred] *)

(* ****** ****** *)
//
implement
fprint_s2rt
  (out, s2t) =
(
//
case+ s2t of
//
| S2RTint() => fprint! (out, "S2RTint()")
| S2RTaddr() => fprint! (out, "S2RTaddr()")
| S2RTbool() => fprint! (out, "S2RTbool()")
//
| S2RTreal() => fprint! (out, "S2RTreal()")
| S2RTfloat() => fprint! (out, "S2RTfloat()")
| S2RTstring() => fprint! (out, "S2RTstring()")
//
| S2RTcls() => fprint! (out, "S2RTcls()")
| S2RTeff() => fprint! (out, "S2RTeff()")
//
| S2RTtup() => fprint! (out, "S2RTtup()")
//
| S2RTtype() => fprint! (out, "S2RTtype()")
| S2RTt0ype() => fprint! (out, "S2RTt0ype()")
//
| S2RTvtype() => fprint! (out, "S2RTvtype()")
| S2RTvt0ype() => fprint! (out, "S2RTvt0ype()")
//
| S2RTprop() => fprint! (out, "S2RTprop()")
| S2RTview() => fprint! (out, "S2RTview()")
//
| S2RTtkind() => fprint! (out, "S2RTtkind()")
//
| S2RTfun
    (s2ts_arg, s2t_res) =>
  fprint!
  ( out
  , "S2RTfun(", s2ts_arg, "; ", s2t_res, ")"
  ) (* end of [S2RTfun] *)
//
| S2RTnamed
    (sym) =>
    fprint! (out, "S2RTnamed(", sym, ")")
  // end of [S2RTnamed]
//
| S2RTerror
    ((*void*)) => fprint! (out, "S2RTerror()")
//
) (* end of [fprint_s2rt] *)
//
(* ****** ****** *)

typedef
s2rtdat_struct = @{
//
  s2rtdat_name= symbol
, s2rtdat_stamp= stamp
, s2rtdat_sconlst= List0 (s2cst)
//
} (* end of [s2rtdat_struct] *)

(* ****** ****** *)

local
//
assume
s2rtdat_type =
  ref (s2rtdat_struct)
//
in (* in of [local] *)

implement
s2rtdat_make
  (name, stamp, s2cs) = let
//
val [l:addr] (
  pfat, pfgc | p
) = ptr_alloc<s2rtdat_struct> ()
//
val () = p->s2rtdat_name := name
val () = p->s2rtdat_stamp := stamp
val () = p->s2rtdat_sconlst := s2cs
//
in
  $UN.castvwtp0{s2rtdat}((pfat, pfgc | p))
end // end of [s2rtdat_make]

implement
s2rtdat_get_name (s2td) = !s2td.s2rtdat_name
implement
s2rtdat_get_stamp (s2td) = !s2td.s2rtdat_stamp
implement
s2rtdat_get_sconlst (s2td) = !s2td.s2rtdat_sconlst

end // end of [local]

(* ****** ****** *)
//
implement
fprint_s2rtdat
  (out, s2td) = let
//
val name = s2rtdat_get_name(s2td)
val s2cs = s2rtdat_get_sconlst(s2td)
//
in
  fprint_symbol(out, name); fprint! (out, "(", s2cs, ")")
end // end of [fprint_s2rtdat]
//
(* ****** ****** *)

(* end of [patsolve_cnstrnt_s2rt.dats] *)

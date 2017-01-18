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

implement
fprint_s3itm
  (out, s3i) =
(
//
case s3i of
| S3ITMsvar(s2v) => fprint! (out, "S3ITMsvar(", s2v, ")")
| S3ITMsVar(s2V) => fprint! (out, "S3ITMsVar(", s2V, ")")
//
| S3ITMhypo(h3p) => fprint! (out, "S3ITMhypo(", h3p, ")")
//
| S3ITMcnstr(c3t) => fprint! (out, "S3ITMcnstr(", c3t, ")")
| S3ITMcnstr_ref(loc, opt) => fprint! (out, "S3ITMcnstr_ref(", opt, ")")
//
| S3ITMdisj(s3iss) => fprint! (out, "S3ITMdisj(", s3iss, ")")
//
| S3ITMsolassert(s2e_prop) => fprint! (out, "S3ITMsolassert(", s2e_prop, ")")
//
) (* end of [fprint_s3itm] *)

(* ****** ****** *)
//
implement
fprint_s3itmlst
  (out, xs) = fprint_list_sep (out, xs, ", ")
//
(* ****** ****** *)
//
implement
fprint_s3itmlstlst
  (out, xss) = fprint_listlist_sep (out, xss, "; ", ", ")
//
(* ****** ****** *)

(* end of [patsolve_cnstrnt_s3itm.dats] *)

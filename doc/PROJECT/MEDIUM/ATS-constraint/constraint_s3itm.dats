(*
** ATS constaint-solving
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

implement
fprint_s3itm
  (out, s3i0) = let
in
//
case+ s3i0 of
//
| S3ITMsvar (s2v) =>
    fprint! (out, "S3ITMsvar(", s2v, ")")
//
| S3ITMhypo (h3p) =>
    fprint! (out, "S3ITMhypo(", h3p, ")")
//
| S3ITMsVar (s2V) =>
    fprint! (out, "S3ITMsVar(", s2V, ")")
//
| S3ITMcnstr (c3t) =>
    fprint! (out, "S3ITMcnstr(", c3t, ")")
//
| S3ITMcnstr_ref
    (loc, opt) => fprint! (out, "S3ITMcnstr_ref(", opt, ")")
//
| S3ITMdisj (s3iss) => fprint! (out, "S3ITMdisj(...)")
//
end // end of [fprint_s3itm]

(* ****** ****** *)

implement
fprint_s3itmlst (out, s3is) = let
//
implement
fprint_val<s3itm> (out, x) = fprint_s3itm (out, x)
//
in
  fprint_list_sep (out, s3is, ", ")
end // end of [fprint_s3itmlst]

(* ****** ****** *)

(* end of [constraint_s3itm.dats] *)

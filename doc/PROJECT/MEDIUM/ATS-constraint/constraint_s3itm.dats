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
s3itm_s2var (s2v) = S3ITMsvar (s2v)
implement
s3itm_h3ypo (h3p) = S3ITMhypo (h3p)
implement
s3itm_cnstr (c3t) = S3ITMcnstr (c3t)

(* ****** ****** *)

implement
s3itm_disj (s3iss) = S3ITMdisj (s3iss)

(* ****** ****** *)

(* end of [constraint_s3itm.dats] *)

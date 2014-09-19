(*
** Parsing constraints in JSON format
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "./../constraint.sats"
//
(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload "./parsing.dats"

(* ****** ****** *)
//
extern
fun parse_S3ITMsvar (jsonval): s3itm
extern
fun parse_S3ITMhypo (jsonval): s3itm
extern
fun parse_S3ITMsVar (jsonval): s3itm
extern
fun parse_S3ITMcnstr (jsonval): s3itm
extern
fun parse_S3ITMcnstr_ref (jsonval): s3itm
extern
fun parse_S3ITMdisj (jsonval): s3itm
//
extern
fun parse_S3ITMignored (jsonval): s3itm
//
(* ****** ****** *)

implement
parse_s3itm
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_s3itm: jsv0 = ", jsv0)
*)
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
in
//
case+ lx.0 of
//
| "S3ITMsvar" => parse_S3ITMsvar (lx.1)
| "S3ITMhypo" => parse_S3ITMhypo (lx.1)
| "S3ITMsVar" => parse_S3ITMsVar (lx.1)
| "S3ITMcnstr" => parse_S3ITMcnstr (lx.1)
| "S3ITMcnstr_ref" => parse_S3ITMcnstr_ref (lx.1)
| "S3ITMdisj" => parse_S3ITMdisj (lx.1)
//
| _(*deadcode*) => parse_S3ITMignored (lx.1)
//
end // end of [parse_s3itm]

(* ****** ****** *)

implement
parse_s3itmlst
  (jsv0) = (
  parse_list<s3itm> (jsv0, parse_s3itm)
) (* end of [parse_s3itmlst] *)

(* ****** ****** *)

implement
parse_s3itmlstlst
  (jsv0) = (
  parse_list<s3itmlst> (jsv0, parse_s3itmlst)
) (* end of [parse_s3itmlstlst] *)

(* ****** ****** *)

implement
parse_S3ITMsvar
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2v = parse_s2var (jsvs[0])
//
in
  S3ITMsvar (s2v)
end // end of [parse_S3ITMsvar]

(* ****** ****** *)

implement
parse_S3ITMhypo
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val h3p = parse_h3ypo (jsvs[0])
//
in
  S3ITMhypo (h3p)
end // end of [parse_S3ITMhypo]

(* ****** ****** *)

implement
parse_S3ITMsVar
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2V = parse_s2Var (jsvs[0])
//
in
  S3ITMsVar (s2V)
end // end of [parse_S3ITMsVar]

(* ****** ****** *)

implement
parse_S3ITMcnstr
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val c3t = parse_c3nstr (jsvs[0])
//
in
  S3ITMcnstr (c3t)
end // end of [parse_S3ITMcnstr]

(* ****** ****** *)

implement
parse_S3ITMcnstr_ref
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val loc = parse_location (jsvs[0])
val opt = parse_c3nstropt (jsvs[1])
//
in
  S3ITMcnstr_ref (loc, opt)
end // end of [parse_S3ITMcnstr_ref]

(* ****** ****** *)

implement
parse_S3ITMdisj
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s3iss = parse_s3itmlstlst (jsvs[0])
//
in
  S3ITMdisj (s3iss)
end // end of [parse_S3ITMdisj]

(* ****** ****** *)
//
implement
parse_S3ITMignored (jsv0) =
  let val () = assertloc (false) in exit(1) end
//
(* ****** ****** *)

(* end of [parsing_s3itm.dats] *)

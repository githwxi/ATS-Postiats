(*
** Parsing: ATS/JSON -> UTFPL
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
staload "./../utfpl.sats"
//
(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload "./parsing.dats"

(* ****** ****** *)

extern
fun parse_d2exparg (jsonval): d2exparg

(* ****** ****** *)

extern fun parse_d2lab (jsonval): d2lab
extern fun parse_d2lab_node (jsonval): d2lab

(* ****** ****** *)
//
extern
fun
parse_d2exp_node (jsonval): d2exp_node
//
(* ****** ****** *)

implement
parse_d2exp
  (jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2exp_loc") 
val loc = parse_location (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2exp_node") 
val node = parse_d2exp_node (jsv)
//
in
  d2exp_make_node (loc, node)
end // end of [parse_d2exp]

(* ****** ****** *)
//
implement
parse_d2explst
  (jsv0) = (
  parse_list<d2exp> (jsv0, parse_d2exp)
) (* end of [parse_d2explst] *)
//
implement
parse_d2expopt
  (jsv0) = (
  parse_option<d2exp> (jsv0, parse_d2exp)
) (* end of [parse_d2expopt] *)
//
(* ****** ****** *)

extern
fun parse_D2Ecst (jsonval): d2exp_node
extern
fun parse_D2Evar (jsonval): d2exp_node
extern
fun parse_D2Esym (jsonval): d2exp_node

extern
fun parse_D2Eint (jsonval): d2exp_node
extern
fun parse_D2Eintrep (jsonval): d2exp_node

extern
fun parse_D2Ei0nt (jsonval): d2exp_node
extern
fun parse_D2Ec0har (jsonval): d2exp_node
extern
fun parse_D2Ef0loat (jsonval): d2exp_node
extern
fun parse_D2Es0tring (jsonval): d2exp_node

extern
fun parse_D2Eempty (jsonval): d2exp_node

extern
fun parse_D2Elet (jsonval): d2exp_node

extern
fun parse_D2Eapplst (jsonval): d2exp_node

extern
fun parse_D2Eifhead (jsonval): d2exp_node

extern
fun parse_D2Elist (jsonval): d2exp_node

extern
fun parse_D2Etup (jsonval): d2exp_node

extern
fun parse_D2Eseq (jsonval): d2exp_node

extern
fun parse_D2Eselab (jsonval): d2exp_node

extern
fun parse_D2Elam_dyn (jsonval): d2exp_node
extern
fun parse_D2Elam_sta (jsonval): d2exp_node

extern
fun parse_D2Eann_seff (jsonval): d2exp_node
extern
fun parse_D2Eann_type (jsonval): d2exp_node
extern
fun parse_D2Eann_funclo (jsonval): d2exp_node

extern
fun parse_D2Eignored (jsonval): d2exp_node

(* ****** ****** *)

implement
parse_d2exp_node
  (jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_d2exp_node: jsv0 = ", jsv0)
*)
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "D2Ecst" => parse_D2Ecst (jsv2)
| "D2Evar" => parse_D2Evar (jsv2)
| "D2Esym" => parse_D2Esym (jsv2)
//
| "D2Eint" => parse_D2Eint (jsv2)
| "D2Eintrep" => parse_D2Eintrep (jsv2)
//
| "D2Ei0nt" => parse_D2Ei0nt (jsv2)
| "D2Ec0har" => parse_D2Ec0har (jsv2)
| "D2Ef0loat" => parse_D2Ef0loat (jsv2)
| "D2Es0tring" => parse_D2Es0tring (jsv2)
//
| "D2Eempty" => parse_D2Eempty (jsv2)
//
| "D2Elet" => parse_D2Elet (jsv2)
//
| "D2Eapplst" => parse_D2Eapplst (jsv2)
//
| "D2Eifhead" => parse_D2Eifhead (jsv2)
//
| "D2Elist" => parse_D2Elist (jsv2)
//
| "D2Etup" => parse_D2Etup (jsv2)
| "D2Eseq" => parse_D2Eseq (jsv2)
//
| "D2Eselab" => parse_D2Eselab (jsv2)
//
| "D2Elam_dyn" => parse_D2Elam_dyn (jsv2)
| "D2Elam_sta" => parse_D2Elam_sta (jsv2)
//
| "D2Eann_seff" => parse_D2Eann_seff (jsv2)
| "D2Eann_type" => parse_D2Eann_type (jsv2)
| "D2Eann_funclo" => parse_D2Eann_funclo (jsv2)
//
| _(*rest*) => parse_D2Eignored (jsv2)
//
end // end of [parse_d2exp_node]

(* ****** ****** *)

implement
parse_D2Ecst
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2c = parse_d2cst (jsvs[0])
//
in
  D2Ecst (d2c)
end // end of [parse_D2Ecst]

(* ****** ****** *)

implement
parse_D2Evar
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2v = parse_d2var (jsvs[0])
//
in
  D2Evar (d2v)
end // end of [parse_D2Evar]

(* ****** ****** *)

implement
parse_D2Esym
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2s = parse_d2sym (jsvs[0])
//
in
  D2Esym (d2s)
end // end of [parse_D2Esym]

(* ****** ****** *)

implement
parse_D2Eint
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val int = parse_int (jsvs[0])
//
in
  D2Eint (int)
end // end of [parse_D2Eint]

implement
parse_D2Eintrep
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Eintrep (rep)
end // end of [parse_D2Eintrep]

(* ****** ****** *)

implement
parse_D2Ei0nt
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Ei0nt (rep)
end // end of [parse_D2Ei0nt]

(* ****** ****** *)

implement
parse_D2Ec0har
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val int = parse_int (jsvs[0])
//
in
  D2Ec0har (int2char0(int))
end // end of [parse_D2Ec0har]

(* ****** ****** *)

implement
parse_D2Ef0loat
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Ef0loat (rep)
end // end of [parse_D2Ef0loat]

(* ****** ****** *)

implement
parse_D2Es0tring
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Es0tring (rep)
end // end of [parse_D2Es0tring]

(* ****** ****** *)

implement
parse_D2Eempty
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
//
in
  D2Eempty ()
end // end of [parse_D2Eempty]

(* ****** ****** *)

implement
parse_D2Elet
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2cs = parse_d2eclist (jsvs[0])
val d2e_body = parse_d2exp (jsvs[1])
//
in
  D2Elet (d2cs, d2e_body)
end // end of [parse_D2Elet]

(* ****** ****** *)

implement
parse_D2Eapplst
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e_fun = parse_d2exp (jsvs[0])
val d2as_arg = parse_list<d2exparg> (jsvs[1], parse_d2exparg)
//
in
  D2Eapplst (d2e_fun, d2as_arg)
end // end of [parse_D2Eapplst]

(* ****** ****** *)

implement
parse_D2Eifhead
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 4)
//
val _test = parse_d2exp (jsvs[1])
val _then = parse_d2exp (jsvs[2])
val _else = parse_d2expopt (jsvs[3])
//
in
  D2Eifopt (_test, _then, _else)
end // end of [parse_D2Eifhead]

(* ****** ****** *)

implement
parse_D2Elist
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2es = parse_d2explst (jsvs[1])
//
in
  D2Elist (d2es)
end // end of [parse_D2Elist]

(* ****** ****** *)

implement
parse_D2Etup
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val d2es = parse_d2explst (jsvs[2])
//
in
  D2Etup (d2es)
end // end of [parse_D2Etup]

(* ****** ****** *)

implement
parse_D2Eseq
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2es = parse_d2explst (jsvs[0])
//
in
  D2Eseq (d2es)
end // end of [parse_D2Eseq]

(* ****** ****** *)

implement
parse_D2Eselab
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (jsvs[0])
val d2ls = parse_list<d2lab> (jsvs[1], parse_d2lab)
//
in
  D2Eselab (d2e, d2ls)
end // end of [parse_D2Eselab]

(* ****** ****** *)

implement
parse_D2Elam_dyn
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 4)
val p2ts = parse_p2atlst (jsvs[2])
val d2e_body = parse_d2exp (jsvs[3])
//
in
  D2Elam (p2ts, d2e_body)
end // end of [parse_D2Elam_dyn]

(* ****** ****** *)

implement
parse_D2Elam_sta
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val d2e = parse_d2exp (jsvs[2])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Elam_sta]

(* ****** ****** *)

implement
parse_D2Eann_seff
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_seff]

(* ****** ****** *)

implement
parse_D2Eann_type
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_type]

(* ****** ****** *)

implement
parse_D2Eann_funclo
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_funclo]

(* ****** ****** *)

implement
parse_D2Eignored (jsv) = D2Eignored ((*void*))

(* ****** ****** *)

implement
parse_d2exparg
  (jsv0) = let
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "D2EXPARGsta" => let
     val-JSONarray(jsvs) = jsv2
   in
     D2EXPARGsta ((*void*))
   end // end of [D2EXPARGsta]
| "D2EXPARGdyn" => let
     val-JSONarray(jsvs) = jsv2
     val () = assertloc (length(jsvs) >= 3)
     val npf = parse_int (jsvs[0])
     val loc = parse_location (jsvs[1])
     val d2es = parse_d2explst (jsvs[2])
   in
     D2EXPARGdyn (npf, loc, d2es)
   end // end of [D2EXPARGdyn]
//
| _ => let val () = assertloc (false) in exit(1) end
//
end // end of [parse_d2exparg]

(* ****** ****** *)

implement
parse_d2lab
  (jsv0) = let
//
(*
val-~Some_vt(jsv) =
  jsonval_get_field (jsv0, "d2lab_loc") 
val loc = parse_location (jsv)
*)
val-~Some_vt(jsv) =
  jsonval_get_field (jsv0, "d2lab_node") 
in
  parse_d2lab_node (jsv)
end // end of [parse_d2lab]

(* ****** ****** *)

implement
parse_d2lab_node
  (jsv0) = let
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "D2LABlab" => let
    val-JSONarray(jsvs) = jsv2
    val () = assertloc (length(jsvs) >= 1)
    val lab = parse_label (jsvs[0])
  in
    D2LABlab (lab)
  end // end of [D2LABlab]
| "D2LABind" => let
    val-JSONarray(jsvs) = jsv2
    val () = assertloc (length(jsvs) >= 1)
    val d2es = parse_d2explst (jsvs[0])
  in
    D2LABind (d2es)
  end // end of [D2LABin]
| _(*deadcode*) =>
    let val () = assertloc (false) in exit(1) end
//
end // end of [parse_d2lab_node]

(* ****** ****** *)

(* end of [parsing_d2exp.dats] *)

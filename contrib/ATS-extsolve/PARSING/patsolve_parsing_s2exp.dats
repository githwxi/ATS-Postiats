(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: May, 2015
*)

(* ****** ****** *)
//
extern
fun
parse_s2exp_node (jsonval): s2exp_node
//
(* ****** ****** *)

implement
parse_s2exp
  (jsnv0) = let
//
(*
val () =
println!
(
  "parse_s2exp: jsnv0 = ", jsnv0
) (* end of [val] *)
*)
//
val-JSONobject(lxs) = jsnv0
val () = assertloc(length(lxs) >= 2)
//
val+list_cons(lx, lxs) = lxs
val s2t = parse_s2rt (lx.1)
//
val+list_cons(lx, lxs) = lxs
val s2en = parse_s2exp_node (lx.1)
//
in
//
  s2exp_make_node (s2t, s2en)
//
end // end of [parse_s2exp]

(* ****** ****** *)

local

fun
aux_S2Eint
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  S2Eint(parse_int(x))
end (* end of [aux_S2Eint] *)

fun
aux_S2Eintinf
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  S2Eintinf(parse_string(x))
end (* end of [aux_S2Eintinf] *)

fun
aux_S2Ecst
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons(x, xs) = xs
//
val s2c = parse_s2cst(x)
//
in
  s2cst_incby1_nused(s2c); S2Ecst(s2c)
end (* end of [aux_S2Ecst] *)

fun
aux_S2Evar
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  S2Evar(parse_s2var(x))
end (* end of [aux_S2Evar] *)

fun
aux_S2EVar
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  S2EVar(parse_s2Var(x))
end (* end of [aux_S2EVar] *)

fun
aux_S2Eeqeq
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x_1, xs) = xs
val-list_cons (x_2, xs) = xs
//
in
  S2Eeqeq(parse_s2exp(x_1), parse_s2exp(x_2))
end (* end of [aux_S2Eeqeq] *)

fun
aux_S2Esizeof
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  S2Esizeof(parse_s2exp(x))
end (* end of [aux_S2Esizeof] *)

fun
aux_S2Eapp
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x_fun, xs) = xs
val-list_cons (x_arg, xs) = xs
//
in
  S2Eapp(parse_s2exp(x_fun), parse_s2explst(x_arg))
end (* end of [aux_S2Eapp] *)

fun
aux_S2Emetdec
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x_met, xs) = xs
val-list_cons (x_bound, xs) = xs
//
in
  S2Emetdec(parse_s2explst(x_met), parse_s2explst(x_bound))
end (* end of [aux_S2Emetdec] *)

fun
aux_S2Etop
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
val-list_cons (x2, xs) = xs
//
in
  S2Etop(parse_int(x1), parse_s2exp(x2))
end (* end of [aux_S2Etop] *)

fun
aux_S2Einvar
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  S2Einvar(parse_s2exp(x))
end (* end of [aux_S2Einvar] *)

fun
aux_S2Efun
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
val-list_cons (x2, xs) = xs
val-list_cons (x3, xs) = xs
//
in
  S2Efun(parse_int(x1), parse_s2explst(x2), parse_s2exp(x3))
end (* end of [aux_S2Efun] *)

fun
aux_S2Euni
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
val-list_cons (x2, xs) = xs
val-list_cons (x3, xs) = xs
//
in
  S2Euni(parse_s2varlst(x1), parse_s2explst(x2), parse_s2exp(x3))
end (* end of [aux_S2Euni] *)

fun
aux_S2Eexi
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
val-list_cons (x2, xs) = xs
val-list_cons (x3, xs) = xs
//
in
  S2Eexi(parse_s2varlst(x1), parse_s2explst(x2), parse_s2exp(x3))
end (* end of [aux_S2Eexi] *)

fun
aux_S2Etyrec
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
val-list_cons (x2, xs) = xs
val-list_cons (x3, xs) = xs
//
in
  S2Etyrec(parse_tyreckind(x1), parse_int(x2), parse_labs2explst(x3))
end (* end of [aux_S2Etyrec] *)

fun
aux_S2Eextype
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
//
in
  S2Eextype(parse_symbol(x1))
end (* end of [aux_S2Eextype] *)

fun
aux_S2Eextkind
(
  x0: jsonval
) : s2exp_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
//
in
  S2Eextkind(parse_symbol(x1))
end (* end of [aux_S2Eextkind] *)

in (* in-of-local *)

implement
parse_s2exp_node
  (jsnv0) = let
//
val-JSONobject(lxs) = jsnv0
//
val-list_cons (lx, lxs) = lxs
val name = lx.0 and jsnv2 = lx.1
//
in
//
case+ name of
//
| "S2Eint" => aux_S2Eint(jsnv2)
| "S2Eintinf" => aux_S2Eintinf(jsnv2)
//
| "S2Ecst" => aux_S2Ecst(jsnv2)
//
| "S2Evar" => aux_S2Evar(jsnv2)
//
| "S2EVar" => aux_S2EVar(jsnv2)
//
| "S2Eeqeq" => aux_S2Eeqeq(jsnv2)
//
| "S2Esizeof" => aux_S2Esizeof(jsnv2)
//
| "S2Eapp" => aux_S2Eapp(jsnv2)
//
| "S2Emetdec" => aux_S2Emetdec(jsnv2)
//
| "S2Etop" => aux_S2Etop(jsnv2)
//
| "S2Einvar" => aux_S2Einvar(jsnv2)
//
| "S2Efun" => aux_S2Efun(jsnv2)
//
| "S2Euni" => aux_S2Euni(jsnv2)
| "S2Eexi" => aux_S2Eexi(jsnv2)
//
| "S2Etyrec" => aux_S2Etyrec(jsnv2)
//
| "S2Eextype" => aux_S2Eextype(jsnv2)
| "S2Eextkind" => aux_S2Eextkind(jsnv2)
//
| "S2Eignored" => S2Eerror(*void*)
//
| _(*unrecognized*) => 
  let
    val () =
    prerrln!
      ("parse_s2exp_node: ", name)
    // end of [val]
    val ((*exit*)) = assertloc(false)
  in
    exit(1)
  end // end of [unrecognized]
//
end // end of [parse_s2exp_node]

end // end of [local]

(* ****** ****** *)

local

fun
aux_SLABELED
(
  x0: jsonval
) : labs2exp = let
//
(*
val () =
println!
(
  "parse_labs2exp: aux_SLABELED: x0 = ", x0
) (* end of [val] *)
*)
//
val-JSONarray(xs) = x0
val-list_cons (x1, xs) = xs
val-list_cons (x2, xs) = xs
val-list_cons (x3, xs) = xs
//
in
  SLABELED(parse_label(x1), parse_s2exp(x3))
end (* end of [aux_SLABELED] *)

in (* in-of-local *)

implement
parse_labs2exp
  (jsnv0) = let
//
val-JSONobject(lxs) = jsnv0
//
val-list_cons (lx, lxs) = lxs
val name = lx.0 and jsnv2 = lx.1
//
in
//
case+ name of
//
| "SL0ABELED" => aux_SLABELED(jsnv2)
//
| _(*unrecognized*) => 
  let
    val () =
    prerrln!
      ("parse_labs2exp: ", name)
    // end of [val]
    val ((*exit*)) = assertloc(false)
  in
    exit(1)
  end // end of [unrecognized]
//
end // end of [parse_labs2exp]

end // end of [local]

(* ****** ****** *)

(* end of [patsolve_parsing_s2exp.dats] *)

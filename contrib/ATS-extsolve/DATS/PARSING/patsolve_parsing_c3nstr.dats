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
parse_c3nstrkind (jsonval): c3nstrkind
//
(* ****** ****** *)
//
extern
fun
parse_c3nstr_node (jsonval): c3nstr_node
//
(* ****** ****** *)

implement
parse_c3nstr
  (jsnv0) = let
//
(*
val () =
println!
(
  "parse_c3nstr: jsnv0 = ", jsnv0
) (* end of [val] *)
*)
//
val-JSONobject(lxs) = jsnv0
val () = assertloc(length(lxs) >= 3)
//
val+list_cons(lx, lxs) = lxs
val loc = parse_location (lx.1)
//
val+list_cons(lx, lxs) = lxs
val c3tk = parse_c3nstrkind (lx.1)
//
val+list_cons(lx, lxs) = lxs
val node = parse_c3nstr_node (lx.1)
//
in
//
  c3nstr_make_node (loc, c3tk, node)
//
end // end of [parse_c3nstr]

(* ****** ****** *)

implement
parse_c3nstrkind
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
| "C3TKmain" => C3TKmain()
//
| "C3TKtermet_isnat" => C3TKtermet_isnat()
| "C3TKtermet_isdec" => C3TKtermet_isdec()
//
| "C3TKsolver" => C3TKsolver(parse_int(jsnv2))
//
| _(*rest-of-c3nstrkind*) => C3TKignored((*void*))
//
end // end of [parse_c3nstrkind]

(* ****** ****** *)

local

fun
aux_C3NSTRprop
(
  x0: jsonval
) : c3nstr_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  C3NSTRprop(parse_s2exp(x))
end (* aux_C3NSTRprop *)

fun
aux_C3NSTRitmlst
(
  x0: jsonval
) : c3nstr_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  C3NSTRitmlst(parse_s3itmlst(x))
end (* aux_C3NSTRitmlst *)

fun
aux_C3NSTRsolverify
(
  x0: jsonval
) : c3nstr_node = let
//
val-JSONarray(xs) = x0
val-list_cons (x, xs) = xs
//
in
  C3NSTRsolverify(parse_s2exp(x))
end (* aux_C3NSTRsolverify *)

in (* in-of-local *)

implement
parse_c3nstr_node
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
| "C3NSTRprop" => aux_C3NSTRprop(jsnv2)
//
| "C3NSTRitmlst" => aux_C3NSTRitmlst(jsnv2)
//
| "C3NSTRsolverify" => aux_C3NSTRsolverify(jsnv2)
//
| _(*unrecognized*) =>
   let val () = assertloc(false) in exit(1) end
//
end // end of [parse_c3nstr_node]

end // end of [local]

(* ****** ****** *)

(* end of [patsolve_parsing_c3nstr.dats] *)

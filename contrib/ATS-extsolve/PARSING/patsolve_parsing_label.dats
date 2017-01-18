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

implement
parse_label
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
| "LABint" => LABint(parse_int(jsnv2))
| "LABsym" => LABsym(parse_symbol(jsnv2))
//
| _(*unrecognized*) => 
  let
    val () =
    prerrln!
      ("parse_label: ", name)
    // end of [val]
    val ((*exit*)) = assertloc(false)
  in
    exit(1)
  end // end of [unrecognized]
//
end // end of [parse_label]

(* ****** ****** *)

(* end of [patsolve_parsing_label.dats] *)

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

local

fun
aux_S2RTbas
(
  x0: jsonval
) : s2rt = let
//
val-JSONarray(xs) = x0
val () =
  assertloc(length(xs) >= 1)
//
val-JSONstring(name) = xs[0]
//
(*
val () =
println!
  ("parse_s2rt: aux_S2RTbas: name = ", name)
*)
//
in
//
case+ name of
//
| "int" => S2RTint()
| "addr" => S2RTaddr()
| "bool" => S2RTbool()
//
| "real" => S2RTreal()
//
| "cls" => S2RTeff()
| "eff" => S2RTeff()
//
| "type" => S2RTtype()
| "t@ype" => S2RTt0ype()
| "t0ype" => S2RTt0ype()
//
| "viewtype" => S2RTvtype()
| "viewt@ype" => S2RTvt0ype()
| "viewt0ype" => S2RTvt0ype()
//
| "prop" => S2RTprop()
| "view" => S2RTview()
//
| "tkind" => S2RTtkind()
//
| _(*rest*) => S2RTnamed(symbol_make_name(name))
//
end // end of [aux_S2RTbas]

fun
aux_S2RTfun
(
  x0: jsonval
) : s2rt = let
//
val-JSONarray(xs) = x0
val () = assertloc (length(xs) >= 2)
//
val arg =
  parse_s2rtlst (xs[0])
//
val res = parse_s2rt (xs[1])
//
in
  S2RTfun (arg, res)
end // end of [aux_S2RTfun]

in (* in-of-local *)

implement
parse_s2rt
  (jsnv0) = let
//
val-
JSONobject(lxs) = jsnv0
//
val-
list_cons (lx, lxs) = lxs
//
in
//
case+ lx.0 of
//
| "S2RTbas" => aux_S2RTbas (lx.1)
//
| "S2RTfun" => aux_S2RTfun (lx.1)
//
| _(*rest-of-S2RT*) => S2RTerror((*void*))
//
end // end of [parse_s2rt]

end // end of [local]

(* ****** ****** *)

local
//
val
the_s2rtdatmap = ref<s2rtdatlst>(list_nil)
//
extern
fun
the_s2rtdatmap_set
  (s2rtdatlst): void = "ext#patsolve_the_s2rtdatmap_set"
//
in (* in-of-local *)

implement
the_s2rtdatmap_get() = !the_s2rtdatmap
implement
the_s2rtdatmap_set(s2tds) = !the_s2rtdatmap := s2tds

end // end of [local]

(* ****** ****** *)

implement
parse_s2rtdat
  (jsnv0) = let
//
val-
~Some_vt(x1) = jsnv0["s2rtdat_sym"]
val-
~Some_vt(x2) = jsnv0["s2rtdat_stamp"]
val-
~Some_vt(x3) = jsnv0["s2rtdat_sconlst"]
//
val name = parse_symbol (x1)
val stamp = parse_stamp (x2)
val s2cs0 = parse_s2cstlst (x3)
//
in
  s2rtdat_make(name, stamp, s2cs0)
end // end of [parse_s2rtdat]

(* ****** ****** *)

(* end of [patsolve_parsing_s2rt.dats] *)

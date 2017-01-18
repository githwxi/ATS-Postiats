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

typedef
key = stamp and itm = s2Var

in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)

local

val
the_s2Varmap =
myhashtbl_make_nil(1024)

in (* in-of-local *)
//
implement
the_s2Varmap_search(key) =
  myhashtbl_search(the_s2Varmap, key)
//
implement
the_s2Varmap_insert(s2V) =
{
//
val-
~None_vt() =
myhashtbl_insert(the_s2Varmap, s2V.stamp(), s2V)
//
} (* end of [the_s2Varmap_insert] *)
//
end // end of [local]

(* ****** ****** *)

implement
parse_s2Var
  (jsnv0) = let
//
val-
~Some_vt
  (jsnv) = jsnv0["s2Var_stamp"]
//
val stamp = parse_stamp (jsnv)
//
val s2Vopt = the_s2Varmap_search (stamp)
//
in
//
case+ s2Vopt of
| ~Some_vt(s2V) => s2V
| ~None_vt((*void*)) => s2V where
  {
//
    val-JSONobject(lxs) = jsnv0
    val () = assertloc(length(lxs) >= 2)
//
    val+list_cons(lx, lxs) = lxs
    val () = the_stamp_update (stamp)
//
    val s2V = s2Var_make (stamp)
    val ((*void*)) = the_s2Varmap_insert (s2V)
//
  } (* end of [None_vt] *)
//
end // end of [parse_s2Var]

(* ****** ****** *)

(* end of [patsolve_parsing_s2vvar.dats] *)

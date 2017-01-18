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
key = stamp and itm = s2var

in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)

local

val
the_s2varmap =
myhashtbl_make_nil(1024)

in (* in-of-local *)
//
implement
the_s2varmap_search(key) =
  myhashtbl_search(the_s2varmap, key)
//
implement
the_s2varmap_insert(s2v) =
{
//
val-
~None_vt() =
myhashtbl_insert(the_s2varmap, s2v.stamp(), s2v)
//
} (* end of [the_s2varmap_insert] *)
//
end // end of [local]

(* ****** ****** *)

implement
parse_s2var
  (jsnv0) = let
//
val-
~Some_vt
  (jsnv) = jsnv0["s2var_stamp"]
//
val stamp = parse_stamp(jsnv)
//
val s2vopt = the_s2varmap_search(stamp)
//
in
//
case+ s2vopt of
| ~Some_vt(s2v) => s2v
| ~None_vt((*void*)) => s2v where
  {
//
    val-JSONobject(lxs) = jsnv0
    val () = assertloc(length(lxs) >= 3)
//
    val+list_cons(lx, lxs) = lxs
    val sym = parse_symbol(lx.1)
//
    val+list_cons(lx, lxs) = lxs
    val s2t = parse_s2rt(lx.1)
//
    val+list_cons(lx, lxs) = lxs
    val () = the_stamp_update(stamp)
//
    val s2v = s2var_make(sym, s2t, stamp)
//
(*
    val ((*void*)) =
      println! ("parse_s2var: s2v = ", s2v)
    // end of [val]
*)
//
    val ((*void*)) = the_s2varmap_insert(s2v)
//
  } (* end of [None_vt] *)
//
end // end of [parse_s2var]

(* ****** ****** *)

(* end of [patsolve_parsing_s2var.dats] *)

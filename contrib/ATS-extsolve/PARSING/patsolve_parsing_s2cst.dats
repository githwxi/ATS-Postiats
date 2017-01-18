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
key = stamp and itm = s2cst

in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)

local

val
the_s2cstmap =
myhashtbl_make_nil(1024)

in (* in-of-local *)
//
implement
the_s2cstmap_search(key) =
  myhashtbl_search(the_s2cstmap, key)
//
implement
the_s2cstmap_insert(s2c) =
{
//
val-
~None_vt() =
myhashtbl_insert(the_s2cstmap, s2c.stamp(), s2c)
//
} (* end of [the_s2cstmap_insert] *)
//
implement
the_s2cstmap_listize
  ((*void*)) = let
//
vtypedef
res_vt = s2cstlst_vt
//
var res: res_vt =
  list_vt_nil((*void*))
val p_res = addr@res
//
val ((*void*)) =
myhashtbl_foreach_cloref
( the_s2cstmap
, lam(k, x) =>
  $UN.ptr0_set<res_vt>
  ( p_res
  , list_vt_cons(x, $UN.ptr0_get<res_vt>(p_res))
  ) (* end of [lam@] *)
) (* myhashtbl_foreach_cloref *)
//
implement
list_vt_mergesort$cmp<s2cst>
  (s2c1, s2c2) =
(
$effmask_all(compare(s2c1.stamp(), s2c2.stamp()))
)
//
in
  list_vt_mergesort<s2cst>(res)
end // end of [the_s2cstmap_listize]

end // end of [local]

(* ****** ****** *)

implement
parse_s2cst
  (jsnv0) = let
//
(*
val () =
println!
(
  "parse_s2cst: jsnv0 = ", jsnv0
) (* end of [val] *)
*)
//
fun
parse_scstextdef
(
  jsnv0: jsonval
) : Option(string) =
(
parse_option<string>
  (jsnv0, lam(x) => parse_string(x))
)
//
val-
~Some_vt
  (jsnv) = jsnv0["s2cst_stamp"]
//
val stamp = parse_stamp(jsnv)
//
val s2copt = the_s2cstmap_search(stamp)
//
in
//
case+ s2copt of
| ~Some_vt(s2c0) => s2c0
| ~None_vt((*void*)) => s2c0 where
  {
    val-JSONobject(lxs) = jsnv0
    val () =
      assertloc(length(lxs) >= 6)
    // end of [va]
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
    val+list_cons(lx, lxs) = lxs
    val extdef = parse_scstextdef(lx.1)
//
    val+list_cons(lx, lxs) = lxs
    val supcls = parse_s2explst(lx.1)
//
    val s2c0 = s2cst_make(sym, s2t, stamp, extdef)
//
(*
    val ((*void*)) =
      println! ("parse_s2cst: s2c = ", s2c)
    // end of [val]
*)
//
    val ((*void*)) = the_s2cstmap_insert(s2c0)
//
  } (* end of [None_vt] *)
//
end // end of [parse_s2cst]

(* ****** ****** *)

(* end of [patsolve_parsing_s2cst.dats] *)

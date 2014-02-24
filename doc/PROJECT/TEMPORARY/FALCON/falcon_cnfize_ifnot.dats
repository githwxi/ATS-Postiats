(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
FS = "libats/ATS1/SATS/funset_listord.sats"
staload
_(*FS*) =  "libats/ATS1/DATS/funset_listord.dats"

(* ****** ****** *)

staload "./falcon.sats"
  
(* ****** ****** *)

staload "./falcon_parser.dats"
staload "./falcon_cnfize.dats"

(* ****** ****** *)
//
// intractable rules for cnfizing
// 
abstype ruleset_type = ptr
typedef ruleset = ruleset_type
//
extern
fun
grexplst_cnfize_ifnot
  (gxs: grexplst, skipped: ruleset): grcnflst
//
(* ****** ****** *)

extern
fun ruleset_make_nil (): ruleset
extern
fun ruleset_is_member (ruleset, rule: int): bool

(* ****** ****** *)

local

assume ruleset_type = $FS.set(int) 

in (* in-of-local *)

val cmp = $UN.cast{$FS.cmp(int)}(0)

implement
$FS.compare_elt_elt<int> (x, y, _) = x - y

implement
ruleset_make_nil() = $FS.funset_make_nil{int}()

implement
ruleset_is_member (xs, x) = $FS.funset_is_member (xs, x, cmp)

end // end of [local]

(* ****** ****** *)

implement
grexplst_cnfize_ifnot
  (gxs, skipped) = let
//
fun loop
(
  gxs: grexplst, rule: int, res: grcnflst
) : grcnflst = let
in
//
case+ gxs of
| list_nil () => res
| list_cons
    (gx, gxs) => let
    val skip = ruleset_is_member (skipped, rule)
    val () = if skip then fprintln! (stderr_ref, "Skipping rule(", rule, ")") 
    val () = if ~skip then fprintln! (stderr_ref, "Processing rule(", rule, ")") 
  in
    if skip
      then
        loop (gxs, rule+1, res)
      else let
        val grf = grexp_cnfize (gx)
        val () = (
          fprint_grcnf (stderr_ref, grf); fprint_newline (stderr_ref)
        ) (* end of [val] *)
        val res = list_vt_cons (grf, res)
      in
        loop (gxs, rule+1, res)
      end // end of [else]
    // end of [skip]
  end // end of [list_cons]
//
end // end of [loop]
//
val res = loop (gxs, 1, list_vt_nil)
//
in
  list_vt_reverse (res)
end // end of [grexplst_cnfize_ifnot]

(* ****** ****** *)

(* end of [falcon_cnfize_ifnot.dats] *)

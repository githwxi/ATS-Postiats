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
//
staload M = "libc/SATS/math.sats"
staload _(*M*) = "libc/DATS/math.dats"
//
(* ****** ****** *)

staload "./falcon.sats"

(* ****** ****** *)

(*
extern
fun genelst_min
  (xs: genelst, emap: GDMap): Option_vt (gene)
// end of [genelst_min]

implement
genelst_min
  (xs, emap) = let
//
fun loop
(
  xs: genelst, x0: gene, xv0: double
) : gene =
(
  case+ xs of
  | list_cons
      (x, xs) => let
      var xv: double?
      val ans = GDMap_find (emap, x, xv)
    in
      if ans then let
        prval () = opt_unsome{double}(xv)
      in
        if xv < xv0 then loop (xs, x, xv) else loop (xs, x0, xv0)
      end else let
        prval () = opt_unnone{double}(xv)
      in
        loop (xs, x0, xv0)
      end // end of [if]
    end // end of [list_cons]
  | list_nil ((*void*)) => x0
) (* end of [loop] *)
//
in
//
case xs of
| list_nil () => None_vt ()
| list_cons (x, xs) => let
    var xv: double?
    val ans = GDMap_find (emap, x, xv)
  in
    if ans then let
      prval () = opt_unsome{double}(xv)
    in
      Some_vt{gene}(loop (xs, x, xv))
    end else let
      prval () = opt_unnone{double}(xv)
    in
      genelst_min (xs, emap)
    end // end of [list_cons]
  end (* end of [list_cons] *)
//
end // end of [genelst_min]
*)

(* ****** ****** *)

extern
fun genes_sum_var
  (xs: !genes, emap: GDMap, smap: GDMap): (double, double)
// end of [genelst_sum_var]

implement
genes_sum_var
  (xs, emap, smap) = let
//
fun loop
(
  xs: genelst_vt
, miss: &int >> _, csum: &double >> _, cvar: &double >> _
) : void =
(
case+ xs of
| ~list_vt_nil () => ()
| ~list_vt_cons (x, xs) => let
//
    var okay: bool = false
//
    var xval: double?
    val xans = GDMap_find (emap, x, xval)
    val () = (
    if xans
      then let
        prval () = opt_unsome (xval)
        val ((*void*)) =
          if $M.isnan(xval) = 0 then okay := true
        // end of [val]
      in
        if okay then csum := csum + xval
      end // end of [then]
      else let
        prval () = opt_unnone (xval) in (*nothing*)
      end // end of [else]
    ) : void // end of [if] // end of [val]
//
    val () =
    if okay then let
      var sval: double?
      val sans = GDMap_find (smap, x, sval)
    in
      if sans
        then let
          prval () = opt_unsome (sval)
        in
          cvar := cvar + sval*sval
        end // end of [then]
        else let
          prval () = opt_unnone (sval) in (*nothing*)
        end // end of [else]
      // end of [if]
    end // end of [if] // end of [val]
//
  in
    loop (xs, miss, csum, cvar)
  end // end of [list_vt_cons]
)
//
var miss: int = 0
var csum: double = 0.0
var cvar: double = 0.0
//
val xs = genes_listize1 (xs)
val nxs = list_vt_length (xs)
val nxs2 = nxs - miss
val () = loop (xs, miss, csum, cvar)
//
in
//
if nxs2 > 0
  then (nxs*(csum/nxs2), cvar) else (0.0, 0.0)
// end of [if]
end // end of [genes_sum_var]

(* ****** ****** *)

(* end of [falcon_algorithm1.dats] *)

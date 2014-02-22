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
UN = "prelude/SATS/unsafe.sats"

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
fun genes_meanvar
  (xs: !genes, emap: GDMap, smap: GDMap): expvar
// end of [genelst_meanvar]

(* ****** ****** *)

implement
genes_meanvar
  (xs, emap, smap) = let
//
fun loop
(
  xs: genelst_vt
, miss: int, csum: &double >> _, cvar: &double >> _
) : int(*miss*) =
(
case+ xs of
| ~list_vt_nil () => miss
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
    if okay
      then loop (xs, miss, csum, cvar)
      else loop (xs, miss+1, csum, cvar)
    // end of [if]
  end // end of [list_vt_cons]
)
//
var csum: double = 0.0
var cvar: double = 0.0
//
val xs = genes_listize1 (xs)
val nxs = list_vt_length (xs)
val miss = loop (xs, 0(*miss*), csum, cvar)
val nxs2 = nxs - miss
//
in
//
if nxs2 > 0
  then expvar_make (nxs*(csum/nxs2), cvar) else expvar_make (0.0, 0.0)
// end of [if]
end // end of [genes_meanvar]

(* ****** ****** *)
//
extern
fun
grcnf_minmean_stdev
  (grcnf: !grcnf, emap: GDMap, smap: GDMap): expvar
//
extern
fun
grcnflst_minmean_stdev
  (grcnfs: !grcnflst, emap: GDMap, smap: GDMap): expvarlst_vt
//
(* ****** ****** *)

implement
grcnflst_minmean_stdev
  (grcnfs, emap, smap) = 
list_vt_map_cloref<grcnf><expvar>
(
  grcnfs, lam (grcnf) => grcnf_minmean_stdev (grcnf, emap, smap)
)

(* ****** ****** *)

implement
grcnf_minmean_stdev
  (grcnf, emap, smap) = let
//
fun loop
(
  gxs: !geneslst
, mean: &double >> _, stdev: &double >> _
) : void =
(
  case+ gxs of
  | list_vt_nil () => ()
  | list_vt_cons (gx, gxs) => let
      val ev = genes_meanvar (gx, emap, smap)
      val () =
      if ev.gexp < mean
        then (mean := ev.gexp; stdev := ev.gvar)
      // end of [if] // end of [val]
    in
      loop (gxs, mean, stdev)
    end (* end of [cons] *)
)
//
var mean: double = INF
var stdev: double = NAN
//
val gxs =
$UN.castvwtp1{geneslst}(grcnf)
val () = loop (gxs, mean, stdev)
prval () = $UN.cast2void(gxs)
//
in 
  expvar_make (mean, stdev)
end // end of [grcnf_minmean_stdev]

(* ****** ****** *)

(* end of [falcon_algorithm1.dats] *)

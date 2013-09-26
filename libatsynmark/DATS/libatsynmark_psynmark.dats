(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _ = "prelude/DATS/list.dats"
staload _ = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "libatsynmark/SATS/libatsynmark.sats"

(* ****** ****** *)

implement
fprint_synmark
  (out, sm) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ sm of
| SMnone () => prstr "SMnone"
| SMcomment () => prstr "SMcomment"
| SMkeyword () => prstr "SMkeyword"
| SMextcode () => prstr "SMextcode"
//
| SMneuexp () => prstr "SMneuexp"
| SMstaexp () => prstr "SMstaexp"
| SMprfexp () => prstr "SMprfexp"
| SMdynexp () => prstr "SMdynexp"
//
| SMstalab () => prstr "SMstalab"
| SMdynlab () => prstr "SMdynlab"
//
| SMdynstr () => prstr "SMdynstr"
//
| SMscst_def (g) => prstr "SMscst_def"
| SMscst_use (g) => prstr "SMscst_use"
//
| SMscon_dec (g) => prstr "SMscon_dec"
| SMscon_use (g) => prstr "SMscon_use"
| SMscon_assume (g) => prstr "SMscon_assume"
//
| SMdcst_dec (g) => prstr "SMdcst_dec"
| SMdcst_use (g) => prstr "SMdcst_use"
| SMdcst_implement (g) => prstr "SMdcst_implement"
//
end // end of [fprint_synmark]

implement
fprint_psynmark
  (out, psm) = let
  val PSM (p, sm, k) = psm
  val () = fprint (out, "PSM(")
  val () = fprint (out, p)
  val () = fprint (out, " -> ")
  val () = fprint_synmark (out, sm)
  val () = fprint (out, ":")
  val () = fprint (out, k)
  val () = fprint (out, ")")
in
  // nothing
end // end of [fprint_psynmark]

(* ****** ****** *)
//
staload
BAS = "src/pats_basics.sats"
//
stadef funkind = $BAS.funkind
stadef valkind = $BAS.valkind
//
staload
TBF = "src/pats_tokbuf.sats"
stadef tokbuf = $TBF.tokbuf
//
(* ****** ****** *)
//
stadef s0rt = $SYN.s0rt
stadef s0rtopt = $SYN.s0rtopt
//
stadef e0xp = $SYN.e0xp
//
stadef s0exp = $SYN.s0exp
stadef s0explst = $SYN.s0explst
stadef s0expopt = $SYN.s0expopt
stadef labs0explst = $SYN.labs0explst
//
stadef e0fftaglst = $SYN.e0fftaglst
stadef e0fftaglstopt = $SYN.e0fftaglstopt
//
stadef p0at = $SYN.p0at
stadef p0atlst = $SYN.p0atlst
stadef p0atopt = $SYN.p0atopt
stadef labp0at = $SYN.labp0at
stadef labp0atlst = $SYN.labp0atlst
//
stadef d0exp = $SYN.d0exp
stadef d0explst = $SYN.d0explst
stadef d0expopt = $SYN.d0expopt
stadef labd0exp = $SYN.labd0exp
stadef labd0explst = $SYN.labd0explst
//
stadef t0mpmarglst = $SYN.t0mpmarglst
//
stadef gm0atlst = $SYN.gm0atlst
//
stadef guap0at = $SYN.guap0at
stadef c0laulst = $SYN.c0laulst
//
stadef s0expdef = $SYN.s0expdef
stadef s0expdeflst = $SYN.s0expdeflst
//
stadef q0marglst = $SYN.q0marglst
stadef a0msrtlst = $SYN.a0msrtlst
//
stadef e0xndeclst = $SYN.e0xndeclst
stadef d0atconlst = $SYN.d0atconlst
stadef d0atdeclst = $SYN.d0atdeclst
//
stadef a0typlst = $SYN.a0typlst
stadef d0cstarglst = $SYN.d0cstarglst
stadef d0cstdeclst = $SYN.d0cstdeclst
//
stadef s0arglst = $SYN.s0arglst
stadef s0vararglst = $SYN.s0vararglst
//
stadef s0marglst = $SYN.s0marglst
//
stadef m0acarglst = $SYN.m0acarglst
stadef m0acdeflst = $SYN.m0acdeflst
//
stadef f0arglst = $SYN.f0arglst
stadef witht0ype = $SYN.witht0ype
//
stadef f0undeclst = $SYN.f0undeclst
stadef v0aldeclst = $SYN.v0aldeclst
stadef v0ardeclst = $SYN.v0ardeclst
//
stadef i0mparg = $SYN.i0mparg
stadef impqi0de = $SYN.impqi0de
stadef i0mpdec = $SYN.i0mpdec
//
typedef d0ecl = $SYN.d0ecl
typedef d0eclist = $SYN.d0eclist
typedef guad0ecl = $SYN.guad0ecl
typedef guad0ecl_node = $SYN.guad0ecl_node

(* ****** ****** *)

local

staload
PAR = "src/pats_parsing.sats"

viewtypedef res = psynmarklst_vt

fun psynmark_ins (
  sm: synmark, knd: int, loc: location
, res: &res >> res
) : void = let
  val p = (
    if knd <= 0 then
      $LOC.location_beg_ntot (loc)
    else
      $LOC.location_end_ntot (loc)
    // end of [if]
  ) : lint // end of [val]
  val psm = PSM (p, sm, knd)
in
  res := list_vt_cons (psm, res)
end // end of [psynmark_ins]

fun psynmark_ins_beg (
  sm: synmark, loc: location, res: &res >> res
) : void = psynmark_ins (sm, 0(*beg*), loc, res)

fun psynmark_ins_end (
  sm: synmark, loc: location, res: &res >> res
) : void = psynmark_ins (sm, 1(*end*), loc, res)

fun psynmark_ins_begend (
  sm: synmark, loc: location, res: &res >> res
) : void = let
  val () = psynmark_ins (sm, 0(*beg*), loc, res)
  val () = psynmark_ins (sm, 1(*end*), loc, res)
in
  // nothing
end // end of [psynmark_ins_begend]

(* ****** ****** *)

implement
listize_token2psynmark (xs) = let
//
fun loop (
  xs: !tokenlst_vt, res: &res >> res
) : void =
  case xs of
  | list_vt_cons
      (x, !p_xs1) => let
      val loc = token_get_loc (x)
      val loc = $UN.cast {location} (loc)
      val () = (
        case+ 0 of
        | _ when token_is_keyword (x) =>
            psynmark_ins_begend (SMkeyword, loc, res)
        | _ when token_is_comment (x) =>
            psynmark_ins_begend (SMcomment, loc, res)
        | _ when token_is_extcode (x) =>
            psynmark_ins_begend (SMextcode, loc, res)
        | _ => ()
      ) : void // end of [val]
      val () = loop (!p_xs1, res)
      prval () = fold@ (xs)
    in
      // nothing
    end // end of [list_vt_cons]
  | list_vt_nil () => fold@ (xs)
// end of [loop]
//
var res: res = list_vt_nil ()
val () = loop (xs, res)
//
in
  list_vt_reverse (res)
end // end of [listize_token2psynmark]

(* ****** ****** *)

implement
psynmarklst_split (xs) = let
//
viewtypedef psmlst = psynmarklst_vt
fun loop (
  xs: psmlst
, res1: &psmlst? >> psmlst
, res2: &psmlst? >> psmlst
) : void = let
in
//
case+ xs of
| list_vt_cons
    (x, !p_xs) => let
    val PSM (_, _, knd) = x
  in
    if knd <= 0 then let
      val () = res1 := xs
      val xs = !p_xs
      val () = loop (xs, !p_xs, res2)
      prval () = fold@ (res1)
    in
      // nothing
    end else let
      val () = res2 := xs
      val xs = !p_xs
      val () = loop (xs, res1, !p_xs)
      prval () = fold@ (res2)
    in
      // nothing
    end // end of [if]
  end // end of [list_vt_cons]
| ~list_vt_nil () => let
    val () = res1 := list_vt_nil ()
    val () = res2 := list_vt_nil ()
  in
    // nothing
  end // end of [list_vt_nil]
//
end // end of [loop]
//
var res1: psmlst and res2: psmlst
val () = loop (xs, res1, res2)
//
in
  (res1, res2)
end // end of [psynmarklst_split]

(* ****** ****** *)

typedef fmark_type (a:t@ype) = (a, &res >> res) -> void

(* ****** ****** *)
//
extern fun s0rt_mark : fmark_type (s0rt)
extern fun s0rtopt_mark : fmark_type (s0rtopt)
//
extern fun e0xp_mark : fmark_type (e0xp)
//
extern fun s0exp_mark : fmark_type (s0exp)
extern fun s0explst_mark : fmark_type (s0explst)
extern fun s0expopt_mark : fmark_type (s0expopt)
extern fun labs0explst_npf_mark
  (npf: int, xs: labs0explst, res: &res >> res): void
//
extern fun e0fftaglst_mark : fmark_type (e0fftaglst)
extern fun e0fftaglstopt_mark : fmark_type (e0fftaglstopt)
//
extern fun p0at_mark : fmark_type (p0at)
extern fun p0atlst_mark : fmark_type (p0atlst)
extern fun p0atopt_mark : fmark_type (p0atopt)
extern fun p0atlst_npf_mark
  (npf: int, xs: p0atlst, res: &res >> res): void
//
extern fun labp0at_mark : fmark_type (labp0at)
extern fun labp0atlst_npf_mark
  (npf: int, xs: labp0atlst, res: &res >> res): void
//
extern fun d0exp_mark : fmark_type (d0exp)
extern fun d0explst_mark : fmark_type (d0explst)
extern fun d0expopt_mark : fmark_type (d0expopt)
extern fun d0explst_npf_mark
  (npf: int, xs: d0explst, res: &res >> res): void
extern fun labd0explst_npf_mark
  (npf: int, xs: labd0explst, res: &res >> res): void
//
extern fun t0mpmarglst_mark : fmark_type (t0mpmarglst)
//
extern fun gm0atlst_mark : fmark_type (gm0atlst)
//
extern fun guap0at_mark : fmark_type (guap0at)
extern fun c0laulst_mark : fmark_type (c0laulst)
//
extern fun q0marglst_mark : fmark_type (q0marglst)
extern fun a0msrtlst_mark : fmark_type (a0msrtlst)
//
extern fun s0expdeflst_mark : fmark_type (s0expdeflst)
//
extern fun e0xndeclst_mark : fmark_type (e0xndeclst)
//
extern fun d0atconlst_mark
  (knd: int, ds: d0atconlst, res: &res >> res): void
// end of [d0atconlst_mark]
extern fun d0atdeclst_mark
  (knd: int, ds: d0atdeclst, res: &res >> res): void
// end of [d0atdeclst_mark]
//
extern fun a0typlst_mark : fmark_type (a0typlst)
extern fun a0typlst_npf_mark
  (npf: int, xs: a0typlst, res: &res >> res): void
extern fun d0cstarglst_mark : fmark_type (d0cstarglst)
extern fun d0cstdeclst_mark : fmark_type (d0cstdeclst)
//
extern fun s0arglst_mark : fmark_type (s0arglst)
extern fun s0vararglst_mark : fmark_type (s0vararglst)
//
extern fun s0marglst_mark : fmark_type (s0marglst)
//
extern fun m0acarglst_mark : fmark_type (m0acarglst)
extern fun m0acdeflst_mark : fmark_type (m0acdeflst)
//
extern fun f0arglst_mark : fmark_type (f0arglst)
extern fun witht0ype_mark : fmark_type (witht0ype)
//
extern fun f0undeclst_mark
  (fk: funkind, ds: f0undeclst, res: &res >> res): void
// end of [f0undeclst_mark]
//
extern fun v0aldeclst_mark
  (vk: valkind, ds: v0aldeclst, res: &res >> res): void
// end of [v0aldeclst_mark]
//
extern fun v0ardeclst_mark : fmark_type (v0ardeclst)
//
extern fun i0mparg_mark : fmark_type (i0mparg)
extern fun impqi0de_mark : fmark_type (impqi0de)
extern fun i0mpdec_mark : fmark_type (i0mpdec)
//
extern fun d0ecl_mark : fmark_type (d0ecl)
extern fun d0eclist_mark : fmark_type (d0eclist)
//
extern fun guad0ecl_mark : fmark_type (guad0ecl)
extern fun guad0ecln_mark : fmark_type (guad0ecl_node)
//
(* ****** ****** *)

implement
s0rt_mark
  (s0t, res) = let
  val loc = s0t.s0rt_loc
  val () = psynmark_ins_begend (SMstaexp, loc, res)
in
  // nothing
end // end of [s0rt_mark]

implement
s0rtopt_mark
  (opt, res) = (
  case+ opt of
  | Some (s0t) => s0rt_mark (s0t, res) | None () => ()
) // end of [s0rtopt_mark]

(* ****** ****** *)

implement
e0xp_mark
  (e, res) = let
  val loc = e.e0xp_loc
  val () = psynmark_ins_begend (SMneuexp, loc, res)
in
  // nothing
end // end of [e0xp_mark]

(* ****** ****** *)

implement
s0exp_mark
  (s0e0, res) = let
  val loc0 = s0e0.s0exp_loc
in
//
case+ s0e0.s0exp_node of
//
(*
| $SYN.S0Eide _ => ()
| $SYN.S0Esqid _ => ()
| $SYN.S0Eopid _ => ()
*)
//
| $SYN.S0Eint _ =>
    psynmark_ins_begend (SMstaexp, loc0, res)
| $SYN.S0Echar _ =>
    psynmark_ins_begend (SMstaexp, loc0, res)
| $SYN.S0Eextype _ =>
    psynmark_ins_begend (SMstaexp, loc0, res)
| $SYN.S0Eextkind _ =>
    psynmark_ins_begend (SMstaexp, loc0, res)
//
| $SYN.S0Eapp
    (s0e1, s0e2) => let
    val () = s0exp_mark (s0e1, res)
    val () = s0exp_mark (s0e2, res)
  in
    // nothing
  end // end of [S0Eapp]
| $SYN.S0Elam
    (_sma, _opt, s0e) => let
    val () = psynmark_ins_beg (SMstaexp, loc0, res)
    val () = s0exp_mark (s0e, res)
    val () = psynmark_ins_end (SMstaexp, loc0, res)
  in
    // nothing
  end // end of [S0Elam]
//
| $SYN.S0Eimp (efs) => e0fftaglst_mark (efs, res)
//
| $SYN.S0Elist (s0es) => s0explst_mark (s0es, res)
| $SYN.S0Elist2
    (s0es1, s0es2) => let
    val () = s0explst_mark (s0es1, res)
    val () = s0explst_mark (s0es2, res)
  in
    // nothing
  end // end of [S0Elist2]
//
| $SYN.S0Etyarr
    (s0e_elt, s0es_dim) => let
    val () = s0exp_mark (s0e_elt, res)
    val () = s0explst_mark (s0es_dim, res)
  in
    // nothing
  end // end of [S0Etyarr]
| $SYN.S0Etytup
    (knd, npf, s0es) => s0explst_mark (s0es, res)
| $SYN.S0Etyrec
    (knd, npf, ls0es) =>
    labs0explst_npf_mark (npf, ls0es, res)
| $SYN.S0Etyrec_ext
    (name, npf, ls0es) =>
    labs0explst_npf_mark (npf, ls0es, res)
//
| $SYN.S0Euni _ => psynmark_ins_begend (SMstaexp, loc0, res)
| $SYN.S0Eexi _ => psynmark_ins_begend (SMstaexp, loc0, res)
//
| $SYN.S0Eann
    (s0e, s0t) => let
    val () =
      s0exp_mark (s0e, res)
    // end of [val]
    val () = s0rt_mark (s0t, res)
  in
    // nothing
  end // end of [S0Eann]
//
| _ => psynmark_ins_begend (SMstaexp, loc0, res)
//
end // end of [s0exp_mark]

implement
s0explst_mark
  (s0es, res) = (
  case+ s0es of
  | list_cons (s0e, s0es) => let
      val () = s0exp_mark (s0e, res) in s0explst_mark (s0es, res)
    end // end of [list_cons]
  | list_nil () => ()
) // end of [s0explst_mark]

implement
s0expopt_mark
  (opt, res) = (
  case+ opt of
  | Some (s0e) => s0exp_mark (s0e, res)
  | None () => ()
) // end of [s0expopt_mark]

(* ****** ****** *)

implement
labs0explst_npf_mark
  (npf, lxs, res) = let
in
//
case+ lxs of
| list_cons (lx, lxs) => let
    val $SYN.SL0ABELED (lab, _, s0e) = lx
    val () =
      psynmark_ins_begend (SMstalab, lab.l0ab_loc, res)
    val () = s0exp_mark (s0e, res)
  in
    labs0explst_npf_mark (npf-1, lxs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [labs0explst_npf_mark]

(* ****** ****** *)

implement
e0fftaglst_mark
  (xs, res) = (
  case+ xs of
  | list_cons
      (x, xs) => let
      val loc = x.e0fftag_loc
      val () = psynmark_ins_begend (SMstaexp, loc, res)
    in
      e0fftaglst_mark (xs, res)
    end // end of [list_cons]
  | list_nil () => ()
) // end of [e0fftaglst_mark]

implement
e0fftaglstopt_mark
  (opt, res) = (
  case+ opt of
  | Some (efs) => e0fftaglst_mark (efs, res)
  | None () => ()
) // end of [e0fftaglstopt_mark]

(* ****** ****** *)

implement
p0at_mark
  (p0t0, res) = let
//
  val loc0 = p0t0.p0at_loc
in
//
case+ p0t0.p0at_node of
//
// (*
| $SYN.P0Tide _ => () // determined by the context
| $SYN.P0Tdqid _ => () // determined by the context
| $SYN.P0Topid _ => () // determined by the context
// *)
//
| $SYN.P0Tint _ =>
    psynmark_ins_begend (SMdynexp, loc0, res)
| $SYN.P0Tchar _ =>
    psynmark_ins_begend (SMdynexp, loc0, res)
| $SYN.P0Tfloat _ =>
    psynmark_ins_begend (SMdynexp, loc0, res)
| $SYN.P0Tstring _ =>
    psynmark_ins_begend (SMdynexp, loc0, res)
//
| $SYN.P0Tapp (p0t1, p0t2) => {
    val () = p0at_mark (p0t1, res)
    val () = p0at_mark (p0t2, res)
  }
| $SYN.P0Tlist
    (npf, p0ts) => p0atlst_npf_mark (npf, p0ts, res)
| $SYN.P0Tsvararg _ =>
    psynmark_ins_begend (SMstaexp, loc0, res)
| $SYN.P0Trefas
    (id, loc_id, p0t) => {
    val () = psynmark_ins_begend (SMstaexp, loc_id, res)
    val () = p0at_mark (p0t, res)
  }
//
| $SYN.P0Tlst (lin, p0ts) => p0atlst_mark (p0ts, res)
| $SYN.P0Ttup (knd, npf, p0ts) => p0atlst_npf_mark (npf, p0ts, res)
| $SYN.P0Trec (knd, npf, lp0ts) => labp0atlst_npf_mark (npf, lp0ts, res)
//
| $SYN.P0Tfree (p0t) => p0at_mark (p0t, res)
| $SYN.P0Tunfold (p0t) => p0at_mark (p0t, res)
//
| $SYN.P0Texist (s0as) => s0arglst_mark (s0as, res)
//
| $SYN.P0Tann
    (p0t, ann) => {
    val () = p0at_mark (p0t, res)
    val () = s0exp_mark (ann, res)
  } // end of [P0Tann]
//
| $SYN.P0Terr _ => psynmark_ins_begend (SMdynexp, loc0, res)
//
end // end of [p0at_mark]

implement
p0atlst_mark
  (p0ts, res) = (
  case+ p0ts of
  | list_cons (p0t, p0ts) => let
      val () = p0at_mark (p0t, res) in p0atlst_mark (p0ts, res)
    end // end of [list_cons]
  | list_nil () => ()
) // end of [p0atlst_mark]

implement
p0atopt_mark
  (opt, res) = (
  case+ opt of
  | Some (p0t) => p0at_mark (p0t, res)
  | None () => ()
) // end of [p0atopt_mark]

implement
p0atlst_npf_mark
  (npf, p0ts, res) = let
in
//
if npf > 0 then (
  case+ p0ts of
  | list_cons (p0t, p0ts) => let
      val loc = p0t.p0at_loc
      val () = psynmark_ins_beg (SMprfexp, loc, res)
      val () = p0at_mark (p0t, res)
      val () = psynmark_ins_end (SMprfexp, loc, res)
    in
      p0atlst_npf_mark (npf-1, p0ts, res)
    end // end of [list_cons]
  | list_nil () => ()
) else p0atlst_mark (p0ts, res)
//
end // end of [p0atlst_npf_mark]

(* ****** ****** *)

implement
labp0at_mark
  (lx, res) = (
  case+ lx.labp0at_node of
  | $SYN.LABP0ATnorm
      (lab, p0t) => let
      val () = psynmark_ins_begend (SMdynlab, lab.l0ab_loc, res)
    in
      p0at_mark (p0t, res)
    end // end of [LABP0ATnorm]
  | $SYN.LABP0ATomit () => ()
) // end of [labp0at_mark]

implement
labp0atlst_npf_mark
  (npf, lxs, res) = let
in
//
case+ lxs of
| list_cons (lx, lxs) => let
    val loc = lx.labp0at_loc
    val () = if npf > 0 then psynmark_ins_beg (SMprfexp, loc, res)
    val () = labp0at_mark (lx, res)
    val () = if npf > 0 then psynmark_ins_end (SMprfexp, loc, res)
  in
    labp0atlst_npf_mark (npf-1, lxs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [labp0atlst_npf_mark]

(* ****** ****** *)

implement
d0exp_mark
  (d0e0, res) = let
  val loc0 = d0e0.d0exp_loc
in
//
case+ d0e0.d0exp_node of
//
// (*
| $SYN.D0Eide _ => () // determined by the context
| $SYN.D0Edqid _ => () // determined by the context
| $SYN.D0Eopid _ => () // determined by the context
// *)
| $SYN.D0Estring _ =>
    psynmark_ins_begend (SMdynstr, loc0, res)
//
| $SYN.D0Eapp
    (d0e_fun, d0e_arg) => {
    val () = d0exp_mark (d0e_fun, res)
    val () = d0exp_mark (d0e_arg, res)
  } // end of [D0Eapp]
//
| $SYN.D0Efoldat (d0es) => d0explst_mark (d0es, res)
| $SYN.D0Efreeat (d0es) => d0explst_mark (d0es, res)
//
| $SYN.D0Etmpid (qid, tmas) => t0mpmarglst_mark (tmas, res)
//
| $SYN.D0Elet (d0cs, d0e) => let
    val () = d0eclist_mark (d0cs, res)
  in
    d0exp_mark (d0e, res)
  end // end of [D0Elet]
| $SYN.D0Edeclseq (d0cs) => d0eclist_mark (d0cs, res)
| $SYN.D0Ewhere (d0e, d0cs) => {
    val () = d0exp_mark (d0e, res)
    val () = d0eclist_mark (d0cs, res)
  } // end of [D0Ewhere]
//
| $SYN.D0Elist (npf, d0es) => d0explst_npf_mark (npf, d0es, res)
//
| $SYN.D0Eifhead (
    invres, _cond, _then, _else
  ) => {
    val () = d0exp_mark (_cond, res)
    val () = d0exp_mark (_then, res)
    val () = d0expopt_mark (_else, res)
  } // end of [D0Eifhead]
| $SYN.D0Esifhead (
    invres, _cond, _then, _else
  ) => {
    val () = s0exp_mark (_cond, res)
    val () = d0exp_mark (_then, res)
    val () = d0exp_mark (_else, res)
  } // end of [D0Esifhead]
//
| $SYN.D0Ecasehead
   (invres, d0e, c0ls) => let
   val () =
     d0exp_mark (d0e, res) in c0laulst_mark (c0ls, res)
   // end of [val]
 end // end of [D0Ecasehead]
//
| $SYN.D0Elst (lin, elt, d0e) => {
    val () = s0expopt_mark (elt, res)
    val () = d0exp_mark (d0e, res) // [d0e] is a tuple
  } // end of [D0Elst]
| $SYN.D0Etup (knd, npf, d0es) => let
    val () = d0explst_npf_mark (npf, d0es, res) in (*none*)
  end // end of [D0Etup]
| $SYN.D0Erec (knd, npf, ld0es) => let
    val () = labd0explst_npf_mark (npf, ld0es, res) in (*none*)
  end // end of [D0Erec]
| $SYN.D0Eseq (d0es) => d0explst_mark (d0es, res)
//
| $SYN.D0Earrpsz (s0e_elt, d0e) => let
    val () = s0expopt_mark (s0e_elt, res) in d0exp_mark (d0e, res)
  end // end of [D0Earrpsz]
//
| $SYN.D0Eeffmask
    (efs, d0e) => let
    val () =
      e0fftaglst_mark (efs, res) in d0exp_mark (d0e, res)
    // end of [val]
  end // end of [D0Eeffmask]
| $SYN.D0Eeffmask_arg (knd, d0e) => d0exp_mark (d0e, res)
//
| $SYN.D0Esexparg _ => psynmark_ins_begend (SMstaexp, loc0, res)
//
| $SYN.D0Elam (
    knd, f0as, retopt, efs, d0e
  ) => let
    val () = f0arglst_mark (f0as, res)
    val () = s0expopt_mark (retopt, res)
    val () = e0fftaglstopt_mark (efs, res)
    val () = d0exp_mark (d0e, res)
  in
    // nothing
  end // end of [D0Elam]
| $SYN.D0Efix (
    knd, id, f0as, retopt, efs, d0e
  ) => let
    val () = f0arglst_mark (f0as, res)
    val () = s0expopt_mark (retopt, res)
    val () = e0fftaglstopt_mark (efs, res)
    val () = d0exp_mark (d0e, res)
  in
    // nothing
  end // end of [D0Efix]
//
| $SYN.D0Eann
    (d0e, ann) => {
    val () = d0exp_mark (d0e, res)
    val () = s0exp_mark (ann, res)
  } // end of [D0Eann]
//
| _ => psynmark_ins_begend (SMdynexp, loc0, res)
//
end // end of [d0exp_mark]

implement
d0explst_mark
  (d0es, res) = (
  case+ d0es of
  | list_cons (d0e, d0es) => let
      val () = d0exp_mark (d0e, res) in d0explst_mark (d0es, res)
    end // end of [list_cons]
  | list_nil () => ()
) // end of [d0explst_mark]

implement
d0expopt_mark
  (opt, res) = (
  case+ opt of
  | Some (d0e) => d0exp_mark (d0e, res)
  | None () => ()
) // end of [d0expopt_mark]

implement
d0explst_npf_mark
  (npf, d0es, res) = let
in
//
if npf > 0 then (
  case+ d0es of
  | list_cons (d0e, d0es) => let
      val loc = d0e.d0exp_loc
      val () = psynmark_ins_beg (SMprfexp, loc, res)
      val () = d0exp_mark (d0e, res)
      val () = psynmark_ins_end (SMprfexp, loc, res)
    in
      d0explst_npf_mark (npf-1, d0es, res)
    end // end of [list_cons]
  | list_nil () => ()
) else d0explst_mark (d0es, res)
//
end // end of [d0explst_npf_mark]

(* ****** ****** *)

implement
labd0explst_npf_mark
  (npf, lxs, res) = let
in
//
case+ lxs of
| list_cons (lx, lxs) => let
    val $SYN.DL0ABELED (lab, d0e) = lx
    val () = if npf > 0 then
      psynmark_ins_beg (SMprfexp, lab.l0ab_loc, res)
    val () =
      psynmark_ins_begend (SMdynlab, lab.l0ab_loc, res)
    val () = d0exp_mark (d0e, res)
    val () = if npf > 0 then
      psynmark_ins_end (SMprfexp, d0e.d0exp_loc, res)
  in
    labd0explst_npf_mark (npf-1, lxs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [labd0explst_npf_mark]

(* ****** ****** *)

implement
t0mpmarglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val arg = x.t0mpmarg_arg
    val () =
      s0explst_mark (arg, res) in t0mpmarglst_mark (xs, res)
    // end of [val]
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [t0mpmarglst_mark]

(* ****** ****** *)

implement
gm0atlst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val () = d0exp_mark (x.gm0at_exp, res)
    val () = p0atopt_mark (x.gm0at_pat, res)
  in
    gm0atlst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [gm0atlst_mark]

(* ****** ****** *)

implement
guap0at_mark
  (x, res) = let
  val () =
    p0at_mark (x.guap0at_pat, res)
  // end of [val]
in
  gm0atlst_mark (x.guap0at_gua, res)
end // end of [guap0at_mark]

implement
c0laulst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val () =
      guap0at_mark (x.c0lau_pat, res)
    val () = d0exp_mark (x.c0lau_body, res)
  in
    c0laulst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
end // end of [c0laulst_mark]

(* ****** ****** *)

implement
q0marglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val loc = x.q0marg_loc
    val () = psynmark_ins_begend (SMstaexp, loc, res)
  in
    q0marglst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [q0marglst_mark]

(* ****** ****** *)

implement
a0msrtlst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val loc = x.a0msrt_loc
    val () = psynmark_ins_begend (SMstaexp, loc, res)
  in
    a0msrtlst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [a0msrtlst_mark]

(* ****** ****** *)

implement
s0expdeflst_mark
  (ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val loc = d.s0expdef_loc
    val () = psynmark_ins_beg (SMstaexp, loc, res)
    val () =
      s0marglst_mark (d.s0expdef_arg, res)
    // end of [val]
    val () = s0exp_mark (d.s0expdef_def, res)
    val () = psynmark_ins_end (SMstaexp, loc, res)
  in
    s0expdeflst_mark (ds, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [s0expdeflst_mark]

(* ****** ****** *)

implement
e0xndeclst_mark
  (ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val loc = d.e0xndec_loc
    val () =
      psynmark_ins_beg (SMdynexp, loc, res)
    val () =
      q0marglst_mark (d.e0xndec_qua, res)
    val () = s0expopt_mark (d.e0xndec_arg, res)
    val () =
      psynmark_ins_end (SMdynexp, loc, res)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [e0xndeclst]

(* ****** ****** *)

implement
d0atconlst_mark
  (knd, ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val () =
      q0marglst_mark (d.d0atcon_qua, res)
    val () = s0expopt_mark (d.d0atcon_arg, res)
    val () = s0expopt_mark (d.d0atcon_ind, res)
  in
    d0atconlst_mark (knd, ds, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [d0atconlst_mark]

implement
d0atdeclst_mark
  (knd, ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val () = a0msrtlst_mark (d.d0atdec_arg, res)
    val () = d0atconlst_mark (knd, d.d0atdec_con, res)
  in
    d0atdeclst_mark (knd, ds, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [d0atdeclst_mark]

(* ****** ****** *)

implement
a0typlst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = s0exp_mark (x.a0typ_typ, res)
  in
    a0typlst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [a0typlst_mark]

implement
a0typlst_npf_mark
  (npf, xs, res) = let
in
//
if npf > 0 then (
  case+ xs of
  | list_cons
      (x, xs) => let
      val loc = x.a0typ_loc
      val () = psynmark_ins_beg (SMprfexp, loc, res)
      val () = s0exp_mark (x.a0typ_typ, res)
      val () = psynmark_ins_end (SMprfexp, loc, res)
    in
      a0typlst_npf_mark (npf-1, xs, res)
    end // end of [list_cons]
  | list_nil () => ()
) else a0typlst_mark (xs, res)
//
end // end of [a0typlst_npf_mark]

implement
d0cstarglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = (
    case+ x.d0cstarg_node of
    | $SYN.D0CSTARGsta _ =>
        psynmark_ins_begend (SMstaexp, x.d0cstarg_loc, res)
    | $SYN.D0CSTARGdyn (npf, a0ts) => a0typlst_npf_mark (npf, a0ts, res)
    ) : void // end of [val]
  in
    d0cstarglst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [d0cstarglst_mark]

implement
d0cstdeclst_mark
  (ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val () =
      d0cstarglst_mark (d.d0cstdec_arg, res)
    val () =
      e0fftaglstopt_mark (d.d0cstdec_eff, res)
    val () = s0exp_mark (d.d0cstdec_res, res)
  in
    d0cstdeclst_mark (ds, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [d0cstdclst_mark]

(* ****** ****** *)

implement
s0arglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val () = psynmark_ins_begend (SMstaexp, x.s0arg_loc, res)
  in
    s0arglst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [s0arglst_mark]

implement
s0vararglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val loc = (
      case+ x of
      | $SYN.S0VARARGseq (loc, _) => loc
      | $SYN.S0VARARGone (tok) => tok.token_loc
      | $SYN.S0VARARGall (tok) => tok.token_loc
    ) : location
    val () = psynmark_ins_begend (SMstaexp, loc, res)
  in
    s0vararglst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [s0vararglst_mark]

(* ****** ****** *)

implement
s0marglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => let
    val () = s0arglst_mark (x.s0marg_arg, res)
  in
    s0marglst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [s0marglst_mark]

(* ****** ****** *)

implement
m0acarglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons (x, xs) => (
  case+ x.m0acarg_node of
  | $SYN.M0ACARGsta (s0as) => let
      val () = s0arglst_mark (s0as, res)
    in
      m0acarglst_mark (xs, res)
    end
  | $SYN.M0ACARGdyn (ids) => let
      val loc = x.m0acarg_loc
      val () = psynmark_ins_begend (SMdynexp, loc, res)
    in
      m0acarglst_mark (xs, res)
    end
  ) // end of [list_cons]
| list_nil () => ()
//
end // end of [m0acarglst_mark]

implement
m0acdeflst_mark
  (ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val () =
      m0acarglst_mark (d.m0acdef_arg, res)
    val () = d0exp_mark (d.m0acdef_def, res)
  in
    m0acdeflst_mark (ds, res)
  end // end of [list_cons]
| list_nil () => ()
end // end of [m0acdeflst_mark]

(* ****** ****** *)

implement
f0arglst_mark
  (xs, res) = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = (
      case+ x.f0arg_node of
      | $SYN.F0ARGdyn (p0t) => p0at_mark (p0t, res)
      | $SYN.F0ARGsta1 _ => 
          psynmark_ins_begend (SMstaexp, x.f0arg_loc, res)
      | $SYN.F0ARGsta2 _ => 
          psynmark_ins_begend (SMstaexp, x.f0arg_loc, res)
      | $SYN.F0ARGmet (s0es) => s0explst_mark (s0es, res)
    ) : void // end of [val]
  in
    f0arglst_mark (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [f0arglst_mark]

(* ****** ****** *)

implement
witht0ype_mark
  (ws0e, res) = (
  case+ ws0e of
  | $SYN.WITHT0YPEsome (_, s0e) => s0exp_mark (s0e, res)
  | $SYN.WITHT0YPEnone () => ()
) // end of [witht0ype_mark]

(* ****** ****** *)

implement
f0undeclst_mark
  (fk, ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val () =
      f0arglst_mark (d.f0undec_arg, res)
    val () =
      e0fftaglstopt_mark (d.f0undec_eff, res)
    val () =
      s0expopt_mark (d.f0undec_res, res)
    val () = d0exp_mark (d.f0undec_def, res)
    val () = witht0ype_mark (d.f0undec_ann, res)
  in
    f0undeclst_mark (fk, ds, res)
  end // end of [list_cons]
| list_nil () => ()
end // end of [f0undeclst_mark]

(* ****** ****** *)

implement
v0aldeclst_mark
  (vk, ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val () = p0at_mark (d.v0aldec_pat, res)
    val () = d0exp_mark (d.v0aldec_def, res)
    val () = witht0ype_mark (d.v0aldec_ann, res)
  in
    v0aldeclst_mark (vk, ds, res)
  end // end of [list_cons]
| list_nil () => ()
end // end of [v0aldeclst_mark]

(* ****** ****** *)

implement
v0ardeclst_mark
  (ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val () = s0expopt_mark (d.v0ardec_type, res)
    val () = (
      case+ d.v0ardec_wth of
      | Some (id) =>
          psynmark_ins_begend (SMprfexp, id.i0de_loc, res)
      | None () => ()
    ) : void // end of [val]
    val () = d0expopt_mark (d.v0ardec_ini, res)
  in
    v0ardeclst_mark (ds, res)
  end // end of [list_cons]
| list_nil () => ()
end // end of [v0ardeclst_mark]

(* ****** ****** *)

implement
i0mparg_mark (x, res) =
  case+ x of
  | $SYN.I0MPARG_sarglst (s0as) => s0arglst_mark (s0as, res)
  | $SYN.I0MPARG_svararglst (s0vs) => s0vararglst_mark (s0vs, res)
// end of [i0mparg_mark]

implement
impqi0de_mark (x, res) = let
  val () =
    t0mpmarglst_mark (x.impqi0de_arg, res)
  // end of [val]
in
  // nothing
end // end of [impqi0de_mark]

implement
i0mpdec_mark (d, res) = let
  val () = impqi0de_mark (d.i0mpdec_qid, res)
  val () = f0arglst_mark (d.i0mpdec_arg, res)
  val () = s0expopt_mark (d.i0mpdec_res, res)
in
  d0exp_mark (d.i0mpdec_def, res)
end // end of [i0mpdec]

(* ****** ****** *)

fun dcstkind_is_proof
  (tok: $LEX.token): bool = (
  case+ tok.token_node of
  | $LEX.T_FUN (fk) => $BAS.funkind_is_proof (fk)
  | $LEX.T_VAL (vk) => $BAS.valkind_is_proof (vk)
  | _ => false
) // end of [dcstkind_is_proof]

implement
d0ecl_mark
  (d0c0, res) = let
  val loc0 = d0c0.d0ecl_loc
  macdef neuexploc_ins () = 
    psynmark_ins_begend (SMneuexp, loc0, res)
  macdef staexploc_ins () = 
    psynmark_ins_begend (SMstaexp, loc0, res)
  macdef dynexploc_ins () = 
    psynmark_ins_begend (SMdynexp, loc0, res)
in
//
case+ d0c0.d0ecl_node of
//
| $SYN.D0Cfixity _ => neuexploc_ins ()
| $SYN.D0Cnonfix _ => neuexploc_ins ()
//
| $SYN.D0Cinclude _ => neuexploc_ins ()
| $SYN.D0Csymintr _ => neuexploc_ins ()
| $SYN.D0Csymelim _ => neuexploc_ins ()
//
| $SYN.D0Coverload _ => dynexploc_ins ()
//
| $SYN.D0Ce0xpdef _ => neuexploc_ins ()
| $SYN.D0Ce0xpundef _ => neuexploc_ins ()
| $SYN.D0Ce0xpact _ => neuexploc_ins ()
//
| $SYN.D0Cdatsrts _ => staexploc_ins ()
| $SYN.D0Csrtdefs _ => staexploc_ins ()
//
| $SYN.D0Cstacsts _ => staexploc_ins ()
| $SYN.D0Cstacons _ => staexploc_ins ()
| $SYN.D0Ctkindef _ => staexploc_ins ()
| $SYN.D0Csexpdefs (knd, defs) => s0expdeflst_mark (defs, res)
| $SYN.D0Csaspdec _ => staexploc_ins ()
//
| $SYN.D0Cexndecs
    (decs) => e0xndeclst_mark (decs, res)
| $SYN.D0Cdatdecs
    (knd, decs, defs) => let
    val isprf = $BAS.test_prfkind (knd)
    val sm = (
      if isprf then SMprfexp else SMdynexp
    ) : synmark // end of [val]
    val () = psynmark_ins_beg (sm, loc0, res)
    val () = d0atdeclst_mark (knd, decs, res)
    val () = psynmark_ins_end (sm, loc0, res)
    val () = s0expdeflst_mark (defs, res)
  in
    // nothing
  end // end of [D0Cdatdecs]
//
| $SYN.D0Cextcode _ =>
    psynmark_ins_begend (SMextcode, loc0, res)
//
| $SYN.D0Cdcstdecs
    (knd, tok, qmas, decs) => let
    val isprf = dcstkind_is_proof (tok)
    val sm = (
      if isprf then SMprfexp else SMdynexp
    ) : synmark // end of [val]
    val () = psynmark_ins_beg (sm, loc0, res)
    val () = q0marglst_mark (qmas, res)
    val () = d0cstdeclst_mark (decs, res)
    val () = psynmark_ins_end (sm, loc0, res)
  in 
    // nothing
  end // end of [D0Cdcstdecs]
//
| $SYN.D0Cmacdefs
    (knd, isrec, decs) => let
    val () = psynmark_ins_beg (SMdynexp, loc0, res)
    val () = m0acdeflst_mark (decs, res)
    val () = psynmark_ins_end (SMdynexp, loc0, res)
  in
    // nothing
  end // end of [D0Cmacdefs]
//
| $SYN.D0Cfundecs
    (fk, qmas, decs) => let
    val isprf = $BAS.funkind_is_proof (fk)
    val sm = (
      if isprf then SMprfexp else SMdynexp
    ) : synmark // end of [val]
    val () = psynmark_ins_beg (sm, loc0, res)
    val () = q0marglst_mark (qmas, res)
    val () = f0undeclst_mark (fk, decs, res)
    val () = psynmark_ins_end (sm, loc0, res)
  in
    // nothing
  end // end of [D0Cfundecs]
//
| $SYN.D0Cvaldecs
    (vk, isrec, decs) => let
    val isprf = $BAS.valkind_is_proof (vk)
    val sm = (
      if isprf then SMprfexp else SMdynexp
    ) : synmark // end of [val]
    val () = psynmark_ins_beg (sm, loc0, res)
    val () = v0aldeclst_mark (vk, decs, res)
    val () = psynmark_ins_end (sm, loc0, res)
  in
    // nothing
  end // end of [D0Cvaldecs]
//
| $SYN.D0Cvardecs (knd, decs) => v0ardeclst_mark (decs, res)
//
| $SYN.D0Cimpdec
    (knd, imparg, impdec) => let
    val isprf = knd > 0
    val sm = (
      if isprf then SMprfexp else SMdynexp
    ) : synmark // end of [val]
    val () = psynmark_ins_beg (sm, loc0, res)
    val () = i0mparg_mark (imparg, res)
    val () = i0mpdec_mark (impdec, res)
    val () = psynmark_ins_end (sm, loc0, res)
  in
    // nothing
  end // end of [D0Cimpdec]
//
| $SYN.D0Clocal
    (d0cs_head, d0cs_body) => {
    val () = d0eclist_mark (d0cs_head, res)
    val () = d0eclist_mark (d0cs_body, res)
  } // end of [$SYN.D0Clocal]
//
| $SYN.D0Cguadecl (knd, gd) => guad0ecl_mark (gd, res)
//
| _ => ()
//
end // end of [d0ecl]

implement
d0eclist_mark
  (d0cs, res) = (
  case+ d0cs of
  | list_cons (d0c, d0cs) => let
      val () = d0ecl_mark (d0c, res) in d0eclist_mark (d0cs, res)
    end // end of [list_cons]
  | list_nil () => ()
) // end of [d0eclist_mark]

(* ****** ****** *)

implement
guad0ecl_mark
  (gd, res) =
  guad0ecln_mark (gd.guad0ecl_node, res)
// end of [guad0ecl_mark]

implement
guad0ecln_mark
  (gdn, res) = (
  case+ gdn of
  | $SYN.GD0Cone
      (e, decs) => let
      val () = e0xp_mark (e, res)
    in
      d0eclist_mark (decs, res)
    end
  | $SYN.GD0Ctwo
      (e, decs1, decs2) => let
      val () = e0xp_mark (e, res)
      val () = d0eclist_mark (decs1, res)
      val () = d0eclist_mark (decs2, res)
    in
      // nothing
    end
  | $SYN.GD0Ccons
      (e, decs, knd, gdn) => let
      val () = e0xp_mark (e, res)
      val () = d0eclist_mark (decs, res)
    in
      guad0ecln_mark (gdn, res)
    end
) // end of [guad0ecln_mark]

(* ****** ****** *)

in // in of [local]

implement
tokbufobj_get_psynmarklst
  (stadyn, tbf) = let
//
val (pf, fpf | p) =
  __cast (tbf) where {
  extern castfn __cast (tbf: !tokbufobj)
    : [l:addr] (tokbuf @ l, tokbuf @ l -<lin,prf> void | ptr l)
} // end of [val]
val d0cs = $PAR.parse_from_tokbuf_toplevel (stadyn, !p)
prval () = fpf (pf)
//
var res: res = list_vt_nil ()
val () = d0eclist_mark (d0cs, res)
//
in
  list_vt_reverse (res)
end // end of [tokbufobj_get_psynmarklst]

end // end of [local]

(* ****** ****** *)

implement{}
psynmarklst_process
  (pos0, psms, putc) = let
in
//
case+ psms of
| list_vt_cons
    (psm, !p_psms1) => let
    val PSM (pos, sm, knd) = psm
  in
    if pos0 >= pos then let
      val () =
        psynmark_process<> (psm, putc)
      val psms1 = !p_psms1
      val () = free@ {psynmark}{0} (psms)
      val () = psms := psms1
    in
      psynmarklst_process (pos0, psms, putc)
    end else fold@ (psms) // end of [if]
  end // end of [list_vt_cons]
| list_vt_nil () => fold@ (psms)
//
end // end of [psynmarklst_process]

implement{}
psynmarklstlst_process
  (pos0, psmss, putc) = (
  case psmss of
  | list_vt_cons (!p1_psms, !p2_psmss) => let
      val () = psynmarklst_process (pos0, !p1_psms, putc)
      val () = psynmarklstlst_process (pos0, !p2_psmss, putc)
    in
      fold@ (psmss)
    end // end of [list_vt_cons]
  | list_vt_nil () => fold@ (psmss)
) // end of [psynmarklstlst_process]

(* ****** ****** *)

#define i2c char_of_int

(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"
macdef fgetc0_err = $STDIO.fgetc0_err

(* ****** ****** *)

implement{}
string_psynmarklstlst_process
  (inp, psmss, putc) = let
  val [n:int] inp = string1_of_string (inp)
//
fun loop
  {i:nat | i <= n} .<n-i>. (
  inp: string (n)
, ind: size_t (i)
, psmss: &psynmarklstlst_vt
, putc: putc_type
, pos: &lint // current position
) : void = let
  val () =
    psynmarklstlst_process (pos, psmss, putc)
  // end of [val]
  val isnotend = string_isnot_atend (inp, ind) 
in
//
if isnotend then let
  val c = inp[ind]
  val () = pos := succ (pos)
  val _(*err*) = fhtml_putc (c, putc)
in
  loop (inp, succ(ind), psmss, putc, pos)
end else () // end of [if]
//
end // end of [loop]
//
var psmss = psmss; var pos: lint = 0L
val () = loop (inp, 0, psmss, putc, pos)
//
viewtypedef psmlst = psynmarklst_vt
val () = list_vt_free_fun<psmlst> (psmss, lam (x) => list_vt_free (x))
//
in
  // nothing
end // end of [string_psynmarklstlst_process]

(* ****** ****** *)

implement{}
fileref_psynmarklstlst_process
  (inp, psmss, putc) = let
//
fun loop (
  inp: FILEref
, psmss: &psynmarklstlst_vt
, putc: putc_type
, pos: &lint // current position
) : void = let
  val () =
    psynmarklstlst_process (pos, psmss, putc)
  val i = fgetc0_err (inp)
in
//
if (i != EOF) then let
  val () = pos := succ (pos)
  val _(*err*) = fhtml_putc ((i2c)i, putc)
in
  loop (inp, psmss, putc, pos)
end else () // end of [if]
//
end // end of [loop]
//
var psmss = psmss; var pos: lint = 0L
val () = loop (inp, psmss, putc, pos)
//
viewtypedef psmlst = psynmarklst_vt
val () = list_vt_free_fun<psmlst> (psmss, lam (x) => list_vt_free (x))
//
in
  // nothing
end // end of [fileref_psynmarklstlst_process]

(* ****** ****** *)

implement{}
charlst_psynmarklstlst_process
  (inp, psmss, putc) = let
//
fun loop (
  inp: List_vt (char)
, psmss: &psynmarklstlst_vt
, putc: putc_type
, pos: &lint // current position
) : void = let
  val () =
    psynmarklstlst_process (pos, psmss, putc)
  // end of [val]
in
//
case+ inp of
| ~list_vt_cons
    (c, inp) => let
    val () = pos := succ (pos)
    val _(*err*) = fhtml_putc (c, putc)
  in
    loop (inp, psmss, putc, pos)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [loop]
//
var psmss = psmss; var pos: lint = 0L
val () = loop (inp, psmss, putc, pos)
//
viewtypedef psmlst = psynmarklst_vt
val () = list_vt_free_fun<psmlst> (psmss, lam (x) => list_vt_free (x))
//
in
  // nothing
end // end of [charlst_psynmarklstlst_process]

(* ****** ****** *)

implement
lexbufobj_level1_psynmarkize
  (stadyn, lbf) = let
//
val toks = lexbufobj_get_tokenlst (lbf)
val psms1 = listize_token2psynmark (toks)
val tbf = tokbufobj_make_lexbufobj (lbf)
//
val toks =
  list_vt_reverse (toks)
val () = let
  fun loop (
    tbf: !tokbufobj, toks: tokenlst_vt
  ) : void =
    case+ toks of
    | ~list_vt_cons (tok, toks) => let
        val iscmnt = token_is_comment (tok)
        val () = if ~iscmnt then tokbufobj_unget_token (tbf, tok)
      in
        loop (tbf, toks)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [loop]
in
  loop (tbf, toks)
end // end of [val]
//
val psms2 =
  tokbufobj_get_psynmarklst (stadyn, tbf)
val () = tokbufobj_free (tbf)
//
val (psms1_beg, psms1_end) = psynmarklst_split (psms1)
val (psms2_beg, psms2_end) = psynmarklst_split (psms2)
//
viewtypedef psmlst = psynmarklst_vt
in
  $lst_vt{psmlst} (psms1_end, psms2_end, psms2_beg, psms1_beg)
end // end of [lexbufobj_level1_psynmarkize]

(* ****** ****** *)

(* end of [libatsynmark_psynmark.dats] *)

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

staload _ = "prelude/DATS/list.dats"
staload _ = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "libatsyntax/SATS/libatsyntax.sats"

(* ****** ****** *)

implement
fprint_synmark
  (out, sm) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
  case+ sm of
  | SMnone () => prstr "SMnone"
  | SMcomment () => prstr "SMcomment"
  | SMkeyword () => prstr "SMkeyword"
  | SMextcode () => prstr "SMextcode"
//
  | SMstaexp () => prstr "SMstaexp"
  | SMprfexp () => prstr "SMprfexp"
  | SMdynexp () => prstr "SMdynexp"
  | SMneuexp () => prstr "SMneuexp"
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

staload
SYN = "src/pats_syntax.sats"
//
stadef e0xp = $SYN.e0xp
stadef s0exp = $SYN.s0exp
stadef s0explst = $SYN.s0explst
stadef s0expopt = $SYN.s0expopt
//
stadef p0at = $SYN.p0at
stadef p0atlst = $SYN.p0atlst
stadef d0exp = $SYN.d0exp
stadef d0explst = $SYN.d0explst
//
stadef s0expdef = $SYN.s0expdef
stadef s0expdeflst = $SYN.s0expdeflst
//
stadef q0marglst = $SYN.q0marglst
stadef e0xndeclst = $SYN.e0xndeclst
stadef d0atdeclst = $SYN.d0atdeclst
//
assume d0ecl = $SYN.d0ecl
typedef d0eclist = List (d0ecl)

(* ****** ****** *)

local

staload
LOC = "src/pats_location.sats"
typedef location = $LOC.location

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

typedef fmark_type (a:t@ype) = (a, &res >> res) -> void

(* ****** ****** *)

extern fun e0xp_mark : fmark_type (e0xp)
//
extern fun s0exp_mark : fmark_type (s0exp)
extern fun s0explst_mark : fmark_type (s0explst)
extern fun s0expopt_mark : fmark_type (s0expopt)
//
extern fun p0at_mark : fmark_type (p0at)
extern fun p0atlst_mark : fmark_type (p0atlst)
//
extern fun d0exp_mark : fmark_type (d0exp)
extern fun d0explst_mark : fmark_type (d0explst)
//
extern fun q0marglst_mark : fmark_type (q0marglst)
//
extern fun s0expdeflst_mark : fmark_type (s0expdeflst)
//
extern fun e0xndeclst_mark : fmark_type (e0xndeclst)
//
extern fun d0atdeclst_mark
  (knd: int, ds: d0atdeclst, res: &res >> res): void
// end of [d0atdeclst_mark]

extern fun d0ecl_mark : fmark_type (d0ecl)
extern fun d0eclist_mark : fmark_type (d0eclist)
//
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
  (s0e, res) = let
  val loc = s0e.s0exp_loc
  val () = psynmark_ins_begend (SMstaexp, loc, res)
in
  // nothing
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
  | Some (s0e) => s0expopt_mark (opt, res) | None () => ()
) // end of [s0expopt_mark]

(* ****** ****** *)

implement
d0exp_mark
  (d0e, res) = let
  val loc = d0e.d0exp_loc
  val () = psynmark_ins_begend (SMdynexp, loc, res)
in
  // nothing
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
s0expdeflst_mark
  (ds, res) = let
in
//
case+ ds of
| list_cons (d, ds) => let
    val loc = d.s0expdef_loc
    val () = psynmark_ins_begend (SMstaexp, loc, res)
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
d0ecl_mark
  (d0c, res) = let
  val loc = d0c.d0ecl_loc
  macdef neuexploc_ins () = 
    psynmark_ins_begend (SMneuexp, loc, res)
  macdef staexploc_ins () = 
    psynmark_ins_begend (SMstaexp, loc, res)
  macdef dynexploc_ins () = 
    psynmark_ins_begend (SMdynexp, loc, res)
in
  case+ d0c.d0ecl_node of
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
  | $SYN.D0Csexpdefs _ => staexploc_ins ()
  | $SYN.D0Csaspdec _ => staexploc_ins ()
//
  | $SYN.D0Cexndecs
      (decs) => e0xndeclst_mark (decs, res)
  | $SYN.D0Cdatdecs
      (knd, decs, defs) => let
(*
      val () =
        d0atdeclst_mark (knd, decs, res)
*)
      val () = s0expdeflst_mark (defs, res)
    in
      // nothing
    end // end of [D0Cdatdecs]
//
  | _ => ()
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

in // in of [local]

implement
fileref_get_psynmarklst
  (stadyn, inp) = let
  val d0cs = $PAR.parse_from_fileref_toplevel (stadyn, inp)
  var res: res = list_vt_nil ()
  val () = d0eclist_mark (d0cs, res)
in
  list_vt_reverse (res)
end // end of [fileref_get_psynmarklst]

end // end of [local]

(* ****** ****** *)

(* end of [libatsyntax.dats] *)

(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
overload + with $LOC.location_combine

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload FIX = "./pats_fixity.sats"
staload FIL = "./pats_filename.sats"

(* ****** ****** *)

staload "./pats_basics.sats"
staload "./pats_lexing.sats"
staload "./pats_parsing.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

#define sz2i int_of_size
#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

implement
lamkind_isbox
  (knd) = (
  if knd >= 0
    then (if test_boxkind (knd) then 1 else 0) else 1(*boxed*)
  // end of [if]
) (* end of [lamkind_isbox] *)

(* ****** ****** *)

implement
lamkind_islin
  (knd) = (
  if knd >= 0
    then (if test_linkind (knd) then 1 else 0) else 0(*nonlin*)
  // end of [if]
) (* end of [lamkind_islin] *)

(* ****** ****** *)
//
implement
synent_null {a} () = $UN.cast{a} (null)
//
implement
synent_is_null (x) = ptr_is_null ($UN.cast{ptr} (x))
implement
synent_isnot_null (x) = ptr_isnot_null ($UN.cast{ptr} (x))
//
(* ****** ****** *)

implement
i0nt2int (tok) = let
//
val-T_INT
  (_, rep, _) = tok.token_node in int_of_string (rep)
//
end // end of [i0nt2int]

(* ****** ****** *)
//
implement
i0de_make_sym (loc, sym) = '{ i0de_loc= loc, i0de_sym= sym }
//
(* ****** ****** *)

implement
i0de_make_string
  (loc, name) = let
//
val sym =
  $SYM.symbol_make_string (name) in i0de_make_sym (loc, sym)
//
end // end of [i0de_make_string]

(* ****** ****** *)

implement
i0de_make_lrbrackets
  (t_beg, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  i0de_loc= loc, i0de_sym= $SYM.symbol_LRBRACKETS
} end // end of [i0de_make_lrbrackets]

(* ****** ****** *)

implement
e0fftag_cst (i, id) = let
  val name = $SYM.symbol_get_name (id.i0de_sym)
in '{
  e0fftag_loc= id.i0de_loc, e0fftag_node= E0FFTAGcst (i, name)
} end // end of [e0fftag_cst]

(* ****** ****** *)

local

#define CLO 0
#define CLOPTR ( 1)
#define CLOREF (~1)

fn name_is_prf
  (name: string): bool = name = "prf"
// end of [name_is_prf]

fn name_is_lin0 (name: string): bool = 
  if name = "lin" then true else name = "lin0"
fn name_is_lin1 (name: string): bool = name = "lin1"

fn name_is_fun0 (name: string): bool = 
  if name = "fun" then true else name = "fun0"
fn name_is_fun1 (name: string): bool = name = "fun1"

fn name_is_linfun0 (name: string): bool = 
  if name = "linfun" then true else name = "linfun0"
fn name_is_linfun1 (name: string): bool = name = "linfun1"

fn name_is_clo0 (name: string): bool =
  if name = "clo" then true else name = "clo0"
fn name_is_clo1 (name: string): bool = name = "clo1"

fn name_is_linclo0 (name: string): bool =
  if name = "linclo" then true else name = "linclo0"
fn name_is_linclo1 (name: string): bool = name = "linclo1"

fn name_is_cloptr0 (name: string): bool = 
  if name = "cloptr" then true else name = "cloptr0"
fn name_is_cloptr1 (name: string): bool = name = "cloptr1"

fn name_is_lincloptr0 (name: string): bool = 
  if name = "lincloptr" then true else name = "lincloptr0"
fn name_is_lincloptr1 (name: string): bool = name = "lincloptr1"

fn name_is_cloref0 (name: string): bool = 
  if name = "cloref" then true else name = "cloref0"
fn name_is_cloref1 (name: string): bool = name = "cloref1"

in (* in of [local] *)

implement
e0fftag_i0de (id) = let
  val name = $SYM.symbol_get_name (id.i0de_sym)
  val node = (case+ name of
//
    | _ when name_is_prf name => E0FFTAGprf
//
    | _ when name_is_clo0 name => E0FFTAGclo (~1(*u*), CLO, 0)
    | _ when name_is_clo1 name => E0FFTAGclo (~1(*u*), CLO, 1)
    | _ when name_is_linclo0 name => E0FFTAGclo (1(*l*), CLO, 0)
    | _ when name_is_linclo1 name => E0FFTAGclo (1(*l*), CLO, 1)
//
    | _ when name_is_cloptr0 name => E0FFTAGclo (~1(*u*), CLOPTR, 0)
    | _ when name_is_cloptr1 name => E0FFTAGclo (~1(*u*), CLOPTR, 1)
    | _ when name_is_lincloptr0 name => E0FFTAGclo (1(*l*), CLOPTR, 0)
    | _ when name_is_lincloptr1 name => E0FFTAGclo (1(*l*), CLOPTR, 1)
//
    | _ when name_is_cloref0 name => E0FFTAGclo (0(*n*), CLOREF, 0)
    | _ when name_is_cloref1 name => E0FFTAGclo (0(*n*), CLOREF, 1)
//
    | _ when name_is_fun0 name => E0FFTAGfun (~1(*u*), 0)
    | _ when name_is_fun1 name => E0FFTAGfun (~1(*u*), 1)
    | _ when name_is_linfun0 name => E0FFTAGfun (1(*l*), 0)
    | _ when name_is_linfun1 name => E0FFTAGfun (1(*l*), 1)
//
    | _ when name_is_lin0 name => E0FFTAGlin 0
    | _ when name_is_lin1 name => E0FFTAGlin 1
//
    | _ => E0FFTAGvar id
  ) : e0fftag_node // end of [val]
//
in '{
  e0fftag_loc= id.i0de_loc, e0fftag_node= node
} end // end of [e0fftag_var]

end // end of [local]

implement
e0fftag_var_fun (t) = '{
  e0fftag_loc= t.token_loc
, e0fftag_node= E0FFTAGfun (~1(*u*), 0)
} // end of [e0fftag_var_fun]

implement
e0fftag_i0nt (tok) = let
  val int = i0nt2int (tok)
in '{
  e0fftag_loc= tok.token_loc, e0fftag_node= E0FFTAGint (int)
} end // end of [e0fftag_int]

(* ****** ****** *)
//
// HX: omitted precedence is assumed to equal 0
//
implement
p0rec_emp () = P0RECint (0)
//
implement
p0rec_i0nt (tok) = let
  val pval = i0nt2int (tok) in P0RECint (pval)
end // end of [p0rec_i0nt]
//
implement
p0rec_i0de (id) = P0RECi0de (id)
//
implement
p0rec_i0de_adj
  (id, opr, i0nt) = let
  val adj = i0nt2int (i0nt) in P0RECi0de_adj (id, opr, adj)
end // end of [p0rec_i0de_adj]
//
(* ****** ****** *)

implement
e0xp_i0de (id) = '{
  e0xp_loc= id.i0de_loc, e0xp_node= E0XPide id.i0de_sym
} // end of [e0xp_ide]

implement
e0xp_i0nt (tok) = let
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPint (tok)
} end // end of [e0xp_i0nt]

implement
e0xp_c0har (tok) = let
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPchar (tok)
} end // end of [e0xp_c0har]

implement
e0xp_f0loat (tok) = let
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPfloat (tok)
} end // end of [e0xp_f0loat]

implement
e0xp_s0tring (tok) = let
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPstring (tok)
} end // end of [e0xp_s0tring]

implement
e0xp_app (e1, e2) = let
  val loc = e1.e0xp_loc + e2.e0xp_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPapp (e1, e2)
} end // end of [e0xp_app]

implement
e0xp_eval (
  t_beg, e, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPeval e
} end // end of [e0xp_eval]

implement
e0xp_list (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPlist xs
} end // end of [e0xp_list]

implement
e0xp_if (
  t_if, _cond, _then, _else
) = let
  val loc = (case+ _else of
    | Some e => t_if.token_loc + e.e0xp_loc
    | None _ => t_if.token_loc + _then.e0xp_loc
  ) : location // end of [val]
in '{
  e0xp_loc= loc, e0xp_node= E0XPif (_cond, _then, _else)
} end // end of [e0xp_if]

implement
e0xp_make_stringid (loc, id) = '{
  e0xp_loc= loc, e0xp_node= E0XPstringid (id)
} // end of [e0xp_make_stringid]

(* ****** ****** *)
//
// HX: this is for supporting definitions like
// #define fversion (x, y, z) (1000 *((1000 * x) + y) + z)
//
fn e0xp_fun (
  loc: location, arg: symbolist, body: e0xp
) : e0xp = '{
  e0xp_loc= loc, e0xp_node= E0XPfun (arg, body)
}
extern
fun e0xp_funize
  (e0: e0xp, flag: &int): e0xp
implement
e0xp_funize (e0, flag) = let
  fun argtest (es: e0xplst): bool =
    case+ es of
    | list_cons (e, es) => (
      case+ e.e0xp_node of E0XPide _ => argtest (es) | _ => false
      ) // end of [list_cons]
    | list_nil () => true
  // end of [argtest]
  fun applst (e: e0xp, es: List_vt (e0xp)): e0xp =
    case+ es of
    | ~list_vt_cons (e1, es1) => let
        val e = e0xp_app (e, e1) in applst (e, es1)
      end
    | ~list_vt_nil () => e
  // end of [applist]
  fun auxfun (
    e0: e0xp, e1: e0xp, e2: e0xp, es2: List_vt (e0xp), flag: &int
  ) : e0xp = case+ e1.e0xp_node of
  | E0XPapp (e1n, e2n) => auxfun (e0, e1n, e2n, list_vt_cons (e2, es2), flag)
  | E0XPlist (es)
      when argtest (es) => let
      fn f (e: e0xp): symbol =
        let val-E0XPide x = e.e0xp_node in x end
      // end of [f]
      val xs = l2l (list_map_fun (es, f))
      val () = flag := flag + 1
    in
      e0xp_fun (e0.e0xp_loc, xs, applst (e2, es2))
    end
  | _ => let
      val () = list_vt_free (es2) in e0
    end
in
  case+ e0.e0xp_node of
  | E0XPapp (e1, e2) => auxfun (e0, e1, e2, list_vt_nil, flag)
  | _ => e0
end // end of [e0xp_funize]

(* ****** ****** *)

implement
datsdef_make
  (id, opt) = DATSDEF (id.i0de_sym, opt)
// end of [datsdef_make]

(* ****** ****** *)

implement
l0ab_make_label
  (loc, lab) = '{
  l0ab_loc= loc, l0ab_lab= lab
} // end of [l0ab_make_lab]

implement
l0ab_make_i0de (x) = let
  val lab =
    $LAB.label_make_sym (x.i0de_sym)
  // end of [val]
in
  l0ab_make_label (x.i0de_loc, lab)
end // end of [l0ab_make_i0de]

implement
l0ab_make_i0nt (x) = let
  val i = i0nt2int (x)
  val lab = $LAB.label_make_int (i)
in
  l0ab_make_label (x.token_loc, lab)
end // end of [l0ab_make_i0nt]

(* ****** ****** *)

implement
i0de_make_dotlab
  (t_dot, l0) = let
//
val loc =
  t_dot.token_loc + l0.l0ab_loc
val l = l0.l0ab_lab
val dotsym = $LAB.label_dotize (l)
//
in
  i0de_make_sym (loc, dotsym)
end // end of [i0de_make_dotlab]

(* ****** ****** *)

implement
s0rtq_none(loc) = '{
  s0rtq_loc= loc, s0rtq_node= S0RTQnone ()
} // end of [s0rtq_none]

implement
s0rtq_symdot(ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  s0rtq_loc= loc, s0rtq_node= S0RTQsymdot(ent1.i0de_sym)
} end // end of [s0rtq_symdot]

(* ****** ****** *)
//
implement
the_s0taq_none =
  s0taq_none($LOC.location_dummy)
//
implement
s0taq_none (loc) = '{
  s0taq_loc= loc, s0taq_node= S0TAQnone()
} // end of [s0taq_none]
//
implement
s0taq_symdot (ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  s0taq_loc= loc, s0taq_node= S0TAQsymdot(ent1.i0de_sym)
} end // end of [s0taq_symdot]
//
(*
//
// HX-2017-01-24:
// removed as it is never in use
//
implement
s0taq_symcolon (ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  s0taq_loc= loc, s0taq_node= S0TAQsymcolon (ent1.i0de_sym)
} end // end of [s0taq_symcolon]
*)
//
implement
s0taq_is_none (q) =
  case q.s0taq_node of S0TAQnone () => true | _ => false
// end of [s0taq_is_none]
//
(* ****** ****** *)

implement
sqi0de_make_none (ent) = let
  val loc = ent.i0de_loc
  val qua = s0taq_none (loc)
in '{
  sqi0de_loc= loc
, sqi0de_qua= qua, sqi0de_sym= ent.i0de_sym
} end // end of [sqi0de_make_node]

implement
sqi0de_make_some
  (ent1, ent2) = let
  val loc = ent1.s0taq_loc + ent2.i0de_loc
in '{
  sqi0de_loc= loc
, sqi0de_qua= ent1, sqi0de_sym= ent2.i0de_sym
} end // end of [sqi0de_make_some]

(* ****** ****** *)

implement
the_d0ynq_none = d0ynq_none ($LOC.location_dummy)

implement
d0ynq_none(loc) = '{
  d0ynq_loc= loc, d0ynq_node= D0YNQnone ()
} // end of [d0ynq_none]

implement
d0ynq_symdot
  (ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  d0ynq_loc= loc, d0ynq_node= D0YNQsymdot(ent1.i0de_sym)
} end // end of [d0ynq_symdot]

(* ****** ****** *)

(*
//
// HX-2017-01-24:
// removed due to no use
//
implement
d0ynq_symcolon
  (ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  d0ynq_loc= loc, d0ynq_node= D0YNQsymcolon(ent1.i0de_sym)
} end // end of [d0ynq_symcolon]
//
implement
d0ynq_symdotcolon
  (ent1, ent2, ent3) = let
  val loc = ent1.i0de_loc + ent3.token_loc
in '{
  d0ynq_loc= loc
, d0ynq_node= D0YNQsymdotcolon(ent1.i0de_sym, ent2.i0de_sym)
} end // end of [d0ynq_symdotcolon]
//
*)

(* ****** ****** *)

implement
d0ynq_is_none (q) =
  case q.d0ynq_node of D0YNQnone() => true | _ => false
// end of [d0ynq_is_none]

(* ****** ****** *)

implement
dqi0de_make_none (ent) = let
  val loc = ent.i0de_loc
  val qua = d0ynq_none (loc)
in '{
  dqi0de_loc= loc
, dqi0de_qua= qua, dqi0de_sym= ent.i0de_sym
} end // end of [dqi0de_make_node]

implement
dqi0de_make_some
  (ent1, ent2) = let
  val loc = ent1.d0ynq_loc + ent2.i0de_loc
in '{
  dqi0de_loc= loc
, dqi0de_qua= ent1, dqi0de_sym= ent2.i0de_sym
} end // end of [dqi0de_make_some]

(* ****** ****** *)

implement
s0rt_i0de (id) = '{
  s0rt_loc= id.i0de_loc, s0rt_node= S0RTide id.i0de_sym
} // end of [s0rt_ide]

implement
s0rt_qid (ent1, ent2) = let
  val loc = ent1.s0rtq_loc + ent2.i0de_loc
in '{
  s0rt_loc= loc, s0rt_node= S0RTqid (ent1, ent2.i0de_sym)
} end // end of [s0rt_ide]

implement
s0rt_app (x1, x2) = let
  val loc = x1.s0rt_loc + x2.s0rt_loc
in '{
  s0rt_loc= loc, s0rt_node= S0RTapp (x1, x2)
} end // end of [s0rt_app]

implement
s0rt_list (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0rt_loc= loc, s0rt_node= S0RTlist (xs)
} end // end of [s0rt_list]

implement
s0rt_type (x) = let
  val-T_TYPE (knd) = x.token_node
in '{
  s0rt_loc= x.token_loc, s0rt_node= S0RTtype (knd)
} end // end of [s0rt_i0nt]

(* ****** ****** *)

implement
d0atsrtcon_make
  (id, arg) = let
  val loc = (case+ arg of
    | Some s0t => id.i0de_loc + s0t.s0rt_loc
    | None () => id.i0de_loc
  ) : location // end of [val]
in '{
  d0atsrtcon_loc= loc
, d0atsrtcon_sym= id.i0de_sym
, d0atsrtcon_arg= arg
} end // end of [d0atsrtcon_make]

implement
d0atsrtdec_make
  (id, tok, xs) = let
  fun loop (
    id: i0de, x: d0atsrtcon, xs: d0atsrtconlst
  ) : location =
    case+ xs of
    | list_cons (x, xs) => loop (id, x, xs)
    | list_nil () => id.i0de_loc + x.d0atsrtcon_loc
  // end of [loop]
  val loc = (
    case+ xs of
    | list_cons (x, xs) => loop (id, x, xs)
    | list_nil () => id.i0de_loc + tok.token_loc
  ) : location // end of [val]
in '{
  d0atsrtdec_loc= loc
, d0atsrtdec_sym= id.i0de_sym, d0atsrtdec_con= xs
} end // end of [d0atsrtdec_make]

(* ****** ****** *)

implement
s0arg_make (x1, x2) = let
  val loc = (case x2 of
    | Some s0t => x1.i0de_loc + s0t.s0rt_loc
    | None () => x1.i0de_loc
  ) : location // end of [val]
in '{
  s0arg_loc= loc, s0arg_sym= x1.i0de_sym, s0arg_srt= x2
} end // end of [s0arg_make]

(* ****** ****** *)

implement
s0marg_make_one (x) = '{
  s0marg_loc= x.s0arg_loc, s0marg_arg= list_sing (x)
} // end of [s0marg_make_one]

implement
s0marg_make_many
  (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0marg_loc= loc, s0marg_arg= xs
} end // end of [s0marg_make_many]

(* ****** ****** *)

implement
a0srt_make_none (s0t) = '{
  a0srt_loc= s0t.s0rt_loc
, a0srt_sym= None (), a0srt_srt= s0t
} // end of [a0srt_make_none]

implement
a0srt_make_some
  (id, s0t) = let
  val loc = id.i0de_loc + s0t.s0rt_loc
in '{
  a0srt_loc= loc
, a0srt_sym= Some (id.i0de_sym), a0srt_srt= s0t
} end // end of [a0srt_make_some]

implement
a0msrt_make
  (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  a0msrt_loc= loc, a0msrt_arg= xs
} end // end of [a0msrt_make]

(* ****** ****** *)

implement
s0arrdim_make (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0arrdim_loc= loc, s0arrdim_dim = xs
} end // end of [s0arrdim]

implement
s0rtext_srt (s0t) = '{
  s0rtext_loc= s0t.s0rt_loc, s0rtext_node= S0TEsrt s0t
} // end of [s0rtext_srt]

implement
s0rtext_sub (
  t_beg, id, s0te, s0e, s0es, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0rtext_loc= loc, s0rtext_node= S0TEsub (id, s0te, s0e, s0es)
} end // end of [s0rtext_sub]

implement
s0qua_prop (s0e) = '{
  s0qua_loc= s0e.s0exp_loc, s0qua_node= S0QUAprop s0e
}

implement
s0qua_vars (id, ids, s0te) = let
  val loc = id.i0de_loc + s0te.s0rtext_loc
in '{
  s0qua_loc= loc, s0qua_node= S0QUAvars (id, ids, s0te)
} end // end of [s0qua_vars]

(* ****** ****** *)

implement
q0marg_make
  (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  q0marg_loc= loc, q0marg_arg= xs
} end // end of [q0marg]

(* ****** ****** *)

implement
a0typ_make_none (s0e) = '{
  a0typ_loc= s0e.s0exp_loc
, a0typ_sym= None (), a0typ_typ= s0e
} // end of [a0typ_make_none]

implement
a0typ_make_some
  (id, s0e) = let
  val loc = id.i0de_loc + s0e.s0exp_loc
in '{
  a0typ_loc= loc
, a0typ_sym= Some (id.i0de_sym), a0typ_typ= s0e
} end // end of [a0typ_make_some]

(* ****** ****** *)

implement
s0exp_tkname (str) = let
  val loc = str.token_loc
  val-T_STRING (name) = str.token_node
in '{
  s0exp_loc= loc, s0exp_node= S0Eextkind (name, list_nil ())
} end // end of [s0exp_tkname]

(* ****** ****** *)

local
//
fun loop {n:nat} .<n>. (
  tok: token, x: s0exp, xs: list (s0exp, n)
) : location =
  case+ xs of
  | list_cons (x, xs) => loop (tok, x, xs)
  | list_nil () => tok.token_loc + x.s0exp_loc
// end of [loop]
//
in (* in of [local] *)
//
implement
s0exp_extype
  (tok1, tok2, xs) = let
  val-T_STRING (name) = tok2.token_node
  val loc = (case+ xs of
    | list_nil () => tok1.token_loc + tok2.token_loc
    | list_cons (x, xs) => loop (tok1, x, xs)
  ) : location // end of [val]
in '{
  s0exp_loc= loc, s0exp_node= S0Eextype (name, xs)
} end // end of [s0exp_extype]
//
implement
s0exp_extkind
  (tok1, tok2, xs) = let
  val-T_STRING (name) = tok2.token_node
  val loc = (case+ xs of
    | list_nil () => tok1.token_loc + tok2.token_loc
    | list_cons (x, xs) => loop (tok1, x, xs)
  ) : location // end of [val]
in '{
  s0exp_loc= loc, s0exp_node= S0Eextkind (name, xs)
} end // end of [s0exp_extkind]
//
end // end of [local]

(* ****** ****** *)

implement
s0exp_i0de (id) = '{
  s0exp_loc= id.i0de_loc, s0exp_node= S0Eide (id.i0de_sym)
} (* end of [s0exp_i0de] *)

(* ****** ****** *)

implement
s0exp_opid (x1, x2) = let
  val loc = x1.token_loc + x2.i0de_loc
in '{
  s0exp_loc= loc
, s0exp_node= S0Eopid (x2.i0de_sym)
} end // end of [s0exp_opid]

implement
s0exp_sqid (sq, id) = let
  val loc = sq.s0taq_loc + id.i0de_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Esqid (sq, id.i0de_sym)
} end // end of [s0exp_sqid]

(* ****** ****** *)

implement
s0exp_i0nt (x) = let
in '{
  s0exp_loc= x.token_loc, s0exp_node= S0Eint (x)
} end // end of [s0exp_i0nt]

implement
s0exp_c0har (x) = let
in '{
  s0exp_loc= x.token_loc, s0exp_node= S0Echar (x)
} end // end of [s0exp_c0har]

(* ****** ****** *)

implement
s0exp_f0loat (x) = let
in '{
  s0exp_loc= x.token_loc, s0exp_node= S0Efloat (x)
} end // end of [s0exp_f0loat]

implement
s0exp_s0tring (x) = let
in '{
  s0exp_loc= x.token_loc, s0exp_node= S0Estring (x)
} end // end of [s0exp_string]

(* ****** ****** *)

implement
s0exp_app (x1, x2) = let
  val loc = x1.s0exp_loc + x2.s0exp_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Eapp (x1, x2)
} end // end of [s0exp_app]

(* ****** ****** *)

implement
s0exp_imp (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Eimp (xs)
} end // end of [s0exp_imp]

implement
s0exp_imp_nil (tok) = '{
  s0exp_loc= tok.token_loc, s0exp_node= S0Eimp (list_nil)
} // end of [s0exp_imp_nil]

(* ****** ****** *)

fn s0exp_lam (
  loc: location
, arg: s0marg, res: s0rtopt, body: s0exp
) : s0exp = '{
  s0exp_loc= loc, s0exp_node = S0Elam (arg, res, body)
} // end of [s0exp_lam]

implement
s0exp_lams (
  t_beg, args, res, body
) = let
  val loc = t_beg.token_loc + body.s0exp_loc
  fun aux (
    arg0: s0marg, args: s0marglst
  ) :<cloref1> s0exp =
    case+ args of
    | list_cons (arg, args) =>
        s0exp_lam (loc, arg0, None (), aux (arg, args))
      // end of [list_cons]
    | list_nil () => s0exp_lam (loc, arg0, res, body)
  // end of [val]
in
  case+ args of
  | list_cons (arg, args) => aux (arg, args) | list_nil () => body
end // end of [s0exp_lams]

(* ****** ****** *)

implement
s0exp_list (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Elist (xs)
} end // end of [s0exp_list]

implement
s0exp_list2 (t_beg, xs1, xs2, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Elist2 (xs1, xs2)
} end // end of [s0exp_list2]

(* ****** ****** *)

implement
s0exp_tyarr (
  t_beg, elt, dim
) = let
//
val loc =
  t_beg.token_loc + dim.s0arrdim_loc
//
in '{
  s0exp_loc= loc
, s0exp_node= S0Etyarr(elt, dim.s0arrdim_dim)
} end // end of [s0exp_tyarr]

(* ****** ****** *)

implement
s0exp_tytup (
  knd, t_beg, npf, xs, t_end
) = let
//
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  s0exp_loc= loc, s0exp_node= S0Etytup(knd, npf, xs)
} end // end of [s0exp_tytup]

(* ****** ****** *)

implement
s0exp_tyrec (
  knd, t_beg, npf, xs, t_end
) = let
//
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  s0exp_loc= loc, s0exp_node= S0Etyrec(knd, npf, xs)
} end // end of [s0exp_tyrec]

implement
s0exp_tyrec_ext (
  name, t_beg, npf, xs, t_end
) = let
//
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  s0exp_loc= loc, s0exp_node= S0Etyrec_ext(name, npf, xs)
} end // end of [s0exp_tyrec]

(* ****** ****** *)

implement
s0exp_uni (
  t_beg, xs, t_end
) = let
//
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  s0exp_loc= loc, s0exp_node= S0Euni(xs)
} end // end of [s0exp_uni]

implement
s0exp_exi (
  funres, t_beg, xs, t_end
) = let
//
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  s0exp_loc= loc, s0exp_node= S0Eexi(funres, xs)
} end // end of [s0exp_exi]

(* ****** ****** *)

implement
s0exp_ann(s0e, s0t) = let
//
val loc = s0e.s0exp_loc + s0t.s0rt_loc
//
in '{
  s0exp_loc= loc, s0exp_node= S0Eann(s0e, s0t)
} end // end of [s0exp_ann]

(* ****** ****** *)

implement
s0exp_d2ctype
  (t_beg, d2ctp, t_end) = let
//
val loc = t_beg.token_loc + t_end.token_loc
//
in '{
  s0exp_loc= loc, s0exp_node= S0Ed2ctype(d2ctp)
} end // end of [s0exp_d2ctype]

(* ****** ****** *)

implement
labs0exp_make
  (lab, name, s0e) = SL0ABELED(lab, name, s0e)
// end of [labs0exp_make]

(* ****** ****** *)

implement
m0acarg_dyn (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  m0acarg_loc= loc, m0acarg_node= M0ACARGdyn (xs)
} end // end of [m0acarg_dyn]

implement
m0acarg_sing (x) = '{
  m0acarg_loc= x.i0de_loc, m0acarg_node= M0ACARGdyn (list_sing x)
} // end of [m0acarg]

implement
m0acarg_sta (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  m0acarg_loc= loc, m0acarg_node= M0ACARGsta (xs)
} end // end of [m0acarg_sta]

(* ****** ****** *)

implement
d0cstarg_sta (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0cstarg_loc= loc
, d0cstarg_node= D0CSTARGsta (xs)
} end // end of [d0cstarg_sta]

implement
d0cstarg_dyn (
  npf, t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0cstarg_loc= loc
, d0cstarg_node= D0CSTARGdyn (npf, xs)
} end // end of [d0cstarg_dyn]

(* ****** ****** *)

implement
s0rtdef_make (id, def) = let
(*
  val () = print "s0rtdef_make:\n"
  val () = begin
    print "def.loc = "; print def.s0rtext_loc; print_newline ()
  end // end of [val]
*)
  val loc = id.i0de_loc + def.s0rtext_loc
in '{
  s0rtdef_loc= loc
, s0rtdef_sym= id.i0de_sym
, s0rtdef_def= def
} end // end of [s0rtdef_make]

(* ****** ****** *)

implement
s0tacon_make
  (id, arg, def) = let
  val loc_id = id.i0de_loc
  val loc = (case+ def of
    | Some s0e => loc_id + s0e.s0exp_loc
    | None () => (
      case+ list_last_opt<a0msrt> (arg) of
      | ~Some_vt x => loc_id + x.a0msrt_loc | ~None_vt () => loc_id
      ) // end of [None]
  ) : location // end of [val]
in '{
  s0tacon_loc= loc
, s0tacon_sym= id.i0de_sym
, s0tacon_arg= arg
, s0tacon_def= def
} end // end of [s0tacon_make_some_some]

(* ****** ****** *)
//
implement
s0tacst_make
(
  id, arg, s0t, extopt
) = let
  val loc = id.i0de_loc + s0t.s0rt_loc
in '{
//
  s0tacst_loc= loc
, s0tacst_sym= id.i0de_sym
, s0tacst_arg= arg
, s0tacst_res= s0t
//
, s0tacst_extopt= extopt
//
} end // end of [s0tacst_make]
//
(* ****** ****** *)

(*
//
// HX-2012-05-23: removed
//
implement
s0tavar_make
  (id, s0t) = let
  val loc = id.i0de_loc + s0t.s0rt_loc
in '{
  s0tavar_loc= loc
, s0tavar_sym= id.i0de_sym
, s0tavar_srt= s0t
} end // end of [s0tavar_make]
*)

(* ****** ****** *)

implement
t0kindef_make
  (id, def) = let
  val loc_id = id.i0de_loc
  val loc = loc_id + def.token_loc
  val def = s0exp_tkname (def)
in '{
  t0kindef_loc= loc
, t0kindef_sym= id.i0de_sym
, t0kindef_loc_id= loc_id
, t0kindef_def= def
} end // end of [t0kindef_make]

(* ****** ****** *)

implement
s0expdef_make (
 id, arg, res, def
) = let
  val loc_id = id.i0de_loc
  val loc = loc_id + def.s0exp_loc
in '{
  s0expdef_loc= loc
, s0expdef_sym= id.i0de_sym
, s0expdef_loc_id= loc_id
, s0expdef_arg= arg
, s0expdef_res= res
, s0expdef_def= def
} end // end of [s0expdef_make]

(* ****** ****** *)

implement
s0aspdec_make (
  qid, arg, res, def
) = let
  val loc = qid.sqi0de_loc + def.s0exp_loc
in '{
  s0aspdec_loc= loc
, s0aspdec_qid= qid
, s0aspdec_arg= arg
, s0aspdec_res= res
, s0aspdec_def= def
} end // end of [s0aspdec_make]

(* ****** ****** *)

implement
e0xndec_make
  (qua, id, arg) = let
  val loc_hd = (case+ qua of
    | list_cons (x, _) => x.q0marg_loc
    | list_nil () => id.i0de_loc
  ) : location
  val loc = (case+ arg of
    | Some s0e => loc_hd + s0e.s0exp_loc | None () => loc_hd
  ) : location // end of [val]
  val fil = $FIL.filename_get_current ()
in '{
  e0xndec_loc= loc
, e0xndec_fil= fil
, e0xndec_sym= id.i0de_sym
, e0xndec_qua= qua
, e0xndec_arg= arg
} end // end of [e0xndec_make]

(* ****** ****** *)

implement
d0atcon_make
  (qua, id, ind, arg) = let
//
val
loc_hd = (
  case+ qua of
  | list_nil() => id.i0de_loc
  | list_cons(x, _) => x.q0marg_loc
) : location
//
val loc = (
  case+ arg of
  | Some s0e => loc_hd + s0e.s0exp_loc
  | None () =>
    (
      case+ ind of
      | Some s0e => loc_hd + s0e.s0exp_loc | _ => loc_hd
    ) (* end of [None] *)
) : location // end of [val]
//
in '{
  d0atcon_loc= loc
, d0atcon_sym= id.i0de_sym
, d0atcon_qua= qua
, d0atcon_arg= arg
, d0atcon_ind= ind
} end // end of [d0atcon_make]

(* ****** ****** *)

implement
d0atdec_make (
  id, arg, con
) = let
  val loc_id = id.i0de_loc
  val loc = (case+
    list_last_opt<d0atcon> (con) of
    ~Some_vt (x) => loc_id + x.d0atcon_loc
  | ~None_vt _ => loc_id
  ) : location // end of [val]
  val loc_hd = (case+
    list_last_opt<a0msrt> (arg) of
    ~Some_vt (x) => loc_id + x.a0msrt_loc
  | ~None_vt _ => loc_id
  ) : location // end of [val]
  val fil = $FIL.filename_get_current ()
in '{
  d0atdec_loc= loc
, d0atdec_loc_hd= loc_hd
, d0atdec_fil= fil
, d0atdec_sym= id.i0de_sym
, d0atdec_arg= arg
, d0atdec_con= con
} end // end of [d0atdec_make]

(* ****** ****** *)

implement
dcstextdef_sta (sym) =
  DCSTEXTDEFsome_sta ($SYM.symbol_get_name (sym))

(* ****** ****** *)
//
implement
dcstextdef_is_ext(x) =
(
  case+ x of DCSTEXTDEFsome_ext _ => true | _ => false
) // end of [dcstextdef_is_ext]
implement
dcstextdef_is_mac(x) =
(
  case+ x of DCSTEXTDEFsome_mac _ => true | _ => false
) // end of [dcstextdef_is_mac]
implement
dcstextdef_is_sta(x) =
(
  case+ x of DCSTEXTDEFsome_sta _ => true | _ => false
) // end of [dcstextdef_is_sta]
//
(* ****** ****** *)

implement
dcstextdef_is_mainats (x) = let
//
extern
fun test_prefix (
  string: string, prfx: string
) :<> bool
  = "ext#patsopt_string_test_prefix"
//
in
//
case+ x of
| DCSTEXTDEFsome_ext
    (name) => test_prefix (name, "mainats")
| _ (*non-extern*) => false
//
end // end of [dcstextdef_is_mainats]

(* ****** ****** *)

implement
d0cstdec_make
(
  id, arg, eff, res, extopt
) = let
  val fil = $FIL.filename_get_current ()
  val loc = (
    case+ extopt of
    | Some s0 => id.i0de_loc + s0.token_loc
    | None () => id.i0de_loc + res.s0exp_loc
  ) : location // end of [val]
in '{
  d0cstdec_loc= loc
, d0cstdec_fil= fil
, d0cstdec_sym= id.i0de_sym
, d0cstdec_arg= arg
, d0cstdec_eff= eff
, d0cstdec_res= res
, d0cstdec_extopt= extopt
} end // end of [d0cstdec_make]

(* ****** ****** *)

implement
p0at_i0de (id) = '{
  p0at_loc= id.i0de_loc, p0at_node= P0Tide id.i0de_sym
} (* end of [p0at_i0de] *)

implement
p0at_dqid (ent1, ent2) = let
  val loc = ent1.d0ynq_loc + ent2.i0de_loc
in '{
  p0at_loc= loc, p0at_node= P0Tdqid (ent1, ent2.i0de_sym)
} end // end of [p0at_ide]

implement
p0at_opid (x1, x2) = let
  val loc = x1.token_loc + x2.i0de_loc
in '{
  p0at_loc= loc, p0at_node= P0Topid (x2.i0de_sym)
} end // end of [p0at_opid]

(* ****** ****** *)

implement
p0at_i0nt (tok) = '{
  p0at_loc= tok.token_loc, p0at_node= P0Tint (tok)
}
implement
p0at_c0har (tok) = '{
  p0at_loc= tok.token_loc, p0at_node= P0Tchar (tok)
}
implement
p0at_f0loat (tok) = '{
  p0at_loc= tok.token_loc, p0at_node= P0Tfloat (tok)
}
implement
p0at_s0tring (tok) = '{
  p0at_loc= tok.token_loc, p0at_node= P0Tstring (tok)
}

(* ****** ****** *)

implement
p0at_app (p0t1, p0t2) = let
  val loc = p0t1.p0at_loc + p0t2.p0at_loc
in '{
  p0at_loc= loc, p0at_node= P0Tapp (p0t1, p0t2)
} end // end of [p0at_app]

(* ****** ****** *)

implement
p0at_list
  (t_beg, npf, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  p0at_loc= loc, p0at_node= P0Tlist (npf, xs)
} end // end of [p0at_list]

(* ****** ****** *)

implement
p0at_lst
(
  lin, t_beg, p0ts, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  p0at_loc= loc, p0at_node= P0Tlst (lin, p0ts)
} end // end of [p0at_lst]

(*
//
// HX-2014-07:
// a list-pattern
// like '[x1, x2] is no longer supported
//
implement
p0at_lst_quote
(
  t_beg, p0ts, t_end
) = p0at_lst (0(*lin*), t_beg, p0ts, t_end)
*)

(* ****** ****** *)

implement
p0at_tup (
  knd, t_beg, npf, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  p0at_loc= loc, p0at_node= P0Ttup (knd, npf, xs)
} end // end of [p0at_tup]

implement
p0at_rec (
  knd, t_beg, npf, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  p0at_loc= loc, p0at_node= P0Trec (knd, npf, xs)
} end // end of [p0at_rec]

(* ****** ****** *)

implement
p0at_free (t_tilde, p0t) = let
  val loc = t_tilde.token_loc + p0t.p0at_loc
in '{
  p0at_loc= loc, p0at_node= P0Tfree (p0t)
} end // end of [p0at_free]

implement
p0at_unfold (t_tilde, p0t) = let
  val loc = t_tilde.token_loc + p0t.p0at_loc
in '{
  p0at_loc= loc, p0at_node= P0Tunfold (p0t)
} end // end of [p0at_unfold]

(* ****** ****** *)

implement
p0at_svararg
  (t_beg, arg, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  p0at_loc= loc, p0at_node= P0Tsvararg (arg)
} end // end of [p0at_svararg]

implement
p0at_exist
  (t_beg, qua, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  p0at_loc= loc, p0at_node= P0Texist (qua)
} end // end of [p0at_exist]

(* ****** ****** *)

implement
p0at_refas (p0t1, p0t2) = let
  val loc1 = p0t1.p0at_loc
  val loc = loc1 + p0t2.p0at_loc
in
//
case+ p0t1.p0at_node of
| P0Tide (id) => '{
    p0at_loc= loc
  , p0at_node= P0Trefas (id, loc1, p0t2)
  } // end of [P0Tide]
| _ => let
    val err = parerr_make (p0t1.p0at_loc, PE_p0at_as)
    val () = the_parerrlst_add (err)
  in
    p0at_err (loc)
  end
end // end of [p0at_as]

(* ****** ****** *)

implement
p0at_ann (p0t, s0e) = let
  val loc = p0t.p0at_loc + s0e.s0exp_loc
in '{
  p0at_loc= loc, p0at_node= P0Tann (p0t, s0e)
} end // end of [p0at_ann]

(* ****** ****** *)

implement
p0at_err (loc) = '{
  p0at_loc= loc, p0at_node= P0Terr ()
}

(* ****** ****** *)

implement
labp0at_norm (l, p) = let
  val loc = l.l0ab_loc + p.p0at_loc
in '{
  labp0at_loc= loc, labp0at_node= LABP0ATnorm (l, p)
} end // end of [labp0at_norm]

implement
labp0at_omit (tok) = '{
  labp0at_loc= tok.token_loc, labp0at_node= LABP0ATomit ()
} // end of [labp0at_omit]

(* ****** ****** *)

implement
i0mparg_sarglst_none
  () = I0MPARG_sarglst (list_nil)
// end of [i0mparg_sarglst_none]

implement
i0mparg_sarglst_some
  (t_beg, xs, t_end) = I0MPARG_sarglst (xs)
// end of [i0mparg_sarglst]

implement
i0mparg_svararglst (xs) = I0MPARG_svararglst (xs)

(* ****** ****** *)

implement
t0mpmarg_make
  (tok, arg) = let
  val loc = tok.token_loc
  val loc = (
    case+ list_last_opt<s0exp> (arg) of
    | ~Some_vt (x) => loc + x.s0exp_loc
    | ~None_vt () => $LOC.location_leftmost (loc)
  ) : location // end of [val]
in '{
  t0mpmarg_loc= loc, t0mpmarg_arg= arg
} end // end of [t0mpmarg_make]

implement
impqi0de_make_none (qid) = '{
  impqi0de_loc= qid.dqi0de_loc
, impqi0de_qua= qid.dqi0de_qua
, impqi0de_sym= qid.dqi0de_sym
, impqi0de_arg= list_nil ()
} // end of [impqi0de_make_none]

implement
impqi0de_make_some
  (qid, args, t_gt) = let
  val loc_qid = qid.dqi0de_loc
  val loc = loc_qid + t_gt.token_loc
in '{
  impqi0de_loc= loc
, impqi0de_qua= qid.dqi0de_qua
, impqi0de_sym= qid.dqi0de_sym
, impqi0de_arg= args
} end // end of [impqid0de_make_some]

(* ****** ****** *)

implement
f0arg_dyn (p0t) = '{
  f0arg_loc= p0t.p0at_loc, f0arg_node= F0ARGdyn (p0t)
}

implement
f0arg_sta1
  (t_beg, qua, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  f0arg_loc= loc, f0arg_node= F0ARGsta1 (qua)
} end // en dof [f0arg_sta1]

implement
f0arg_sta2
  (t_beg, arg, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  f0arg_loc= loc, f0arg_node= F0ARGsta2 (arg)
} end // en dof [f0arg_sta2]

implement
f0arg_met
  (t_beg, s0es, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  f0arg_loc= loc, f0arg_node= F0ARGmet3 (s0es)
} end // end of [f0arg_met]

implement
f0arg_met_nil (tok) = '{
  f0arg_loc= tok.token_loc, f0arg_node= F0ARGmet3 (list_nil)
} (* end of [f0arg_met_nil] *)

(* ****** ****** *)

implement
s0elop_make_dot (t) = '{
  s0elop_loc= t.token_loc, s0elop_knd= 0(*knd*)
}
implement
s0elop_make_minusgt (t) = '{
  s0elop_loc= t.token_loc, s0elop_knd= 1(*knd*)
}

(* ****** ****** *)

implement
i0nvarg_make (id, opt) = let
  val loc = (case+ opt of
    | Some x => id.i0de_loc + x.s0exp_loc
    | None _ => id.i0de_loc
  ) : location // end of [val]
in '{
  i0nvarg_loc= loc, i0nvarg_sym= id.i0de_sym, i0nvarg_typ= opt
} end // end of [i0nvarg_make]

(* ****** ****** *)

implement
i0nvresstate_make_none (loc) = '{
  i0nvresstate_loc= loc
, i0nvresstate_qua= None (), i0nvresstate_arg= list_nil ()
} // end of [i0nvresstate_make_none]

implement
i0nvresstate_make_some
  (t_beg, qua, arg, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  i0nvresstate_loc= loc
, i0nvresstate_qua= qua, i0nvresstate_arg= arg
} end // end of [i0nvresstate_some]

(* ****** ****** *)

implement
loopi0nv_make (
  qua, met, arg, res
) = '{
  loopi0nv_qua= qua
, loopi0nv_met= met
, loopi0nv_arg= arg
, loopi0nv_res= res
} // end of [loopi0nv_make]

(* ****** ****** *)

implement
ifhead_make
  (t_if, invopt) = let
  val inv = (
    case+ invopt of
    | Some inv => inv
    | None () => i0nvresstate_make_none (t_if.token_loc)
  ) : i0nvresstate // end of [val]
in '{
  ifhead_tok= t_if, ifhead_inv= inv
} end // end of [ifhead_make]

implement
sifhead_make
  (t_sif, invopt) = let
  val inv = (
    case+ invopt of
    | Some inv => inv
    | None () => i0nvresstate_make_none (t_sif.token_loc)
  ) : i0nvresstate // end of [val]
in '{
  sifhead_tok= t_sif, sifhead_inv= inv
} end // end of [sifhead_make]

(* ****** ****** *)

implement
casehead_make
  (t_case, invopt) = let
  val inv = (
    case+ invopt of
    | Some inv => inv
    | None () => i0nvresstate_make_none (t_case.token_loc)
  ) : i0nvresstate // end of [val]
in '{
  casehead_tok= t_case, casehead_inv= inv
} end // end of [casehead_make]

implement
scasehead_make
  (t_scase, invopt) = let
  val inv = (
    case+ invopt of
    | Some inv => inv
    | None () => i0nvresstate_make_none (t_scase.token_loc)
  ) : i0nvresstate // end of [val]
in '{
  scasehead_tok= t_scase, scasehead_inv= inv
} end // end of [scasehead_make]

(* ****** ****** *)

implement
loophead_make_none
  (t_loop) = '{
  loophead_tok= t_loop, loophead_inv= None ()
} // end of [loophead_make_none]

implement
loophead_make_some
  (t_loop, inv, t_eqgt) = let
  val loc = t_loop.token_loc + t_eqgt.token_loc
in '{
  loophead_tok= t_loop, loophead_inv= Some (inv)
} end // end of [loophead_make_some]

(* ****** ****** *)

implement
tryhead_make
  (t_try, invopt) = let
  val inv = (
    case+ invopt of
    | Some (inv) => inv
    | None () => i0nvresstate_make_none (t_try.token_loc)
  ) : i0nvresstate // end of [val]
in '{
  tryhead_tok= t_try, tryhead_inv= inv
} end // end of [tryhead_make]

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

implement
d0exp_ide (id) = '{
  d0exp_loc= id.i0de_loc, d0exp_node= D0Eide (id.i0de_sym)
} // end of [d0exp_ide]

implement
d0exp_opid (x1, x2) = let
  val loc = x1.token_loc + x2.i0de_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eopid (x2.i0de_sym)
} end // end of [d0exp_opid]

implement
d0exp_dqid (qid) = let
  val dq = qid.dqi0de_qua and sym = qid.dqi0de_sym
in '{
  d0exp_loc= qid.dqi0de_loc, d0exp_node= D0Edqid (dq, sym)
} end // end of [d0exp_dqid]

(* ****** ****** *)

implement
d0exp_idext (id) = '{
  d0exp_loc= id.i0de_loc, d0exp_node= D0Eidext (id.i0de_sym)
} // end of [d0exp_idext]

(* ****** ****** *)

implement
d0exp_i0nt (x) = let
in '{
  d0exp_loc= x.token_loc, d0exp_node= D0Eint (x)
} end // end of [d0exp_i0nt]

implement
d0exp_c0har (x) = let
in '{
  d0exp_loc= x.token_loc, d0exp_node= D0Echar (x)
} end // end of [d0exp_c0har]

implement
d0exp_f0loat (x) = let
in '{
  d0exp_loc= x.token_loc, d0exp_node= D0Efloat (x)
} end // end of [d0exp_f0loat]

implement
d0exp_s0tring (x) = let
in '{
  d0exp_loc= x.token_loc, d0exp_node= D0Estring (x)
} end // end of [d0exp_s0tring]

(* ****** ****** *)

implement
d0exp_empty (loc) = '{
  d0exp_loc= loc, d0exp_node= D0Eempty ()
}

(* ****** ****** *)

implement
d0exp_MYFIL (tok) = '{
  d0exp_loc= tok.token_loc
, d0exp_node= D0Ecstsp (CSTSPmyfil())
}

implement
d0exp_MYLOC (tok) = '{
  d0exp_loc= tok.token_loc
, d0exp_node= D0Ecstsp (CSTSPmyloc())
}

implement
d0exp_MYFUN (tok) = '{
  d0exp_loc= tok.token_loc
, d0exp_node= D0Ecstsp (CSTSPmyfun())
}

(* ****** ****** *)

implement
d0exp_tyrep
  (t_beg, s0e, t_end) = let
//
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  d0exp_loc= loc, d0exp_node= D0Etyrep(s0e)
} end // end of [d0exp_tyrep]

(* ****** ****** *)

implement
d0exp_literal
  (t_beg, lit, t_end) = let
//
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  d0exp_loc= loc, d0exp_node= D0Eliteral (lit)
} end // end of [d0exp_literal]

(* ****** ****** *)

implement
d0exp_extval
(
  t_beg, _type, rep, t_end
) = let
//
val-T_STRING(rep) = rep.token_node
val loc =
  t_beg.token_loc + t_end.token_loc
//
in '{
  d0exp_loc= loc
, d0exp_node= D0Eextval (_type, rep)
} end // end of [d0exp_extval]

implement
d0exp_extfcall (
  t_beg, _type, _fun, _arg, t_end
) = let
  val-T_STRING(_fun) = _fun.token_node
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc
, d0exp_node= D0Eextfcall (_type, _fun, _arg)
} end // end of [d0exp_extfcall]

implement
d0exp_extmcall
(
  t_beg, _type, _obj, _mtd, _arg, t_end
) = let
  val-T_STRING(_mtd) = _mtd.token_node
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc
, d0exp_node= D0Eextmcall (_type, _obj, _mtd, _arg)
} end // end of [d0exp_extmcall]

(* ****** ****** *)

implement
d0exp_foldat
  (t_foldat, d0es) = let
//
val opt =
  list_last_opt<d0exp> (d0es)
val loc =
(
  case+ opt of
  | ~None_vt _ => t_foldat.token_loc
  | ~Some_vt x => t_foldat.token_loc + x.d0exp_loc
) : location // end of [val]
in '{
  d0exp_loc= loc, d0exp_node= D0Efoldat d0es
} end (* end of [d0exp_foldat] *)

implement
d0exp_freeat
  (t_freeat, d0es) = let
//
val opt =
  list_last_opt<d0exp> (d0es)
//
val loc =
(
  case+ opt of
  | ~None_vt _ => t_freeat.token_loc
  | ~Some_vt x => t_freeat.token_loc + x.d0exp_loc
) : location // end of [val]
//
in '{
  d0exp_loc= loc, d0exp_node= D0Efreeat d0es
} end (* end of [d0exp_freeat] *)

(* ****** ****** *)

implement
d0exp_tmpid
  (qid, arg, t_gt) = let
  val loc_qid = qid.dqi0de_loc
  val loc = loc_qid + t_gt.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Etmpid (qid, arg)
} end // end of [d0exp_tmpid]

(* ****** ****** *)

implement
d0exp_let_seq (
  t_let, d0cs, t_in, d0es, t_end
) = let
  val loc = t_let.token_loc + t_end.token_loc
  val body = d0exp_seq (t_in, d0es, t_end)
in '{
  d0exp_loc= loc, d0exp_node= D0Elet (d0cs, body)
} end // end of [d0exp_let_seq]

implement
d0exp_declseq
  (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Edeclseq (xs)
} end // end of [d0exp_declseq]

(* ****** ****** *)

implement
d0exp_where
  (d0e, d0cs, t_end) = let
  val loc = d0e.d0exp_loc + t_end.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Ewhere (d0e, d0cs)
} end // end of [d0exp_where]

(* ****** ****** *)

implement
d0exp_app (d0e1, d0e2) = let
  val loc = d0e1.d0exp_loc + d0e2.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eapp (d0e1, d0e2)
} end // end of [d0exp_app]

(* ****** ****** *)

implement
d0exp_list
  (t_beg, npf, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Elist (npf, xs)
} end // end of [d0exp_list]

(* ****** ****** *)

implement
d0exp_ifhead (
  hd, _cond, _then, _else
) = let
  val t_if = hd.ifhead_tok
  val loc = (case+ _else of
    | Some x => t_if.token_loc + x.d0exp_loc
    | None _ => t_if.token_loc + _then.d0exp_loc
  ) : location // end of [val]
in '{
  d0exp_loc= loc
, d0exp_node= D0Eifhead (hd, _cond, _then, _else)
} end // end of [d0exp_ifhead]

implement
d0exp_sifhead (
  hd, _cond, _then, _else
) = let
  val t_sif = hd.sifhead_tok
  val loc = t_sif.token_loc + _else.d0exp_loc
in '{
  d0exp_loc= loc
, d0exp_node= D0Esifhead (hd, _cond, _then, _else)
} end // end of [d0exp_sifhead]

(* ****** ****** *)

implement
d0exp_ifcasehd
  (ifhd, ifcls) = let
  val tok =
    ifhd.ifhead_tok
  // end of [val]
  val loc = tok.token_loc
  val opt = list_last_opt<i0fcl> (ifcls)
  val loc = (
    case+ opt of
    | ~Some_vt x => (loc + x.i0fcl_loc) | ~None_vt() => loc
  ) : location // end of [val]
in '{
  d0exp_loc= loc, d0exp_node= D0Eifcasehd (ifhd, ifcls)
} end // end of [d0exp_ifcasehd]

(* ****** ****** *)

implement
d0exp_casehead (
  hd, d0e, t_of, c0ls
) : d0exp = let
  val t_case = hd.casehead_tok
  val loc_hd = t_case.token_loc
  val loc = (
    case+ list_last_opt<c0lau> (c0ls) of
    | ~Some_vt x => loc_hd + x.c0lau_loc
    | ~None_vt _ => loc_hd + t_of.token_loc
  ) : location
in '{
  d0exp_loc= loc, d0exp_node= D0Ecasehead (hd, d0e, c0ls)
} end // end of [d0exp_casehead]

implement
d0exp_scasehead (
  hd, d0e, t_of, c0ls
) : d0exp = let
  val t_scase = hd.scasehead_tok
  val loc_hd = t_scase.token_loc
  val loc = (
    case+ list_last_opt<sc0lau> (c0ls) of
    | ~Some_vt x => loc_hd + x.sc0lau_loc
    | ~None_vt _ => loc_hd + t_of.token_loc
  ) : location
in '{
  d0exp_loc= loc, d0exp_node= D0Escasehead (hd, d0e, c0ls)
} end // end of [d0exp_scasehead]

(* ****** ****** *)

implement
d0exp_lam (
  knd, t_lam, arg, res, eff, body
) = let
  val loc = t_lam.token_loc + body.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Elam (knd, arg, res, eff, body)
} end // end of [d0exp_lam]

implement
d0exp_fix (
  knd, t_fix, fid, arg, res, eff, body
) = let
  val loc = t_fix.token_loc + body.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Efix (knd, fid, arg, res, eff, body)
} end // end of [d0exp_fix]

(* ****** ****** *)

implement
d0exp_delay
  (knd, tok, body) = let
  val loc = tok.token_loc + body.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Edelay (knd, body)
} end // end of [d0exp_delay]

(* ****** ****** *)

implement
d0exp_lst
(
  lin, t_beg, elt, t_lp, d0es, t_rp
) = let
  val loc = t_beg.token_loc + t_rp.token_loc
  val d0e_elts = d0exp_list (t_lp, ~1(*npf*), d0es, t_rp)
in '{
  d0exp_loc= loc, d0exp_node= D0Elst (lin, elt, d0e_elts)
} end // end of [d0exp_lst]

implement
d0exp_lst_quote
  (t_beg, d0es, t_end) =
  d0exp_lst (0(*lin*), t_beg, None(*elt*), t_beg, d0es, t_end)
// end of [d0exp_lst_quote]

(* ****** ****** *)

implement
d0exp_tup
(
  knd, t_beg, npf, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Etup(knd, npf, xs)
} end // end of [d0exp_tup]

implement
d0exp_rec
(
  knd, t_beg, npf, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Erec(knd, npf, xs)
} end // end of [d0exp_rec]

(* ****** ****** *)

implement
d0exp_arrsub (qid, ind) = let
  val loc_ind = ind.d0arrind_loc
  val loc = qid.dqi0de_loc + loc_ind
in '{
  d0exp_loc= loc
, d0exp_node= D0Earrsub (qid, loc_ind, ind.d0arrind_ind)
} end // end of [d0exp_arrsub]

implement
d0exp_arrinit (
  t_beg, elt, dim, init, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Earrinit (elt, dim, init)
} end // end of [d0exp_arrinit]

implement
d0exp_arrpsz (
  t_beg, os0e, t_lp, d0es, t_rp
) = let
  val loc = t_beg.token_loc + t_rp.token_loc
  val d0e_init =
  (
    case+ d0es of
    | list_cons (d0e, list_nil ()) => d0e
    | _ => d0exp_list (t_lp, ~1(*npf*), d0es, t_rp)
  ) : d0exp // end of [val]
in '{
  d0exp_loc= loc, d0exp_node= D0Earrpsz (os0e, d0e_init)
} end // end of [d0exp_arrpsz]

(* ****** ****** *)

implement
d0exp_seq
  (t_beg, d0es, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in
  case+ d0es of
  | list_cons _ => '{
      d0exp_loc= loc, d0exp_node= D0Eseq d0es
    } // end of [cons]
  | list_nil _ => d0exp_empty (loc)
end // end of [d0exp_seq]

(* ****** ****** *)

implement
d0exp_ptrof (t_addrat) = '{
  d0exp_loc= t_addrat.token_loc, d0exp_node= D0Eptrof ()
} // end of [d0exp_ptrof]

implement
d0exp_viewat (t_viewat) = '{
  d0exp_loc= t_viewat.token_loc, d0exp_node= D0Eviewat ()
} // end of [d0exp_viewat]

(* ****** ****** *)

implement
d0exp_sel_lab (sel, lab) = let
  val loc = sel.s0elop_loc + lab.l0ab_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Esel_lab (sel.s0elop_knd, lab.l0ab_lab)
} end // end of [d0exp_sel_lab]

implement
d0exp_sel_ind (sel, ind) = let
  val loc = sel.s0elop_loc + ind.d0arrind_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Esel_ind (sel.s0elop_knd, ind.d0arrind_ind)
} end // end of [d0exp_sel_ind]

implement
d0exp_sel_int (tok) = let
  val knd = 0 // HX: dot selection
  val-T_DOTINT (int) = tok.token_node
  val lab = $LAB.label_make_int (int)
in '{
  d0exp_loc= tok.token_loc, d0exp_node= D0Esel_lab (knd, lab)
} end // end of [d0exp_sel_int]

(* ****** ****** *)

implement
d0exp_raise
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eraise (ent2)
} end // end of [d0exp_raise]

(* ****** ****** *)

implement
d0exp_effmask
  (tok, eff, body) = let
  val loc = tok.token_loc + body.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eeffmask (eff, body)
} end // end of [d0exp_effmask]

implement
d0exp_effmask_arg
  (knd, tok, body) = let
  val loc = tok.token_loc + body.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eeffmask_arg (knd, body)
} end // end of [d0exp_effmask_arg]

(* ****** ****** *)

implement
d0exp_vararg
  (t_beg, d0es, t_end) = let
//
val loc = t_beg.token_loc + t_end.token_loc
//
in '{
  d0exp_loc= loc, d0exp_node= D0Evararg(d0es)
} end // end of [d0exp_vararg]

(* ****** ****** *)

implement
d0exp_vcopyenv
  (knd, tok, ent2) = let
  val loc = tok.token_loc + ent2.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Evcopyenv (knd, ent2)
} end // end of [d0exp_vcopyenv]

(* ****** ****** *)

implement
d0exp_showtype
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eshowtype (ent2)
} end // end of [d0exp_showtype]

(* ****** ****** *)

implement
d0exp_tempenver
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Etempenver (ent2)
} end // end of [d0exp_tempenver]

(* ****** ****** *)

implement
d0exp_sexparg
  (t_beg, s0a, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Esexparg s0a
} end // end of [d0exp_sexparg]

implement
d0exp_exist (
  t_beg, s0a, t_bar, d0e, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
  val loc_qua = t_beg.token_loc + t_bar.token_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eexist (loc_qua, s0a, d0e)
} end // end of [d0exp_exist]

(* ****** ****** *)

implement
d0exp_forhead (
  hd, itp, body
) = let
  val t_loop = hd.loophead_tok
  val loc_inv = t_loop.token_loc
  val loc = loc_inv + body.d0exp_loc
(*
  val () = begin
    $LOC.print_location loc; print ": d0exp_for"; print_newline ()
  end // end of [val]
*)
  val inv = hd.loophead_inv
in '{
  d0exp_loc= loc
, d0exp_node= D0Efor (inv, loc_inv, itp, body)
} end // end of [d0exp_forhead]

(* ****** ****** *)

implement
d0exp_whilehead (
  hd, test, body
) = let
  val t_loop = hd.loophead_tok
  val loc_inv = t_loop.token_loc
  val loc = loc_inv + body.d0exp_loc
(*
  val () = begin
    $LOC.print_location loc; print ": d0exp_while"; print_newline ()
  end // end of [val]
*)
  val inv = hd.loophead_inv
in '{
  d0exp_loc= loc
, d0exp_node= D0Ewhile (inv, loc_inv, test, body)
} end // end of [d0exp_whilehead]

(* ****** ****** *)

implement
d0exp_loopexn
  (knd, tok) = '{
  d0exp_loc= tok.token_loc, d0exp_node= D0Eloopexn (knd)
} // end of [d0exp_loopexn]

(* ****** ****** *)

implement
d0exp_trywith_seq
  (hd, d0es, t_with, c0ls) = let
  val t_try = hd.tryhead_tok
  val loc = (
    case+ list_last_opt<c0lau> (c0ls) of
    | ~Some_vt x => t_try.token_loc + x.c0lau_loc
    | ~None_vt _ => t_try.token_loc + t_with.token_loc
  ) : location // end of [val]
  val d0e = d0exp_seq (t_try, d0es, t_with)
in '{
  d0exp_loc= loc, d0exp_node= D0Etrywith (hd, d0e, c0ls)
} end // end of [d0exp_trywith]

(* ****** ****** *)

implement
d0exp_ann (d0e, s0e) = let
  val loc = d0e.d0exp_loc + s0e.s0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Eann (d0e, s0e)
} end // end of [d0exp_ann]

(* ****** ****** *)

implement
d0exp_solassert
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.d0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Esolassert(ent2)
} end // end of [d0exp_solassert]

implement
d0exp_solverify
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.s0exp_loc
in '{
  d0exp_loc= loc, d0exp_node= D0Esolverify(ent2)
} end // end of [d0exp_solverify]

(* ****** ****** *)

local

fun
d0exp_macsyn
(
  loc: location, knd: macsynkind, d0e: d0exp
): d0exp = '{
  d0exp_loc= loc, d0exp_node= D0Emacsyn (knd, d0e)
} // end of [d0exp_macsyn]

in (* in of [local] *)

implement
d0exp_macsyn_cross
  (t_beg, d0e, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in
  d0exp_macsyn (loc, MSKxstage, d0e)
end // end of [d0exp_macsyn_cross]

implement
d0exp_macsyn_decode
  (t_beg, d0e, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in
  d0exp_macsyn (loc, MSKdecode, d0e)
end // end of [d0exp_macsyn_decode]

implement
d0exp_macsyn_encode_seq
  (t_beg, d0es, t_end) = let
  val d0e = d0exp_seq (t_beg, d0es, t_end)
in
  d0exp_macsyn (d0e.d0exp_loc, MSKencode, d0e)
end // end of [d0exp_macsyn_encode_seq]

end // end of [local]

(* ****** ****** *)

implement
labd0exp_make (ent1, ent2) = DL0ABELED (ent1, ent2)

(* ****** ****** *)

implement
d0arrind_sing
  (d0es, t_rbracket) = '{
  d0arrind_loc= t_rbracket.token_loc, d0arrind_ind= list_sing (d0es)
} // end of [d0arrind_sing]

implement
d0arrind_cons
  (d0es, ind) = '{
  d0arrind_loc= ind.d0arrind_loc
, d0arrind_ind= list_cons (d0es, ind.d0arrind_ind)
} // end of [d0arrind_cons]

(* ****** ****** *)

implement
initestpost_make
(
  t_beg
, init, t_sep1, test, t_sep2, post
, t_end
) = let
  val init = d0exp_seq (t_beg, init, t_sep1)
  val test = d0exp_seq (t_sep1, test, t_sep2)
  val post = d0exp_seq (t_sep2, post, t_end)
in '{
  itp_init= init, itp_test= test, itp_post= post
} end // end of [initestpost_make]

(* ****** ****** *)

implement
gm0at_make
  (d0e, p0topt) = let
  val loc = (
    case+ p0topt of
    | Some x => d0e.d0exp_loc + x.p0at_loc
    | None _ => d0e.d0exp_loc
  ) : location // end of [val]
in '{
  gm0at_loc= loc, gm0at_exp= d0e, gm0at_pat= p0topt
} end // end of [gm0at_make]

implement
guap0at_make (p0t, matopt) = let
  val xs = (
    case+ matopt of Some xs => xs | None () => list_nil
  ) : gm0atlst
  val loc = p0t.p0at_loc
  val loc = (
    case+ list_last_opt<gm0at> (xs) of
    | ~Some_vt x => loc + x.gm0at_loc | ~None_vt () => loc
  ) : location // end of [val]
in '{
  guap0at_loc= loc, guap0at_pat= p0t, guap0at_gua= xs
} end // end of [guap0at_make_some]

(* ****** ****** *)

implement
c0lau_make
  (gp0t, seq, neg, body) = let
  val loc = gp0t.guap0at_loc + body.d0exp_loc
in '{
  c0lau_loc= loc
, c0lau_pat= gp0t
, c0lau_seq= seq
, c0lau_neg= neg
, c0lau_body= body
} end // end of [c0lau_make]

(* ****** ****** *)

implement
sp0at_cstr (qid, xs, t_end) = let
  val loc = qid.sqi0de_loc + t_end.token_loc
in '{
  sp0at_loc= loc, sp0at_node= SP0Tcstr (qid, xs)
} end // end of [s0pat_cstr]

implement
sc0lau_make (sp0t, d0e) = let
  val loc = sp0t.sp0at_loc + d0e.d0exp_loc
in '{
  sc0lau_loc= loc, sc0lau_pat= sp0t, sc0lau_body= d0e
} end // end of [sc0lau_make]

(* ****** ****** *)

implement
i0fcl_make
  (test, body) = let
//
val loc =
  test.d0exp_loc + body.d0exp_loc
//
in '{
  i0fcl_loc= loc
, i0fcl_test= test
, i0fcl_body= body
} end // end of [i0fcl_make]

(* ****** ****** *)

implement
m0acdef_make (id, arg, def) = let
  val loc = id.i0de_loc + def.d0exp_loc
in '{
  m0acdef_loc= loc
, m0acdef_sym= id.i0de_sym
, m0acdef_arg= arg
, m0acdef_def= def
} end // end of [m0acdef_make]

(* ****** ****** *)

implement
v0aldec_make
  (p0t, def, ann) = let
  val loc = (case+ ann of
    | WITHT0YPEnone () => p0t.p0at_loc + def.d0exp_loc
    | WITHT0YPEsome (knd, s0e) => p0t.p0at_loc + s0e.s0exp_loc
  ) : location // end of [val]
in '{
  v0aldec_loc= loc, v0aldec_pat= p0t, v0aldec_def= def, v0aldec_ann= ann
} end // end of [v0aldec_make]

(* ****** ****** *)

implement
f0undec_make
(
  fid, arg, eff, res, def, ann
) = let
//
val loc = (
case+ ann of
| WITHT0YPEnone () => fid.i0de_loc + def.d0exp_loc
| WITHT0YPEsome (knd, s0e) => fid.i0de_loc + s0e.s0exp_loc
) : location // end of [val]
//
in '{
  f0undec_loc= loc
, f0undec_sym= fid.i0de_sym
, f0undec_sym_loc= fid.i0de_loc
, f0undec_arg= arg
, f0undec_eff= eff
, f0undec_res= res
, f0undec_def= def
, f0undec_ann= ann
} end // end of [f0undec_make]

(* ****** ****** *)

implement
v0ardec_make
(
  tokopt, id, pfat, s0eopt, init
) = let
//
var knd: int = 0
//
val loc_hd =
(
  case+ tokopt of
  | None () => id.i0de_loc
  | Some tok =>
      let val () = knd := 1 in tok.token_loc end
    // end of [Some]
) : location // end of [val]
//
val loc_tl =
(
  case+ init of
  | Some d0e => d0e.d0exp_loc
  | None () => (
    case+ pfat of
    | Some id2 => id2.i0de_loc
    | None () => (
      case+ s0eopt of
      | Some s0e => s0e.s0exp_loc | None () => id.i0de_loc
    ) // end of [None]
  )
) : location // end of [val]
//
val loc = loc_hd + loc_tl
//
in '{
  v0ardec_loc= loc
, v0ardec_knd= knd
, v0ardec_sym= id.i0de_sym
, v0ardec_sym_loc= id.i0de_loc
, v0ardec_pfat= pfat
, v0ardec_type= s0eopt // type annotation
, v0ardec_init= init // value for initialization
} end // end of [v0ardec_make]

(* ****** ****** *)

implement
i0mpdec_make
(
  qid, arg, res, def
) = let
//
val loc = qid.impqi0de_loc + def.d0exp_loc
//
in '{
  i0mpdec_loc= loc
, i0mpdec_qid= qid
, i0mpdec_arg= arg
, i0mpdec_res= res
, i0mpdec_def= def
} end // end of [i0mpdec_make]

(* ****** ****** *)

local

fun
loop{n:nat} .<n>.
(
  tok: token, id: i0de, ids: list (i0de, n)
) : location =
  case+ ids of
  | list_cons (id, ids) => loop (tok, id, ids)
  | list_nil () => tok.token_loc + id.i0de_loc
// end of [loop]

in (* in of [local] *)

implement
d0ecl_fixity
  (tok, prec, ids) = let
//
val-
T_FIXITY(knd) = tok.token_node
//
val fxty =
( case+ knd of
  | FXK_infix() =>
    F0XTYinf(prec, $FIX.ASSOCnon())
  | FXK_infixl() =>
    F0XTYinf(prec, $FIX.ASSOClft())
  | FXK_infixr() =>
    F0XTYinf(prec, $FIX.ASSOCrgt())
//
  | FXK_prefix() => F0XTYpre (prec)
  | FXK_postfix() => F0XTYpos (prec)
//
) : f0xty // end of [val]
//
val loc =
( case+ ids of
  | list_cons (id, ids) => loop (tok, id, ids)
  | list_nil () => tok.token_loc
) : location // end of [val]
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cfixity (fxty, ids)
} end // end of [d0ecl_infix]

implement
d0ecl_nonfix
  (tok, ids) = let
  val-T_NONFIX () = tok.token_node
  val loc = (case+ ids of
    | list_cons (id, ids) => loop (tok, id, ids)
    | list_nil () => tok.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cnonfix (ids)
} end // end of [d0ecl_nonfix]

(* ****** ****** *)

implement
d0ecl_symintr
  (tok, ids) = let
  val-T_SYMINTR () = tok.token_node
  val loc = (case+ ids of
    | list_cons (id, ids) => loop (tok, id, ids)
    | list_nil () => tok.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csymintr (ids)
} end // end of [d0ecl_symintr]

implement
d0ecl_symelim
  (tok, ids) = let
  val-T_SYMELIM () = tok.token_node
  val loc = (case+ ids of
    | list_cons (id, ids) => loop (tok, id, ids)
    | list_nil () => tok.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csymelim (ids)
} end // end of [d0ecl_symelim]

end // end of [local]

implement
d0ecl_overload
  (tok, id, dqid, opt) = let
//
  val loc1 = tok.token_loc
  val loc2 = (
    case+ opt of
    | Some x => x.token_loc | None () => dqid.dqi0de_loc
  ) : location // end of [val]
  val loc = loc1 + loc2
  val pval = (
    case+ opt of
    | Some x => i0nt2int (x) | None () => 0
  ) : int // end of [val]
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Coverload (id, dqid, pval)
} end // end of [d0ecl_overload]

(* ****** ****** *)

implement
d0ecl_include
  (knd, tok, ent2) = let
//
  val loc = ent2.token_loc
  val-T_STRING (name) = ent2.token_node
  val () = the_parerrlst_add_ifunclosed (loc, name)
  val loc = tok.token_loc + loc
//
  val pfil = $FIL.filename_get_current ()
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cinclude (pfil, knd, name)
} end // end of [d0ecl_include]

(* ****** ****** *)

implement
d0ecl_e0xpdef
  (tok, ent2, ent3) = let
  val loc = tok.token_loc
  val loc = (
    case+ ent3 of
    | Some x => loc + x.e0xp_loc
    | None() => loc + ent2.i0de_loc
  ) : location // end of [val]
  val def = (case+ ent3 of
    | Some x => let
        var flag: int = 0
        val x = e0xp_funize (x, flag)
      in
        if flag > 0 then Some (x) else ent3
      end // end of [Some]
    | None () => None ()
  ) : e0xpopt // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ce0xpdef (ent2.i0de_sym, def)
} end // end of [d0ecl_e0xpdef]

(* ****** ****** *)

implement
d0ecl_e0xpundef
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.i0de_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ce0xpundef (ent2.i0de_sym)
} end // end of [d0ecl_e0xpundef]

(* ****** ****** *)

implement
d0ecl_e0xpact_assert
  (tok, ent2) = let
//
val loc =
  tok.token_loc + ent2.e0xp_loc
//
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Ce0xpact(E0XPACTassert, ent2)
} end // end of [d0ecl_e0xpact_assert]

(* ****** ****** *)

implement
d0ecl_e0xpact_error
  (tok, ent2) = let
//
val loc =
  tok.token_loc + ent2.e0xp_loc
//
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Ce0xpact(E0XPACTerror, ent2)
} end // end of [d0ecl_e0xpact_error]

(* ****** ****** *)

implement
d0ecl_e0xpact_prerr
  (tok, ent2) = let
//
val loc =
  tok.token_loc + ent2.e0xp_loc
//
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Ce0xpact(E0XPACTprerr, ent2)
} end // end of [d0ecl_e0xpact_prerr]

(* ****** ****** *)

implement
d0ecl_e0xpact_print
  (tok, ent2) = let
//
val loc =
  tok.token_loc + ent2.e0xp_loc
//
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Ce0xpact(E0XPACTprint, ent2)
} end // end of [d0ecl_e0xpact_print]

(* ****** ****** *)

implement
d0ecl_pragma
(
  tok1, xs, tok2
) = let
//
val () = d0ecl_pragma_process(xs)
//
val loc = tok1.token_loc + tok2.token_loc
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cpragma(xs)
} end // end of [d0ecl_pragma]

(* ****** ****** *)

local

typedef
locpragma = $LOC.locpragma

fun
e0xp_is_location
  (e0: e0xp): bool = let
//
val cat =
(
case+ e0.e0xp_node of
| E0XPide(id) =>
  $SYM.symbol_get_name(id)
| E0XPstring(tok) => str where
  {
    val-$LEX.T_STRING(str) = tok.token_node
  }
| _(*rest-of-e0xp*) => ""
) : string // end of [val]
//
in
  if cat = "location" then true else false
end // end of [e0xp_is_location]

fun
e2s(e0: e0xp): string =
(
case+ e0.e0xp_node of
| E0XPide(id) =>
  $SYM.symbol_get_name(id)
| E0XPstring(tok) => str where
  {
    val-$LEX.T_STRING(str) = tok.token_node
  }
| _(*rest-of-e0xp*) => "??????"
)

fun
locpragma_process0
  (xs: e0xplst): locpragma =
(
case+ xs of
| list_nil() => $LOC.locpragma0_make()
| list_cons(x1, xs) => locpragma_process1 (x1, xs)
)

and
locpragma_process1
  (x1: e0xp, xs: e0xplst): locpragma =
(
case+ xs of
| list_nil() => $LOC.locpragma1_make(e2s(x1))
| list_cons(x2, xs) => $LOC.locpragma2_make(e2s(x1), e2s(x2))
)

in (* in-of-local *)

implement
d0ecl_pragma_process
  (xs) = let
(*
val () = println! ("d0ecl_pragma_process")
*)
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  (
    case+ 0 of
    | _ when
        e0xp_is_location(x) =>
      (
        $LOC.the_location_pragma_set(locpragma_process0(xs))
      )
    | _ => ((*nothing*))
  ) (* end of [list_cons] *)
//
end // end of [d0ecl_pragma_process]

end // end of [local]

(* ****** ****** *)

implement
d0ecl_codegen2
(
  tok1, xs, tok2
) = let
//
val loc = tok1.token_loc + tok2.token_loc
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ccodegen(2(*knd*), xs)
} end // end of [d0ecl_codegen2]

implement
d0ecl_codegen3
(
  tok1, xs, tok2
) = let
//
val loc = tok1.token_loc + tok2.token_loc
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ccodegen(3(*knd*), xs)
} end // end of [d0ecl_codegen3]

(* ****** ****** *)

implement
d0ecl_datsrts
  (tok, xs) = let
//
val loc = tok.token_loc
val loc = (case+
  list_last_opt<d0atsrtdec> (xs) of
  | ~Some_vt x => loc + x.d0atsrtdec_loc | ~None_vt _ => loc
) : location // end of [val]
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cdatsrts (xs)
} end // end of [d0ecl_datsrts]

implement
d0ecl_srtdefs
  (tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0rtdef> (xs) of
    | ~Some_vt x => loc + x.s0rtdef_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csrtdefs (xs)
} end // end of [d0ecl_srtdefs]

implement
d0ecl_stacons
  (knd, tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0tacon> (xs) of
    | ~Some_vt x => loc + x.s0tacon_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cstacons (knd, xs)
} end // end of [d0ecl_stacons]

implement
d0ecl_stacsts
  (tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0tacst> (xs) of
    | ~Some_vt x => loc + x.s0tacst_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cstacsts (xs)
} end // end of [d0ecl_stacsts]

(*
//
// HX-2012-05-23: removed
//
implement
d0ecl_stavars
  (tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0tavar> (xs) of
    | ~Some_vt x => loc + x.s0tavar_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cstavars (xs)
} end // end of [d0ecl_stavars]
*)

implement
d0ecl_tkindef (tok, x) = let
  val loc = tok.token_loc + x.t0kindef_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ctkindef (x)
} end // end of [d0ecl_tkindef]

implement
d0ecl_sexpdefs
  (knd, tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0expdef> (xs) of
    | ~Some_vt x => loc + x.s0expdef_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csexpdefs (knd, xs)
} end // end of [d0ecl_sexpdefs]

(* ****** ****** *)

implement
d0ecl_saspdec(tok, x) = let
//
val
loc = tok.token_loc + x.s0aspdec_loc
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csaspdec(x)
} end // end of [d0ecl_saspdec]

implement
d0ecl_reassume(tok, x) = let
//
val loc = tok.token_loc + x.sqi0de_loc
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Creassume(x)
} end // end of [d0ecl_reassume]

(* ****** ****** *)

implement
d0ecl_exndecs
  (tok, ent2) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<e0xndec> (ent2) of
    ~Some_vt x => loc + x.e0xndec_loc | ~None_vt () => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cexndecs (ent2)
} end // end of [d0ecl_exndecs]

(* ****** ****** *)

implement
d0ecl_datdecs_none
(
  knd, tok, ent2
) = let
  val loc = tok.token_loc
  val opt = list_last_opt<d0atdec> (ent2)
  val loc = (
    case+ opt of
    | ~Some_vt x => loc + x.d0atdec_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Cdatdecs (knd, ent2, list_nil)
} end // end of [d0ecl_datdecs_none]

implement
d0ecl_datdecs_some
(
  knd, tok, ent2, tok2, ent4
) = let
  val loc = tok.token_loc
  val opt = list_last_opt<s0expdef> (ent4)
  val loc2 = (
    case+ opt of
    | ~Some_vt x => x.s0expdef_loc | ~None_vt _ => tok2.token_loc
  ) : location // end of [val]
  val loc = loc + loc2
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Cdatdecs (knd, ent2, ent4)
} end // end of [d0ecl_datdecs_some]

(* ****** ****** *)

implement
d0ecl_classdec
  (tok, id, sup) = let
  val loc = tok.token_loc
  val loc = (
    case+ sup of
    | Some x => loc + x.s0exp_loc | None _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cclassdec (id, sup)
} end // end of [d0ecl_classdec]

(* ****** ****** *)

local

fun auxmain
(
  knd: int // 0/1: static/dynamic
, tok: token, ent2: q0marglst, ent3: d0cstdeclst
) : d0ecl = let
//
val loc = tok.token_loc
val opt = list_last_opt<d0cstdec> (ent3)
val loc =
(
case+ opt of
| ~Some_vt x =>
    loc + x.d0cstdec_loc | ~None_vt _ => loc (*dead*)
) : location // end of [val]
//
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Cdcstdecs (knd, tok, ent2, ent3)
} end // end of [auxmain]

in (* in of [local] *)
//
implement
d0ecl_dcstdecs
  (tok, ent2, ent3) = auxmain (1(*ext*), tok, ent2, ent3)
//
implement
d0ecl_dcstdecs_extern
  (tok, ent2, ent3) = auxmain (1(*ext*), tok, ent2, ent3)
//
implement
d0ecl_dcstdecs_static // HX: static dyncst not exported
  (tok, ent2, ent3) = auxmain (0(*sta*), tok, ent2, ent3)
//
end // end of [local]

(* ****** ****** *)

implement
d0ecl_macdefs
  (knd, isrec, tok, ent2) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<m0acdef> (ent2) of
    ~Some_vt x => loc + x.m0acdef_loc | ~None_vt _ => loc (*dead*)
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cmacdefs (knd, isrec, ent2)
} end // end of [d0ecl_macdefs]

(* ****** ****** *)

implement
d0ecl_extype
  (tok, name, s0e) = let
  val-T_EXTYPE () = tok.token_node
  val-T_STRING (name) = name.token_node
  val loc = tok.token_loc + s0e.s0exp_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cextype (name, s0e)
} end // end of [d0ecl_extype]

implement
d0ecl_extype2
  (tok, name, s0e) = let
  val-T_TYPEDEF (knd) = tok.token_node
  val-T_STRING (name) = name.token_node
  val loc = tok.token_loc + s0e.s0exp_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cextype (knd, name, s0e)
} end // end of [d0ecl_extype]

(* ****** ****** *)

implement
d0ecl_extvar
  (tok, name, d0e) = let
  val-T_EXTVAR () = tok.token_node
  val-T_STRING (name) = name.token_node
  val loc = tok.token_loc + d0e.d0exp_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cextvar (name, d0e)
} end // end of [d0ecl_extvar]

implement
d0ecl_extvar2
  (tok, name, d0e) = let
  val-T_VAR _ = tok.token_node
  val-T_STRING (name) = name.token_node
  val loc = tok.token_loc + d0e.d0exp_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cextvar (name, d0e)
} end // end of [d0ecl_extvar2]

(* ****** ****** *)

implement
d0ecl_extcode
  (knd, tok) = let
  val-T_EXTCODE (pos, code) = tok.token_node
in '{
  d0ecl_loc= tok.token_loc, d0ecl_node= D0Cextcode (knd, pos, code)
} end // end of [d0ecl_extcode]

(* ****** ****** *)

implement
d0ecl_impdec (
  tok, imparg, impdec
) = let
  val-T_IMPLEMENT (knd) = tok.token_node
  val loc = tok.token_loc + impdec.i0mpdec_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cimpdec (knd, imparg, impdec)
} end // end of [d0ecl_impdec]

(* ****** ****** *)

implement
d0ecl_fundecs (
  knd, tok, qua, xs
) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<f0undec> (xs) of
    | ~Some_vt x => loc + x.f0undec_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cfundecs (knd, qua, xs)
} end // end of [d0ecl_fundecs]

(* ****** ****** *)

implement
d0ecl_valdecs (
  knd, isrec, tok, xs
) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<v0aldec> (xs) of
    | ~Some_vt x => loc + x.v0aldec_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cvaldecs (knd, isrec, xs)
} end // end of [d0ecl_valdecs]

(* ****** ****** *)

implement
d0ecl_vardecs
  (knd, tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<v0ardec> (xs) of
    | ~Some_vt x => loc + x.v0ardec_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cvardecs (knd, xs)
} end // end of [d0ecl_vardecs]

(* ****** ****** *)

implement
d0ecl_staload_fname
  (tok, tok2) = let
//
  val loc = tok2.token_loc
  val-T_STRING (name) = tok2.token_node
  val () = the_parerrlst_add_ifunclosed (loc, name)
  val loc = tok.token_loc + loc
//
  val pfil = $FIL.filename_get_current ()
//
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Cstaload (pfil, None, name)
} end // end of [d0ecl_staload_fname]

(* ****** ****** *)

implement
d0ecl_staload_nspace
  (tok, tok2) = let
//
  val loc = tok2.token_loc
  val-T_IDENT_dlr (name) = tok2.token_node
  val loc = tok.token_loc + loc
  val pfil = $FIL.filename_get_current ()
  val name = $SYM.symbol_make_string (name)
//
in '{
  d0ecl_loc= loc
, d0ecl_node= D0Cstaloadnm (pfil, None, name)
} end // end of [d0ecl_staload_nspace]

(* ****** ****** *)

implement
staloadarg_get_loc (arg) = let
in
//
case+ arg of
| STLDfname (loc, name) => loc
| STLDnspace (loc, name) => loc
| STLDdeclist (loc, d0cs) => loc
//
end // end of [staloadarg_get_loc]

(* ****** ****** *)

implement
staloadarg_declist
  (t_lb, d0cs, t_lr) =
  STLDdeclist (t_lb.token_loc + t_lr.token_loc, d0cs)
// end of [staloadarg_declist]

(* ****** ****** *)

implement
d0ecl_staload_some_arg
  (tok, ent2, ent4) = let
//
val sym = ent2.i0de_sym
val loc =
  tok.token_loc + staloadarg_get_loc (ent4)
//
val pfil = $FIL.filename_get_current ((*void*))
//
val d0cn = (
case+ ent4 of
| STLDfname (loc, name) => let
    val () =
    the_parerrlst_add_ifunclosed (loc, name)
  in
    D0Cstaload (pfil, Some(sym), name)
  end // end of [STLDfname]
| STLDnspace (loc, name) => let
    val name = $SYM.symbol_make_string (name)
  in
    D0Cstaloadnm (pfil, Some(sym), name)
  end // end of [STLDnspace]
| STLDdeclist
    (_, d0cs) => D0Cstaloadloc (pfil, sym, d0cs)
) : d0ecl_node // end of [val]
//
in '{
  d0ecl_loc= loc, d0ecl_node= d0cn
} end // end of [d0ecl_staload_some_arg]

(* ****** ****** *)

implement
d0ecl_require
  (tok, ent2) = let
//
val loc = ent2.token_loc
val-T_STRING (name) = ent2.token_node
val () = the_parerrlst_add_ifunclosed (loc, name)
val loc = tok.token_loc + loc
//
val pfil = $FIL.filename_get_current ()
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Crequire (pfil, name)
} end // end of [d0ecl_require]

(* ****** ****** *)

implement
d0ecl_dynload
  (tok, ent2) = let
//
val loc = ent2.token_loc
val-T_STRING (name) = ent2.token_node
val () = the_parerrlst_add_ifunclosed (loc, name)
val loc = tok.token_loc + loc
//
val pfil = $FIL.filename_get_current ()
//
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cdynload (pfil, name)
} end // end of [d0ecl_dynload]

(* ****** ****** *)

implement
d0ecl_local
(
  t_local, d0cs1, d0cs2, t_end
) = let
  val loc = t_local.token_loc + t_end.token_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Clocal (d0cs1, d0cs2)
} end // end of [d0ec_local]

(* ****** ****** *)

local

fun
loop
(
  d0c0: d0ecl
, d0c1: d0ecl
, d0cs: d0eclist
) : location =
(
case+ d0cs of
| list_nil() =>
  $LOC.location_combine
    (d0c0.d0ecl_loc, d0c1.d0ecl_loc)
  // list_nil
| list_cons
    (d0c1, d0cs) => loop(d0c0, d0c1, d0cs)
  // end of [list_cons]
)

in (* in-of-local *)

implement
d0ecl_list
(
  fil, d0cs
) = let
//
val loc01 =
(
case+ d0cs of
| list_nil() =>
  $LOC.location_filename_origin(fil)
| list_cons
    (d0c0, d0cs) => loop(d0c0, d0c0, d0cs)
  // end of [list_cons]
) : location // end of [val]
//
in '{ 
  d0ecl_loc= loc01, d0ecl_node= D0Clocal(list_nil(), d0cs)
} end // end of [d0ecl_list]

implement
d0ecl_toplocal
(
  fil, d0cs
) = let
//
val loc01 =
(
case+ d0cs of
| list_nil() =>
  $LOC.location_filename_origin(fil)
| list_cons
    (d0c0, d0cs) => loop(d0c0, d0c0, d0cs)
  // end of [list_cons]
) : location // end of [val]
//
in '{ 
  d0ecl_loc= loc01, d0ecl_node= D0Clocal(d0cs, list_nil())
} end // end of [d0ecl_toplocal]

end // end of [local]

(* ****** ****** *)

fun srpifkind_of_token
  (tok: token): srpifkind =
  case+ tok.token_node of
  | T_SRPIF () => SRPIFKINDif ()
  | T_SRPIFDEF () => SRPIFKINDifdef ()
  | T_SRPIFNDEF () => SRPIFKINDifndef ()
  | _ => let
      val () = assertloc (false) in SRPIFKINDif ()
    end (* end of [_] *)
// end of [srpifkind_of_token]

fun srpelifkind_of_token
  (tok: token): srpifkind =
  case+ tok.token_node of
  | T_SRPELIF () => SRPIFKINDif ()
  | T_SRPELIFDEF () => SRPIFKINDifdef ()
  | T_SRPELIFNDEF () => SRPIFKINDifndef ()
  | _ => let
      val () = assertloc (false) in SRPIFKINDif ()
    end (* end of [_] *)
// end of [srpelifkind_of_token]

(* ****** ****** *)

implement
d0ecl_guadecl (knd, gd) = let
  val loc = knd.token_loc + gd.guad0ecl_loc
  val knd = srpifkind_of_token (knd)
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cguadecl (knd, gd)
} end // end of [d0ecl_guadecl]

(* ****** ****** *)

implement
guad0ecl_one (
  gua, ds_then, t_endif
) = let
  val loc = gua.e0xp_loc + t_endif.token_loc
in '{
  guad0ecl_loc= loc
, guad0ecl_node= GD0Cone (gua, ds_then)
} end // end of [guad0ecl_one]

implement
guad0ecl_two (
  gua, ds_then, ds_else, t_endif
) = let
  val loc = gua.e0xp_loc + t_endif.token_loc
in '{
  guad0ecl_loc= loc
, guad0ecl_node= GD0Ctwo (gua, ds_then, ds_else)
} end // end of [guad0ecl_two]

implement
guad0ecl_cons (
  gua, ds, knd, rst
) = let
  val loc = (
    gua.e0xp_loc + rst.guad0ecl_loc
  ) : location // end of [val]
  val knd = srpelifkind_of_token (knd)
in '{
  guad0ecl_loc= loc
, guad0ecl_node= GD0Ccons (gua, ds, knd, rst.guad0ecl_node)
} end // end of [guad0ecl_cons]

(* ****** ****** *)

(* end of [pats_syntax.dats] *)

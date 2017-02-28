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
// Start Time: April, 2011
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
staload
UT = "./pats_utils.sats"
staload
_(*anon*) = "./pats_utils.dats"
//
(* ****** ****** *)

staload EFF = "./pats_effect.sats"

(* ****** ****** *)

staload "./pats_syntax.sats"
staload "./pats_staexp1.sats"

(* ****** ****** *)
//
macdef
fprint_symbol = $SYM.fprint_symbol
//
(* ****** ****** *)
//
implement
fprint_v1al
  (out, v0) = let
//
macdef
prstr(str) =
fprint_string(out, ,(str))
//
in
//
case+ v0 of
| V1ALint(x) => {
    val () = prstr "V1ALint("
    val () = fprint_int (out, x)
    val () = prstr ")"
  }
| V1ALchar(x) => {
    val () = prstr "V1ALchar("
    val () = fprint_char (out, x)
    val () = prstr ")"
  }
| V1ALstring(x) => {
    val () = prstr "V1ALstring("
    val () = fprint_string (out, x)
    val () = prstr ")"
  }  
| V1ALfloat(x) => {
    val () = prstr "V1ALdouble("
    val () = fprint_double (out, x)
    val () = prstr ")"
  }
| V1ALerr((*void*)) => prstr "V1ALerr()"
//
end // end of [fprint_v1al]
//
implement
print_v1al(x) = fprint_v1al(stdout_ref, x)
implement
prerr_v1al(x) = fprint_v1al(stderr_ref, x)
//
(* ****** ****** *)

implement
fprint_e1xp
  (out, e0) = let
//
macdef
prstr(str) = fprint_string (out, ,(str))
//
in
//
case+
e0.e1xp_node
of // case+
//
| E1XPide (id) =>
    fprint_symbol (out, id)
  // end of [E1XPide]
//
| E1XPint (int) => {
    val () = prstr "E1XPint("
    val () = fprint_int (out, int)
    val () = prstr ")"
  } // end of [E1XPint]
| E1XPintrep (rep) => {
    val () = prstr "E1XPintrep("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  } // end of [E1XPi0nt]
| E1XPchar (c: char) => begin
    prstr "E1XPchar("; fprint_char (out, c); prstr ")"
  end // end of [E1XPchar]
| E1XPfloat (f: string) => begin
    prstr "E1XPfloat("; fprint_string (out, f); prstr ")"
  end // end of [E1XPfloat]
//
| E1XPv1al (v) => begin
    prstr "E1XPv1al("; fprint_v1al (out, v); prstr ")"
  end // end of [E1XPv1al]
//
| E1XPnone () => begin
    fprint_string (out, "E1XPnone()")
  end // end of [E1XPnone]
| E1XPundef () => begin
    fprint_string (out, "E1XPundef()")
  end // end of [E1XPundef]
| E1XPstring (str) => {
    val () = prstr "E1XPstring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  } // end of [E1XPstring]
//
| E1XPapp
  (
    e_fun, _(*loc*), es_arg
  ) => {
    val () = prstr "E1XPapp("
    val () = fprint_e1xp (out, e_fun)
    val () = prstr "; "
    val () = fprint_e1xplst (out, es_arg)
    val () = prstr ")"
  } (* end of [E1XPapp] *)
| E1XPfun (arg, body) => {
    val () = prstr "E1XPfun("
    val () = $UT.fprintlst<symbol> (out, arg, ", ", fprint_symbol)
    val () = prstr "; "
    val () = fprint_e1xp (out, body)
    val () = prstr ")"
  } (* end of [E1XPfun] *)
//
| E1XPif
  (
    _cond, _then, _else
  ) => {
    val () = prstr "E1XPif("
    val () = fprint_e1xp (out, _cond)
    val () = prstr "; "
    val () = fprint_e1xp (out, _then)
    val () = prstr "; "
    val () = fprint_e1xp (out, _else)
    val () = prstr ")"
  } (* end of [E1XPif] *)
//
| E1XPeval e => begin
    prstr "E1XPeval("; fprint_e1xp (out, e); prstr ")"
  end // end of [E1XPlist]
| E1XPlist es => begin
    prstr "E1XPlist("; fprint_e1xplst (out, es); prstr ")"
  end // end of [E1XPlist]
//
| E1XPerr () => prstr "E1XPerr()"
//
end // end of [fprint_e1xp]

(* ****** ****** *)
//
implement print_e1xp (x) = fprint_e1xp (stdout_ref, x)
implement prerr_e1xp (x) = fprint_e1xp (stderr_ref, x)
//
(* ****** ****** *)

implement
fprint_e1xplst (out, xs) =
  $UT.fprintlst<e1xp> (out, xs, ", ", fprint_e1xp)
// end of [fprint_e1xplst]

implement print_e1xplst (xs) = fprint_e1xplst (stdout_ref, xs)
implement prerr_e1xplst (xs) = fprint_e1xplst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_effcst (out, efc) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ efc of
| EFFCSTall () => prstr "all"
| EFFCSTnil () => prstr "nil"
| EFFCSTset (efs, efvs) => {
    val () = prstr "set("
    val () = $EFF.fprint_effset (out, efs)
    val () = prstr "; "
    val () = $UT.fprintlst (out, efvs, ", ", fprint_i0de)
    val () = prstr ")"
  } // end of [EFFCSTset]
//
end // end of [fprint_effcst]  

(* ****** ****** *)

implement
fprint_s1rt (out, s1t0) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ s1t0.s1rt_node of
| S1RTapp (s1t, s1ts) => {
    val () = prstr "S1RTapp("
    val () = fprint_s1rt (out, s1t)
    val () = prstr "; "
    val () = fprint_s1rtlst (out, s1ts)
    val () = prstr ")"
  } // end of [S1RTapp]
| S1RTlist s1ts => begin
    prstr "S1RTlist("; fprint_s1rtlst (out, s1ts); prstr ")"
  end // end of [S1RTlist]
| S1RTqid (q, id) => {
    val () = prstr "S1RTqid("
    val () = fprint_s0rtq (out, q)
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  } // end of [S1RTqid]
(*
| S1RTtup s1ts => begin
    prstr "S1RTtup("; fprint_s1rtlst (out, s1ts); prstr ")"
  end // end of [S1RTtup]
*)
| S1RTtype (knd) => begin
    prstr "S1RTtype("; fprint_int (out, knd); prstr ")"
  end // end of [S1RTtype]
//
| S1RTerr () => prstr "S1RTerr()" // HX: indicating an error
//
end // end of [fprint_s1rt]

implement print_s1rt (x) = fprint_s1rt (stdout_ref, x)
implement prerr_s1rt (x) = fprint_s1rt (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s1rtlst (out, xs) =
  $UT.fprintlst<s1rt> (out, xs, ", ", fprint_s1rt)
// end of [fprint_s1rtlst]

implement print_s1rtlst (xs) = fprint_s1rtlst (stdout_ref, xs)
implement prerr_s1rtlst (xs) = fprint_s1rtlst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s1rtopt (out, x) = $UT.fprintopt<s1rt> (out, x, fprint_s1rt)

(* ****** ****** *)

implement
fprint_s1rtlstlst (out, xss) =
  $UT.fprintlst<s1rtlst> (out, xss, "; ", fprint_s1rtlst)
// end of [fprint_s1rtlstlst]

(* ****** ****** *)

implement
fprint_d1atsrtcon (out, x) = {
  val () = fprint_symbol (out, x.d1atsrtcon_sym)
  val () = fprint_string (out, "(")
  val () = fprint_s1rtlst (out, x.d1atsrtcon_arg)
  val () = fprint_string (out, ")")
}

implement
fprint_d1atsrtdec (out, x) = {
  val () = fprint_symbol (out, x.d1atsrtdec_sym)
  val () = fprint_string (out, "(\n")
  val () = $UT.fprintlst (out, x.d1atsrtdec_con, "\n", fprint_d1atsrtcon)
  val () = fprint_string (out, "\n)")
}

(* ****** ****** *)

implement
fprint_s1arg (out, x) = {
  val () = fprint_symbol (out, x.s1arg_sym)
  val () = (case+ x.s1arg_srt of
    | Some s1t => (
        fprint_string (out, ": "); fprint_s1rt (out, s1t)
      ) // end of [Some]
    | None () => ()
  ) : void // end of [val]
} // end of [fprint_s1arg]

implement
fprint_s1arglst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s1arg)
// end of [fprint_s1arglst]

implement
fprint_s1marg (out, x) = fprint_s1arglst (out, x.s1marg_arg)

(* ****** ****** *)

implement
fprint_a1srt (out, x) = {
  val () = (case+ x.a1srt_sym of
    | Some sym => (
        fprint_symbol (out, sym); fprint_string (out, ": ")
      ) // end of [Some]
    | None () => ()
  ) : void // end of [val]
  val () = fprint_s1rt (out, x.a1srt_srt)
} // end of [fprint_a1srt]

implement
fprint_a1srtlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_a1srt)
// end of [fprint_a1srtlst]

(* ****** ****** *)

implement
fprint_a1msrt (out, x) = {
  val () = fprint_string (out, "(")
  val () = fprint_a1srtlst (out, x.a1msrt_arg)
  val () = fprint_string (out, ")")
}

implement
fprint_a1msrtlst
  (out, xs) = $UT.fprintlst (out, xs, " ", fprint_a1msrt)
// end of [fprint_a1msrtlst]

(* ****** ****** *)

implement
fprint_s1exp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x.s1exp_node of
//
| S1Eint (int) => {
    val () = prstr "S1Eint("
    val () = fprint_int (out, int)
    val () = prstr ")"
  }
| S1Eintrep (rep) => {
    val () = prstr "S1Eintrep("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
//
| S1Echar (char) => {
    val () = prstr "S1Echar("
    val () = fprint_char (out, char)
    val () = prstr ")"
  }
//
| S1Efloat (rep) => {
    val () = prstr "S1Efloat("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| S1Estring (str) => {
    val () = prstr "S1Estring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| S1Eextype
    (name, arg) => {
    val () = prstr "S1Eextype("
    val () = fprint_string (out, name)
    val () = prstr "; "
    val () = $UT.fprintlst (out, arg, "; ", fprint_s1explst)
    val () = prstr ")"
  }
| S1Eextkind
    (name, arg) => {
    val () = prstr "S1Eextkind("
    val () = fprint_string (out, name)
    val () = prstr "; "
    val () = $UT.fprintlst (out, arg, "; ", fprint_s1explst)
    val () = prstr ")"
  }
//
| S1Eide (id) => {
    val () = prstr "S1Eide("
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
| S1Esqid (sq, id) => {
    val () = prstr "S1Esqid("
    val () = fprint_s0taq (out, sq)
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| S1Eapp (
    s1e, _(*loc_arg*), s1es
  ) => {
    val () = prstr "S1Eapp("
    val () = fprint_s1exp (out, s1e)
    val () = prstr "; "
    val () = fprint_s1explst (out, s1es)
    val () = prstr ")"
  }
| S1Elam (
    arg, res, body
  ) => {
    val () = prstr "S1Elam("
    val () = fprint_s1marg (out, arg)
    val () = prstr "; "
    val () = fprint_s1rtopt (out, res)
    val () = prstr "; "
    val () = fprint_s1exp (out, body)
    val () = prstr ")"
  }
| S1Eimp _ => {
    val () = prstr "S1Eimp("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| S1Elist (npf, s1es) => {
    val () = prstr "S1Elist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_s1explst (out, s1es)
    val () = prstr ")"
  }
//
| S1Etop (knd, s1e) => {
    val () = prstr "S1Etop("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_s1exp (out, s1e)
    val () = prstr ")"
  }
//
| S1Einvar (knd, s1e) => {
    val () = prstr "S1Einvar("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_s1exp (out, s1e)
    val () = prstr ")"
  }
| S1Etrans (s1e1, s1e2) => {
    val () = prstr "S1Etrans("
    val () = fprint_s1exp (out, s1e1)
    val () = prstr " >> "
    val () = fprint_s1exp (out, s1e2)
    val () = prstr ")"
  }
//
| S1Etyarr (elt, dim) => {
    val () = prstr "S1Etyarr("
    val () = fprint_s1exp (out, elt)
    val () = prstr "; "
    val () = fprint_s1explst (out, dim)
    val () = prstr ")"
  }
| S1Etytup (knd, npf, s1es) => {
    val () = prstr "S1Etytup("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_s1explst (out, s1es)
    val () = prstr ")"
  }
| S1Etyrec (knd, npf, ls1es) => {
    val () = prstr "S1Etyrec("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_labs1explst (out, ls1es)
    val () = prstr ")"
  }
| S1Etyrec_ext
    (name, npf, ls1es) => {
    val () = prstr "S1Etyrec_ext("
    val () = fprint_string (out, name)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_labs1explst (out, ls1es)
    val () = prstr ")"
  }
//
| S1Eexi (knd, qua, body) => {
    val () = prstr "S1Eexi("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_s1qualst (out, qua)
    val () = prstr "; "
    val () = fprint_s1exp (out, body)
    val () = prstr ")"
  }
| S1Euni (qua, body) => {
    val () = prstr "S1Euni("
    val () = fprint_s1qualst (out, qua)
    val () = prstr "; "
    val () = fprint_s1exp (out, body)
    val () = prstr ")"
  }
//
| S1Eann (s1e, s1t) => {
    val () = prstr "S1Eann("
    val () = fprint_s1exp (out, s1e)
    val () = prstr " : "
    val () = fprint_s1rt (out, s1t)
    val () = prstr ")"
  }
//
| S1Ed2ctype (d2ctp) => prstr "S1Ed2ctype(...)"
//
| S1Eerr () => prstr "S1Eerr()"
//
(*
| _ => prstr "S1E...(...)"
*)
//
end // end of [fprint_s1exp]

implement
print_s1exp (x) = fprint_s1exp (stdout_ref, x)
implement
prerr_s1exp (x) = fprint_s1exp (stderr_ref, x)

implement
fprint_s1explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s1exp)
// end of [fprint_s1explst]

implement
fprint_s1expopt
  (out, opt) = $UT.fprintopt (out, opt, fprint_s1exp)
// end of [fprint_s1expopt]

(* ****** ****** *)

implement
fprint_labs1exp
  (out, x) = () where {
  val+SL0ABELED (l, name, s1e) = x
  val () = fprint_l0ab (out, l)
  val () = fprint_string (out, "= ")
  val () = fprint_s1exp (out, s1e)
} // end of [fprint_labs1exp]

implement
fprint_labs1explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_labs1exp)
// end of [fprint_labs1explst]

(* ****** ****** *)

implement
fprint_s1rtext
  (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x.s1rtext_node of
| S1TEsrt (s1t) => {
    val () = prstr "S1TEsrt("
    val () = fprint_s1rt (out, s1t)
    val () = prstr ")"
  }
| S1TEsub (sym, s1te, s1ps) => {
    val () = prstr "S1TEsub("
    val () = fprint_symbol (out, sym)
    val () = prstr "; "
    val () = fprint_s1rtext (out, s1te)
    val () = prstr " | "
    val () = fprint_s1explst (out, s1ps)
    val () = prstr ")"
  }
//
end // end of [fprint_s1rtext]

(* ****** ****** *)

implement
fprint_s1qua
  (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ x.s1qua_node of
  | S1Qprop (s1p) => {
      val () = prstr "S1Qprop("
      val () = fprint_s1exp (out, s1p)
      val () = prstr ")"
    }
  | S1Qvars (ids, s1te) => {
      val () = prstr "S1Qvars("
      val () = $UT.fprintlst (out, ids, ", ", fprint_i0de)
      val () = prstr " : "
      val () = fprint_s1rtext (out, s1te)
      val () = prstr ")"
    }
end // end of [fprint_s1qua]

implement
fprint_s1qualst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s1qua)
// end of [fprint_s1qualst]

(* ****** ****** *)

implement
fprint_s1vararg (out, x) =
  case+ x of
  | S1VARARGone (_) =>
      fprint_string (out, "{..}")
  | S1VARARGall (_) =>
      fprint_string (out, "{...}")
  | S1VARARGseq (loc, s1as) => {
      val () = fprint_string (out, "{")
      val () = fprint_s1arglst (out, s1as)
      val () = fprint_string (out, "}")
    } (* end of [S1VARARGseq] *)
// end of [fprint_s1vararg]

implement
print_s1vararg (x) = fprint_s1vararg (stdout_ref, x)
implement
prerr_s1vararg (x) = fprint_s1vararg (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s1exparg (out, x) =
  case+ x.s1exparg_node of
  | S1EXPARGone () =>
      fprint_string (out, "{..}")
  | S1EXPARGall () =>
      fprint_string (out, "{...}")
  | S1EXPARGseq (s1es) => {
      val () = fprint_string (out, "{")
      val () = fprint_s1explst (out, s1es)
      val () = fprint_string (out, "}")
    } (* end of [S1EXPARGseq] *)
// end of [s1exparg_node]

implement
fprint_s1exparglst
  (out, xs) = $UT.fprintlst (out, xs, "", fprint_s1exparg)
// end of [fprint_s1exparglst]

(* ****** ****** *)

implement
fprint_s1rtdef (out, x) = {
  val () = fprint_symbol (out, x.s1rtdef_sym)
  val () = fprint_string (out, " = ")
  val () = fprint_s1rtext (out, x.s1rtdef_def)
} // end of [fprint_s1rtdef]

(* ****** ****** *)

implement
fprint_s1tacst (out, x) = {
  val () = fprint_symbol (out, x.s1tacst_sym)
  val () = fprint_string (out, "(")
  val () = fprint_a1msrtlst (out, x.s1tacst_arg)
  val () = fprint_string (out, ") : ")
  val () = fprint_s1rt (out, x.s1tacst_res)
} // end of [fprint_s1tacst]

(* ****** ****** *)

implement
fprint_s1tacon (out, x) = {
  val () = fprint_symbol (out, x.s1tacon_sym)
  val () = fprint_string (out, "(")
  val () = fprint_a1msrtlst (out, x.s1tacon_arg)
  val () = fprint_string (out, ") = ")
  val () = fprint_s1expopt (out, x.s1tacon_def)
} // end of [fprint_s1tacon]

(* ****** ****** *)

(*
implement
fprint_s1tavar (out, x) = {
  val () = fprint_symbol (out, x.s1tavar_sym)
  val () = fprint_string (out, " : ")
  val () = fprint_s1rt (out, x.s1tavar_srt)
} // end of [fprint_s1tavar]
*)

(* ****** ****** *)

implement
fprint_s1expdef (out, x) = {
  macdef prstr (s) = fprint_string (out, ,(s))
  val () = fprint_symbol (out, x.s1expdef_sym)
  val () = prstr "("
  val () = $UT.fprintlst (out, x.s1expdef_arg, "; ", fprint_s1marg)
  val () = prstr ")"
  val () = (case+ x.s1expdef_res of
    | Some s1t => (prstr ": "; fprint_s1rt (out, s1t))
    | None () => ()
  ) : void // end of [val]
  val () = prstr " = "
  val () = fprint_s1exp (out, x.s1expdef_def)
} // end of [fprint_s1expdef]

(* ****** ****** *)

implement
fprint_s1aspdec (out, x) = {
  macdef prstr (s) = fprint_string (out, ,(s))
  val () = fprint_sqi0de (out, x.s1aspdec_qid)
  val () = prstr "("
  val () = $UT.fprintlst (out, x.s1aspdec_arg, "; ", fprint_s1marg)
  val () = prstr ")"
  val () = (case+ x.s1aspdec_res of
    | Some s1t => (prstr ": "; fprint_s1rt (out, s1t))
    | None () => ()
  ) : void // end of [val]
  val () = prstr " = "
  val () = fprint_s1exp (out, x.s1aspdec_def)
} // end of [fprint_s1expdef]

(* ****** ****** *)

implement
fprint_q1marg (out, x) = {
  val () = fprint_string (out, "{")
  val () = fprint_s1qualst (out, x.q1marg_arg)
  val () = fprint_string (out, "}")
} // end of [fprint_q1marg]

implement
fprint_q1marglst
  (out, xs) = $UT.fprintlst (out, xs, "", fprint_q1marg)
// end of [fprint_q1marglst]

(* ****** ****** *)

implement
fprint_i1mparg (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ x of
  | I1MPARG_sarglst (s1as) => {
      val () = prstr "("
      val () = fprint_s1arglst (out, s1as)
      val () = prstr ")"
    } (* end of [I1MPARG_sarglst] *)
  | I1MPARG_svararglst (s1vs) => {
      val () = $UT.fprintlst (out, s1vs, "", fprint_s1vararg)
    } (* end of [I1MPARG_svararglst] *)
end // end of [fprint_i1mparg]

(* ****** ****** *)

implement
fprint_e1xndec (out, x) = {
  val () = fprint_symbol (out, x.e1xndec_sym)
  val () = fprint_string (out, " : ")
  val () = $UT.fprintlst (out, x.e1xndec_qua, " ", fprint_q1marg)
  val () = fprint_string (out, "(")
  val () = fprint_int (out, x.e1xndec_npf)
  val () = fprint_string (out, "; ")
  val () = fprint_s1explst (out, x.e1xndec_arg)
  val () = fprint_string (out, ")")
} // end of [fprint_e1xndec]

(* ****** ****** *)

implement
fprint_d1cstdec (out, x) = {
  val () = fprint_symbol (out, x.d1cstdec_sym)
  val () = fprint_string (out, " : ")
  val () = fprint_s1exp (out, x.d1cstdec_type)
} // end of [d1cstdec]

(* ****** ****** *)

(* end of [pats_staexp1_print.dats] *)

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

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_fixity.sats"
staload "./pats_label.sats"
staload "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_lexing.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

implement
fprint_macsynkind
  (out, x) = let
//
macdef prstr
  (str) = fprint_string (out, ,(str))
//
in
  case+ x of
  | MSKencode () => prstr "MSKencode"
  | MSKdecode () => prstr "MSKdecode"
  | MSKxstage () => prstr "MSKxstage" // CSP: cross-stage persistence
end // end of [fprint_macsynkind]

implement
print_macsynkind (x) = fprint_macsynkind (stdout_ref, x)
implement
prerr_macsynkind (x) = fprint_macsynkind (stderr_ref, x)

(* ****** ****** *)

implement
fprint_cstsp
  (out, x) = (
  case+ x of
  | CSTSPmyfil () => fprint_string (out, "$myfilename")
  | CSTSPmyloc () => fprint_string (out, "$mylocation")
  | CSTSPmyfun () => fprint_string (out, "$myfunction")
(*
  | CSTSPmylinecnt () => fprint_string (out, "$mylinecount")
  | CSTSPmycharcnt () => fprint_string (out, "$mycharcount")
*)
) // end of [fprint_cstsp]

(* ****** ****** *)

implement
fprint_i0nt
  (out, x) = let
//
val-T_INT
  (_, rep, _) = x.token_node in fprint_string (out, rep)
//
end // end of [fprint_i0nt]

implement
fprint_c0har
  (out, x) = let
  val-T_CHAR (chr) = x.token_node in fprint_char (out, chr)
end // end of [fprint_c0har]

implement
fprint_f0loat
  (out, x) = let
//
val-T_FLOAT
  (base, rep, sfx) = x.token_node in fprint_string (out, rep)
//
end // end of [fprint_f0loat]

implement
fprint_s0tring
  (out, x) = let
  val-T_STRING (str) = x.token_node in fprint_string (out, str)
end // end of [fprint_c0har]

(* ****** ****** *)

implement
fprint_i0de
  (out, x) = fprint_symbol (out, x.i0de_sym)
// end of [fprint_i0de]

implement print_i0de (x) = fprint_i0de (stdout_ref, x)
implement prerr_i0de (x) = fprint_i0de (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s0rtq (out, x) =
  case+ x.s0rtq_node of
  | S0RTQnone () => ()
  | S0RTQsymdot (sym) => {
      val () = fprint_symbol (out, sym)
      val () = fprint_string (out, ".")
    }
// end of [fprint_s0rtq]

implement print_s0rtq (x) = fprint_s0rtq (stdout_ref, x)
implement prerr_s0rtq (x) = fprint_s0rtq (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s0taq (out, x) =
  case+ x.s0taq_node of
  | S0TAQnone () => ()
  | S0TAQsymdot (sym) => {
      val () = fprint_symbol (out, sym)
      val () = fprint_string (out, ".")
    }
  | S0TAQsymcolon (sym) => {
      val () = fprint_symbol (out, sym)
      val () = fprint_string (out, ":")
    }
// end of [fprint_s0taq]

implement print_s0taq (x) = fprint_s0taq (stdout_ref, x)
implement prerr_s0taq (x) = fprint_s0taq (stderr_ref, x)

implement
fprint_sqi0de (out, x) = {
  val () = fprint_s0taq (out, x.sqi0de_qua)
  val () = fprint_symbol (out, x.sqi0de_sym)
} // end of [fprint_sqi0de]

(* ****** ****** *)

implement
fprint_d0ynq (out, x) =
  case+ x.d0ynq_node of
  | D0YNQnone () => ()
  | D0YNQsymdot (sym) => {
      val () = fprint_symbol (out, sym)
      val () = fprint_string (out, ".")
    }
  | D0YNQsymcolon (sym) => {
      val () = fprint_symbol (out, sym)
      val () = fprint_string (out, ":")
    }
  | D0YNQsymdotcolon (sym1, sym2) => {
      val () = fprint_symbol (out, sym1)
      val () = fprint_symbol (out, sym2)
      val () = fprint_string (out, ":")
    }
// end of [fprint_d0ynq]

implement print_d0ynq (x) = fprint_d0ynq (stdout_ref, x)
implement prerr_d0ynq (x) = fprint_d0ynq (stderr_ref, x)

implement
fprint_dqi0de (out, x) = {
  val () = fprint_d0ynq (out, x.dqi0de_qua)
  val () = fprint_symbol (out, x.dqi0de_sym)
} // end of [fprint_dqi0de]

implement print_dqi0de (x) = fprint_dqi0de (stdout_ref, x)
implement prerr_dqi0de (x) = fprint_dqi0de (stderr_ref, x)

(* ****** ****** *)

implement
fprint_p0rec (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ x of
  | P0RECint int => prstr "P0RECint(...)"
  | P0RECi0de (id) => prstr "P0RECi0de(...)"
  | P0RECi0de_adj _ => prstr "P0RECi0de_adj(...)" 
end // end of [fprint_p0rec]

(* ****** ****** *)

implement
fprint_f0xty
  (out, x) = let
//
macdef
prstr(x) = fprint_string (out, ,(x))
//
in
  case+ x of
  | F0XTYinf _ => prstr "F0XTYinf(...)"
  | F0XTYpre _ => prstr "F0XTYpre(...)"
  | F0XTYpos _ => prstr "F0XTYpos(...)"
end // end of [fprint_f0xty]

(* ****** ****** *)

implement
fprint_e0xpactkind
  (out, x) = (
//
case+ x of
| E0XPACTassert
    ((*void*)) => fprint_string (out, "E0XPACTassert")
//
| E0XPACTerror () => fprint_string (out, "E0XPACTerror")
| E0XPACTprerr () => fprint_string (out, "E0XPACTprint")
| E0XPACTprint () => fprint_string (out, "E0XPACTprint")
//
) (* end of [fprint_e0xpactkind] *)

(* ****** ****** *)

implement
fprint_e0xp
  (out, x0) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ x0.e0xp_node of
  | E0XPide (x) => {
      val () = prstr "E0XPide("
      val () = fprint_symbol (out, x)
      val () = prstr ")"
    }
  | E0XPchar (x) => {
      val () = prstr "E0XPchar("
      val () = fprint_c0har (out, x)
      val () = prstr ")"
    }
  | E0XPint (x) => {
      val () = prstr "E0XPint("
      val () = fprint_i0nt (out, x)
      val () = prstr ")"
    }
  | E0XPfloat (x) => {
      val () = prstr "E0XPfloat("
      val () = fprint_f0loat (out, x)
      val () = prstr ")"
    }
  | E0XPstring (x) => {
      val () = prstr "E0XPstring("
      val () = fprint_s0tring (out, x)
      val () = prstr ")"
    }
  | E0XPstringid (x) => {
      val () = prstr "E0XPstringid("
      val () = fprint_string (out, x)
      val () = prstr ")"
    }
  | E0XPapp (x1, x2) => {
      val () = prstr "E0XPapp("
      val () = fprint_e0xp (out, x1)
      val () = prstr "; "
      val () = fprint_e0xp (out, x2)
      val () = prstr ")"
    }
  | E0XPfun (arg, body) => {
      val () = prstr "E0XPfun("
      val () = $UT.fprintlst<symbol> (out, arg, ", ", fprint_symbol)
      val () = prstr "; "
      val () = fprint_e0xp (out, body)
      val () = prstr ")"
    }
  | E0XPeval (x) => {
      val () = prstr "E0XPeval("
      val () = fprint_e0xp (out, x)
      val () = prstr ")"
    }
  | E0XPlist (xs) => {
      val () = prstr "E0XPlist("
      val () = fprint_e0xplst (out, xs)
      val () = prstr ")"
    }
  | E0XPif (_cond, _then, _else) => {
      val () = prstr "E0XPif("
      val () = fprint_e0xp (out, _cond)
      val () = prstr "; "
      val () = fprint_e0xp (out, _then)
      val () = prstr "; "
      val () = $UT.fprintopt<e0xp> (out, _else, fprint_e0xp)
      val () = prstr ")"
    }
end // end of [fprint_e0xp]

implement
fprint_e0xplst (out, xs) =
  $UT.fprintlst<e0xp> (out, xs, ", ", fprint_e0xp)
// end of [fprint_e0xplst]

(* ****** ****** *)

implement fprint_l0ab
  (out, x) = fprint_label (out, x.l0ab_lab)
// end of [fprint_l0ab]

(* ****** ****** *)

implement
fprint_s0rt (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ x.s0rt_node of
  | S0RTapp (s0t1, s0t2) => {
      val () = prstr "S0RTapp("
      val () = fprint_s0rt (out, s0t1)
      val () = prstr "; "
      val () = fprint_s0rt (out, s0t2)
      val () = prstr ")"
    }
  | S0RTide (id) => {
      val () = prstr "S0RTide("
      val () = fprint_symbol (out, id)
      val () = prstr ")"
    }
  | S0RTqid (q, id) => {
      val () = prstr "S0RTqid("
      val () = fprint_s0rtq (out, q)
      val () = fprint_symbol (out, id)
      val () = prstr ")"
    }
  | S0RTlist (xs) => {
      val () = prstr "S0RTlist("
      val () = $UT.fprintlst<s0rt> (out, xs, ", ", fprint_s0rt)
      val () = prstr ")"
    }
  | S0RTtype (knd) => {
      val () = prstr "S0RTtype("
      val () = fprint_int (out, knd)
      val () = prstr ")"
    }
end // end of [fprint_s0rt]

(* ****** ****** *)

fun fprint_d0atsrtcon
  (out: FILEref, x: d0atsrtcon) = {
  val () = fprint_symbol (out, x.d0atsrtcon_sym)
  val () = (
    case+ x.d0atsrtcon_arg of
    | Some s0t => {
        val () = fprint_string (out, " of ")
        val () = fprint_s0rt (out, s0t)
      } // end of [Some]
    | None () => {
        val () = fprint_string (out, " of ()")
      } // end of [None]
  ) : void // end of [val]
} // end of [fprint_d0atsrtcon]

implement
fprint_d0atsrtdec (out, x) = {
  val () = fprint_symbol (out, x.d0atsrtdec_sym)
  val () = fprint_string (out,  " = ")
  val () = $UT.fprintlst<d0atsrtcon>
    (out, x.d0atsrtdec_con, " | ", fprint_d0atsrtcon)
} // end of [fprint_d0atsrtdec]

(* ****** ****** *)

fun fprint_a0srt (
  out: FILEref, x: a0srt
) : void = () where {
  val () = (case+ x.a0srt_sym of
    | Some sym => (
        fprint_symbol (out, sym); fprint_string (out, ": ")
      ) // end of [Some]
    | None () => ()
  ) : void // end of [val]
  val () = fprint_s0rt (out, x.a0srt_srt)
} // end of [fprint_a0srt]

fun fprint_a0msrt (
  out: FILEref, x: a0msrt
) : void = () where {
  val () = fprint_string (out, "(")
  val () = $UT.fprintlst (out, x.a0msrt_arg, ", ", fprint_a0srt)
  val () = fprint_string (out, ")")
} // end of [fprint_a0msrt]

(* ****** ****** *)

implement
fprint_s0rtext (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ x.s0rtext_node of
| S0TEsrt s0t => {
    val () = prstr "S0TEsrt("
    val () = fprint_s0rt (out, s0t)
    val () = prstr ")"
  } // end of [S0TEsrt]
| S0TEsub (id, s0te, s0e, s0es) => {
    val () = prstr "S0TEsub("
    val () = fprint_i0de (out, id)
    val () = prstr ": "
    val () = fprint_s0rtext (out, s0te)
    val () = prstr "; "
    val () = fprint_s0exp (out, s0e)
    val () = (case+ s0es of
      | list_cons _ => (
          prstr "; "; $UT.fprintlst (out, s0es, "; ", fprint_s0exp)
        )
      | list_nil () => ()
    ) // end of [val]
    val () = prstr ")"
  } (* end of [S0TEsub] *)
//
end // end of [fprint_s0rtext]

(* ****** ****** *)

implement
fprint_s0qua (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ x.s0qua_node of
| S0QUAprop (s0e) => {
    val () = prstr "S0QUAprop("
    val () = fprint_s0exp (out, s0e)
    val () = prstr ")"
  }
| S0QUAvars (id, ids, s0te) => {
    val () = prstr "S0QUAvar("
    val () = fprint_i0de (out, id)
    val () = (
      case+ ids of
      | list_cons _ => (
          prstr ", "; $UT.fprintlst (out, ids, ", ", fprint_i0de)
        )
      | list_nil () => ()
    ) // end of [val]
    val () = prstr ": "
    val () = fprint_s0rtext (out, s0te)
    val () = prstr ")"
  } (* end of [S0QUAvars] *)
//
end // end of [fprint_s0qua]

implement
fprint_s0qualst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_s0qua)
// end of [fprint_s0qualst]

(* ****** ****** *)

implement
fprint_s0exp (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ x.s0exp_node of
//
| S0Eide (id) => {
    val () = prstr "S0Eide("
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| S0Esqid
    (sq, id) => {
    val () = prstr "S0Esqid("
    val () = fprint_s0taq (out, sq)
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| S0Eopid (id) => {
    val () = prstr "S0Eopid("
    val () = fprint_symbol (out, id)
    val () = prstr ")"
  }
//
| S0Eint (x) => {
    val () = prstr "S0Ei0nt("
    val () = fprint_i0nt (out, x)
    val () = prstr ")"
  }
| S0Echar (x) => {
    val () = prstr "S0Echar("
    val () = fprint_c0har (out, x)
    val () = prstr ")"
  }
| S0Efloat (x) => {
    val () = prstr "S0Efloat("
    val () = fprint_f0loat (out, x)
    val () = prstr ")"
  }
| S0Estring (x) => {
    val () = prstr "S0Estring("
    val () = fprint_s0tring (out, x)
    val () = prstr ")"
  }
//
| S0Eextype
    (name, s0es) => {
    val () = prstr "S0Eextype("
    val () = fprint_string (out, name)
    val () = prstr "; "
    val () = fprint_s0explst (out, s0es)
    val () = prstr ")"
  }
| S0Eextkind
    (name, s0es) => {
    val () = prstr "S0Eextkind("
    val () = fprint_string (out, name)
    val () = prstr "; "
    val () = fprint_s0explst (out, s0es)
    val () = prstr ")"
  }
//
| S0Eapp (s0e1, s0e2) => {
    val () = prstr "S0Eapp("
    val () = fprint_s0exp (out, s0e1)
    val () = prstr "; "
    val () = fprint_s0exp (out, s0e2)
    val () = prstr ")"
  }
| S0Eimp _ => {
    val () = prstr "S0Eimp("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| S0Elam
    (_, s0topt, s0e) => {
    val () = prstr "S0Elam("
    val () = $UT.fprintopt<s0rt> (out, s0topt, fprint_s0rt)
    val () = prstr "; "
    val () = fprint_s0exp (out, s0e)
    val () = prstr ")"
  }
| S0Elist (s0es) => {
    val () = prstr "S0Elist("
    val () = fprint_s0explst (out, s0es)
    val () = prstr ")"
  }
| S0Elist2
    (s0es1, s0es2) => {
    val () = prstr "S0Elist2("
    val () = fprint_s0explst (out, s0es1)
    val () = prstr " | "
    val () = fprint_s0explst (out, s0es2)
    val () = prstr ")"
  }
| S0Etyarr
    (elt, dim) => {
    val () = prstr "S0Etyarr("
    val () = fprint_s0exp (out, elt)
    val () = prstr "; "
    val () = fprint_s0explst (out, dim)
    val () = prstr ")"
  }
| S0Etytup (knd, npf, s0es) => {
    val () = prstr "S0Etytup("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_s0explst (out, s0es)
    val () = prstr ")"
  }
| S0Etyrec
    (knd, npf, xs) => {
    val () = prstr "S0Etyrec("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () =
      $UT.fprintlst (out, xs, ", ", fprint_labs0exp)
    // end of [val]
    val () = prstr ")"
  }
| S0Etyrec_ext
    (name, npf, xs) => {
    val () = prstr "S0Etyrec_ext("
    val () = fprint_string (out, name)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () =
      $UT.fprintlst (out, xs, ", ", fprint_labs0exp)
    // end of [val]
    val () = prstr ")"
  }
//
| S0Euni s0qs => {
    val () = prstr "S0Euni("
    val () = $UT.fprintlst (out, s0qs, ", ", fprint_s0qua)
    val () = prstr ")"
  }
| S0Eexi
    (knd, s0qs) => {
    val () = prstr "S0Eexi("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst (out, s0qs, ", ", fprint_s0qua)
    val () = prstr ")"
  }
//
| S0Eann
    (s0e1, s0t2) => {
    val () = prstr "S0Eann("
    val () =
      fprint_s0exp (out, s0e1)
    // end of [val]
    val () = prstr "; "
    val () = fprint_s0rt (out, s0t2)
    val ((*closing*)) = prstr ")"
  }
//
| S0Ed2ctype (d2ctp) => prstr "S0Ed2ctype(...)"
//
(*
//  | _ => prstr "S0E(...)"
*)
end // end of [fprint_s0exp]

(* ****** ****** *)

implement
fprint_s0explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s0exp)
// end of [fprint_s0explst]

implement
fprint_s0expopt
  (out, opt) = $UT.fprintopt (out, opt, fprint_s0exp)
// end of [fprint_s0expopt]

(* ****** ****** *)

implement
fprint_s0exparg
  (out, s0a) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
  case+ s0a of
  | S0EXPARGone _ => prstr "{..}"
  | S0EXPARGall _ => prstr "{...}"
  | S0EXPARGseq (s0es) => {
      val () = prstr "{"
      val () = fprint_s0explst (out, s0es)
      val () = prstr "}"
    } (* end of [S0EXPARGseq] *)
end // end of [fprint_s0exparg]

(* ****** ****** *)

implement
fprint_labs0exp
  (out, x) = () where {
  val+SL0ABELED (l, name, s0e) = x
  val () = fprint_l0ab (out, l)
  val () = fprint_string (out, "= ")
  val () = fprint_s0exp (out, s0e)
} // end of [fprint_labs0exp]

(* ****** ****** *)

implement
fprint_q0marg
  (out, x) = {
  val () = fprint_string (out, "{")
  val () = fprint_s0qualst (out, x.q0marg_arg)
  val () = fprint_string (out, "}")
} // end of [fprint_q0marg]

implement
fprint_q0marglst
  (out, xs) = $UT.fprintlst (out, xs, "", fprint_q0marg)
// end of [fprint_q0marglst]

(* ****** ****** *)

implement
fprint_p0at (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ x.p0at_node of
//
| P0Tide (sym) => {
    val () = prstr "P0Tide("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
| P0Topid (sym) => {
    val () = prstr "P0Topid("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
| P0Tdqid (dq, sym) => {
    val () = prstr "P0Tdqid("
    val () = fprint_d0ynq (out, dq)
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
//
| P0Tint (x) => {
    val () = prstr "P0Tint("
    val () = fprint_i0nt (out, x)
    val () = prstr ")"
  }
| P0Tchar (x) => {
    val () = prstr "P0Tchar("
    val () = fprint_c0har (out, x)
    val () = prstr ")"
  }
| P0Tfloat (x) => {
    val () = prstr "P0Tfloat("
    val () = fprint_f0loat (out, x)
    val () = prstr ")"
  }
| P0Tstring (x) => {
    val () = prstr "P0Tstring("
    val () = fprint_s0tring (out, x)
    val () = prstr ")"
  }
//
| P0Tapp (p0t1, p0t2) => {
    val () = prstr "P0Tapp("
    val () = fprint_p0at (out, p0t1)
    val () = prstr "; "
//    val () = fprint_p0at (out, p0t2)
    val () = prstr ")"
  }
| P0Tlist (npf, p0ts) => {
    val () = prstr "P0Tlist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = $UT.fprintlst (out, p0ts, ", ", fprint_p0at)
    val () = prstr ")"
  }
//
| P0Tlst (lin, p0ts) => {
    val () = prstr "P0Tlst("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = $UT.fprintlst (out, p0ts, ", ", fprint_p0at)
    val () = prstr ")"
  }
| P0Trec (knd, npf, lp0ts) => {
    val () = prstr "P0Trec("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = $UT.fprintlst (out, lp0ts, ", ", fprint_labp0at)
    val () = prstr ")"
  }
| P0Ttup (knd, npf, p0ts) => {
    val () = prstr "P0Ttup("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = $UT.fprintlst (out, p0ts, ", ", fprint_p0at)
    val () = prstr ")"
  }
//
| P0Tfree (p0t) => {
    val () = prstr "P0Tfree("
    val () = fprint_p0at (out, p0t)
    val () = prstr ")"
  }
| P0Tunfold (p0t) => {
    val () = prstr "P0Tunfold("
    val () = fprint_p0at (out, p0t)
    val () = prstr ")"
  }
//
| P0Texist (s0as) => {
    val () = prstr "P0Texist("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| P0Tsvararg (s0vs) => {
    val () = prstr "P0Tsvararg("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| P0Trefas (id, loc_id, p0t_as) => {
    val () = prstr "P0Trefas("
    val () = fprint_symbol (out, id)
    val () = prstr ", "
    val () = fprint_p0at (out, p0t_as)
    val () = prstr ")"
  }
//
| P0Tann (p0t, s0e) => {
    val () = prstr "P0Tann("
    val () = fprint_p0at (out, p0t)
    val () = prstr ": "
    val () = fprint_s0exp (out, s0e)
    val () = prstr ")"
  }
//
| P0Terr () => prstr "P0Terr()"
//
end // end of [fprint_p0at]

(* ****** ****** *)

implement
fprint_labp0at (out, x) =
  case+ x.labp0at_node of
  | LABP0ATnorm (l, p0t) => {
      val () = fprint_l0ab (out, l)
      val () = fprint_string (out, "= ")
      val () = fprint_p0at (out, p0t)
    } // end of [LABP0ATnorm]
  | LABP0ATomit () => fprint_string (out, "...")
// end of [fprint_labp0at]

(* ****** ****** *)

implement
fprint_d0exp (out, x) = let
  macdef prstr (str) = fprint_string (out, ,(str))
in
//
case+ x.d0exp_node of
//
| D0Eide (sym) => {
    val () = prstr "D0Eide("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
| D0Eopid (sym) => {
    val () = prstr "D0Eopid("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
| D0Edqid (dq, sym) => {
    val () = prstr "D0Edqid("
    val () = fprint_d0ynq (out, dq)
    val () = prstr ", "
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
//
| D0Eidext (sym) => {
    val () = prstr "D0Eidext("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  }
//
| D0Eint (x) => {
    val () = prstr "D0Eint("
    val () = fprint_i0nt (out, x)
    val () = prstr ")"
  }
| D0Echar (x) => {
    val () = prstr "D0Echar("
    val () = fprint_c0har (out, x)
    val () = prstr ")"
  }
| D0Efloat (x) => {
    val () = prstr "D0Efloat("
    val () = fprint_f0loat (out, x)
    val () = prstr ")"
  }
| D0Estring (x) => {
    val () = prstr "D0Estring("
    val () = fprint_s0tring (out, x)
    val () = prstr ")"
  }
//
(*
| D0Etop () => prstr "D0Etop()"
*)
| D0Eempty () => prstr "D0Eempty()"
//
| D0Ecstsp (x) => {
    val () = prstr "D0Ecstsp("
    val () = fprint_cstsp (out, x)
    val () = prstr ")"
  }
//
| D0Etyrep (x) => {
    val () = prstr "D0Etyrep("
    val () = fprint_s0exp (out, x)
    val () = prstr ")"
  }
//
| D0Eliteral (x) => {
    val () = prstr "D0Eliteral("
    val () = fprint_d0exp (out, x)
    val () = prstr ")"
  }
//
| D0Elet _ => prstr "D0Elet(...)"
| D0Ewhere _ => prstr "D0Ewhere(...)"
| D0Edeclseq _ => prstr "D0Edeclseq(...)"
//
| D0Eapp
  (
    _fun, _arg
  ) => {
    val () = prstr "D0Eapp("
    val () = fprint_d0exp (out, _fun)
    val () = prstr "; "
    val () = fprint_d0exp (out, _arg)
    val () = prstr ")"
  }
//
| D0Elist
  (
    npf, d0es
  ) => {
    val () = prstr "D0Elist("
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d0explst (out, d0es)
    val () = prstr ")"
  }
//
| D0Eifhead (
    hd, _test, _then, _else
  ) => {
    val () = prstr "D0Eifhead("
    val () = fprint_d0exp (out, _test)
    val () = prstr "; "
    val () = fprint_d0exp (out, _then)
    val () = prstr "; "
    val () = fprint_d0expopt (out, _else)
    val () = prstr ")"
  }
| D0Esifhead (
    hd, _test, _then, _else
  ) => {
    val () = prstr "D0Esifhead("
    val () = fprint_s0exp (out, _test)
    val () = prstr "; "
    val () = fprint_d0exp (out, _then)
    val () = prstr "; "
    val () = fprint_d0exp (out, _else)
    val () = prstr ")"
  } (* end of [D0Esifhead] *)
//
| D0Eifcasehd _ =>
  {
    val () = prstr "D0Eifcasehd("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D0Ecasehead _ => {
    val () = prstr "D0Ecasehead("
    val () = prstr "..."
    val () = prstr ")"
  }
| D0Escasehead _ => {
    val () = prstr "D0Escasehead("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D0Elst(lin, elt, d0e) => {
    val () = prstr "D0Elst("
    val () = fprint_int (out, lin)
    val () = prstr "; "
    val () = fprint_s0expopt (out, elt)
    val () = prstr "; "
    val () = fprint_d0exp (out, d0e)
    val () = prstr ")"
  }
| D0Etup(knd, npf, d0es) => {
    val () = prstr "D0Etup("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () = fprint_d0explst (out, d0es)
    val () = prstr ")"
  }
| D0Erec(knd, npf, ld0es) => {
    val () = prstr "D0Erec("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, npf)
    val () = prstr "; "
    val () =
      $UT.fprintlst (out, ld0es, ", ", fprint_labd0exp)
    // end of [val]
    val () = prstr ")"
  }
| D0Eseq (d0es) => {
    val () = prstr "D0Eseq("
    val () = $UT.fprintlst (out, d0es, "; ", fprint_d0exp)
    val () = prstr ")"
  }
//
| D0Earrsub _ => {
    val () = prstr "D0Earrsub("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D0Earrpsz _ => {
    val () = prstr "D0Earrpsz("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| D0Earrinit _ => {
    val () = prstr "D0Earrinit("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| D0Eptrof () => prstr "D0Eptrof()"
| D0Eviewat () => prstr "D0Eviewat()"
//
| D0Esel_lab
    (knd, lab) => {
    val () = prstr "D0Esel_lab("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_label (out, lab)
    val () = prstr ")"
  }
| D0Esel_ind
    (knd, ind) => {
    val () = prstr "D0Esel_int("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D0Eraise (d0e) => {
    val () = prstr "D0Eraise("
    val () = fprint_d0exp (out, d0e)
    val () = prstr ")"
  }
//
| D0Eeffmask _ =>
  {
    val () = prstr "D0Eeffmask(...)"
  }
| D0Eeffmask_arg _ =>
  {
    val () = prstr "D0Eeffmask_arg(...)"
  }
//
| D0Eshowtype (d0e) => {
    val () = prstr "D0Eshowtype("
    val () = fprint_d0exp (out, d0e)
    val () = prstr ")"
  }
//
| D0Evcopyenv (knd, d0e) => {
    val () = prstr "D0Evcopyenv("
    val () = fprint_int (out, knd)
    val () = prstr ", "
    val () = fprint_d0exp (out, d0e)
    val () = prstr ")"
  }
//
| D0Etempenver (d0e) => {
    val () = prstr "D0Etempenver("
    val () = fprint_d0exp (out, d0e)
    val () = prstr ")"
  }
//
| D0Esexparg (s0a) => {
    val () = prstr "D0Esexparg("
    val () = fprint_s0exparg (out, s0a)
    val () = prstr ")"
  }
//
| D0Eann (d0e, s0e) => {
    val () = prstr "D0Eann("
    val () = fprint_d0exp (out, d0e)
    val () = prstr ": "
    val () = fprint_s0exp (out, s0e)
    val () = prstr ")"
  }
//
| D0Elam _ => {
    val () = prstr "D0Elam("
    val () = prstr "..."
    val () = prstr ")"
  }
| D0Efix _ => {
    val () = prstr "D0Efix("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D0Edelay (knd, d0e) => {
    val () = prstr "D0Edelay("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_d0exp (out, d0e)
    val () = prstr ")"
  }
//
| D0Efor _ => {
    val () = prstr "D0Efor("
    val () = prstr "..."
    val () = prstr ")"
  }
| D0Ewhile _ => {
    val () = prstr "D0Ewhile("
    val () = prstr "..."
    val () = prstr ")"
  }
| D0Eloopexn (knd) => {
    val () = prstr "D0Eloopexn("
    val () = fprint_int (out, knd)
    val () = prstr ")"
  }
//
| D0Etrywith _ => {
    val () = prstr "D0Etrywith("
    val () = prstr "..."
    val () = prstr ")"
  }
//
| D0Esolassert(d0e) => {
    val () = prstr "D0Esolassert("
    val () = fprint_d0exp (out, d0e)
    val () = prstr ")"
  }
//
| D0Esolverify(s0e) => {
    val () = prstr "D0Esolverify("
    val () = fprint_s0exp (out, s0e)
    val () = prstr ")"
  }
//
| _ (* rest-of-D0E *) => prstr "D0E(...)"
//
end // end of [fprint_d0exp]

(* ****** ****** *)

implement
fprint_d0explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_d0exp)
// end of [fprint_d0explst]

implement
fprint_d0expopt
  (out, opt) = $UT.fprintopt (out, opt, fprint_d0exp)
// end of [fprint_d0expopt]

(* ****** ****** *)

implement
fprint_labd0exp
  (out, x) = () where {
  val+DL0ABELED (l, d0e) = x
  val () = fprint_l0ab (out, l)
  val () = fprint_string (out, "= ")
  val () = fprint_d0exp (out, d0e)
} // end of [fprint_labd0exp]

(* ****** ****** *)

fun fprint_s0tacon (
  out: FILEref, x: s0tacon
) : void = () where {
  val () = fprint_symbol (out, x.s0tacon_sym)
  val () = fprint_string (out, "(")
  val () = $UT.fprintlst (out, x.s0tacon_arg, " ", fprint_a0msrt)
  val () = fprint_string (out, ")")
  val () = fprint_string (out, " = ")
  val () = $UT.fprintopt (out, x.s0tacon_def, fprint_s0exp)
} // end of [fprint_s0tacon]

(* ****** ****** *)

fun fprint_s0tacst (
  out: FILEref, x: s0tacst
) : void = () where {
  val () = fprint_symbol (out, x.s0tacst_sym)
  val () = fprint_string (out, "(")
  val () = $UT.fprintlst (out, x.s0tacst_arg, " ", fprint_a0msrt)
  val () = fprint_string (out, "):")
  val () = fprint_s0rt (out, x.s0tacst_res)
} // end of [fprint_s0tacst]

(* ****** ****** *)

(*
//
// HX-2012-05-23: removed
//
fun fprint_s0tavar
(
  out: FILEref, x: s0tavar
) : void = () where {
  val () = fprint_symbol (out, x.s0tavar_sym)
  val () = fprint_string (out, "(")
  val () = fprint_s0rt (out, x.s0tavar_srt)
  val () = fprint_string (out, ")")
} // end of [fprint_s0tavar]
*)

(* ****** ****** *)

implement
fprint_d0ecl
  (out, x) = let
//
macdef
prstr (str) =
  fprint_string (out, ,(str))
//
in
//
case+
x.d0ecl_node
of // case+
//
| D0Cfixity
    (fxty, ids) => {
    val () = prstr "D0Cfixity("
    val () = fprint_f0xty (out, fxty)
    val () = prstr "; "
    val () = $UT.fprintlst<i0de> (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D0Cnonfix(ids) => {
    val () = prstr "D0Cnonfix("
    val () = $UT.fprintlst<i0de> (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
//
| D0Csymintr(ids) => {
    val () = prstr "D0Csymintr("
    val () = $UT.fprintlst<i0de> (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D0Csymelim(ids) => {
    val () = prstr "D0Csymelim("
    val () = $UT.fprintlst<i0de> (out, ids, ", ", fprint_i0de)
    val () = prstr ")"
  }
| D0Coverload
    (id, qid, pval) =>
  {
    val () =
      prstr "D0Coverload("
    // end of [val]
    val () = fprint_i0de (out, id)
    val () = prstr "; "
    val () = fprint_dqi0de (out, qid)
    val () = prstr "; "
    val () = fprint_int (out, pval)
    val ((*closing*)) = prstr ")"
  } // end of [D0Coverload]
//
| D0Ce0xpdef(id, def) =>
  {
    val () =
      prstr "D0Ce0xpdef("
    // end of [val]
    val () = fprint_symbol (out, id)
    val () = prstr ", "
    val () = $UT.fprintopt<e0xp> (out, def, fprint_e0xp)
    val ((*closing*)) = prstr ")"
  }
| D0Ce0xpundef(idsym) =>
  {
    val () =
      prstr "D0Ce0xpundef("
    // end of [val]
    val () = fprint_symbol (out, idsym)
    val ((*closing*)) = prstr ")"
  }
//
| D0Ce0xpact(knd, act) =>
  {
    val () = prstr "D0Ce0xpact("
    val () = fprint_e0xpactkind (out, knd)
    val () = prstr "; "
    val () = fprint_e0xp (out, act)
    val ((*closing*)) = prstr ")"
  }
//
| D0Cpragma(xs) =>
  {
    val () = prstr "D0Cpragma("
    val () = $UT.fprintlst<e0xp> (out, xs, ", ", fprint_e0xp)
    val ((*closing*)) = prstr ")"
  } (* end of [D0Cpragma] *)
//
| D0Ccodegen(knd, xs) =>
  {
    val () = prstr "D0Ccodegen("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst<e0xp> (out, xs, ", ", fprint_e0xp)
    val ((*closing*)) = prstr ")"
  } (* end of [D0Ccodegen] *)
//
| D0Cdatsrts(xs) => {
    val () = prstr "D0Cdatsrts(\n"
    val () =
      $UT.fprintlst<d0atsrtdec> (out, xs, "\n", fprint_d0atsrtdec)
    // end of [val]
    val ((*closing*)) = prstr "\n)"
  }
| D0Csrtdefs(xs) => {
    val () = prstr "D0Csrtdefs(...)"
  }
| D0Cstacsts(xs) => {
    val () = prstr "D0Cstacsts(\n"
    val () = $UT.fprintlst<s0tacst> (out, xs, "\n", fprint_s0tacst)
    val ((*closing*)) = prstr "\n)"
  }
| D0Cstacons
    (knd, xs) => {
    val () = prstr "D0Cstacons("
    val () = fprint_int (out, knd)
    val () = prstr ";\n"
    val () = $UT.fprintlst<s0tacon> (out, xs, "\n", fprint_s0tacon)
    val ((*closing*)) = prstr "\n)"
  }
(*
| D0Cstavars(xs) => {
    val () = prstr "D0Cstavars(\n"
    val () = $UT.fprintlst<s0tavar> (out, xs, "\n", fprint_s0tavar)
    val ((*closing*)) = prstr "\n)"
  }
*)
| D0Ctkindef(x) =>
  {
    val () = prstr "D0Ctkindef(...)"
  }
| D0Csexpdefs
    (knd, xs) => {
    val () = prstr "D0Csexpdefs("
    val () = fprint! (out, knd, "; ", "...")
    val ((*closing*)) = prstr ")"
  }
| D0Csaspdec(x) =>
  {
    val () = prstr "D0Csaspdec(...)"
  }
| D0Cexndecs(xs) =>
  {
    val () = prstr "D0Cexndecs(...)"
  }
| D0Cdatdecs
    (knd, decs, defs) =>
  {
    val () = prstr "D0Cdatdecs("
    val () = fprint! (out, knd, "; ", "...")
    val ((*closing*)) = prstr ")"
  } (* end of [D0Cdatdecs] *)
//
| D0Cdcstdecs _ => {
    val () = prstr "D0Cdcstdecs(...)"
  } // end of [D0Cdcstdecs]
| D0Cmacdefs _ => {
    val ((*void*)) = prstr "D0Cmacdefs(...)"
  } (* end of [D0Cmacdefs] *)
//
| D0Cclassdec
    (id, sup) => {
    val () = prstr "D0Cclassdec("
    val () = fprint_i0de (out, id)
    val () = prstr "; "
    val () = fprint_s0expopt (out, sup)
    val ((*closing*)) = prstr ")"
  }
| D0Cextype
    (name, s0e_def) => {
    val () = prstr "D0Cextype("
    val () = fprint_string (out, name)
    val () = prstr " = "
    val () = fprint_s0exp (out, s0e_def)
    val ((*closing*)) = prstr ")"
  }
| D0Cextype
  (
    knd, name, s0e_def
  ) => {
    val () = prstr "D0Cextype("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_string (out, name)
    val () = prstr "; "
    val () = fprint_s0exp (out, s0e_def)
    val ((*closing*)) = prstr ")"
  }
| D0Cextvar
    (name, d0e) => {
    val () = prstr "D0Cextvar("
    val () = fprint_string (out, name)
    val () = prstr " = "
    val () = fprint_d0exp (out, d0e)
    val ((*closing*)) = prstr ")"
  }
| D0Cextcode
  (
    knd, pos, code
  ) => {
    val () = prstr "D0Cextcode("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_int (out, pos)
    val () = prstr "\n"
    val () = prstr "..."
    val ((*closing*)) = prstr "\n)"
  }
//
| D0Cimpdec _ => {
    val () = prstr "D0Cimpdec(...)"
  }
//
| D0Cvaldecs _ => {
    val () = prstr "D0Cvaldecs(...)"
  }
| D0Cfundecs _ => {
    val () = prstr "D0Cfundecs(...)"
  }
| D0Cvardecs _ => {
    val () = prstr "D0Cvardecs(...)"
  }
//
| D0Cinclude
  (
    pfil, knd, name
  ) => {
    val () = prstr "D0Cinclude("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_string (out, name)
    val ((*closing*)) = prstr ")"
  }
//
| D0Cstaload
  (
    pfil, idopt, name
  ) => {
    val () = prstr "D0Cstaload("
    val () = fprint_symbolopt (out, idopt)
    val () = prstr "; "
    val () = fprint_string (out, name)
    val ((*closing*)) = prstr ")"
  }
| D0Cstaloadnm
  (
    pfil, idopt, name
  ) => {
    val () = prstr "D0Cstaloadnm("
    val () = fprint_symbolopt (out, idopt)
    val () = prstr "; "
    val () = fprint_symbol (out, name)
    val ((*closing*)) = prstr ")"
  }
| D0Cstaloadloc
  (
    pfil, idsym, d0cs
  ) => {
    val () = prstr "D0Cstaloadloc("
    val () = fprint_symbol (out, idsym)
    val () = prstr "; "
    val () = fprint_string (out, "(*d0eclist*)")
    val ((*closing*)) = prstr ")"
  }
//
| D0Crequire
    (pfil, name) => {
    val () = prstr "D0Crequire("
    val () = fprint_string (out, name)
    val ((*closing*)) = prstr ")"
  }
//
| D0Cdynload
    (pfil, name) => {
    val () = prstr "D0Cdynload("
    val () = fprint_string (out, name)
    val ((*closing*)) = prstr ")"
  }
//
| D0Clocal
  (
    ds_head, ds_body
  ) => {
    val () = prstr "D0Clocal(\n"
    val () = fprint_d0eclist (out, ds_head)
    val () = prstr "\n(*in*)\n"
    val () = fprint_d0eclist (out, ds_body)
    val ((*closing*)) = prstr "\n)"
  }
//
| D0Cguadecl _ => {
    val ((*void*)) = prstr "D0Cguadecl(...)"
  }
// end of [case]
end // end of [fprint_d0ecl]

(* ****** ****** *)

implement
fprint_d0eclist
  (out, xs) = () where {
  val () = $UT.fprintlst (out, xs, "\n", fprint_d0ecl)
  val () = fprint_newline (out)
} (* end of [fprint_d0eclst] *)

(* ****** ****** *)

(*
implement
fprint_staloadarg
  (out, arg) = let
//
macdef prstr (str) = fprint_string (out, ,(str))
//
in
//
case+ arg of
| STLDfname
    (loc, name) => {
    val () = prstr "STLDfname("
    val () = fprint_string (out, name)
    val () = prstr ")"
  } (* end of [STLDfname] *)
| STLDnspace
    (loc, name) => {
    val () = prstr "STLDnspace("
    val () = fprint_string (out, name)
    val () = prstr ")"
  } (* end of [STLDnspace] *)
(*
| STLDdeclist
    (loc, d0cs) => {
    val ((*void*)) = prstr "STLDdeclist(...)"
  } (* end of [STLDdeclist] *)
*)
//
end // end of [fprint_staloadarg]
*)

(* ****** ****** *)

(* end of [pats_syntax_print.dats] *)

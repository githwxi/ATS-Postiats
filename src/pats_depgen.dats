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
// Start Time: August, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
GLOB = "./pats_global.sats"
staload
FIL = "./pats_filename.sats"

(* ****** ****** *)

staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_depgen.sats"

(* ****** ****** *)

typedef path = string
typedef pathlst = List (path)
viewtypedef pathlst_vt = List_vt (path)

(* ****** ****** *)
//
extern
fun
pathtry_givename
  (given: string): Option_vt (string)
//
(* ****** ****** *)

implement
pathtry_givename(given) = let
//
extern
castfn
p2s{l:agz}(x: !strptr l):<> string
//
(*
val () =
printf
(
"pathtry_givename: given = %s\n", @(given)
) (* printf *)
*)
//
fun
loop
(
ps: List(string), given: string
) : Option_vt(string) = let
(*
val () = printf("pathtry_givename: loop\n")
*)
in
  case+ ps of
  | list_cons 
      (p, ps) => let
      val pname =
        $FIL.filename_append(p, given)
      // end of [val]
(*
      val test = true
*)
      val test = test_file_exists((p2s)pname)
    in
      if test then let
        val pname_norm = $FIL.path_normalize((p2s)pname)
        val () = strptr_free (pname)
      in
        Some_vt (pname_norm)
      end else let
        val () = strptr_free(pname)
      in
        loop (ps, given)
      end // end of [if]
    end // end of [list_cons]
  | list_nil((*void*)) => None_vt()
end // end of [loop]
//
val knd = $FIL.givename_srchknd(given)
//
in
//
case+ knd of
| 0 (*local*) => let
    val fil = $FIL.filename_get_current()
    val pname = $FIL.filename_get_partname(fil)
    val pname2 = $FIL.filename_merge(pname, given)
    val isexi = test_file_exists((p2s)pname2)
  in
    if isexi then let
      val pname2_norm = $FIL.path_normalize((p2s)pname2)
      val () = strptr_free (pname2)
    in
      Some_vt(pname2_norm)
    end else let
      val () = strptr_free(pname2) in None_vt()
    end // end of [if]
  end // end of [0]
| _ (*extern*) => loop($GLOB.the_IATS_dirlst_get(), given)
//
end // end of [pathtry_givename]

(* ****** ****** *)
//
extern
fun
pathtry_staloadarg
  (arg: staloadarg): Option_vt(string)
//
implement
pathtry_staloadarg(arg) =
(
  case+ arg of
  | STLDfname
      (loc, name) => pathtry_givename(name)
    // end of [STLDfname]
  | _ => None_vt (*void*)
) (* end of [pathtry_staloadarg] *)
//
(* ****** ****** *)

typedef
depgen_ftype
  (a: type) = (a, &pathlst_vt) -> void
// end of [depgen_ftype]

(* ****** ****** *)
//
extern
fun depgen_d0exp : depgen_ftype(d0exp)
and depgen_d0explst : depgen_ftype(d0explst)
and depgen_d0expopt : depgen_ftype(d0expopt)
and depgen_labd0explst : depgen_ftype(labd0explst)
//
extern
fun depgen_d0ecl : depgen_ftype(d0ecl)
and depgen_d0eclist : depgen_ftype(d0eclist)
and depgen_guad0ecl_node : depgen_ftype(guad0ecl_node)
//
(* ****** ****** *)

implement
depgen_d0exp
  (d0e0, res) = let
in
//
case+
  d0e0.d0exp_node of
//
| D0Eide _ => ()
| D0Edqid _ => ()
| D0Eopid _ => ()
//
| D0Eidext _ => ()
//
| D0Eint _ => ()
| D0Echar _ => ()
| D0Efloat _ => ()
| D0Estring _ => ()
//
| D0Eempty () => ()
| D0Ecstsp _ => ()
| D0Eextval _ => ()
//
| D0Eloopexn _ => ()
//
| D0Efoldat(d0es) => depgen_d0explst (d0es, res)
| D0Efreeat(d0es) => depgen_d0explst (d0es, res)
//
| D0Etmpid _ => ()
//
| D0Elet(d0cs1, d0e2) => let
    val () = depgen_d0eclist (d0cs1, res) in depgen_d0exp (d0e2, res)
  end // end of [D0Elet]
| D0Edeclseq(d0cs) => depgen_d0eclist (d0cs, res)
| D0Ewhere(d0e1, d0cs2) => let
    val () = depgen_d0eclist (d0cs2, res) in depgen_d0exp (d0e1, res)
  end // end of [D0Ewhere]
//
| D0Eapp(d0e1, d0e2) => let
    val () = depgen_d0exp (d0e1, res)
    val () = depgen_d0exp (d0e2, res)
  in
    // nothing
  end // end of [D0Eapp]
//
| D0Elist(npf, d0es) => depgen_d0explst (d0es, res)
//
| D0Eifhead
  (
    hd, _cond, _then, _else
  ) => let
    val () = depgen_d0exp (_cond, res)
    val () = depgen_d0exp (_then, res)
    val () = depgen_d0expopt (_else, res)
  in
    // nothing
  end // end of [D0Eifhead]
| D0Esifhead
  (
    hd, _cond, _then, _else
  ) => let
    val () = depgen_d0exp (_then, res)
    val () = depgen_d0exp (_else, res)
  in
    // nothing
  end // end of [D0Esifhead]
//
| D0Elst(lin, elt, d0e) => depgen_d0exp (d0e, res)
| D0Etup(knd, npf, d0es) => depgen_d0explst (d0es, res)
| D0Erec(knd, npf, ld0es) => depgen_labd0explst (ld0es, res)
| D0Eseq(d0es) => depgen_d0explst (d0es, res)
//
| _ (* rest-of-d0exp *) => ((*nothing*))
//
end // end of [depgen_d0exp]

(* ****** ****** *)

implement
depgen_d0explst
  (xs, res) =
(
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = depgen_d0exp (x, res) in depgen_d0explst (xs, res)
  end // end of [list_cons]
| list_nil () => ()
//
) // end of [depgen_d0explst]

implement
depgen_d0expopt
  (opt, res) =
(
//
case+ opt of
| Some (d0e) => depgen_d0exp (d0e, res) | None () => ()
//
) // end of [depgen_d0expopt]

(* ****** ****** *)

implement
depgen_labd0explst
  (lxs, res) =
(
//
case+ lxs of
| list_nil() => ()
| list_cons(lx, lxs) => let
    val DL0ABELED(l, x) = lx
    val () = depgen_d0exp(x, res)
  in
    depgen_labd0explst(lxs, res)
  end // end of [list_cons]
//
) // end of [depgen_labd0explst]

(* ****** ****** *)

implement
depgen_d0ecl
  (d0c0, res) = let
(*
val () = println! ("depgen_d0ecl")
*)
in
//
case+
  d0c0.d0ecl_node of
//
| D0Cinclude
    (pfil, _, given) => let
    val opt = pathtry_givename(given)
  in
    case+ opt of
    | ~None_vt() => ()
    | ~Some_vt(pname) =>
        (res := list_vt_cons(pname, res))
      // end of [Some_vt]
  end // end of [DOCinclude]
//
| D0Cstaload
    (pfil, _, given) => let
    val opt = pathtry_givename(given)
  in
    case+ opt of
    | ~None_vt() => ()
    | ~Some_vt(pname) =>
        (res := list_vt_cons(pname, res))
      // end of [Some_vt]
  end // end of [D0Cstaload]
//
| D0Cstaloadloc
    (pfil, nspace, d0cs) => depgen_d0eclist (d0cs, res)
//
| D0Clocal
    (d0cs_head, d0cs_body) =>
  {
    val () = depgen_d0eclist (d0cs_head, res)
    val () = depgen_d0eclist (d0cs_body, res)
  } (* end of [D0Clocal] *)
//
| D0Cguadecl
    (knd, gd0c) => depgen_guad0ecl_node (gd0c.guad0ecl_node, res)
  // end of [D0Cguadecl]
//
| _ (* rest-of-d0ecl *) => ((*void*))
//
end // end of [depgen_d0ecl]

(* ****** ****** *)

implement
depgen_d0eclist
  (xs, res) =
(
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () = depgen_d0ecl(x, res) in depgen_d0eclist(xs, res)
  end // end of [list_cons]
//
) // end of [depgen_d0eclist]

(* ****** ****** *)

implement
depgen_guad0ecl_node
  (x, res) = let
in
//
case+ x of
| GD0Cone(gua, d0cs) =>
    depgen_d0eclist(d0cs, res)
| GD0Ctwo
    (gua, d0cs1, d0cs2) => let
    val () = depgen_d0eclist(d0cs1, res)
    val () = depgen_d0eclist(d0cs2, res)
  in
    // nothing
  end // end of [GD0Ctwo]
| GD0Ccons
    (gua, d0cs1, knd, x2) => let
    val () = depgen_d0eclist(d0cs1, res)
    val () = depgen_guad0ecl_node(x2, res)
  in
    // nothing
  end // end of [GD0Ccons]
//
end // end of [depgen_guad0ecl_node]

(* ****** ****** *)

implement
depgen_eval(d0cs) =
list_vt_reverse(res) where
{
//
var
res: pathlst_vt = list_vt_nil()
//
val () = depgen_d0eclist(d0cs, res)
//
} (* end of [depgen_eval] *)

(* ****** ****** *)

implement
fprint_target
  (out, given) = let
//
val
[n:int] given = string1_of_string(given)
//
val k = string_index_of_char_from_right(given, '.')
//
in
//
case+ 0 of
| _ when k >= 0 => let
    fun fpr
      {i:nat | i <= n} .<n-i>.
    (
      out: FILEref
    , given: string n
    , k: size_t(*un*), i: size_t(i)
    ) : void = let
      val not =
        string_isnot_atend(given, i)
      // end of [val]
    in
      if not then let
        val c =
        (
          if i = k then '_' else given[i]
        ) : char // end of [val]
      in
        fprint_char(out, c); fpr(out, given, k, i+1)
      end // end of [if]
    end (* end of [fpr] *)
    val k = size_of_ssize(k)
  in
    fpr(out, given, k, 0); fprint_string(out, ".o")
  end // end of [_ when ...]
| _ (*~found*) => fprint_string (out, given)
//
end // end of [fprint_target]

(* ****** ****** *)

implement
fprint_entlst
  (out, given, ents) = let
//
fun
loop
(
  out: FILEref, i: int, ents: pathlst_vt
) : void = let
in
//
case+ ents of
| ~list_vt_nil
    ((*void*)) => ()
  // end of [list_vt_nil]
| ~list_vt_cons
    (ent, ents) => let
    val () =
    (
      if i > 0 then fprint_char (out, ' ')
    ) : void
    val () = fprint_string (out, ent)
  in
    loop (out, i + 1, ents)
  end // end of [list_vt_cons]
//
end
//
val () =
  fprint_target(out, given)
val () = fprint_string(out, " : ")
val () = loop(out, 0, ents)
val () = fprint_newline(out)
//
in
  // nothing
end // end of [fprint_entlst]

(* ****** ****** *)

(* end of [pats_depgen.dats] *)

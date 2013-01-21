(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
emit_ats_ccomp_header (out) = let
  val () = emit_text (out, "/*\n")
  val () = emit_text (out, "** include runtime header files\n")
  val () = emit_text (out, "*/\n")
  val () = emit_text (out, "#ifndef _ATS_CCOMP_HEADER_NONE\n")
  val () = emit_text (out, "#include \"pats_ccomp_config.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_basics.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_typedefs.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_instrset.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_exception.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_memalloc.h\"\n")
  val () = emit_text (out, "#endif /* _ATS_CCOMP_HEADER_NONE */\n")
  val () = emit_newline (out)
in
  emit_newline (out)
end // end of [emit_ats_ccomp_header]

(* ****** ****** *)

implement
emit_ats_ccomp_prelude (out) = let
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "** include prelude cats files\n")
val () = emit_text (out, "*/\n")
//
val () = emit_text (out, "#ifndef _ATS_CCOMP_PRELUDE_NONE\n")
//
// HX: primary prelude cats files
//
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include \"prelude/CATS/basics.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/integer.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/pointer.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/bool.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/char.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/string.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/float.cats\"\n")
//
// HX: secondary prelude cats files
//
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include \"prelude/CATS/list.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/option.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/array.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/matrix.cats\"\n")
//
val () = emit_text (out, "//\n")
val () = emit_text (out, "#endif /* _ATS_CCOMP_PRELUDE_NONE */\n")
//
in
  emit_newline (out)
end // end of [emit_ats_ccomp_prelude]

(* ****** ****** *)

extern
fun emit_funlablst_ptype
  (out: FILEref, fls: funlablst): void
implement
emit_funlablst_ptype
  (out, fls) = let
//
fun loop (
  out: FILEref, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val-Some (fent) =
      funlab_get_funent (fl)
    // end of [val]
    val () = emit_funent_ptype (out, fent)
  in
    loop (out, fls, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, fls, 0)
end // end of [emit_funlablst_ptype]

(* ****** ****** *)

extern
fun emit_funlablst_implmnt
  (out: FILEref, fls: funlablst): void
implement
emit_funlablst_implmnt
  (out, fls) = let
//
fun loop (
  out: FILEref, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val tmpknd = funlab_get_tmpknd (fl)
    val-Some (fent) = funlab_get_funent (fl)
    val () =
      if tmpknd > 0 then fprint_string (out, "#if(0)\n")
    // end of [val]
    val ((*void*)) = emit_funent_implmnt (out, fent)
    val () =
      if tmpknd > 0 then fprint_string (out, "#endif // end of [TEMPLATE]\n")
    // end of [val]
  in
    loop (out, fls, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, fls, 0)
end // end of [emit_funlablst_implmnt]

(* ****** ****** *)

implement
emit_the_tmpdeclst
  (out) = let
  val p =
    the_toplevel_getref_tmpvarlst ()
  // end of [val]
  val tmplst = $UN.ptrget<tmpvarlst> (p)
in
  emit_tmpdeclst (out, tmplst)
end // end of [emit_the_tmpdeclst]

(* ****** ****** *)

implement
emit_the_funlablst
  (out) = let
  val fls0 = the_funlablst_get ()
  val () = emit_funlablst_ptype (out, fls0)
  val () = emit_funlablst_implmnt (out, fls0)
in
  // nothing
end // end of [emit_the_funlablst]

(* ****** ****** *)

implement
emit_the_primdeclst
  (out) = let
  val p =
    the_toplevel_getref_primdeclst ()
  // end of [val]
  val pmdlst = $UN.ptrget<primdeclst> (p)
in
  emit_primdeclst (out, pmdlst)
end // end of [emit_the_primdeclst]

(* ****** ****** *)

local

staload _ = "libc/SATS/fcntl.sats"
staload _ = "libc/SATS/stdio.sats"
staload _ = "libc/SATS/stdlib.sats"
staload _ = "libc/SATS/unistd.sats"

staload "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

fun
the_tmpdeclst_stringize (
) =
  tostring_fprint<int> (
  "postiats_tmpdeclst", lam (out, _) => emit_the_tmpdeclst (out), 0
) // end of [the_tmpdeclst_stringize]

fun
the_funlablst_stringize (
) =
  tostring_fprint<int> (
  "postiats_funlablst", lam (out, _) => emit_the_funlablst (out), 0
) // end of [the_funlablst_stringize]

fun
the_primdeclst_stringize (
) =
  tostring_fprint<int> (
  "postiats_primdeclst", lam (out, _) => emit_the_primdeclst (out), 0
) // end of [the_funlablst_stringize]

in (* in of [local] *)

implement
ccomp_main (
  out, flag, infil, hids
) = let
//
val () = emit_time_stamp (out)
val () = emit_ats_ccomp_header (out)
val () = emit_ats_ccomp_prelude (out)
//
val () = let
  val pmds = hideclist_ccomp0 (hids)
  val p_pmds = the_toplevel_getref_primdeclst ()
  val () = $UN.ptrset<primdeclst> (p_pmds, pmds)
  val tmps =
    primdeclst_get_tmpvarset (pmds)
  val tmps =
    tmpvarset_vt_listize_free (tmps)
  val tmps = list_of_list_vt (tmps)
  val p_tmps = the_toplevel_getref_tmpvarlst ()
  val () = $UN.ptrset<tmpvarlst> (p_tmps, tmps)
in
  // nothing
end // end of [val]
//
val the_tmpdeclst_rep = the_tmpdeclst_stringize ()
val the_primdeclst_rep = the_primdeclst_stringize ()
val the_funlablst_rep = the_funlablst_stringize ()
//
val () = emit_the_typedeflst (out)
//
val () =
  fprint_strptr (out, the_tmpdeclst_rep)
val () = strptr_free (the_tmpdeclst_rep)
//
val () =
  fprint_strptr (out, the_funlablst_rep)
val () = strptr_free (the_funlablst_rep)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "** declaration initialization\n")
val () = emit_text (out, "*/\n")
//
val () =
  fprint_strptr (out, the_primdeclst_rep)
val () = strptr_free (the_primdeclst_rep)
//
in
  // nothing
end // end of [ccomp_main]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_main.dats] *)

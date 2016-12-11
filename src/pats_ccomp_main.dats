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
// Start Time: October, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)
//
staload
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename
//
(* ****** ****** *)

staload GLOB = "./pats_global.sats"

(* ****** ****** *)
//
staload
S2E = "./pats_staexp2.sats"
typedef d2con = $S2E.d2con
typedef d2conlst = $S2E.d2conlst
//
staload
D2E = "./pats_dynexp2.sats"
//
typedef d2cst = $D2E.d2cst
typedef d2cstlst = $D2E.d2cstlst
typedef d2cstopt = $D2E.d2cstopt
//
(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
emit_ats_ccomp_header (out) = let
  val () = emit_text (out, "/*\n")
  val () = emit_text (out, "** include runtime header files\n")
  val () = emit_text (out, "*/\n")
//
  val () = emit_text (out, "#ifndef _ATS_CCOMP_HEADER_NONE_\n")
//
  val () = emit_text (out, "#include \"pats_ccomp_config.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_basics.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_typedefs.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_instrset.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_memalloc.h\"\n")
//
  val () = emit_text (out, "#ifndef _ATS_CCOMP_EXCEPTION_NONE_\n")
  val () = emit_text (out, "#include \"pats_ccomp_memalloca.h\"\n")
  val () = emit_text (out, "#include \"pats_ccomp_exception.h\"\n")
  val () = emit_text (out, "#endif // end of [_ATS_CCOMP_EXCEPTION_NONE_]\n")
//
  val () = emit_text (out, "#endif /* _ATS_CCOMP_HEADER_NONE_ */\n")
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
val () = emit_text (out, "#ifndef _ATS_CCOMP_PRELUDE_NONE_\n")
//
// HX: primary prelude cats files
//
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include \"prelude/CATS/basics.cats\"\n")
//
val () = emit_text (out, "#include \"prelude/CATS/integer.cats\"\n")
//
val () = emit_text (out, "#include \"prelude/CATS/pointer.cats\"\n")
//
val () = emit_text (out, "#include \"prelude/CATS/integer_long.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/integer_size.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/integer_short.cats\"\n")
//
val () = emit_text (out, "#include \"prelude/CATS/bool.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/char.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/float.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/integer_ptr.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/integer_fixed.cats\"\n")
//
val () = emit_text (out, "#include \"prelude/CATS/memory.cats\"\n")
//
val () = emit_text (out, "#include \"prelude/CATS/string.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/strptr.cats\"\n")
//
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include \"prelude/CATS/fprintf.cats\"\n")
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include \"prelude/CATS/filebas.cats\"\n")
//
// HX: secondary prelude cats files
//
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include \"prelude/CATS/list.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/option.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/array.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/arrayptr.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/arrayref.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/matrix.cats\"\n")
val () = emit_text (out, "#include \"prelude/CATS/matrixptr.cats\"\n")
//
val () = emit_text (out, "//\n")
val () = emit_text (out, "#endif /* _ATS_CCOMP_PRELUDE_NONE_ */\n")
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "** for user-supplied prelude\n")
val () = emit_text (out, "*/\n")
val () = emit_text (out, "#ifdef _ATS_CCOMP_PRELUDE_USER_\n")
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include _ATS_CCOMP_PRELUDE_USER_\n")
val () = emit_text (out, "//\n")
val () = emit_text (out, "#endif /* _ATS_CCOMP_PRELUDE_USER_ */\n")
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "** for user2-supplied prelude\n")
val () = emit_text (out, "*/\n")
val () = emit_text (out, "#ifdef _ATS_CCOMP_PRELUDE_USER2_\n")
val () = emit_text (out, "//\n")
val () = emit_text (out, "#include _ATS_CCOMP_PRELUDE_USER2_\n")
val () = emit_text (out, "//\n")
val () = emit_text (out, "#endif /* _ATS_CCOMP_PRELUDE_USER2_ */\n")
//
in
  emit_newline (out)
end // end of [emit_ats_ccomp_prelude]

(* ****** ****** *)
//
extern
fun the_dynconlst_get2 (): d2conlst
extern
fun the_dynconlst_set2 (xs: d2conlst): void
//
local

val the_d2conlst = ref<Option(d2conlst)> (None)

in (*in-of-local*)

implement
the_dynconlst_get2
  ((*void*)) = let
//
val opt = !the_d2conlst
//
in
//
case+ opt of
| Some xs => xs
| None () => xs where
  {
    val xs = the_dynconlst_get ()
    val () = !the_d2conlst := Some (xs)
  } (* end of [None] *)
//
end // end of [the_dynconlst_get2]

implement
the_dynconlst_set2 (xs) = !the_d2conlst := Some (xs)

end // end of [local]
//
(* ****** ****** *)
//
extern
fun
emit_funlablst_ptype
  (out: FILEref, fls: funlablst): void
//
implement
emit_funlablst_ptype (out, fls) = let
//
fun loop
(
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
//
(* ****** ****** *)
//
extern
fun
emit_funlablst_closure
  (out: FILEref, fls: funlablst): void
//
implement
emit_funlablst_closure
  (out, fls) = let
//
fun loop
(
  out: FILEref, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val tmpknd = funlab_get_tmpknd (fl)
    val istmp =
    (
      if tmpknd > 0 then true else false
    ) : bool // end of [val]
    val isclo =
    (
      if istmp then false else let
        val fc = funlab_get_funclo (fl) in funclo_is_clo (fc)
      end // end of [let] // end of [if]
    ) : bool // end of [val]
    val-Some(fent) = funlab_get_funent (fl)
    val () =
      if isclo then emit_funent_closure (out, fent)
    // end of [val]
  in
    loop (out, fls, i+1)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [loop]
//
in
  loop (out, fls, 0)
end // end of [emit_funlablst_closure]
//
(* ****** ****** *)
//
extern
fun
emit_funlablst_implmnt
  (out: FILEref, fls: funlablst): void
//
implement
emit_funlablst_implmnt
  (out, fls) = let
//
fun loop
(
  out: FILEref, fls: funlablst, i: int
) : void = let
in
//
case+ fls of
//
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
    val () = emit_newline (out)
  in
    loop (out, fls, i+1)
  end // end of [list_cons]
//
| list_nil ((*void*)) => ()
//
end // end of [loop]
//
in
  loop (out, fls, 0)
end // end of [emit_funlablst_implmnt]
//
(* ****** ****** *)

local

extern
fun tmpvar_set_topknd
(
  x: tmpvar, knd: int
) : void = "ext#patsopt_tmpvar_set_topknd"

fun
auxlst_staticize
  (xs: tmpvarlst): void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = tmpvar_set_topknd (x, 1(*static*))
  in
    auxlst_staticize (xs)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [auxlst]

in (*in-of-local*)

implement
emit_the_tmpdeclst
  (out) = let
//
val p =
  the_toplevel_getref_tmpvarlst ()
val tmplst = $UN.ptrget<tmpvarlst> (p)
val () = auxlst_staticize (tmplst)
//
in
  emit_tmpdeclst (out, tmplst)
end // end of [emit_the_tmpdeclst]

end // end of [local]

(* ****** ****** *)

implement
emit_the_dynconlst_extdec (out) = let
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "dynconlst-declaration(beg)\n")
val () = emit_text (out, "*/\n")
//
val d2cs = the_dynconlst_get2 ()
val () = emit_d2conlst_extdec (out, d2cs)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "dynconlst-declaration(end)\n")
val () = emit_text (out, "*/\n")
//
in
  // nothing
end // end of [emit_the_dynconlst_extdec]

(* ****** ****** *)
//
extern
fun the_dyncstlst_get2 (): d2cstlst
extern
fun the_dyncstlst_set2 (xs: d2cstlst): void
//
local

val the_d2cstlst = ref<Option(d2cstlst)> (None)

in (*in-of-local*)

implement
the_dyncstlst_get2
  ((*void*)) = let
//
val opt = !the_d2cstlst
//
in
//
case+ opt of
| Some (xs) => xs
| None (  ) => let
    val xs = the_dyncstlst_get ()
    val () = !the_d2cstlst := Some (xs)
  in
    xs
  end // end of [None]
//
end // end of [the_dyncstlst_get2]

implement
the_dyncstlst_set2 (xs) = !the_d2cstlst := Some (xs)

end // end of [local]
//
(* ****** ****** *)

implement
emit_the_dyncstlst_extdec (out) = let
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "dyncstlst-declaration(beg)\n")
val () = emit_text (out, "*/\n")
//
val d2cs = the_dyncstlst_get2 ()
val () = emit_d2cstlst_extdec (out, d2cs)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "dyncstlst-declaration(end)\n")
val () = emit_text (out, "*/\n")
//
in
  // nothing
end // end of [emit_the_dyncstlst_extdec]

(* ****** ****** *)
//
extern
fun the_extcodelst_get2 (): hideclist
extern
fun the_extcodelst_set2 (xs: hideclist): void
//
local

val the_extlst = ref<Option(hideclist)> (None)

in (*in-of-local*)

implement
the_extcodelst_get2
  ((*void*)) = let
//
val opt = !the_extlst
//
in
//
case+ opt of
| Some xs => xs
| None () => let
    val xs = the_extcodelst_get()
    val () = !the_extlst := Some(xs)
  in
    xs
  end // end of [None]
//
end // end of [the_extcodelst_get2]

implement
the_extcodelst_set2(xs) = !the_extlst := Some(xs)

end // end of [local]
//
(* ****** ****** *)
//
extern
fun
the_funlablst_get2
  ((*void*)): funlablst
//
local
//
val
the_flablst =
  ref<Option(funlablst)>(None)
//
in (* in of [local] *)

implement
the_funlablst_get2
  ((*void*)) = let
//
val opt = !the_flablst
//
in
//
case+ opt of
| Some xs => xs
| None () => xs where
  {
    val xs = the_funlablst_get()
    val () = !the_flablst := Some(xs)
  } (* end of [None] *)
//
end // end of [the_fublablst_get2]

end // end of [local]
//
(* ****** ****** *)

implement
emit_the_funlablst
  (out) = let
//
val fls0 = the_funlablst_get2()
//
val () = emit_funlablst_ptype(out, fls0)
val () = emit_funlablst_closure(out, fls0)
val () = emit_funlablst_implmnt(out, fls0)
//
in
  // nothing
end // end of [emit_the_funlablst]

(* ****** ****** *)

implement
emit_the_primdeclst
  (out) = let
//
val p0 =
  the_toplevel_getref_primdeclst()
//
val pmdlst = $UN.ptrget<primdeclst>(p0)
//
in
  emit_primdeclst (out, pmdlst)
end // end of [emit_the_primdeclst]

(* ****** ****** *)

local

fun aux
(
  out: FILEref, x: primdec
) : void = let
in
//
case+
x.primdec_node
of // case+
//
| PMDimpdec(imp) => let
    val opt =
      hiimpdec_get_instrlstopt (imp)
    // end of [val]
  in
    case+ opt of
    | None _ => ()
    | Some _ => let
        val d2c = imp.hiimpdec_cst
        val-Some(hse) = d2cst_get2_hisexp (d2c)
        val () = emit_text (out, "ATSdyncst_valimp(")
        val () = emit_d2cst (out, d2c)
        val () = emit_text (out, ", ")
        val () = emit_hisexp (out, hse)
        val () = emit_text (out, ") ;\n")
      in
        // nothing
      end // end of [Some]
  end // end of [PMDimpdec]
//
| PMDlocal
    (xs_head, xs_body) =>
  {
    val ((*void*)) = auxlst (out, xs_head)
    val ((*void*)) = auxlst (out, xs_body)
  } (* end of [PMDlocal] *)
//
| PMDinclude
    (knd, xs_incl) => if knd > 0 then auxlst (out, xs_incl)
  // end of [PMDinclude]
//
| _ (*rest-of-PMD*) => ()
//
end // end of [aux]

and auxlst
(
  out: FILEref, xs: primdeclst
) : void = let
in
//
case+ xs of
| list_nil () => ()
| list_cons(x, xs) => let
    val () = aux (out, x) in auxlst (out, xs)
  end // end of [list_cons]
//
end // end of [auxlst]

in (* in of [local] *)

implement
emit_the_primdeclst_valimp
  (out) = let
//
val p =
  the_toplevel_getref_primdeclst ()
// end of [val]
val pmdlst = $UN.ptrget<primdeclst> (p)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "dynvalist-implementation(beg)\n")
val () = emit_text (out, "*/\n")
//
val () = auxlst (out, pmdlst)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "dynvalist-implementation(end)\n")
val () = emit_text (out, "*/\n")
//
in
  // nothing
end // end of [emit_the_primdeclst_valimp]

end // end of [local]

(* ****** ****** *)

(*
#define MAIN_NONE 0
#define MAIN_VOID 1 // main()
#define MAIN_ARGC_ARGV 2 // main(argc, argv)
#define MAIN_ARGC_ARGV_ENVP 3 // main(argc, argv, envp)
*)

(* ****** ****** *)
//
extern
fun the_mainats_initize (): void
extern
fun the_mainats_d2copt_get (): d2cstopt
//
(* ****** ****** *)

local

val the_mainats_d2copt = ref<d2cstopt> (None)

in (* in of [local] *)

implement
the_mainats_initize
  ((*void*)) = let
//
fun loop (fls: funlablst): void = let
//
in
//
case+ fls of
//
| list_nil () => ()
//
| list_cons
    (fl, fls) => let
    val opt = funlab_get_d2copt (fl)
    val () = (
      case+ opt of
      | Some (d2c) =>
          if $D2E.d2cst_is_mainats (d2c) then !the_mainats_d2copt := opt
      | None () => ()
    ) : void // end of [val]
  in
    loop (fls)        
  end // end of [list_cons]
//
end // end of [loop]
//
in
  loop (the_funlablst_get2 ())
end // end of [the_mainats_initize]

implement
the_mainats_d2copt_get () = !the_mainats_d2copt

end // end of [local]

(* ****** ****** *)

extern
fun
the_dynloadflag_get (): int

implement
the_dynloadflag_get () = let
//
val
the_mainatsflag =
  $GLOB.the_MAINATSFLAG_get ()
//
in
//
if
the_mainatsflag = 0
then let
  val opt = the_mainats_d2copt_get ()
in
//
case+ opt of
| Some _ => (~1)
| None () => $GLOB.the_DYNLOADFLAG_get ()
//
end // end of [then]
else (~1) // HX: mainatsflag overrules dynloadflag
//
end // end of [the_dynloadflag_get]

(* ****** ****** *)

extern
fun
emit_main_arglst_err
  (out: FILEref, arty: int): void
implement
emit_main_arglst_err
  (out, arty) = let
//
val () =
  if arty >= 1 then emit_text (out, "argc")
val () =
  if arty >= 2 then emit_text (out, ", argv")
val () =
  if arty >= 3 then emit_text (out, ", envp")
val () = (
  if arty <= 0
    then emit_text (out, "err") else emit_text (out, ", err")
  // end of [if]
) : void // end of [val]
//
in
  // nothing
end // end of [emit_main_arglst_err]

(* ****** ****** *)

extern
fun
emit_dynload
  (out: FILEref, infil: filename): void
implement
emit_dynload
  (out, infil) =
{
  val () = emit_filename (out, infil)
  val () = emit_text (out, "__dynload")
}

extern
fun
emit_dynloadflag
  (out: FILEref, infil: filename): void
implement
emit_dynloadflag
  (out, infil) =
{
  val () = emit_filename (out, infil)
  val () = emit_text (out, "__dynloadflag")
}

(* ****** ****** *)

local

staload _ = "libc/SATS/fcntl.sats"
staload _ = "libc/SATS/stdio.sats"
staload _ = "libc/SATS/stdlib.sats"
staload _ = "libc/SATS/unistd.sats"

staload "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

fun
the_tmpdeclst_stringize
(
) = tostring_fprint<int>
(
  "postiats_tmpdeclst_"
, lam (out, _) => emit_the_tmpdeclst (out), 0
) // end of [the_tmpdeclst_stringize]

fun
the_primdeclst_stringize
(
) = tostring_fprint<int>
(
  "postiats_primdeclst_"
, lam (out, _) => emit_the_primdeclst (out), 0
) // end of [the_funlablst_stringize]

fun
the_funlablst_stringize
(
) = tostring_fprint<int>
(
  "postiats_funlablst_", lam (out, _) => emit_the_funlablst (out), 0
) // end of [the_funlablst_stringize]

fun
aux_staload
  (out: FILEref): void = let
//
fun loop
(
  out: FILEref, xs: hideclist
) : void = let
in
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => let
    val () =
      emit_staload (out, x) in loop(out, xs)
    // end of [val]
  end // end of [list_cons]
//
end // end of [loop]
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "staload-prologues(beg)\n")
val () = emit_text (out, "*/\n")
//
val () = loop (out, the_staloadlst_get())
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "staload-prologues(end)\n")
val () = emit_text (out, "*/\n")
//
in
  // nothing
end // end of [aux_staload]

fun
aux_dynload_ext
  (out: FILEref): void = let
//
fun loop
(
  out: FILEref, xs: hideclist
) : void = let
in
//
case+ xs of
//
| list_nil () => ()
//
| list_cons
    (x, xs) => let
    val-HIDdynload (fil) = x.hidecl_node
    val () = (
      emit_text (out, "ATSdynloadflag_init(");
      emit_filename (out, fil); emit_text (out, "__dynloadflag) ;\n")
    ) (* end of [val] *)
    val () =
      emit_text (out, "ATSextern()\n")
    val () =
      emit_text (out, "atsvoid_t0ype\n")
    val () = (
      emit_filename (out, fil);
      emit_text (out, "__dynload(/*void*/) ;\n")
    ) (* end of [val] *)
  in
    loop (out, xs)
  end (* end of [list_cons] *)
//
end // end of [loop]
//
in
  loop (out, the_dynloadlst_get ())
end // end of [aux_dynload_ext]

fun
aux_dynload_ias
(
  out: FILEref, infil: filename
) : void = let
//
val opt = $GLOB.the_DYNLOADNAME_get ()
//
in
//
if
stropt_is_some (opt)
then let
//
val name = stropt_unsome (opt)
//
val () = emit_text (out, "ATSextern()\n")
val () = emit_text (out, "atsvoid_t0ype\n")
//
val () =
(
  emit_text (out, name); emit_text (out, "()\n{\n")
)
//
val () = emit_text (out, "ATSfunbody_beg()\n")
//
val () =
  emit_text (out, "ATSINSmove_void(tmpret_void, ")
val () =
(
  emit_dynload (out, infil); emit_text (out, "()) ;\n")
)
//
val () = emit_text (out, "ATSfunbody_end()\n")
//
val () = emit_text (out, "ATSreturn_void(tmpret_void) ;\n")
//
val () = emit_text (out, "} // end-of-dynload-alias\n")
//
in
  // nothing
end // end of [then]
else () // end of [else]
//
end // end of [aux_dynload_ias]

fun
aux_dynload_def
(
  out: FILEref
, infil: filename, fbody: string
) : void = let
//
val flag = the_dynloadflag_get ()
//
val () =
if flag = 0
  then emit_text (out, "#if(0)\n")
//
val () = emit_text (out, "/*\n")
val () =
(
  emit_text (out, "** for initialization(dynloading)")
) (* end of [val] *)
//
val () = emit_text (out, "\n*/\n")
//
val () =
if
flag <= 0
then (
  emit_text (out, "ATSdynloadflag_minit(");
  emit_dynloadflag (out, infil); emit_text (out, ") ;\n")
) (* end of [if] *)
//
val () = emit_text (out, "ATSextern()\n")
val () = emit_text (out, "atsvoid_t0ype\n")
//
val () = emit_dynload (out, infil)
val () = emit_text (out, "()\n{\n")
//
val () = emit_text (out, "ATSfunbody_beg()\n")
//
val () = emit_text (out, "ATSdynload(/*void*/)\n")
//
val () =
if flag <= 0
  then emit_text (out, "ATSdynloadflag_sta(\n")
val () =
if flag >= 1
  then emit_text (out, "ATSdynloadflag_ext(\n")
//
val () = emit_dynloadflag (out, infil)
val () = emit_text (out, "\n) ;\n")
val () = emit_text (out, "ATSif(\n")
val () = emit_text (out, "ATSCKiseqz(\n")
val () = emit_dynloadflag (out, infil)
val () = emit_text (out, "\n)\n) ATSthen() {\n")
val () = emit_text (out, "ATSdynloadset(")
val () = emit_dynloadflag (out, infil)
val ((*closing*)) = emit_text (out, ") ;\n")
//
val () = let
  val d2cs = the_dynconlst_get2 ()
  val () = emit_text (out, "/*\n")
  val () = emit_text (out, "dynexnlst-initize(beg)\n")
  val () = emit_text (out, "*/\n")
  val () = emit_d2conlst_initize (out, d2cs)
  val () = emit_text (out, "/*\n")
  val () = emit_text (out, "dynexnlst-initize(end)\n")
  val () = emit_text (out, "*/\n")
in
  // nothing
end // end of [val]
//
val () = emit_text (out, fbody)
val () = emit_text (out, "} /* ATSendif */\n")
//
val () = emit_text (out, "ATSfunbody_end()\n")
//
val () = emit_text (out, "ATSreturn_void(tmpret_void) ;\n")
val () = emit_text (out, "} /* end of [*_dynload] */\n")
//
val () = aux_dynload_ias (out, infil) // HX: creating an alias
//
val () =
if flag = 0 then emit_text (out, "#endif // end of [#if(0)]\n")
//
in
  // nothing
end // end of [aux_dynload_def]

fun
aux_main
(
  out: FILEref
, infil: filename, d2cmain: d2cst
) : void = let
//
val () = emit_text (out, "\n/*\n")
val () = emit_text (out, "** the ATS runtime")
val () = emit_text (out, "\n*/\n")
val () = emit_text (out, "#ifndef _ATS_CCOMP_RUNTIME_NONE_\n")
val () = emit_text (out, "#include \"pats_ccomp_runtime.c\"\n")
val () = emit_text (out, "#include \"pats_ccomp_runtime_memalloc.c\"\n")
val () = emit_text (out, "#ifndef _ATS_CCOMP_EXCEPTION_NONE_\n")
val () = emit_text (out, "#include \"pats_ccomp_runtime2_dats.c\"\n")
val () = emit_text (out, "#ifndef _ATS_CCOMP_RUNTIME_TRYWITH_NONE_\n")
val () = emit_text (out, "#include \"pats_ccomp_runtime_trywith.c\"\n")
val () = emit_text (out, "#endif /* _ATS_CCOMP_RUNTIME_TRYWITH_NONE_ */\n")
val () = emit_text (out, "#endif // end of [_ATS_CCOMP_EXCEPTION_NONE_]\n")
val () = emit_text (out, "#endif /* _ATS_CCOMP_RUNTIME_NONE_ */\n")
//
val () = emit_text (out, "\n/*\n")
val () = emit_text (out, "** the [main] implementation")
val () = emit_text (out, "\n*/\n")
//
val () = emit_text (out, "int\n")
val () = emit_text (out, "main\n")
val () = emit_text (out, "(\n")
val () = emit_text (out, "int argc, char **argv, char **envp")
val () = emit_text (out, "\n) {\n")
val () = emit_text (out, "int err = 0 ;\n")
val () = {
  val () = emit_filename (out, infil)
  val () = emit_text (out, "__dynload() ;\n")
} (* end of [val] *)
//
val arty = let
  val ns = $D2E.d2cst_get_artylst (d2cmain)
in
  case+ ns of
  | list_cons (n, _) => n | list_nil () => 0
end : int // end of [val]
//
val () = emit_text (out, "ATS")
val () = emit_d2cst (out, d2cmain)
val () = emit_LPAREN (out)
val () = emit_main_arglst_err (out, arty)
val () = emit_RPAREN (out)
val () = emit_text (out, " ;\n")
//
val () = emit_text (out, "return (err) ;\n")
val () = emit_text (out, "} /* end of [main] */")
val () = emit_newline (out)
//
in
  // nothing
end // end of [aux_main]

fun
aux_main_ifopt
(
  out: FILEref, infil: filename
) : void = let
//
val opt = the_mainats_d2copt_get()
//
in
//
case+ opt of
| None() => ()
| Some(d2c) => aux_main (out, infil, d2c)
//
end // end of [aux_main_ifopt]

#define DYNBEG 1
#define DYNMID 10
#define DYNEND 99

fun
aux_extcodelst_if
(
  out: FILEref, test: (int) -> bool
) : void = let
//
fun
loop
(
  out: FILEref, test: (int) -> bool, xs: hideclist
) : hideclist = let
in
//
case+ xs of
| list_nil() => list_nil()
| list_cons(x, xs1) => let
    val-HIDextcode (knd, pos, _) = x.hidecl_node
  in
    if test(pos) then let
      val () = emit_extcode (out, x) in loop (out, test, xs1)
    end else xs // end of [if]
  end // end of [if]
//
end // end of [loop]
//
val xs = the_extcodelst_get2()
//
val xs2 = loop (out, test, xs)
val ((*set*)) = the_extcodelst_set2(xs2)
//
in
  // nothing
end // end of [aux_extcodelst_if]

fun
aux_exndeclst
  (out: FILEref): void = let
//
fun
loop
(
  out: FILEref, xs: hideclist
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = emit_exndec(out, x) in loop(out, xs)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
val () =
(
emit_text (out, "/*\n");
emit_text (out, "exnconlst-declaration(beg)\n");
emit_text (out, "*/\n");
) (* end of [val] *)
//
val () =
emit_text
(
  out
, "#ifndef _ATS_CCOMP_EXCEPTION_NONE_\n"
)
val () =
emit_text
(
  out
, "\
ATSextern()\n\
atsvoid_t0ype\n\
the_atsexncon_initize\n\
(\n\
  atstype_exnconptr d2c, atstype_string exnmsg\n\
) ;\n\
") // end of [val]
val () =
emit_text (out, "#endif // end of [_ATS_CCOMP_EXCEPTION_NONE_]\n")
//
val hids = the_exndeclst_get ()
val ((*void*)) = loop (out, hids)
//
val () = (
emit_text (out, "/*\n");
emit_text (out, "exnconlst-declaration(end)\n");
emit_text (out, "*/\n");
) (* end of [val] *)
//
in
  (* nothing *)
end // end of [aux_exndeclst]

(* ****** ****** *)

fun
aux_saspdeclst
  (out: FILEref): void = let
//
fun loop (
  out: FILEref, xs: hideclist
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = emit_saspdec (out, x) in loop (out, xs)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "assumelst-declaration(beg)\n")
val () = emit_text (out, "*/\n")
//
val hids = the_saspdeclst_get ()
val ((*void*)) = loop (out, hids)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "assumelst-declaration(end)\n")
val () = emit_text (out, "*/\n")
//
in
  (* nothing *)
end // end of [aux_saspdeclst]

(* ****** ****** *)

fun
aux_extypelst
  (out: FILEref): void = let
//
fun loop
(
  out: FILEref, xs: hideclist
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = emit_extype (out, x) in loop (out, xs)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [loop]
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "extypelst-declaration(beg)\n")
val () = emit_text (out, "*/\n")
//
val hids = the_extypelst_get ()
val ((*void*)) = loop (out, hids)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "extypelst-declaration(end)\n")
val () = emit_text (out, "*/\n")
//
in
  (* nothing *)
end // end of [aux_extypelst]

in (* in of [local] *)

implement
ccomp_main
(
  out, flag, infil, hids
) = let
//
(*
val () =
  print ("ccomp_main: infil = ")
val () =
  $FIL.print_filename_full (infil)
val () = print_newline ((*void*))
*)
//
val () = emit_time_stamp (out)
//
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
#if(0)
val () = emit_the_tmpdeclst (out)
val () = emit_the_primdeclst (out)
val () = emit_the_funlablst (out)
#endif // end of [#if(0)]
//
val the_tmpdeclst_rep = the_tmpdeclst_stringize ()
val the_primdeclst_rep = the_primdeclst_stringize ()
val the_funlablst_rep = the_funlablst_stringize ()
//
val () = aux_staload (out)
//
val (
) = aux_extcodelst_if (out, lam (pos) => pos = DYNBEG)
//
val () = emit_the_typedeflst (out)
//
val () = emit_the_dynconlst_extdec (out)
val () = emit_the_dyncstlst_extdec (out)
//
val () = emit_the_primdeclst_valimp (out)
//
val () = aux_exndeclst (out)
//
val () = aux_saspdeclst (out)
//
val () = aux_extypelst (out)
//
val (
) = aux_extcodelst_if (out, lam (pos) => pos < DYNMID)
//
val () =
  fprint_strptr (out, the_tmpdeclst_rep)
val () = strptr_free (the_tmpdeclst_rep)
//
val (
) = aux_extcodelst_if (out, lam (pos) => pos <= DYNMID)
//
val () =
  fprint_strptr (out, the_funlablst_rep)
val () = strptr_free (the_funlablst_rep)
//
val ( // HX: the call must be made before
) = the_mainats_initize () // aux_dynload is called
//
val () =
aux_dynload_ext (out)
val () =
aux_dynload_def
  (out, infil, fbody) where
{
  val fbody = $UN.castvwtp1{string}(the_primdeclst_rep)
} // end of [where] // end of [val]
val () = strptr_free (the_primdeclst_rep)
//
val () =
aux_main_ifopt (out, infil)
//
val () =
aux_extcodelst_if (out, lam (pos) => pos <= DYNEND)
//
val () =
emit_text (out, "\n/* ****** ****** */\n")
val () =
emit_text (out, "\n/* end-of-compilation-unit */\n")
//
(*
val ((*debugging*)) = println! ("ccomp_main: leave")
*)
//
in
  // nothing
end // end of [ccomp_main]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_main.dats] *)

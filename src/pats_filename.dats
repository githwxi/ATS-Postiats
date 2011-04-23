(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload
LOC = "pats_location.sats"
staload SYM = "pats_symbol.sats"
typedef symbol= $SYM.symbol
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "pats_filename.sats"

(* ****** ****** *)

local

#include
"prelude/params_system.hats"
#if SYSTEM_IS_UNIX_LIKE #then
//
val theDirSep: char = '/'
val theCurDir: string = "./"
val theParDir: string = "../"
//
#endif

in // in of [local]

implement theDirSep_get () = theDirSep
implement theCurDir_get () = theCurDir
implement theParDir_get () = theParDir

end // end of [local]

(* ****** ****** *)

assume
filename_type = '{
  filename_name= string, filename_full= symbol
} // end of [filename]

(* ****** ****** *)

implement
fprint_filename (out, fil) =
  fprint_string (out, fil.filename_name)
// end of [fprint_filename]

implement
print_filename (fil) = fprint_filename (stdout_ref, fil)
implement
prerr_filename (fil) = fprint_filename (stderr_ref, fil)

(* ****** ****** *)

implement
fprint_filename_full
  (out, fil) = let
  val name = $SYM.symbol_get_name (fil.filename_full)
in
  fprint_string (out, name)
end // end of [fprint_filename_full]

implement
print_filename_full (fil) = fprint_filename_full (stdout_ref, fil)

(* ****** ****** *)

implement filename_get_base (fil) = fil.filename_name
implement filename_get_full (fil) = fil.filename_full

(* ****** ****** *)

implement
eq_filename_filename
  (x1, x2) = x1.filename_full = x2.filename_full
// end of [eq_filename_filename]

implement
compare_filename_filename
  (x1, x2) = let
  val f1 = $SYM.symbol_get_name (x1.filename_full)
  val f2 = $SYM.symbol_get_name (x2.filename_full)
in
  compare_string_string (f1, f2)
end // end of [compare_filename_filename]

(* ****** ****** *)

implement
filename_is_relative
  (name) = let
  val name = string1_of_string (name)
  fn aux {n,i:nat | i <= n} (
    name: string n, i: size_t i, dirsep: char
  ) : bool =
    if string_isnot_at_end (name, i) then (name[i] != dirsep) else false 
  // end of [aux]
  val dirsep = theDirSep_get ()
in
  aux (name, 0, dirsep)
end // [filename_is_relative]

(* ****** ****** *)

implement
filename_none = '{
  filename_name= "", filename_full= $SYM.symbol_empty
} // end of [filename_none]

(* ****** ****** *)

fun path_normalize
  (s0: path): path = let
  fun loop1
    {n0,i0:nat | i0 <= n0} (
    dirsep: char
  , s0: string n0, n0: size_t n0, i0: size_t i0
  , dirs: &List_vt strptr1
  ) : void =
    if i0 < n0 then loop2 (dirsep, s0, n0, i0, i0, dirs) else ()
  and loop2
    {n0,i0,i:nat | i0 < n0; i0 <= i; i <= n0} (
    dirsep: char
  , s0: string n0, n0: size_t n0, i0: size_t i0, i: size_t i
  , dirs: &List_vt strptr1
  ) : void =
    if i < n0 then let
(*
      // empty
*)
    in
      if s0[i] <> dirsep then
        loop2 (dirsep, s0, n0, i0, i+1, dirs)
      else let
        val sbp = string_make_substring (s0, i0, i - i0 + 1)
        val dir = strptr_of_strbuf (sbp) // this is a no-op cast
(*
        val () = begin
          print "path_normalize: loop2: dir = "; print dir; print_newline ()
        end // end of [val]
*)
      in
        dirs := list_vt_cons (dir, dirs); loop1 (dirsep, s0, n0, i + 1, dirs)
      end // end of [if]
    end else let
      val sbp = string_make_substring (s0, i0, i - i0)
      val dir = strptr_of_strbuf (sbp) // this is a no-op cast
(*
      val () = begin
        print "path_normalize: loop2: dir = "; print dir; print_newline ()
      end // end of [val]
*)
    in
      dirs := list_vt_cons (dir, dirs)
    end // end of [if]
  // end of [loop1] and [loop2]
//
  viewtypedef strptrlst = List_vt (strptr1)
  extern castfn p2s {l:agz} (x: !strptr l):<> string
//
  fun dirs_process {n:nat} (
    curdir: string, pardir: string
  , npar: int n, dirs: strptrlst, res: strptrlst
  ) : strptrlst = case+ dirs of
    | ~list_vt_cons (dir, dirs) => (
        if (p2s)dir = curdir then let
          val () = strptr_free (dir) in
          dirs_process (curdir, pardir, npar, dirs, res)
        end else if (p2s)dir = pardir then let
          val () = strptr_free (dir) in
          dirs_process (curdir, pardir, npar + 1, dirs, res)
        end else (
          if npar > 0 then let
            val () = strptr_free (dir)
          in
            dirs_process (curdir, pardir, npar - 1, dirs, res)
          end else begin
            dirs_process (curdir, pardir, 0, dirs, list_vt_cons (dir, res))
          end (* end of [if] *)
        ) // end of [if]
      ) // end of [list_vt_cons]
    | ~list_vt_nil () =>
        loop (pardir, npar, res) where {
        fun loop {i,j:nat} (
          pardir: string, npar: int i, res: list_vt (strptr1, j)
        ) : list_vt (strptr1, i+j) =
          if npar > 0 then let
            val dir = string1_of_string (pardir)
            val n = string1_length (dir)
            val dir = string_make_substring (dir, 0, n)
            val dir = strptr_of_strbuf (dir)
          in
            loop (pardir, npar - 1, list_vt_cons (dir, res))
          end else res
          (* end of [if] *)
        // end of [loop]
      } // end of [list_vt_nil]
//
  val dirsep = theDirSep_get ()
  val curdir = theCurDir_get () and pardir = theParDir_get ()
//
  var dirs: strptrlst = list_vt_nil ()
  val s0 = string1_of_string s0; val n0 = string_length s0
  val () = loop1 (dirsep, s0, n0, 0, dirs)
  val () = dirs := dirs_process (curdir, pardir, 0, dirs, list_vt_nil ())
  val fullname =
    stringlst_concat (__cast dirs) where {
    extern castfn __cast (x: !strptrlst): List string
  } // end of [val]
  val () = list_vt_free_fun<strptr1> (dirs, lam x => strptr_free (x))
//
in
  string_of_strptr (fullname)
end // end of [path_normalize]

(* ****** ****** *)

local

assume the_filenamelst_push_v = unit_v
viewtypedef filenamelst = List_vt filename

val the_filename = ref_make_elt<filename> (filename_none)
val the_filenamelst = ref_make_elt<filenamelst> (list_vt_nil ())

fun filename_occurs
  (f0: filename): bool = let
  fun loop {n:nat} .<n>. (
    fs: !list_vt (filename, n), f0: filename
  ) :<> bool = case+ fs of
    | list_vt_cons (f, !p_fs) =>
        if eq_filename_filename (f0, f) then
          (fold@ fs; true)
        else let
          val ans = loop (!p_fs, f0); prval () = fold@ (fs)
        in
          ans
        end (* end of [if] *)
    | list_vt_nil () => (fold@ fs; false)
  // end of [loop]
  val (vbox pf | p) = ref_get_view_ptr (the_filenamelst)
in
  loop (!p, f0)
end // end of [filename_occurs]

in // in of [local]

implement filename_get_current () = !the_filename

implement
the_filenamelst_pop
  (pf | (*none*)) = let
  prval unit_v () = pf
  val x = x where {
    val (vbox pf | p) = ref_get_view_ptr (the_filenamelst)
    val- ~list_vt_cons (x, xs) = !p
    val () = !p := xs
  } // end of [val]
  val () = !the_filename := x
in
  // nothing
end // end of [the_filenamelst_pop]

implement
the_filenamelst_push (f0) = let
  val x = !the_filename
  val () = !the_filename := f0
  val (vbox pf | p) = ref_get_view_ptr (the_filenamelst)
  val () = !p := list_vt_cons (x, !p)
in
  (unit_v () | ())
end // end of [the_filenamelst_push]

implement
the_filenamelst_push_check
  (f0) = let
(*
  val () = print ("the_filenamelst_push_check: the_filenamelst(bef) =\n")
  val () = fprint_the_filenamelst (stdout_ref)
*)
  val (pf | ()) = the_filenamelst_push (f0)
(*
  val () = print ("the_filenamelst_push_check: the_filenamelst(aft) =\n")
  val () = fprint_the_filenamelst (stdout_ref)
*)
  val isexi = filename_occurs (f0) // HX: is [f0] already in the list?
in
  (pf | isexi)
end // end of [the_filenamelst_push_check]

implement
fprint_the_filenamelst
  (out) = let
  fun loop (
    out: FILEref, fs: !filenamelst
  ) : void =
    case+ fs of
    | list_vt_cons (f, !p_fs) => let
        val () = fprint_filename_full (out, f)
        val () = fprint_newline (out)
        val () = loop (out, !p_fs)
      in
        fold@ (fs)
      end // end of [list_vt_cons]
    | list_vt_nil () => fold@ (fs)
  // end of[ loop]
  val (vbox pf | p) = ref_get_view_ptr (the_filenamelst)
in
  $effmask_ref (loop (out, !p))
end // end of [fprint_the_filenamelst]

end // end of [local]

(* ****** ****** *)

viewtypedef pathlst = List_vt (path)

local

assume the_pathlst_push_v = unit_v
val the_pathlst = ref_make_elt<pathlst> (list_vt_nil)
val the_prepathlst = ref_make_elt<pathlst> (list_vt_nil)

in // in of [local]

fun the_pathlst_get
  (): pathlst = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val xs = !p
  val () = !p := list_vt_nil ()
} // end of [the_pathlst_get]

fun the_pathlst_set
  (xs: pathlst): void = {
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val- ~list_vt_nil () = !p
  val () = !p := xs
} // end of [the_pathlst_get]

implement
the_pathlst_pop
  (pf | (*none*)) = {
  prval unit_v () = pf
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
  val- ~list_vt_cons (_, xs) = !p
  val () = !p := xs
} // end of [the_prepathlst_push]

implement
the_pathlst_push (x) = let
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
  val () = !p := list_vt_cons (x, !p)
in
  (unit_v () | ())
end // end of [the_prepathlst_push]

(* ****** ****** *)

fun the_prepathlst_get
  (): pathlst = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
  val xs = !p
  val () = !p := list_vt_nil ()
} // end of [the_prepathlst_get]

fun the_prepathlst_set
  (xs: pathlst): void = {
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
  val- ~list_vt_nil () = !p
  val () = !p := xs
} // end of [the_prepathlst_get]

implement
the_prepathlst_push (x) = let
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
in
  !p := list_vt_cons (x, !p)
end // end of [the_prepathlst_push]

end // end of [local]

(* ****** ****** *)

local

staload UNISTD = "libc/SATS/unistd.sats"

in // in of [local]

implement
filename_make (
  basename, fullname
) = let
  val fullname_sym = $SYM.symbol_make_string (fullname)
in '{
  filename_name= basename, filename_full= fullname_sym
} end // end of [filename_make]

implement
filenameopt_make_relative
  (basename) = let
//
  extern castfn p2s {l:agz} (x: !strptr l):<> string
//
  fun aux_try {n:nat} .<n>. (
    paths: list (path, n), basename: string
  ) : Stropt =
    case+ paths of
    | list_cons (path, paths) => let
        val fullname =
          filename_append (path, basename)
        val isexi = test_file_exists ((p2s)fullname)
(*
        val () = begin
          printf ("filenameopt_make_relative: aux_try: fullname = %s\n", @(fullname))
        end // end of [val]
*)
      in
        if isexi then let
          val fullname = string1_of_strptr (fullname)
        in
          stropt_some (fullname)
        end else let
          val () = strptr_free (fullname) in aux_try (paths, basename)
        end // end of [if]
      end // end of [list_cons]
    | list_nil () => stropt_none
  (* end of [aux_try] *)
//
  fn aux_try_pathlst
    (basename: string): Stropt = ans where {
    val paths = the_pathlst_get ()
    val ans = aux_try ($UN.castvwtp1 {List(path)} (paths), basename)
    val () = the_pathlst_set (paths)
  } // end of [aux_try_pathlst]
  fn aux_try_prepathlst
    (basename: string): Stropt = ans where {
    val paths = the_prepathlst_get ()
    val ans = aux_try ($UN.castvwtp1 {List(path)} (paths), basename)
    val () = the_prepathlst_set (paths)
  } // end of [aux_try_prepathlst]
//
  fun aux_relative
    (basename: string): Stropt = let
    val fullnameopt = aux_try_prepathlst (basename)
  in
    case+ 0 of
    | _ when
        stropt_is_some fullnameopt => fullnameopt
    | _ when test_file_exists (basename) => let
        val cwd = $UNISTD.getcwd0 ()
        val fullname = filename_append ((p2s)cwd, basename)
        val () = strptr_free (cwd)
        val fullname = string1_of_strptr (fullname)
      in
        stropt_some (fullname)
      end
    | _ => aux_try_pathlst (basename)
  end // end of [aux_relative]
//
  val fullnameopt = (case+ 0 of
    | _ when filename_is_relative basename => aux_relative (basename)
    | _ => (
        if test_file_exists (basename) then let
          val basename = string1_of_string (basename) in stropt_some basename
        end else stropt_none
      ) // end of [_]
  ) : Stropt // end of [val]
//
in
  if stropt_is_some fullnameopt then let
    val fullname = stropt_unsome fullnameopt
    val fullname = path_normalize fullname
  in
    Some_vt (filename_make (basename, fullname))
  end else begin
    None_vt ()
  end // end of [if]
end // end of [filenameopt_make]

end // end of [local]

(* ****** ****** *)

%{$

ats_ptr_type
atsopt_filename_append (
  ats_ptr_type dir, ats_ptr_type bas
) {
  int n1, n2, n ;
  char dirsep, *dirbas ;
//
  dirsep = atsopt_filename_theDirSep_get () ;
//
  n1 = strlen ((char*)dir) ;
  n2 = strlen ((char*)bas) ;
  n = n1 + n2 ;
  if (n1 > 0 && ((char*)dir)[n1-1] != dirsep) n += 1 ;
  dirbas = ATS_MALLOC (n + 1) ;
  memcpy (dirbas, dir, n1) ;
  if (n > n1 + n2) { dirbas[n1] = dirsep ; n1 += 1 ; }
  memcpy (dirbas + n1, bas, n2) ;
  dirbas[n] = '\000' ;
//
  return dirbas ;
} /* end of [atsopt_filename_append] */

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_filename.dats] *)

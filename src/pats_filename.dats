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

local

staload
STR = "libc/SATS/string.sats"
macdef strncmp = $STR.strncmp

in // in of [local]

implement
path_get_srchknd
  (path) = let
  val dir = theCurDir_get ()
  val len = string_length (dir)
in
  if strncmp (path, dir, len) = 0 then 0(*loc*) else 1(*ext*)
end // end of [path_get_srchknd]

end // end of [local]

(* ****** ****** *)

assume
filename_type = '{
  filename_part= string
, filename_full= symbol
} // end of [filename]

(* ****** ****** *)

(*
implement
fprint_filename (out, fil) =
  fprint_string (out, fil.filename_part)
// end of [fprint_filename]
*)
implement
fprint_filename (out, fil) =
  $SYM.fprint_symbol (out, fil.filename_full)
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

implement filename_get_part (fil) = fil.filename_part
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
    if string_isnot_atend (name, i) then (name[i] != dirsep) else false 
  // end of [aux]
  val dirsep = theDirSep_get ()
in
  aux (name, 0, dirsep)
end // [filename_is_relative]

(* ****** ****** *)

implement
filename_dummy = '{
  filename_part= "", filename_full= $SYM.symbol_empty
} // end of [filename_dummy]

implement
filename_stdin = '{
  filename_part= "<STDIN>", filename_full= $SYM.symbol_empty
} // end of [filename_stdin]

(* ****** ****** *)

local

staload UNISTD = "libc/SATS/unistd.sats"

in // in of [local]

implement
path_normalize (s0) = let
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
  val path =
    stringlst_concat (__cast dirs) where {
    extern castfn __cast (x: !strptrlst): List string
  } // end of [val]
  val () = list_vt_free_fun<strptr1> (dirs, lam x => strptr_free (x))
//
in
  string_of_strptr (path)
end // end of [path_normalize]

fun partname_fullize
  (pname: string): string = let
  extern castfn p2s {l:agz} (x: !strptr l):<> string
  val isrel = filename_is_relative (pname)
in
  if isrel then let
    val cwd = $UNISTD.getcwd0 ()
    val fname =
      filename_append ((p2s)cwd, pname)
    // end of [val]
    val () = strptr_free (cwd)
    val fname_norm = path_normalize ((p2s)fname)
    val () = strptr_free (fname)
  in
    fname_norm
  end else pname // HX: it is absolute
end // end of [partname_fullize]

end // end of [local]

(* ****** ****** *)

local

assume the_filenamelst_push_v = unit_v
viewtypedef filenamelst = List_vt filename

val the_filename = ref_make_elt<filename> (filename_dummy)
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
  val () = the_filenamelst_ppush (f0) in (unit_v () | ())
end // end of [the_filenamelst_push]

implement
the_filenamelst_ppush (f0) = let
  val x = !the_filename
  val () = !the_filename := f0
  val (vbox pf | p) = ref_get_view_ptr (the_filenamelst)
  val () = !p := list_vt_cons (x, !p)
in
  // nothing
end // end of [the_filenamelst_ppush]

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

typedef pathlst = List (path)
viewtypedef pathlst_vt = List_vt (path)

local
//
assume the_pathlst_push_v = unit_v
//
val the_pathlst = ref_make_elt<pathlst_vt> (list_vt_nil)
val the_prepathlst = ref_make_elt<pathlst_vt> (list_vt_nil)
//
in // in of [local]

fun the_pathlst_get
  (): pathlst_vt = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val xs = !p
  val () = !p := list_vt_nil ()
} // end of [the_pathlst_get]

fun the_pathlst_set
  (xs: pathlst_vt): void = {
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val- ~list_vt_nil () = !p
  val () = !p := xs
} // end of [the_pathlst_set]

implement
the_pathlst_pop
  (pf | (*none*)) = {
  prval unit_v () = pf
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val- ~list_vt_cons (_, xs) = !p
  val () = !p := xs
} // end of [the_pathlst_pop]

implement
the_pathlst_push (x) = let
  val () = the_pathlst_ppush (x) in (unit_v () | ())
end // end of [the_pathlst_push]

implement
the_pathlst_ppush (x) = let
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
in
  !p := list_vt_cons (x, !p)
end // end of [the_pathlst_ppush]

(* ****** ****** *)

fun the_prepathlst_get
  (): pathlst_vt = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
  val xs = !p
  val () = !p := list_vt_nil ()
} // end of [the_prepathlst_get]

fun the_prepathlst_set
  (xs: pathlst_vt): void = {
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
  val- ~list_vt_nil () = !p
  val () = !p := xs
} // end of [the_prepathlst_set]

implement
the_prepathlst_push (x) = let
  val (vbox pf | p) = ref_get_view_ptr (the_prepathlst)
in
  !p := list_vt_cons (x, !p)
end // end of [the_prepathlst_push]

end // end of [local]

(* ****** ****** *)

implement
filename_make (
  pname, fname
) = let
  val fsymb =
    $SYM.symbol_make_string (fname)
  // end of [val]
in '{
  filename_part= pname, filename_full= fsymb
} end // end of [filename_make]

(* ****** ****** *)

local

extern castfn s2s (x: string):<> String
extern castfn p2s {l:agz} (x: !strptr l):<> String

fun aux_local (
  basename: string
) : Stropt = let
  val fil = filename_get_current ()
  val pname = filename_get_part (fil)
(*
  val () = println! ("aux_local: pname = ", pname)
*)
  val pname2 = filename_merge (pname, basename)
(*
  val () = println! ("aux_local: pname2 = ", pname2)
*)
  val isexi = test_file_exists ((p2s)pname2)
in
  if isexi then
    stropt_of_strptr (pname2)
  else let
    val () = strptr_free (pname2) in stropt_none
  end // end of [if]
end // end of [aux_local]

(* ****** ****** *)

fun aux_try
  {n:nat} .<n,0>. (
  paths: list (path, n), basename: string
) : Stropt = let
in
//
case+ paths of
| list_cons (
    path, paths
  ) => aux2_try (path, paths, basename)
| list_nil () => stropt_none
//
end // end of [aux_try]

and aux2_try
  {n:nat} .<n,1>. (
  path: path, paths: list (path, n), basename: string
) : Stropt = let
  val partname =
    filename_append (path, basename)
  val isexi = test_file_exists ((p2s)partname)
(*
  val () = begin
    printf ("aux2_try: partname = %s\n", @(partname))
  end // end of [val]
*)
in
//
if isexi then (
  stropt_of_strptr (partname)
) else let
  val () = strptr_free (partname) in aux_try (paths, basename)
end // end of [if]
//
end // end of [aux2_try]

(* ****** ****** *)

fun aux_try_pathlst
  (basename: string): Stropt = let
  val path = theCurDir_get ()
  val paths = the_pathlst_get ()
  val ans = // HX: search the current directory first
    aux2_try (path, $UN.castvwtp1{pathlst}(paths), basename)
  // end of [val]
  val () = the_pathlst_set (paths)
in
  ans
end // end of [aux_try_pathlst]

fun aux_try_prepathlst
  (basename: string): Stropt = let
  val paths = the_prepathlst_get ()
  val ans =
    aux_try ($UN.castvwtp1{pathlst}(paths), basename)
  val () = the_prepathlst_set (paths)
in
  ans
end // end of [aux_try_prepathlst]

(* ****** ****** *)

fun aux_relative (
  basename: string
) : Stropt = let
  val basename = (s2s)basename
  val knd = path_get_srchknd (basename)
in
//
case+ knd of
| 0 (*local*) => aux_local (basename)
| _ (*external*) => let
    val opt = aux_try_pathlst (basename)
  in
    if stropt_is_some (opt) then opt else aux_try_prepathlst (basename)
  end // end of [_]
//
end // end of [aux_relative]

in // in of [local]

implement
filenameopt_make_local
  (basename) = let
  val opt = aux_local (basename)
  val issome = stropt_is_some (opt)
in
  if issome then let
    val partname = stropt_unsome (opt)
    val fullname = partname_fullize (partname)
  in
    Some_vt (filename_make (partname, fullname))
  end else None_vt () // end of [if]
end // end of [filenameopt_make_local]

implement
filenameopt_make_relative
  (basename) = let
//
  val opt = (case+ 0 of
    | _ when
        filename_is_relative (basename) => aux_relative (basename)
    | _ => (
        if test_file_exists (basename) then let
          val basename = string1_of_string (basename) in stropt_some basename
        end else stropt_none
      ) // end of [_]
  ) : Stropt // end of [val]
//
  val issome = stropt_is_some (opt)
in
  if issome then let
    val partname = stropt_unsome (opt)
    val fullname = partname_fullize (partname)
  in
    Some_vt (filename_make (partname, fullname))
  end else None_vt () // end of [if]
end // end of [filenameopt_make_relative]

end // end of [local]

(* ****** ****** *)

%{$

ats_ptr_type
patsopt_filename_merge (
  ats_ptr_type ful, ats_ptr_type bas
) {
  char c, dirsep ;
  char *p0, *p1, *p ;
  int n, n1, n2, found = 0 ;
  char *fulbas ;
  p0 = p = (char*)ful ;
  dirsep =
    patsopt_filename_theDirSep_get () ;
//
  while (1) {
    c = *p++ ;
    if (c == 0) break ;
    if (c == dirsep) { found = 1 ; p1 = p ; }
  }
//
  n1 = 0 ;
  if (found) n1 = (p1-p0) ;
  n2 = strlen ((char*)bas) ;
  n = n1 + n2 ;
  fulbas = ATS_MALLOC (n+1) ;
  memcpy (fulbas, ful, n1) ;
  memcpy (fulbas + n1, bas, n2) ;
  fulbas[n] = '\000' ;
//
  return fulbas ;
//
} // end of [patsopt_filename_merge]

ats_ptr_type
patsopt_filename_append (
  ats_ptr_type dir, ats_ptr_type bas
) {
  int n1, n2, n ;
  char dirsep, *dirbas ;
//
  dirsep = patsopt_filename_theDirSep_get () ;
//
  n1 = strlen ((char*)dir) ;
  n2 = strlen ((char*)bas) ;
  n = n1 + n2 ;
//
  if (n1 > 0 && ((char*)dir)[n1-1] != dirsep) n += 1 ;
  dirbas = ATS_MALLOC (n + 1) ;
  memcpy (dirbas, dir, n1) ;
  if (n > n1 + n2) { dirbas[n1] = dirsep ; n1 += 1 ; }
  memcpy (dirbas + n1, bas, n2) ;
  dirbas[n] = '\000' ;
//
  return dirbas ;
} /* end of [patsopt_filename_append] */

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_filename.dats] *)

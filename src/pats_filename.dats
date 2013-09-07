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
staload
_(*UN*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
staload SYM = "./pats_symbol.sats"
typedef symbol= $SYM.symbol
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "./pats_filename.sats"

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

in (* in of [local] *)

implement theDirSep_get () = theDirSep
implement theCurDir_get () = theCurDir
implement theParDir_get () = theParDir

end // end of [local]

(* ****** ****** *)

local

staload
STR = "libc/SATS/string.sats"
macdef strncmp = $STR.strncmp

in (* in of [local] *)

implement
givename_srchknd
  (given) = let
  val dir = theCurDir_get ()
  val len = string_length (dir)
in
  if strncmp (given, dir, len) = 0 then 0(*loc*) else 1(*ext*)
end // end of [givename_srchknd]

(* ****** ****** *)
//
// HX-2013-09:
// a gurled name looks like this:
// {}prelude/SATS/string.sats
// {$ATSCNTRB}/libgmp/SATS/string.sats
// {http://ats-lang.org/LIBRARY}prelude/SATS/string.sats
// {git@github.com:githwxi/ATS-Postiats.git}prelude/SATS/string.sats
//
implement
givename_get_ngurl
  (given) = let
//
fun loop
(
  p: ptr, n: int
, c0: char, c1: char
) : ptr = let
//
val c = $UN.ptr0_get<char> (p)
val p1 = add_ptr_size (p, sizeof<char>)
//
in
//
case+ 0 of
| _ when c = c0 =>
    loop (p1, n+1, c0, c1)
| _ when c = c1 =>
    if n > 1 then loop (p1, n-1, c0, c1) else p1
| _ => if c != '\000' then loop (p1, n, c0, c1) else null
//
end (* end of [loop] *)
//
val p0 = $UN.cast2ptr (given)
val c0 = $UN.ptr0_get<char> (p0)
//
val p1 = (
case+ 0 of
(*
| _ when
    c0 = '\(' => let
    val p = add_ptr_int (p0, 1) in loop (p, 1, c0, ')')
  end // end of [_ when ...]
*)
| _ when
    c0 = '\{' => let
    val p = add_ptr_int (p0, 1) in loop (p, 1, c0, '}')
  end // end of [_ when ...]
| _ (*rest-of-chars*) => null
) : ptr // end of [val]
//
val p0 = $UN.cast2Ptr1(p0)
val p1 = $UN.cast2Ptr1(p1)
//
in
  if p1 > p0 then $UN.cast2int(pdiff(p1, p0)) else ~1
end // end of [givename_get_ngurl]

end // end of [local]

(* ****** ****** *)

assume
filename_type = '{
  filename_givename= string
, filename_partname= string, filename_fullname= symbol
} // end of [filename]

(* ****** ****** *)

implement
filename_get_givename (fil) = fil.filename_givename
implement
filename_get_partname (fil) = fil.filename_partname
implement
filename_get_fullname (fil) = fil.filename_fullname

(* ****** ****** *)
(*
//
implement
fprint_filename (out, fil) =
  fprint_string (out, fil.filename_partname)
//
implement
print_filename (fil) = fprint_filename (stdout_ref, fil)
implement
prerr_filename (fil) = fprint_filename (stderr_ref, fil)
//
*)
(* ****** ****** *)

implement
print_filename_full
  (fil) = fprint_filename_full (stdout_ref, fil)
implement
prerr_filename_full
  (fil) = fprint_filename_full (stdout_ref, fil)
implement
fprint_filename_full
  (out, fil) = let
  val fname = $SYM.symbol_get_name (fil.filename_fullname)
in
  fprint_string (out, fname)
end // end of [fprint_filename_full]

(* ****** ****** *)

implement
fprint_filename2_full
  (out, fil) = let
//
val given = fil.filename_givename
val ngurl = givename_get_ngurl (given)
val fname = $SYM.symbol_get_name (fil.filename_fullname)
//
in
//
if ngurl < 0
  then fprint_string (out, fname)
  else fprintf (out, "%s(%s)", @(fname, given))
// end of [if]
//
end // end of [fprint_filename2_full]

(* ****** ****** *)

implement
eq_filename_filename
  (x1, x2) = x1.filename_fullname = x2.filename_fullname
// end of [eq_filename_filename]

(* ****** ****** *)

implement
compare_filename_filename
  (x1, x2) = let
  val f1 = $SYM.symbol_get_name (x1.filename_fullname)
  val f2 = $SYM.symbol_get_name (x2.filename_fullname)
in
  compare_string_string (f1, f2)
end // end of [compare_filename_filename]

(* ****** ****** *)

local
//
// HX: implemented in [pats_utils.dats]
//
extern
fun string_test_suffix
(
  str: string, sffx: string
) : bool = "ext#patsopt_string_test_suffix"

in (* in of [local] *)
//
implement
filename_is_sats (fil) =
  string_test_suffix (fil.filename_partname, ".sats")
implement
filename_is_dats (fil) =
  string_test_suffix (fil.filename_partname, ".dats")
//
end // end of [local]

(* ****** ****** *)

extern
fun givename_is_relative (given: string): bool
implement
givename_is_relative
  (given) = let
  fn aux {n,i:nat | i <= n}
  (
    given: string n, i: size_t i, dirsep: char
  ) : bool =
    if string_isnot_atend (given, i) then (given[i] != dirsep) else false 
  // end of [aux]
  val dirsep = theDirSep_get ()
  val given = string1_of_string (given)
in
  aux (given, 0, dirsep)
end // [givename_is_relative]

(* ****** ****** *)

implement
filename_dummy = '{
  filename_givename= ""
, filename_partname= "", filename_fullname= $SYM.symbol_empty
} // end of [filename_dummy]

implement
filename_stdin = '{
  filename_givename= "__STDIN__"
, filename_partname= "__STDIN__", filename_fullname= $SYM.symbol_empty
} // end of [filename_stdin]

(* ****** ****** *)

staload UNISTD = "libc/SATS/unistd.sats"

implement
path_normalize_vt (s0) = let
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
          print "path_normalize_vt: loop2: dir = "; print dir; print_newline ()
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
        print "path_normalize_vt: loop2: dir = "; print dir; print_newline ()
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
            val dir =
              string1_of_string (pardir)
            // end of [val]
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
  path(*strptr*)
end // end of [path_normalize_vt]

implement
path_normalize (s0) =
  string_of_strptr (path_normalize_vt (s0))
// end of [path_normalize]

(* ****** ****** *)

local

extern castfn p2s {l:agz} (x: !strptr l):<> string

in (* in of [local] *)

fun partname_fullize
  (pname: string): string = let
  val isrel = givename_is_relative (pname)
in
  if isrel then let
    val cwd = $UNISTD.getcwd0 ()
    val fname =
      filename_append ((p2s)cwd, pname)
    // end of [val]
    val () = strptr_free (cwd)
    val fname_nf = path_normalize ((p2s)fname)
    val () = strptr_free (fname)
  in
    fname_nf
  end else pname // HX: it is absolute
end // end of [partname_fullize]

end (* end of [local] *)

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

in (* in of [local] *)

implement filename_get_current () = !the_filename

implement
the_filenamelst_pop
  (pf | (*none*)) = let
  prval unit_v () = pf
  val x = x where {
    val (vbox pf | p) = ref_get_view_ptr (the_filenamelst)
    val-~list_vt_cons (x, xs) = !p
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
in (* in of [local] *)

fun the_pathlst_get
  (): pathlst_vt = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val xs = !p
  val () = !p := list_vt_nil ()
} // end of [the_pathlst_get]

fun the_pathlst_set
  (xs: pathlst_vt): void = {
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val-~list_vt_nil () = !p
  val () = !p := xs
} // end of [the_pathlst_set]

implement
the_pathlst_pop
  (pf | (*none*)) = {
  prval unit_v () = pf
  val (vbox pf | p) = ref_get_view_ptr (the_pathlst)
  val-~list_vt_cons (_, xs) = !p
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
  val-~list_vt_nil () = !p
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
filename_make
(
  given, pname, fname
) = let
//
val fname = $SYM.symbol_make_string (fname)
//
in '{
  filename_givename= given
, filename_partname= pname, filename_fullname= fname
} end // end of [filename_make]

(* ****** ****** *)

local

extern castfn s2s (x: string):<> String
extern castfn p2s {l:agz} (x: !strptr l):<> String

fun
aux_local
(
  given: string
) : Stropt = let
  val fil = filename_get_current ()
  val pname = filename_get_partname (fil)
(*
  val () = println! ("aux_local: pname = ", pname)
*)
  val pname2 = filename_merge (pname, given)
  val pname2_nf = path_normalize_vt ((p2s)pname2)
  val () = strptr_free (pname2)
(*
  val () = println! ("aux_local: pname2_nf = ", pname2_nf)
*)
  val isexi = test_file_exists ((p2s)pname2_nf)
in
  if isexi then
    stropt_of_strptr (pname2_nf)
  else let
    val () = strptr_free (pname2_nf) in stropt_none(*void*)
  end // end of [if]
end // end of [aux_local]

(* ****** ****** *)

fun
aux_try
  {n:nat} .<n,0>.
(
  paths: list (path, n), given: string
) : Stropt = let
in
//
case+ paths of
| list_cons (
    path, paths
  ) => aux2_try (path, paths, given)
| list_nil () => stropt_none
//
end // end of [aux_try]

and aux2_try
  {n:nat} .<n,1>. (
  path: path, paths: list (path, n), given: string
) : Stropt = let
  val partname =
    filename_append (path, given)
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
  val () = strptr_free (partname) in aux_try (paths, given)
end // end of [if]
//
end // end of [aux2_try]

(* ****** ****** *)

fun aux_try_pathlst
  (given: string): Stropt = let
  val path = theCurDir_get ()
  val paths = the_pathlst_get ()
  val ans = // HX: search the current directory first
    aux2_try (path, $UN.castvwtp1{pathlst}(paths), given)
  // end of [val]
  val () = the_pathlst_set (paths)
in
  ans
end // end of [aux_try_pathlst]

fun aux_try_prepathlst
  (given: string): Stropt = let
  val paths = the_prepathlst_get ()
  val ans =
    aux_try ($UN.castvwtp1{pathlst}(paths), given)
  val () = the_prepathlst_set (paths)
in
  ans
end // end of [aux_try_prepathlst]

(* ****** ****** *)

fun
aux_relative
(
  given: string
) : Stropt = let
//
val given = (s2s)given
val knd = givename_srchknd (given)
//
in
//
case+ knd of
| 0 (*local*) => aux_local (given)
| _ (*external*) => let
    val opt = aux_try_pathlst (given)
  in
    if stropt_is_some (opt) then opt else aux_try_prepathlst (given)
  end // end of [_]
//
end // end of [aux_relative]

in (* in of [local] *)

implement
filenameopt_make_local
  (given) = let
//
val opt = aux_local (given)
val issome = stropt_is_some (opt)
//
in
//
if issome then let
  val partname = stropt_unsome (opt)
  val fullname = partname_fullize (partname)
in
  Some_vt (filename_make (given, partname, fullname))
end else None_vt () // end of [if]
//
end // end of [filenameopt_make_local]

implement
filenameopt_make_relative
  (given) = let
//
val ngurl = givename_get_ngurl (given)
val given2 = pkgsrcname_relocatize (given, ngurl)
//
(*
val () = 
  println! ("filenameopt_make_relative: ngurl = ", ngurl)
val () = 
  println! ("filenameopt_make_relative: given = ", given)
val () = 
  println! ("filenameopt_make_relative: given2 = ", given2)
*)
//
val opt =
(
case+ 0 of
| _ when
    givename_is_relative (given2) => aux_relative (given2)
  // end of [_ when ...]
| _ => let
    val isexi = test_file_exists (given2)
  in
    if isexi then stropt_some (given2) else stropt_none(*void*)
  end // end of [_]
) : Stropt // end of [val]
//
val issome = stropt_is_some (opt)
//
in
//
if issome then let
  val partname = stropt_unsome (opt)
  val fullname = partname_fullize (partname)
in
  Some_vt (filename_make (given, partname, fullname))
end else None_vt () // end of [if]
//
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

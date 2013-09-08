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

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_utils.sats"

(* ****** ****** *)

%{^
//
// HX-2011-04-18:
// there is no need for marking these variables as
// GC roots because the values stored in them cannot be GCed
//
static char *patsopt_PATSHOME = (char*)0 ;
static char *patsopt_PATSHOMERELOC = (char*)0 ;
extern char *getenv (const char *name) ; // [stdlib.h]
//
ATSextfun()
ats_ptr_type
patsopt_PATSHOME_get () {
  return patsopt_PATSHOME ; // optional string
} // end of [patsopt_PATSHOME_get]
ATSextfun()
ats_ptr_type
patsopt_PATSHOMERELOC_get () {
  return patsopt_PATSHOMERELOC ; // optional string
} // end of [patsopt_PATSHOMERELOC_get]
//
ATSextfun()
ats_void_type
patsopt_PATSHOME_set () {
  patsopt_PATSHOME = getenv ("PATSHOME") ; return ;
  if (!patsopt_PATSHOME) patsopt_PATSHOME = getenv ("ATSHOME") ;
} // end of [patsopt_PATSHOME_set]
ATSextfun()
ats_void_type
patsopt_PATSHOMERELOC_set () {
  patsopt_PATSHOMERELOC = getenv ("PATSHOMERELOC") ;
  if (!patsopt_PATSHOMERELOC) patsopt_PATSHOMERELOC = getenv ("ATSHOMERELOC") ;
  return ;
} // end of [patsopt_PATSHOMERELOC_set]
//
%} // end of [%{^]

(* ****** ****** *)

implement
eqref_type
  {a} (x1, x2) = let
  extern castfn __cast (x: a):<> ptr
  val x1 = __cast (x1) and x2 = __cast (x2)
in
  eq_ptr_ptr (x1, x2)
end // end of [eqref_type]

(* ****** ****** *)
//
// HX: case-insensitive string comparision
//
extern
fun strcasecmp (
  x1: string, x2: string
) :<> int
  = "ext#patsopt_strcasecmp"
implement
strcasecmp (x1, x2) = let
  fun loop (p1: Ptr1, p2: Ptr1): int = let
    val c1 = char_toupper ($UN.ptrget<char> (p1))
    val c2 = char_toupper ($UN.ptrget<char> (p2))
  in
    if c1 < c2 then ~1
    else if c1 > c2 then 1
    else if c1 != '\000' then loop (p1+1, p2+1)
    else 0 // end of [if]
  end // end of [loop]
in
  $effmask_all (loop ($UN.cast2Ptr1(x1), $UN.cast2Ptr1(x2)))
end // end of [strcasecmp]

(* ****** ****** *)

extern
fun string_test_prefix
(
  str: string, prfx: string
) :<> bool
  = "ext#patsopt_string_test_prefix"
implement
string_test_prefix
  (str, prfx) = let
//
#define NUL '\000'
//
fun loop (
  p1: Ptr1, p2: Ptr1
) : bool = let
  val c1 = $UN.ptrget<char> (p1)
in
//
if c1 > NUL then let
  val c2 = $UN.ptrget<char> (p2)
in
  if c1 = c2 then loop (p1+1, p2+1) else false
end else true // end of [if]
//
end // end of [loop]
//
in
  $effmask_all (loop ($UN.cast2Ptr1(prfx), $UN.cast2Ptr1(str)))
end // end of [patsopt_string_test_prefix]

(* ****** ****** *)

extern
fun string_test_sffx
(
  str: string, sffx: string
) :<> bool
  = "ext#patsopt_string_test_suffix"
implement
string_test_sffx
  (str, sffx) = let
//
val n1 = string_length (str)
val n2 = string_length (sffx)
//
in
//
if n1 >= n2 then let
  val p1 = $UN.cast2Ptr1(str)
  val str2 = $UN.cast{string}(p1 + (n1 - n2))
in
  str2 = sffx
end else false // end of [if]
//
end // end of [string_test_sffx]

(* ****** ****** *)

local

staload STDLIB = "libc/SATS/stdlib.sats"

fun
llint_make_string_sgn
  {n,i:nat | i <= n}
(
  sgn: int, rep: string (n), i: size_t i
) : llint = let
in
  if string_isnot_atend (rep, i) then let
    val c0 = rep[i]
  in
    case+ c0 of
    | '0' => (
        if string_isnot_atend (rep, i+1) then let
          val i = i+1
          val c0 = rep[i]
        in
          if (c0 != 'x' && c0 != 'X') then
            llint_make_string_sgn_base (sgn, 8(*base*), rep, i)
          else
            llint_make_string_sgn_base (sgn, 16(*base*), rep, i+1)
          // end of [if]
        end else 0ll (* end of [if] *)
      ) // end of ['0']
    | _ => llint_make_string_sgn_base (sgn, 10(*base*), rep, i)
  end else 0ll (* end of [if] *)
end // end of [llint_make_string_sgn]

and
llint_make_string_sgn_base
  {n,i:nat | i <= n}
(
  sgn: int, base: intBtw (2,36+1), rep: string (n), i: size_t i
) : llint = let
//
extern fun substring
  {n,i:nat | i <= n}
  (x: string n, i: size_t i): string (n-i) = "mac#atspre_padd_int"
//
in
  (llint_of)sgn * $STDLIB.strtoll_errnul (substring (rep, i), base)
end // end of [llint_make_string_sgn_base]

in (* in of [local] *)

implement
llint_make_string
  (rep) = let
//
var sgn: int = 1
val [n0:int] rep = string1_of_string (rep)
val isnot = string_isnot_empty (rep)
//
in
//
if isnot then let
  val c0 = rep[0] in
//
case+ c0 of
| '+' => llint_make_string_sgn ( 1(*sgn*), rep, 1)
| '-' => llint_make_string_sgn (~1(*sgn*), rep, 1)
| '~' => llint_make_string_sgn (~1(*sgn*), rep, 1) // HX: should it be supported?
| _ => llint_make_string_sgn (1(*sgn*), rep, 0)
//
end else 0ll // end of [if]
//
end // end of [llint_make_string]

implement
double_make_string (rep) = $STDLIB.atof (rep)

end // end of [local]

(* ****** ****** *)

implement
intrep_get_base (rep) = let
  val rep = string1_of_string (rep)
  val isnot = string_isnot_atend (rep, 0)
in
//
if isnot then let
  val c0 = rep[0]
in
//
if c0 = '0' then let
  val isnot = string_isnot_atend (rep, 1)
in
  if isnot then let
    val c1 = rep[1]
    val isxX = (if c1 = 'x' then true else c1 = 'X'): bool
  in
    if isxX
      then 16
      else (
        if char_isdigit (c1) then 8 else 10
      )
    // end of [if]
  end
    else 10
  // end of [if]
end else 10 // end of [if]
//
end else 10 // end of [if]
//
end // end of [intrep_get_base]

implement
intrep_get_nsfx (rep) = let
//
macdef test (c) =
  string_contains ("ulUL", ,(c))
//
val [n:int] rep = string1_of_string (rep)
//
fun loop
  {i:nat | i <= n} .<i>. (
  rep: string n, i: size_t i, k: uint
) : uint = let
in
  if i > 0 then let
    val i1 = i - 1
    val c = rep[i1]
  in
    if test (c) then loop (rep, i1, k+1u) else k
  end else k
end // end of [loop]
//
val n = string_length (rep)
//
in
  loop (rep, n, 0u)
end // end of [intrep_get_nsfx]

(* ****** ****** *)

implement
float_get_nsfx (rep) = let
//
macdef test (c) =
  string_contains ("fFlL", ,(c))
//
val [n:int] rep = string1_of_string (rep)
//
fun loop
  {i:nat | i <= n} .<i>. (
  rep: string n, i: size_t i, k: uint
) : uint = let
in
  if i > 0 then let
    val i1 = i - 1
    val c = rep[i1]
  in
    if test (c) then loop (rep, i1, k+1u) else k
  end else k
end // end of [loop]
//
val n = string_length (rep)
//
in
  loop (rep, n, 0u)
end // end of [float_get_nsfx]

(* ****** ****** *)

local

assume lstord (a:type) = List (a)

in (* in of [local] *)

implement
lstord_nil () = list_nil ()

implement
lstord_sing (x) = list_cons (x, list_nil ())

implement
lstord_insert{a}
  (xs, x0, cmp) = let
  fun aux {n:nat} .<n>.
    (xs: list (a, n)):<cloref> list (a, n+1) =
    case+ xs of
    | list_cons (x, xs1) =>
        if cmp (x0, x) <= 0 then
          list_cons (x0, xs) else list_cons (x, aux (xs1))
        // end of [if]
    | list_nil () => list_cons (x0, list_nil)
  // end of [aux]
in
  aux (xs)
end // end of [lstord_insert]

implement
lstord_union{a}
  (xs1, xs2, cmp) = let
  fun aux {n1,n2:nat} .<n1+n2>. (
    xs1: list (a, n1), xs2: list (a, n2)
  ) :<cloref> list (a, n1+n2) =
    case+ xs1 of
    | list_cons (x1, xs11) => (
      case+ xs2 of
      | list_cons (x2, xs21) =>
          if cmp (x1, x2) <= 0 then
            list_cons (x1, aux (xs11, xs2))
          else
            list_cons (x2, aux (xs1, xs21))
          // end of [if]
      | list_nil () => xs1
      ) // end of [list_cons]
    | list_nil () => xs2
  // end of [aux]
in
  aux (xs1, xs2)
end // end of [lstord_union]

implement
lstord_get_dups
  {a} (xs, cmp) = let
//
fun aux {n:nat} .<n>. (
  x0: a, xs: list (a, n), cnt: int
) :<cloref> List a =
  case+ xs of
  | list_cons (x, xs) =>
      if cmp (x, x0) = 0 then
        aux (x0, xs, cnt+1)
      else ( // HX: x0 < x holds
        if cnt > 0 then
          list_cons (x0, aux (x, xs, 0)) else aux (x, xs, 0)
        // end of [if]
      ) // end of [if]
  | list_nil () =>
      if cnt > 0 then list_cons (x0, list_nil) else list_nil
    // end of [list_nil]
(* end of [aux] *)
//
in
//
case+ xs of
| list_cons
    (x, xs) => aux (x, xs, 0)
| list_nil () => list_nil ()
//
end // end of [lstord_get_dups]

implement lstord2list (xs) = xs

end // end of [local]

(* ****** ****** *)

implement
dirpath_append
  (dir, path, sep) = let
//
val p0 = $UN.cast2ptr (path)
val c0 = $UN.ptr0_get<char> (p0)
//
in
  if c0 = sep
    then sprintf ("%s%s", @(dir, path))
    else sprintf("%s%c%s", @(dir, sep, path))
  // end of [if]
end // end of [dirpath_append]

(* ****** ****** *)

implement
fprint_stropt
 (out, opt) = let
in
//
if stropt_is_some (opt) then
  fprint_string (out, stropt_unsome (opt))
else
  fprint_string (out, "(none)")
// end of [if]
//
end (* end of [fprint_stropt] *)

(* ****** ****** *)

implement{a}
fprintlst (
  out, xs, sep, fprint
) = let
  fun aux (
    xs: List a, i: int
  ) :<cloref1> void =
    case+ xs of
    | list_cons (x, xs) => let
        val () = if i > 0 then fprint_string (out, sep)
        val () = fprint (out, x)
      in
         aux (xs, i+1)
      end // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [aux]
in
  aux (xs, 0)
end // end of [fprintlst]

(* ****** ****** *)

implement{a}
fprintopt (
  out, opt, fprint
) = case+ opt of
  | Some x => let
      val () = fprint_string (out, "Some(")
      val () = fprint (out, x)
      val () = fprint_string (out, ")")
    in
      // nothing
    end // end of [Some]
  | None () => fprint_string (out, "None()")
// end of [fprintopt]

(* ****** ****** *)

local
//
staload Q = "libats/SATS/linqueue_arr.sats"
//
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"
//
in (* in of [local] *)
//
implement
queue_get_strptr1
  (q, st, ln) = let
  val [l:addr]
    (pfgc, pfarr | p) = malloc_gc (ln+1)
  // end of [val]
  prval (pf1, fpf2) =
   __assert (pfarr) where {
   extern prfun __assert {k:nat} (
     pfarr: b0ytes(k+1) @ l
   ) : (
     @[uchar?][k] @ l, @[uchar][k] @ l -<lin,prf> bytes(k+1) @ l
   ) (* end of [_assert] *)
  } // end of [prval]
  val () = $Q.queue_copyout<uchar> (q, st, ln, !p)
  prval () = pfarr := fpf2 (pf1)
  val () = bytes_strbuf_trans (pfarr | p, ln)
in
  strptr_of_strbuf @(pfgc, pfarr | p)
end // end of [queue_get_strptr1]
//
end // end of [local]

(* ****** ****** *)

%{$
//
extern
ats_int_type
atslib_fildes_read_all_err
  (ats_int_type fd, ats_ref_type buf, ats_size_type ntot) ;
//
ats_ptr_type
patsopt_file2strptr
  (ats_int_type fd) {
  int err = 0 ;
  int nerr = 0 ;
  char* sbp = (char*)0 ;
//
  long int ofs_beg, ofs_end, nbyte ;
//
  ofs_beg = lseek (fd, 0L, SEEK_CUR) ;
  if (ofs_beg < 0) nerr += 1 ;
  ofs_end = lseek (fd, 0L, SEEK_END) ;
  if (ofs_end < 0) nerr += 1 ;
  ofs_beg = lseek (fd, ofs_beg, SEEK_SET) ;
  if (ofs_beg < 0) nerr += 1 ;
  nbyte = ofs_end - ofs_beg ;
//
  if (nerr == 0) { sbp = ATS_MALLOC(nbyte + 1) ; }
  if (sbp == NULL) nerr += 1 ;
//
  if (nerr == 0) {
    err = atslib_fildes_read_all_err (fd, sbp, nbyte) ;
  }
  if (err < 0) { nerr += 1 ; }
//
  if (nerr == 0) {
    sbp[ofs_end] = '\0'; return sbp ;
  }
//
  if (sbp) free (sbp) ; return NULL ;
} // end of [patsopt_file2strptr]
%} // end of [%{$]

(* ****** ****** *)

local

staload
FCNTL = "libc/SATS/fcntl.sats"
staload
STDIO = "libc/SATS/stdio.sats"
macdef SEEK_SET = $STDIO.SEEK_SET
staload
STDLIB = "libc/SATS/stdlib.sats"
staload
UNISTD = "libc/SATS/unistd.sats"

in (* in of [local] *)

implement{a}
tostring_fprint
  (prfx, fpr, x) = let
  val tmp = sprintf ("%sXXXXXX", @(prfx))
  val [m,n:int] tmp = strbuf_of_strptr (tmp)
  prval () = __assert () where {
    extern prfun __assert (): [n >= 6] void
  }
  prval pfstr = tmp.1
  val (pfopt | fd) = $STDLIB.mkstemp !(tmp.2) // create it!
  prval () = tmp.1 := pfstr
  val tmp = strptr_of_strbuf (tmp)
in
//
if fd >= 0 then let
  prval $FCNTL.open_v_succ (pffil) = pfopt
  val (fpf | out) = fdopen (pffil | fd, file_mode_w) where {
    extern fun fdopen {fd:nat} (
      pffil: !fildes_v fd | fd: int fd, mode: file_mode
    ) : (fildes_v fd -<lin,prf> void | FILEref) = "mac#fdopen"
  } // end of [out]
  val () = fpr (out, x)
  val _err = $STDIO.fflush_err (out)
  val _err = $STDIO.fseek_err (out, 0L, SEEK_SET)
  val res = file2strptr (pffil | fd)
  prval () = fpf (pffil)
  val _err = $STDIO.fclose_err (out)
  val _err = $UNISTD.unlink ($UN.castvwtp1 (tmp))
  val () = strptr_free (tmp)
in
  res (*strptr*)
end else let
  prval $FCNTL.open_v_fail () = pfopt
  val () = strptr_free (tmp) in strptr_null ()
end // end of [if]
//
end // end of [tostring_fprint]

end // end of [local]

(* ****** ****** *)

(* end of [pats_utils.dats] *)

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
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload STDLIB = "libc/SATS/stdlib.sats"
staload _(*anon*) = "libc/DATS/stdlib.dats"

(* ****** ****** *)

staload "./atscc.sats"

(* ****** ****** *)

staload _(*anon*) = "./atscc_util.dats"

(* ****** ****** *)

typedef ca = commarg

(* ****** ****** *)

macdef
unsome (opt) = stropt_unsome (,(opt))
macdef
issome (opt) = stropt_is_some (,(opt))

(* ****** ****** *)

macdef
isfilsats (name) = filename_test_ext (,(name), "sats")
macdef
isfildats (name) = filename_test_ext (,(name), "dats")

(* ****** ****** *)

fun{
} argv_getopt_at
  {n:int}{i:nat}
(
  n: int n, argv: !argv(n), i: int i
) : stropt =
(
  if i < n then stropt_some (argv[i]) else stropt_none ()
) (* end of [argv_getopt_at] *)

(* ****** ****** *)

local
//
// HX: this is a bit heavy-handed, but ...
//
fun auxmain
(
  path: string, sfx: string
) : string = let
//
val
(
  fpf | base
) = filename_get_base (path)
val base2 = g1ofg0 ($UN.strptr2string (base))
val nb = string1_length (base2)
//
val (fpf2 | ext) = filename_get_ext (base2)
val isext = strptr2ptr(ext) > 0
//
#define CHR1 '\001'
//
val res =
(
if isext then let
//
val ne =
  string0_length ($UN.strptr2string (ext))
val len = nb+i2sz(2) // HX: 2 -> .c
//
implement
string_tabulate$fwork<>
  (i) = let
//
val i = g1ofg0(i)
val ne1 = succ (ne)
//
in
//
case+ 0 of
| _ when (i+ne1 = nb) => '_'
| _ when (i < nb) => base2[i]
| _ when (i = nb+i2sz(0)) => '.'
| _ when (i = nb+i2sz(1)) => 'c'
| _ => CHR1
//
end // end of [string_tabulate$fwork]
//
in
  strnptr2string (string_tabulate(len))
end else let
//
val sfx = g1ofg0(sfx)
val nsfx = string1_length (sfx)
val len = nb+nsfx
//
implement
string_tabulate$fwork<>
  (i) = let
//
val i = g1ofg0(i) in
//
case+ 0 of
| _ when (i < nb) => base2[i]
| _ when (i < len) => let
    extern praxi
    __assert{i,j:int}
      (size_t i, size_t j): [i >= j] void
    prval () = __assert (i, nb) in sfx[i-nb]
  end // end of [_ when ...]
| _ => CHR1
//
end // end of [string_tabulate$fwork]
//
in
  strnptr2string (string_tabulate(len))
end // end of [if]
) : string // end of [val]
//
prval () = fpf (base) and () = fpf2 (ext)
//
in
  res
end // end of [auxmain]

in (* in of [local] *)

implement
atscc_outname
  (flag, path) = let
in
//
if flag = 0
  then auxmain (path, "@sats.c")
  else auxmain (path, "@dats.c")
// end of [if]
//
end // end of [atscc_outname]

end // end of [local]

(* ****** ****** *)

local

fun aux0
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+2>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt =
(
  if i < n then aux1 (n, argv, i, res) else res
) // end of [aux0]

and aux1
  {n:int}
  {i:nat | i < n}
  .<3*(n-i)+1>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
//
val str0 = argv[i]
//
in
//
case+ 0 of
//
| _ when (str0="-vats") => let
      val res = list_vt_cons{ca}(CAvats(), res)
    in
      aux0 (n, argv, i+1, res)
    end // end of [_ when ...]
| _ when (str0="-ccats") => let
      val res = list_vt_cons{ca}(CAccats(), res)
    in
      aux0 (n, argv, i+1, res)
    end // end of [_ when ...]
| _ when (str0="-tcats") => let
      val res = list_vt_cons{ca}(CAtcats(), res)
    in
      aux0 (n, argv, i+1, res)
    end // end of [_ when ...]
//
| _ when (str0="-IATS") =>
    aux1_iats (n, argv, i+1, res)
| _ when (str0="-IIATS") =>
    aux1_iiats (n, argv, i+1, res)
//
| _ when (str0="-DATS") =>
    aux1_dats (n, argv, i+1, res)
| _ when (str0="-DDATS") =>
    aux1_ddats (n, argv, i+1, res)
//
| _ when (str0="-fsats") =>
    aux1_fsats (n, argv, i+1, res)
| _ when (str0="-fdats") =>
    aux1_fdats (n, argv, i+1, res)
//
| _ when isfilsats(str0) =>
    aux1_fsats (n, argv, i+0, res)
| _ when isfildats(str0) =>
    aux1_fdats (n, argv, i+0, res)
//
| _ => let
    val res =
      list_vt_cons{ca}(CAgitem(str0), res)
    // end of [val]
  in
    aux0 (n, argv, i+1, res)
  end // end of [_]
//
end // end of [aux1]

(* ****** ****** *)

and aux1_iats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAiats(0, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_iats]

and aux1_iiats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAiats(1, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_iiats]

(* ****** ****** *)

and aux1_dats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAdats(0, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_dats]

and aux1_ddats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAdats(1, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_ddats]

(* ****** ****** *)

and aux1_fsats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAfilats(0, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_fsats]

and aux1_fdats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAfilats(1, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_fdats]

in (* in of [local] *)

implement
atsccproc_commline
  (argc, argv) = let
//
prval (
) = lemma_argv_param (argv)
//
val res = list_vt_nil{ca}()
val res = aux0 (argc, argv, 0, res)
val res = list_vt_reverse (res)
//
in
  list_vt2t(res)
end // end of [atsccproc]

end (* end of [local] *)

(* ****** ****** *)

local

vtypedef res = stringlst_vt

fun aux
(
  ca: commarg, i: int, res: &res >> _
) : void = let
in
//
case+ ca of
//
| CAtcats () =>
  {
    val (
    ) = res := list_vt_cons{string}("--typecheck", res)
  }
//
| CAdats (_, opt) =>
  (
    if issome (opt) then aux_dats (unsome(opt), res)
  )
//
| CAiats (_, opt) =>
  (
    if issome (opt) then aux_iats (unsome(opt), res)
  )
//
| _ => ()
//
end (* end of [aux] *)
//
and aux_dats
(
  path: string, res: &res >> _
) : void =
{
  val () = res := list_vt_cons{string}("-DATS", res)
  val () = res := list_vt_cons{string}(  path , res)
}
and aux_iats
(
  path: string, res: &res >> _
) : void =
{
  val () = res := list_vt_cons{string}("-IATS", res)
  val () = res := list_vt_cons{string}(  path , res)
}
//
fun auxlst
(
  cas: commarglst, i: int, res: &res >> _
) : void = let
in
//
case+ cas of
| list_cons
    (ca, cas) => let
    val () = aux (ca, i, res) in auxlst (cas, i+1, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

in (* in of [local] *)

implement
atsoptline_make
  (cas, ca0) = let
//
var res: res = list_vt_nil ()
val () = auxlst (cas, 1(*i*), res)
//
val () =
(
case+ ca0 of
| CAvats () =>
  {
    val () = res := list_vt_cons{string}("--version", res)
  }
| CAfilats (knd, opt) =>
  if issome (opt) then
  {
    val name = unsome(opt)
    val outname = atscc_outname (knd, name)
//
    val (
    ) = res := list_vt_cons{string}("--output", res)
    val () = res := list_vt_cons{string}(outname, res)
//
    val () =
      if knd = 0 then res := list_vt_cons{string}("--static", res)
    // end of [val]
    val () =
      if knd > 0 then res := list_vt_cons{string}("--dynamic", res)
    // end of [val]
    val () = res := list_vt_cons{string}(name, res)
//
  } (* end of [if] *)
| _ => ((*void*))
) : void // end of [val]
//
in
  list_vt_reverse (res)
end // end of [atsoptline_make]

end // end of [local]

(* ****** ****** *)

local
//
vtypedef res = stringlst_vt
vtypedef ress = List0_vt (stringlst_vt)
//
macdef snoc = list_vt_snoc
//
fun auxlst
(
  cas1: commarglst_vt, cas2: commarglst, ress: &ress >> _
) : void = let
in
//
case+ cas2 of
| list_cons
    (ca2, cas2) => let
  in
    case+ ca2 of
//
    | CAvats () => let
        val res =
          atsoptline_make ($UN.list_vt2t(cas1), ca2)
        val () = ress := list_vt_cons{res}(res, ress)
      in
        auxlst (cas1, cas2, ress)
      end (* end of [CAvats] *)
//
    | CAtcats () => let
        val cas1 =
          snoc (cas1, ca2) in auxlst (cas1, cas2, ress)
      end (* end of [CAiats] *)
//
    | CAdats _ => let
        val cas1 =
          snoc (cas1, ca2) in auxlst (cas1, cas2, ress)
      end (* end of [CAdats] *)
    | CAiats _ => let
        val cas1 =
          snoc (cas1, ca2) in auxlst (cas1, cas2, ress)
      end (* end of [CAiats] *)
//
    | CAfilats _ => let
        val res =
          atsoptline_make ($UN.list_vt2t(cas1), ca2) 
        val () = ress := list_vt_cons{res}(res, ress)
      in
        auxlst (cas1, cas2, ress)
      end (* end of [CAfilats] *)
//
    | _(*ignored*) => auxlst (cas1, cas2, ress)
//
  end // end of [list_cons]
| list_nil () => let
    val () = list_vt_free (cas1) in (*nothing*)
  end (* end of [list_nil] *)
//
end // end of [auxlst]

in (* in of [local] *)

implement
atsoptline_make_all
  (cas0) = let
//
var ress: ress = list_vt_nil
val () = auxlst (list_vt_nil, cas0, ress)
//
in
  list_vt_reverse (ress)
end // end of [atsoptline_make_all]

end // end of [local]

(* ****** ****** *)

local

vtypedef res = stringlst_vt

fun aux
(
  ca: commarg, i: int, res: &res >> _
) : void = let
in
//
case+ ca of
//
| CAvats () => ()
| CAccats () => ()
| CAtcats () => ()
//
| CAdats (0, opt) => ()
| CAdats (_, opt) =>
  if issome (opt) then
  {
    val () = res := list_vt_cons{string}("-D", res)
    val () = res := list_vt_cons{string}(unsome(opt), res)
  } else ((*void*)) // end of [if]
//
| CAiats (0, opt) => ()
| CAiats (_, opt) =>
  if issome (opt) then
  {
    val () = res := list_vt_cons{string}("-I", res)
    val () = res := list_vt_cons{string}(unsome(opt), res)
  } else ((*void*)) // end of [if]
//
| CAfilats (0, opt) =>
  (
    if issome (opt) then aux_fsats (unsome(opt), res)
  )
| CAfilats (_, opt) =>
  (
    if issome (opt) then aux_fdats (unsome(opt), res)
  )
//
| CAgitem (item) => aux_gitem (item, res)
//
end // end of [aux]

and aux_fsats
  (path: string, res: &res >> _): void =
{
  val outname = atscc_outname (0(*sta*), path)
  val () = res := list_vt_cons{string}(outname, res)
}
and aux_fdats
  (path: string, res: &res >> _): void =
{
  val outname = atscc_outname (0(*sta*), path)
  val () = res := list_vt_cons{string}(outname, res)
}
and aux_gitem
  (item: string, res: &res >> _): void =
{
  val () = res := list_vt_cons{string}(item, res)
}

fun auxlst
(
  cas: commarglst, i: int, res: &res >> _
) : void = let
in
//
case+ cas of
| list_cons
    (ca, cas) => let
    val () = aux (ca, i, res) in auxlst (cas, i+1, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]

in (* in of [local] *)

implement
atsccompline_make
  (cas0) = let
//
var res: res = list_vt_nil
val-list_cons (ca, cas) = cas0
val () = auxlst (cas, 1(*i*), res)
//
in
  list_vt_reverse (res)
end // end of [atsccompline_make]

end // end of [local]

(* ****** ****** *)

local

#define CNUL '\000'
overload + with add_ptr_bsz

fun auxstr
(
  p0: &ptr >> _, n0: &size_t >> _, x: string
) : int = let
//
val n = string_length (x)
//
in
//
if n0 > n then let
  val _ = $extfcall
  (
    ptr, "memcpy", p0, string2ptr(x), n
  ) // end of [val]
  val () = p0 := p0 + n and () = n0 := n0 - n
in
  0(*success*)
end else ~1(*failure*) // end of [if]
//
end // end of [auxstr]

fun auxstrlst_sep
(
  p0: &ptr >> _, n0: &size_t >> _, sep: string, xs: stringlst
) : int = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val ecode = auxstr (p0, n0, sep)
    val ecode =
    (
      if ecode >= 0 then auxstr (p0, n0, x) else ~1
    ) : int // end of [val]
  in
    if ecode >= 0 then auxstrlst_sep (p0, n0, sep, xs) else ~1
  end // end of [list_cons]
| list_nil () => 0(*success*)
//
end // end of [auxstrlst_sep]

fun auxline
(
  cmd: string
, args: stringlst
, bsz: sizeGte(1)
) : Strptr1 = let
//
val (
  pfat
, pfgc
| p_st
) = malloc_gc (bsz)
//
var p0: ptr = p_st
var n0: size_t = bsz
val sep: string = " "
//
val ecode = auxstr (p0, n0, cmd)
val ecode = (
  if ecode >= 0 then auxstrlst_sep (p0, n0, sep, args) else ~1
) : int // end of [val]
//
in
//
if ecode >= 0
  then let
  val () = $UN.ptr0_set<char> (p0, CNUL) in
  $UN.castvwtp0{Strptr1}((pfat, pfgc | p_st))
  end else let
  val () = mfree_gc (pfat, pfgc | p_st) in auxline (cmd, args, bsz+bsz)
  end // end of [else]
// end of [if]
end // end of [auxline]

in (* in of [local]*)

implement
atsoptline_exec
  (args) = let
//
val bsz = 1024 // HX: more or less arbitrary
//
val cmd = atsopt_get ()
val line = auxline (cmd, $UN.list_vt2t(args), i2sz(bsz))
val () = list_vt_free (args)
//
val (
) = fprintln! (stdout_ref, "atsoptline: ", line)
//
val ecode = $STDLIB.system ($UN.strptr2string(line))
//
val (
) = fprintln! (stdout_ref, "atsoptline: ecode = ", ecode)
//
val () = strptr_free (line)
//
in
  ecode
end // end of [atsoptline_exec]

(* ****** ****** *)

implement
atsoptline_exec_all
  (lines) = let
//
vtypedef
lines = List_vt(stringlst_vt)
//
fun auxlst
(
  lines: lines, ecode: int
) : int = let
in
//
case+ lines of
| ~list_vt_cons
    (line, lines) => let
    val ecode =
    (
      if ecode = 0
        then atsoptline_exec (line)
        else let
          val () = list_vt_free (line) in ecode
        end // end of [else]
      // end of [if]
    ) : int // end of [val]
  in
    auxlst (lines, ecode)
  end // end of [cons]
| ~list_vt_nil () => ecode(*success*)
//
end // end of [auxlst]
//
in
  auxlst (lines, 0(*ecode*))
end // end of [atsoptline_exec_all]

(* ****** ****** *)

implement
atsccompline_exec
  (args) = let
//
val bsz = 1024 // HX: more or less arbitrary
//
val cmd = atsccomp_get ()
val line = auxline (cmd, $UN.list_vt2t(args), i2sz(bsz))
val () = list_vt_free (args)
//
val (
) = fprintln! (stdout_ref, "atsccompline: ", line)
//
val ecode = $STDLIB.system ($UN.strptr2string(line))
//
val (
) = fprintln! (stdout_ref, "atsccompline: ecode = ", ecode)
//
val () = strptr_free (line)
//
in
  ecode
end // end of [atsccompline_exec]

end // end of [local]

(* ****** ****** *)

(* end of [atscc_main.dats] *)

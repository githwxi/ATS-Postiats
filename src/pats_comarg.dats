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
// Start Time: April, 2011
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/string.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload GLOB = "./pats_global.sats"

staload LOC = "./pats_location.sats"
staload FIL = "./pats_filename.sats"

staload SYM = "./pats_symbol.sats"
staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload PAR = "./pats_parsing.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload TRANS1 = "./pats_trans1.sats"
staload TRENV1 = "./pats_trans1_env.sats"

(* ****** ****** *)

staload "./pats_comarg.sats"

(* ****** ****** *)

%{^
//
extern char* patsopt_PATSRELOCROOT_get () ;
//
%} // end of [%{^]

(* ****** ****** *)
//
implement
print_comarg(x) =
fprint_comarg(stdout_ref, x)
//
implement
fprint_comarg(out, x) =
(
case+ x of
| COMARG(i, k) =>
  fprint!(out, "COMARG(", i, ", ", k, ")")
)
//
(* ****** ****** *)

implement
comarg_parse
  (str) = let
//
fun
loop
{n,i:nat|i <= n} .<n-i>.
(
  str: string n, n: int n, i: int i
) :<> comarg = 
(
  if i < n
    then (
    if (str[i] <> '-')
      then COMARG (i, str) else loop (str, n, i+1)
    ) else COMARG (n, str)
) (* end of [if] *)  
// end of [loop]
//
val str =
  string1_of_string str
//
val len = string_length (str)
val len = int1_of_size1 (len)
//
in
  loop(str, len, 0)
end // end of [comarg_parse]

(* ****** ****** *)

implement
comarglst_parse
  {n}(argc, argv) = let
//
vtypedef
arglst(n:int) = list_vt(comarg, n)
//
fun
loop
{i:nat | i <= n}{l:addr} .<n-i>.
(
  pf0: arglst(0) @ l
| argv: &(@[string][n]), i: int i, p: ptr l
) :<cloref> (arglst (n-i) @ l | void) =
(
//
if
i < argc
then let
  val+~list_vt_nil () = !p
  val x = comarg_parse (argv.[i])
  val () =
    !p := list_vt_cons (x, list_vt_nil ())
  val+list_vt_cons (_, !lst) = !p
  val (pf | ()) =
    loop (view@ (!lst) | argv, i+1, lst) // tail-call
  // end of [val]
in
  fold@(!p); (pf0 | ())
end // end of [then]
else (pf0 | ()) // end of [else]
//
) (* end of [loop] *)
//
var lst0 = list_vt_nil{comarg}()
val (pf | ()) = loop (view@ lst0 | argv, 0, &lst0)
prval ((*void*)) = view@ lst0 := pf
//
in
  lst0
end // end of [comarglst_parse]

(* ****** ****** *)

implement
comarg_warning
  (str) = {
//
val () = prerr ("warning(ATS)")
val () = prerr (": unrecognized command line argument [")
val () = prerr (str)
val () = prerr ("] is ignored.")
val () = prerr_newline ((*void*))
//
} (* end of [comarg_warning] *)

(* ****** ****** *)

implement
is_DATS_flag (flag) = 
  if strncmp (flag, "-DATS", 5) = 0 then true else false
// end of [is_DATS_flag]

implement
is_IATS_flag (flag) = 
  if strncmp (flag, "-IATS", 5) = 0 then true else false
// end of [is_IATS_flag]

(* ****** ****** *)

local

fun
string_extract
(
  s: string, k: size_t
) : Stropt = let
  val s =
    string1_of_string(s)
  // end of [val]
  val k = size1_of_size(k)
  val n = string1_length(s)
in
//
if n > k
  then let
    val
    sub =
    string_make_substring(s,k,n-k)
    val sub = string_of_strbuf(sub)
  in
    stropt_some (sub)
  end // end of [then]
  else stropt_none (*void*)
//
end // [string_extract]

in (* in-of-local *)
//
implement
DATS_extract
  (str: string) = string_extract(str, 5)
//
implement
IATS_extract
  (str: string) = string_extract(str, 5)
//
end // end of [local]

(* ****** ****** *)

implement
process_DATS_def
  (def) = let
//
val def = string1_of_string(def)
//
(*
val () =
  println! ("process_DATS_def: def = ", def)
*)
//
val opt =
  $PAR.parse_from_string_parser(def, $PAR.p_datsdef)
//
in
//
case+ opt of
| ~Some_vt(def) => let
    val+$SYN.DATSDEF(key, opt) = def
    val e1xp = (
      case+ opt of
      | Some v => $TRANS1.e0xp_tr (v)
      | None _ => e1xp_none ($LOC.location_dummy)
    ) : e1xp // end of [val]
  in
    $TRENV1.the_e1xpenv_addperv (key, e1xp)
  end // end of [Some_vt]
| ~None_vt((*void*)) => let
    val () =
    prerr ("patsopt: error(0)")
    val () =
    prerrln! (
      ": the command-line argument [", def, "] cannot be properly parsed."
    ) (* end of [prerrln!] *)
  in
    $ERR.abort ((*reachable*))
  end // end of [None_vt]
//
end // end of [process_DATS_def]

(* ****** ****** *)
//
// HX: [ppush] means permanent push
//
implement
process_IATS_dir
  (dir) = let
//
val () = $FIL.the_pathlst_ppush(dir)
val () = $GLOB.the_IATS_dirlst_ppush(dir)
//
(*
// HX-2017-01-31: push from the back!
val () = $FIL.the_pathlst_ppushb(dir)
val () = $GLOB.the_IATS_dirlst_ppushb(dir)
*)
//
in
  // nothing
end (* end of [process_IATS_dir] *)

(* ****** ****** *)

local
//
extern
fun
getenv
(
  name: string
) : Stropt = "ext#getenv"
//
in (* in-of-local *)

implement
process_PATSRELOCROOT() = let
//
val
opt =
get() where
{
//
extern
fun
get
(
// argless
) : Stropt =
  "mac#patsopt_PATSRELOCROOT_get"
// end of [extern]
//
} (* where *) // end of [val]
val
issome = stropt_is_some (opt)
//
val def = (
//
if
issome
then
(
stropt_unsome(opt)
) (* end of [then] *)
else let
//
val
user = getenv("USER")
val
issome = stropt_is_some(user)
val
user = (
//
if issome
  then stropt_unsome(user) else "$USER"
//
) : string // end of [val]
val
PATSRELOCROOT =
  sprintf("/tmp/.PATSRELOCROOT-%s", @(user))
// end of [val]
//
in
  string_of_strptr(PATSRELOCROOT)
end // end of [else]
//
) : string // end of [val]
//
(*
val () =
println!
(
  "process_PATSRELOCROOT: def = ", def
) (* end of [val] *)
*)
//
val key =
  $SYM.symbol_PATSRELOCROOT
val e1xp =
  e1xp_string ($LOC.location_dummy, def)
//
in
  $TRENV1.the_e1xpenv_addperv (key, e1xp)
end // end of [process_PATSRELOCROOT]

end // end of [local]

(* ****** ****** *)

(* end of [pats_comarg.dats] *)

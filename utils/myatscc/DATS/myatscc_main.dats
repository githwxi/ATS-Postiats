(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Start time: April, 2017 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)
//
local
#include "./myatscc_loc_t.dats"
in (* nothing *) end // endlocal
//
local
#include "./myatscc_lexer.dats"
in (* nothing *) end // endlocal
//
local
#include "./myatscc_parser.dats"
in (* nothing *) end // endlocal
//
local
#include "./myatscc_evaler.dats"
in (* nothing *) end // endlocal
//
local
#include "./myatscc_getdef.dats"
in (* nothing *) end // endlocal
//
(* ****** ****** *)
//
local
#include "./myatscc_libats.dats"
in (* nothing *) end // endlocal
//
(* ****** ****** *)

#include
"share/HATS\
/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#staload "./../SATS/myatscc.sats"

(* ****** ****** *)

fun
comarg_parse
(
  arg: string
) : int = let
//
fun
aux
(
 p: ptr, r: int
) : int = let
  val c = $UN.ptr0_get<char>(p)
in
//
if
isneqz(c)
then (
if c = '-'
  then aux(ptr0_succ<char>(p), r+1) else r
// end of [if]
) else (r)
// end of [if]
end // end of [aux]
//
in
  aux(string2ptr(arg), 0)
end // end of [comarg_parse]

(* ****** ****** *)
//
implement
the_name_i_env_initize
  {n}(argc, argv) = let
//
vtypedef
res = List0_vt(gvalue)
//
fun
loop
{i:nat | i <= n}
(
 i: int(i), argv: !argv(n), res: res
) : res =
(
if
(i < argc)
then let
  val arg = argv[i]
in
  if comarg_parse(arg) = 0
    then let
      val arg = GVstring(arg)
      val res = cons_vt(arg, res)
    in
      loop(i+1, argv, res)
    end // end of [then]
    else loop(i+1, argv, res)
end // end of [then]
else res (* end of [else] *)
)
//
val arg = GVstring(argv[0])
val res = list_vt_sing(arg)
val res = loop(1, argv, res)
//
in
//
the_name_i_env_initset
  (list0_of_list_vt(list_vt_reverse(res)))
//
end // end of [the_name_i_env_initize]
//
(* ****** ****** *)
//
(*
HX: see
myatscc_get_def.dats
*)
(*
implement
myatscc_get_def
  ((*void*)) = MYATSCCDEF_def
*)
//
(* ****** ****** *)
//
implement
myatscc_evaldef
  ((*void*)) = let
//
val
def = myatscc_getdef()
//
val
toks = string_tokenize(def)
val
toks = tokenlst_tokenize(toks)
//
val
exps = myexpseq_parse(toks)
//
(*
val () =
exps.foreach()
  (lam(exp) => println!(exp))
*)
//
in
  myexpseq_stringize(g0ofg1(exps))
end // end of [myatscc_get_def]
//
(* ****** ****** *)
//
extern
fun
myatscc_usage
  {n:pos}
(
  argc: int(n), argv: !argv(n)
) : int // end-of-function
//
implement
myatscc_usage
  {n}(argc, argv) = let
//
fun
loop
{i:nat | i <= n}
(
 i: int(i), argv: !argv(n)
) : int =
(
if
(i=argc)
then (0)
else
(
case+ argv[i] of
| "-h" => usage()
| "--help" => usage()
| _(* rest *) => loop(i+1, argv)
)
)
//
and
usage(): int = 1 where
{
val () =
println!("Usage: myatscc [FLAG]... [FILE]...")
val () =
println!("\n\
By supporting embedding as comment some form of scripts\n\
for compilation inside the code to be compiled, [myatscc]\n\
is primarily for simplifying the compilation of ATS source.\n\
")
val () =
println!("The following options are supported:")
val () =
println!("  -h/--help: for printing the help message")
val () =
println!("  --dry/--dryrun: for command generation only")
}
//
in
  (if argc >= 2 then loop(1, argv) else usage())
end // end of [myatscc_usage]
//
(* ****** ****** *)

implement
main(argc, argv) =
myatscc_main(argc, argv) where
{
//
(*
val () =
println!("Hello from [myatscc]!")
*)
//
val done =
  myatscc_usage(argc, argv)
//
val ((*void*)) =
  if done > 0 then exit(0)
//
val ((*void*)) =
  the_myexpfun_map_initize((*void*))
val ((*void*)) =
  the_name_i_env_initize(argc, argv)
//
} (* end of [main] *)

(* ****** ****** *)

local
//
typedef
state = @{
//
dryrun= int
//
} (* state *)
//
#staload
"libats/libc/SATS/stdlib.sats"
//
fun
state_initset
{n:int}
{i:nat|i <= n}
(
  i: int(i)
, argc: int(n)
, argv: !argv(n)
, state: &state >> _
) : void =
(
if
(i < argc)
then let
//
val () =
if
string_is_prefix
  ("--dry", argv[i])
then (state.dryrun := state.dryrun + 1)
//
in
  state_initset(i+1, argc, argv, state)
end // end of [then]
else () // end of [else]
)
//
in (* in-of-local *)

implement
myatscc_main
(
  argc, argv
) = res where {
//
var
state: state
val () =
state.dryrun := 0
//
var res: int = 0
//
var dryrun: bool = false
//
val ((*void*)) =
state_initset(1, argc, argv, state)
//
val ((*void*)) =
(
if
dryrun
then () else (
if state.dryrun > 0 then dryrun := true
) (* end of [if] *)
) (* end of [val] *)
//
val command = myatscc_evaldef()
//
val ((*void*)) =
if dryrun then println! (command) else ()
//
val ((*void*)) =
  if ~(dryrun) then (res := system(command))
//
} // end of [myatscc_main]

end // end of [local]

(* ****** ****** *)

(* end of [myatscc_main.dats] *)

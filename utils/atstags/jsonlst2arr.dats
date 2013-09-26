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
// HX-2013-07:
// [jsonlst2arr] turns a list of json-objects into a json-array of these
// objects. This code sets up an example that shows a way to implement a
// command to be used in a command-line.
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json.sats"
staload _(*anon*) = "{$JSONC}/DATS/json.dats"

(* ****** ****** *)

fun jsonlst2arr_usage
(
  out: FILEref, arg0: string
) : void = let
//
in
//
fprintln! (out, "usage: ", arg0, " <command> ... <command>\n");
fprintln! (out, "where a <command> is of one of the following forms:\n");
//
fprintln! (out, "  -h (for printing out this help usage)");
fprintln! (out, "  --help (for printing out this help usage)");
//
fprintln! (out, "  -i filenames (for compiling (many) static <filenames>)");
fprintln! (out, "  --input filenames (for compiling (many) static <filenames>)");
//
fprintln! (out, "  -o filename (output into <filename>)");
fprintln! (out, "  --output filename (output into <filename>)");
//
fprintln! (out, "  --delim string (for setting delimiter to <string>)");
//
end // end of [jsonlst2arr]

(* ****** ****** *)

extern
fun jsonlst2arr_main
  (out: FILEref, inp: FILEref, delim: string, n: int): int
// end of [jsonlst2arr_main]

(* ****** ****** *)

implement
jsonlst2arr_main
  (out, inp, delim, n) = let
//
vtypedef jobj = json_object0
//
fun auxlst
(
  xs: List_vt (jobj), n: int
) : int = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () =
      if n > 0 then fprint (out, ",\n")
    val () =
    (
      fprint_json_object (out, x); fprint (out, "\n")
    )
    val _(*freed*) = json_object_put (x)
  in
    auxlst (xs, n+1)
  end // end of [list_vt_cons]
| ~list_vt_nil((*void*)) => (n)
//
end // end of [auxlst]
//
val cs =
  fileref_get_file_string (inp)
val xs = json_tokener_parse_list_delim ($UN.strptr2string(cs), delim)
val ((*void*)) = strptr_free (cs)
//
in
  auxlst (xs, n)
end // end of [jsonlst2arr_main]

(* ****** ****** *)

datatype
commarg =
  | CAhelp of ()
  | CAinput of ()
  | CAoutput of stropt
  | CAdelim of stropt
  | CAgitem of string
// end of [commarg]

(* ****** ****** *)

vtypedef commarglst = List0 (commarg)
vtypedef commarglst_vt = List0_vt (commarg)

(* ****** ****** *)

macdef
unsome (opt) = stropt_unsome (,(opt))
macdef
issome (opt) = stropt_is_some (,(opt))

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
//
extern
fun jsonlst2arr_parse
  {n:int} (argc: int n, argv: !argv(n)): commarglst
// 
(* ****** ****** *)

local

typedef ca = commarg

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
| _ when (str0="-h") =>
    aux1_help (n, argv, i, res)
| _ when (str0="--help") =>
    aux1_help (n, argv, i, res)
//
| _ when (str0="-i") =>
    aux1_input (n, argv, i, res)
| _ when (str0="--input") =>
    aux1_input (n, argv, i, res)
//
| _ when (str0="-o") =>
    aux1_output (n, argv, i+1, res)
| _ when (str0="--output") =>
    aux1_output (n, argv, i+1, res)
//
| _ when (str0="--delim") =>
    aux1_delim (n, argv, i+1, res)
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

and aux1_help
  {n:int}
  {i:nat | i < n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val res =
    list_vt_cons{ca}(CAhelp(), res)
  // end of [val]
in
  aux0 (n, argv, i+1, res)
end // end of [aux1_help]

and aux1_input
  {n:int}
  {i:nat | i < n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val res =
    list_vt_cons{ca}(CAinput(), res)
  // end of [val]
in
  aux0 (n, argv, i+1, res)
end // end of [aux1_input]

and aux1_output
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
  val res = list_vt_cons{ca}(CAoutput(opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_output]

and aux1_delim
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
  val res = list_vt_cons{ca}(CAdelim(opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_delim]

in (* in of [local] *)

implement
jsonlst2arr_parse
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
end // end of [jsonlst2arr_commline]

end // end of [local]

(* ****** ****** *)

extern
fun jsonlst2arr_exec
(
  out: stropt, inplst: stringlst_vt, delim: stropt
) : void // end of [jsonlst2arr_exec]
implement
jsonlst2arr_exec
(
  out, inplst, delim
) = let
//
var flag: int = 0
var out2: FILEref = stdout_ref
val ()  =
(
if issome (out) then let
  val opt =
    fileref_open_opt (unsome(out), file_mode_w)
in
  case+ opt of
  | ~Some_vt (x) => (flag := 1; out2 := x)
  | ~None_vt ((*void*)) => out2 := stderr_ref
end else () // end of [if]
) : void // end of [val]
//
val out2 = out2
val delim2 = (
  if issome (delim) then unsome(delim) else ""
) : string // end of [val]
//
fun auxlst
  (inplst: stringlst_vt, n: int): int = let
in
//
case+ inplst of
| ~list_vt_cons
    (inp, inplst) => let
    val opt = fileref_open_opt (inp, file_mode_r)
  in
    case+ opt of
    | ~Some_vt (x) => let
        val n = jsonlst2arr_main (out2, x, delim2, n) in auxlst (inplst, n)
      end // end of [Some_vt]
    | ~None_vt ((*void*)) => auxlst (inplst, n)
  end // end of [list_vt_cons] 
| ~list_vt_nil ((*void*)) => (n)
//
end // end of [auxlst]
//
val () = fprint (out2, "[\n")
//
val nent = (
case+ inplst of
| list_vt_cons _ => auxlst (inplst, 0)
| ~list_vt_nil () =>
    jsonlst2arr_main (out2, stdin_ref, delim2, 0)
) : int // end of [val]
//
val () = fprint (out2, "]\n")
//
val () = if flag > 0 then fileref_close (out2)
//
in
  // nothing
end // end of [jsonlst2arr_exec]

(* ****** ****** *)

extern
fun jsonlst2arr_proc
  (arg0: string, cas: commarglst): void

(* ****** ****** *)

typedef
param = @{
, cmd= string
, out= stropt
, inplst= stringlst
, delim= stropt
, nexec= int
} (* end of [param] *)

implement
jsonlst2arr_proc (arg0, cas) = let
//
fun auxexec
(
  param: &param
) : void = let
//
val out = param.out
val inplst = param.inplst
val inplst = list_reverse (inplst)
val () = param.inplst := list_nil (*void*)
val delim = param.delim
val nexec0 = param.nexec
val () = param.nexec := nexec0 + 1
//
(*
val () = println! ("auxexec: out= ", out)
val () = println! ("auxexec: inplst= ", inplst)
val () = println! ("auxexec: delim= ", delim)
val () = println! ("auxexec: nexec= ", nexec0)
*)
//
in
//
case+ inplst of
| list_vt_cons _ =>
    jsonlst2arr_exec (out, inplst, delim)
| ~list_vt_nil () =>
    if nexec0 = 0 then jsonlst2arr_exec (out, list_vt_nil, delim) else ()
  // end of [list_nil]
//
end // end of [auxexec]
//
fun auxlst
(
  param: &param, cas0: commarglst
) : void = let
in
//
case+ cas0 of
| list_cons
    (ca, cas) =>
  (
    case+ ca of
    | CAhelp () => let
        val (
        ) = jsonlst2arr_usage (stdout_ref, param.cmd)
        val () = param.nexec := param.nexec + 1
      in
        auxlst (param, cas)
      end // end of [CAhelp]
    | CAinput() => auxlst_input (param, cas)
    | CAoutput(opt) => let
        val () = param.out := opt in auxlst (param, cas)
      end // end of [CAoutput]
    | CAdelim(opt) => let
        val () = param.delim := opt in auxlst (param, cas)
      end // end of [CAoutput]
    | CAgitem(str) => auxlst (param, cas)
  )
| list_nil () => auxexec (param)
//
end // end of [auxlst]
//
and auxlst_input
(
  param: &param, cas0: commarglst
) : void = let
in
//
case+ cas0 of
| list_cons
    (ca, cas) =>
  (
    case+ ca of
    | CAgitem (str) => let
        val () =
        param.inplst :=
          list_cons{string}(str, param.inplst)
        // end of [val]
      in
        auxlst_input (param, cas)
      end // end of [CAgitem]
    | _ => let
        val () = auxexec (param) in auxlst (param, cas0)
      end // end of [auxlst_input]
  )
| list_nil () => auxexec (param)
//
end // end of [auxlst_input]
//
var param: param
val () = param.cmd := arg0
val () = param.out := stropt_none ()
val () = param.inplst := list_nil ()
val () = param.delim := stropt_none ()
val () = param.nexec := 0
//
in
  auxlst (param, cas)
end // end of [jsonlst2arr_proc]

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val cas =
  jsonlst2arr_parse (argc, argv)
val-list_cons (_, cas) = cas
//
val ((*void*)) = jsonlst2arr_proc (argv[0], cas)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [jsonlst2arr.dats] *)

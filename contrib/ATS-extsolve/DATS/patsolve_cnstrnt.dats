(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: May, 2015
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME
"patsolve_cnstrnt__dynload"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)
//
#staload
"./../SATS/patsolve_cnstrnt.sats"
//
(* ****** ****** *)
//
implement
fprint_val<stamp> = fprint_stamp
implement
fprint_val<symbol> = fprint_symbol
//
(* ****** ****** *)

implement
print_stamp(x) = fprint_stamp(stdout_ref, x)
implement
prerr_stamp(x) = fprint_stamp(stderr_ref, x)

(* ****** ****** *)
//
implement
print_symbol(x) = fprint_symbol(stdout_ref, x)
implement
prerr_symbol(x) = fprint_symbol(stderr_ref, x)
//
(* ****** ****** *)
//
implement
print_label(x) = fprint_label(stdout_ref, x)
implement
prerr_label(x) = fprint_label(stderr_ref, x)
//
(* ****** ****** *)
//
implement
print_tyreckind(x) = fprint_tyreckind(stdout_ref, x)
implement
prerr_tyreckind(x) = fprint_tyreckind(stderr_ref, x)
//
(* ****** ****** *)
//
implement
fprint_val<s2rt> = fprint_s2rt
implement
fprint_val<s2rtdat> = fprint_s2rtdat
//
implement
fprint_val<s2cst> = fprint_s2cst
implement
fprint_val<s2var> = fprint_s2var
//
implement
fprint_val<s2exp> = fprint_s2exp
implement
fprint_val<labs2exp> = fprint_labs2exp
//
(* ****** ****** *)

implement
fprint_val<s3itm> = fprint_s3itm
implement
fprint_val<h3ypo> = fprint_h3ypo
implement
fprint_val<c3nstr> = fprint_c3nstr

(* ****** ****** *)
//
implement
print_s2rt(x) = fprint_s2rt(stdout_ref, x)
implement
prerr_s2rt(x) = fprint_s2rt(stderr_ref, x)
//
implement
print_s2rtdat(x) = fprint_s2rtdat(stdout_ref, x)
implement
prerr_s2rtdat(x) = fprint_s2rtdat(stderr_ref, x)
//
(* ****** ****** *)
//
implement
print_s2cst(x) = fprint_s2cst(stdout_ref, x)
implement
prerr_s2cst(x) = fprint_s2cst(stderr_ref, x)
//
(* ****** ****** *)
//
implement
print_s2var(x) = fprint_s2var(stdout_ref, x)
implement
prerr_s2var(x) = fprint_s2var(stderr_ref, x)
//
implement
print_s2Var(x) = fprint_s2Var(stdout_ref, x)
implement
prerr_s2Var(x) = fprint_s2Var(stderr_ref, x)
//
(* ****** ****** *)
//
implement
print_s2exp(x) = fprint_s2exp(stdout_ref, x)
implement
prerr_s2exp(x) = fprint_s2exp(stderr_ref, x)
//
implement
print_s2explst(xs) = fprint_s2explst(stdout_ref, xs)
implement
prerr_s2explst(xs) = fprint_s2explst(stderr_ref, xs)
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_stamp.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_label.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_symbol.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_location.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2rt.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2cst.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2var.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2vvar.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2exp.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s3itm.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_h3ypo.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_c3nstr.dats" in (*nothing*)
//
end // end of [local]
//
(* ****** ****** *)

(* end of [patsolve_cnstrnt.dats] *)

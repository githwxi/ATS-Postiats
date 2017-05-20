(*
**
** Author: Hongwei Xi
** Authoremail: (gmhwxiATgmailDOTcom)
** Start Time: July 23, 2016
**
*)

(* ****** ****** *)
//
staload
"./../SATS/libatsyntext.sats"
//
(* ****** ****** *)
//
staload
"./../DATS/libatsyntext.dats"
//
(* ****** ****** *)
//
staload
TRANS1 = "src/pats_trans1.sats"
staload
TRENV1 = "src/pats_trans1_env.sats"
//
(* ****** ****** *)
//
staload
TRANS2 = "src/pats_trans2.sats"
staload
TRENV2 = "src/pats_trans2_env.sats"
//
(* ****** ****** *)

%{^
//
extern void patsopt_PATSHOME_set () ;
extern char *patsopt_PATSHOME_get () ;
//
extern void patsopt_PATSHOMELOCS_set () ;
//
%} // end of [%{^]

(* ****** ****** *)

dynload "./../dynloadall.dats"

(* ****** ****** *)

implement
main() = let
//
val () =
set () where
{ 
  extern
  fun set (): void
    = "mac#patsopt_PATSHOME_set"
  // end of [fun]
} // end of [where] // end of [val]
val () =
set () where
{
  extern
  fun set (): void
    = "mac#patsopt_PATSHOMELOCS_set"
  // end of [fun]
} // end of [where] // end of [val]
//
val
PATSHOME = let
//
val opt = get () where
{
  extern
  fun get (): Stropt = "mac#patsopt_PATSHOME_get"
} (* end of [where] *)
val issome = stropt_is_some (opt)
//
in
//
if (
issome
) then (
  stropt_unsome(opt)
) else let
//
val () =
prerrln!
(
  "The environment variable PATSHOME is undefined!"
) (* end of [val] *)
//
in
  $ERR.abort((*exit*))
end (* end of [else] *)
//
end : string // end of [val]
//
val () =
  $FIL.the_prepathlst_push(PATSHOME)
//
val () = $TRENV1.the_trans1_env_initialize()
val () = $TRENV2.the_trans2_env_initialize()
//
val () =
the_prelude_load
  (PATSHOME) where
{
//
extern
fun
the_prelude_load
(
  PATSHOME: string
) : void =
  "ext#libatsopt_the_prelude_load"
//
} (* end of [where] *)
//
val
d0cs =
parse_from_stdin_toplevel(1)
//
val
(pfenv | ()) =
$TRENV1.the_fxtyenv_push_nil()
//
val
d1cs =
$TRANS1.d0eclist_tr_errck(d0cs)
//
val
fxtymap =
$TRENV1.the_fxtyenv_pop(pfenv | (*none*))
//
val
((*joined*)) =
$TRENV1.the_fxtyenv_pervasive_joinwth(fxtymap)
//
val
d2cs =
$TRANS2.d1eclist_tr_errck(d1cs)
//
in
  syntext_d2eclist(stdout_ref, d2cs)
end // end of [main]

(* ****** ****** *)

(* end of [test02.dats] *)

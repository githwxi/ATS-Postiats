(*
** Session Co-List (Dyadic)
*)

(* ****** ****** *)
//
// HX-2015-07:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "libats2erl_session_"
//
(* ****** ****** *)

staload "./basis.sats"

(* ****** ****** *)
//
(*
datatype
sslist (a:vt@ype) =
| sslist_nil of (nil)
| sslist_cons of (chsnd(a)::sslist(a))
*)
//
abstype sslist(a:vt@ype)
//
(* ****** ****** *)
//
datatype
chanpos_list
  (a:vt@ype, type) =
| chanpos_list_nil(a, nil) of ()
| chanpos_list_cons(a, chsnd(a)::sslist(a)) of ()
//
(* ****** ****** *)
//
fun
chanpos_list{a:vt0p}
  (!chanpos(sslist(a)) >> chanpos(ss)): #[ss:type] chanpos_list(a, ss) = "mac#%"
//
(* ****** ****** *)
//
fun
channeg_list_nil
  {a:vt0p}(!channeg(sslist(a)) >> channeg(nil)): void = "mac#%"
fun
channeg_list_cons
  {a:vt0p}(!channeg(sslist(a)) >> channeg(chsnd(a)::sslist(a))): void = "mac#%"
//
(* ****** ****** *)

(* end of [co-list.sats] *)

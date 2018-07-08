(*
** Session List (Dyadic)
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
channeg_list
  (a:vt@ype, type) =
| channeg_list_nil(a, nil) of ()
| channeg_list_cons(a, chsnd(a)::sslist(a)) of ()
//
(* ****** ****** *)
//
fun
chanpos_list_nil
  {a:vt0p}(!chanpos(sslist(a)) >> chanpos(nil)): void = "mac#%"
fun
chanpos_list_cons
  {a:vt0p}
  (!chanpos(sslist(a)) >> chanpos(chsnd(a)::sslist(a))): void = "mac#%"
//
(* ****** ****** *)
//
fun
channeg_list{a:vt0p}
  (!channeg(sslist(a)) >> channeg(ss)): #[ss:type] channeg_list(a, ss) = "mac#%"
//
(* ****** ****** *)
//
fun
list2sslist{a:t0p}(xs: List(a)): channeg(sslist(a)) = "mac#%"
fun
sslist2list{a:t0p}(chn: channeg(sslist(a))): List0(a) = "mac#%"
//
fun
list2sslist_vt{a:vt0p}(xs: List_vt(a)): channeg(sslist(a)) = "mac#%"
fun
sslist2list_vt{a:vt0p}(chn: channeg(sslist(a))): List0_vt(a) = "mac#%"
//
(* ****** ****** *)

(* end of [list.sats] *)

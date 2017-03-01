(*
** Session List
*)

(* ****** ****** *)

staload "./basis.sats"

(* ****** ****** *)
//
(*
datatype
sslist (a:vt@ype) =
| sslist_nil of (nil)
| sslist_cons of (chsnd(a) :: sslist(a))
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
| channeg_list_cons(a, chsnd(a) :: sslist(a)) of ()
//
(* ****** ****** *)
//
fun{}
chanpos_list_nil
  {a:vt@ype}
  (!chanpos(sslist(a)) >> chanpos(nil)): void
fun{}
chanpos_list_cons
  {a:vt@ype}
  (!chanpos(sslist(a)) >> chanpos(chsnd(a)::sslist(a))): void
//
(* ****** ****** *)
//
fun{}
channeg_list
  {a:vt@ype}(!channeg(sslist(a)) >> channeg(ss)): #[ss:type] channeg_list(a, ss)
//
(* ****** ****** *)
//
fun
{a:t@ype}
list2sslist(List(a)): channeg(sslist(a))
fun
{a:t@ype}
sslist2list(channeg(sslist(a))): List0(a)
//
fun
{a:vt@ype}
list2sslist_vt(List_vt(a)): channeg(sslist(a))
fun
{a:vt@ype}
sslist2list_vt(channeg(sslist(a))): List0_vt(a)
//
(* ****** ****** *)

(* end of [list.sats] *)

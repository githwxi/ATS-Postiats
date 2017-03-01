(*
** Session Co-List
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
chanpos_list
  (a:vt@ype, type) =
| chanpos_list_nil(a, nil) of ()
| chanpos_list_cons(a, chsnd(a) :: sslist(a)) of ()
//
(* ****** ****** *)
//
fun{}
chanpos_list
  {a:vt@ype}
  (!chanpos(sslist(a)) >> chanpos(ss)): #[ss:type] chanpos_list(a, ss)
//
(* ****** ****** *)
//
fun{}
channeg_list_nil
  {a:vt@ype}
  (!channeg(sslist(a)) >> channeg(nil)): void
fun{}
channeg_list_cons
  {a:vt@ype}
  (!channeg(sslist(a)) >> channeg(chsnd(a)::sslist(a))): void
//
(* ****** ****** *)

(* end of [co-list.sats] *)

(*
** Session Array
*)

(* ****** ****** *)

staload "./basis.sats"

(* ****** ****** *)
//
abstype
ssarrsz(a:vt@ype)
abstype
ssarray(a:vt@ype, n:int)
//
(* ****** ****** *)
//
fun{}
chanpos_arrsz
  {a:vt@ype}{n:nat}
  (!chanpos(ssarrsz(a)) >> chanpos(ssarray(a, n)), int(n)): void
//
fun{}
channeg_arrsz
  {a:vt@ype}
  (!channeg(ssarrsz(a)) >> channeg(ssarray(a, n))): #[n:nat] int(n)
//
(* ****** ****** *)
//
praxi
chanpos_array_nil
  {a:vt@ype}
  (!chanpos(ssarray(a, 0)) >> chanpos(nil)): void
praxi
chanpos_array_cons
  {a:vt@ype}{n:pos}
(
  !chanpos(ssarray(a, n)) >> chanpos(chsnd(a)::ssarray(a,n-1))
) : void // end of [chanpos_array_cons]
//
(* ****** ****** *)
//
praxi
channeg_array_nil
  {a:vt@ype}
  (!channeg(ssarray(a, 0)) >> channeg(nil)): void
praxi
channeg_array_cons
  {a:vt@ype}{n:pos}
(
  !channeg(ssarray(a, n)) >> channeg(chsnd(a)::ssarray(a,n-1))
) : void // end of [channeg_array_cons]
//
(* ****** ****** *)
//
fun
{a:t0p}
list2ssarray{n:int}(list(a, n)): channeg(ssarray(a, n))
fun
{a:t0p}
ssarray2list{n:int}(channeg(ssarray(a, n)), int(n)): list(a, n)
//
fun
{a:vt0p}
list2ssarray_vt{n:int}(list_vt(a, n)): channeg(ssarray(a, n))
fun
{a:vt0p}
ssarray2list_vt{n:int}(channeg(ssarray(a, n)), int(n)): list_vt(a, n)
//
(* ****** ****** *)
fun
{a:vt0p}
channeg_array_takeout_list
  {n:int}{i:nat | i <= n}
  (!channeg(ssarray(a, n)) >> channeg(ssarray(a,n-i)), int(i)): list_vt(a, i)
//
(* ****** ****** *)

(* end of [array.sats] *)

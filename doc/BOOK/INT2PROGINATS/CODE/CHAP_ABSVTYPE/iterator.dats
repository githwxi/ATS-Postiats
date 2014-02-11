(*
** Iterator Implementation in ATS
*)

(* ****** ****** *)

sortdef vt0p = viewt@ype

(* ****** ****** *)

absviewtype
iterObj(knd:t@ype, a:viewt@ype+, f:int, r:int)
absviewtype
fiterObj(knd:t@ype, a:viewt@ype+, f:int, r:int, l:addr)

(* ****** ****** *)

extern
praxi iterObj_lemma {knd:t@ype}{a:vt0p}{f,r:int}
  (pobj: !iterObj (knd, a, f, r)): [f >= 0; r >= 0] void
// end of [iterObj_lemma]

(* ****** ****** *)

extern
fun{knd:t@ype}{a:vt0p}
iterObj_takeout_ptr {f,r:int | r > 0} (
  pobj: !iterObj (knd, a, f, r) >> fiterObj (knd, a, f, r, l)
) : #[l:addr] (a @ l | ptr l) // end of [iterObj_takeout_ptr]

extern
prfun fiterObj_addback
  {knd:t@ype}{a:vt0p}{f,r:int}{l:addr} (
  pf: a @ l | pobj: !fiterObj (knd, a, f, r, l) >> iterObj (knd, a, f, r)
) : void // end of [fiterObj_addback]

(* ****** ****** *)

extern
fun{knd:t@ype}{a:vt0p}
iterObj_get_flength {f,r:int}
  (pobj: !iterObj (knd, a, f, r)): size_t (f)
// end of [iterObj_get_flength]

extern
fun{knd:t@ype}{a:vt0p}
iterObj_get_rlength {f,r:int}
  (pobj: !iterObj (knd, a, f, r)): size_t (r)
// end of [iterObj_get_rlength]

(* ****** ****** *)

extern
fun{knd:t@ype}{a:vt0p}
iterObj_is_at_end {f,r:int}
  (pobj: !iterObj (knd, a, f, r)): bool (r==0)
// end of[iterObj_is_at_end]
extern
fun{knd:t@ype}{a:vt0p}
iterObj_isnot_at_end {f,r:int}
  (pobj: !iterObj (knd, a, f, r)): bool (r > 0)
// end of[iterObj_isnot_at_end]

extern
fun{knd:t@ype}{a:vt0p}
iterObj_is_at_beg {f,r:int}
  (pobj: !iterObj (knd, a, f, r)): bool (f==0)
// end of[iterObj_is_at_beg]
extern
fun{knd:t@ype}{a:vt0p}
iterObj_isnot_at_beg {f,r:int}
  (pobj: !iterObj (knd, a, f, r)): bool (f > 0)
// end of[iterObj_isnot_at_beg]

(* ****** ****** *)

extern
fun{knd:t@ype}{a:vt0p}
iterObj_next {f,r:int | r > 0} (
  pobj: !iterObj (knd, a, f, r) >> iterObj (knd, a, f+1, r-1)
) : void // end of[iterObj_next]

extern
fun{knd:t@ype}{a:vt0p}
iterObj_prev {f,r:int | f > 0} (
  pobj: !iterObj (knd, a, f, r) >> iterObj (knd, a, f-1, r+1)
) : void // end of[iterObj_prev]

(* ****** ****** *)

extern
fun{knd:t@ype}{a:vt0p}
iterObj_foreach_funenv
  {v:view} {vt:viewtype} {f,r:int} (
  pfv: !v
| pobj: !iterObj (knd, a, f, r) >> iterObj (knd, a, f+r, 0)
, f: (!v | &a, !vt) -<fun> void
, env: !vt
) : void // end of[iterObj_foreach_funenv]

implement{knd}{a}
iterObj_foreach_funenv
  (pfv | pobj, f, env) = let
  prval () = iterObj_lemma {knd}{a} (pobj)
in
  if iterObj_isnot_at_end (pobj) then let
    val (pfat | p) = iterObj_takeout_ptr<knd><a> (pobj)
    val () = f (pfv | !p, env)
    prval () = fiterObj_addback (pfat | pobj)
  in
    iterObj_foreach_funenv (pfv | pobj, f, env)
  end else ((*done*))
end // end of [iterObj_foreach_funenv]

(* ****** ****** *)

abst@ype
iterknd_array(l:addr) = $extype "iterknd_array"
extern
fun iterObj_make_array
  {a:vt0p}{n:int}{l:addr} (
  pfarr: array_v (a, n, l) | p: ptr l, n: size_t n
) : iterObj (iterknd_array(l), a, 0, n)

extern
fun iterObj_free_array
  {a:vt0p}{f,r:int}{l:addr} (
  pobj: iterObj (iterknd_array(l), a, f, r)
) : (array_v (a, f+r, l) | void)

(* ****** ****** *)

extern
fun{a:viewt@ype}
array_ptr_foreach_funenv
  {v:view} {vt:viewtype} {n:nat} (
  pfv: !v
| base: &(@[a][n])
, f: (!v | &a, !vt) -<fun> void
, asz: size_t n
, env: !vt
) : void
  = "atspre_array_ptr_foreach_funenv_tsz"
// end of [fun]

implement{a}
array_ptr_foreach_funenv
  {v}{vt}{n} (
  pfv | base, f, asz, env
) = let
  stavar l:addr
  val p_base = &base : ptr (l)
  typedef knd = iterknd_array (l)
  prval pfarr = view@ (base)
  val pobj = iterObj_make_array {a} (pfarr | &base, asz)
  val () = iterObj_foreach_funenv<knd><a> (pfv | pobj, f, env)
  val (pfarr | ()) = iterObj_free_array (pobj)
  prval () = view@ (base) := pfarr
in
  // nothing
end // end of [array_ptr_foreach_funenv]

(* ****** ****** *)

(* end of [iterator.dats] *)

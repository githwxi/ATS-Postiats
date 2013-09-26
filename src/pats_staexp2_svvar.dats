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
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload
CNTR = "./pats_counter.sats"
staload STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp
overload compare with $STMP.compare_stamp_stamp

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

typedef
s2Var_struct = @{
  s2Var_loc= location
, s2Var_cnt= $CNTR.count // the count
, s2Var_srt= s2rt  // the sort
(*
, s2Var_varknd= int // derived from tyvarknd
*)
(*
, s2Var_skexp= s2kexp // skeleton
*)
, s2Var_link= s2expopt // solution
, s2Var_svar= s2varopt // instantiated static var
, s2Var_szexp= s2zexp // unique size
, s2Var_sVarlst= ptr(*s2Varlst*) // exist. vars in its solution
, s2Var_lbs= s2VarBoundlst // lower bounds
, s2Var_ubs= s2VarBoundlst // upper bounds
, s2Var_stamp= stamp // uniqueness
} // end of [s2Var_struct]

(* ****** ****** *)

val the_s2Var_name_counter = $CNTR.counter_make ()

(* ****** ****** *)

local

assume s2Var_type = ref (s2Var_struct)

in // in of [local]

implement
s2Var_make_srt (loc, s2t) = let
//
val cnt = $CNTR.counter_getinc (the_s2Var_name_counter)
val stamp = $STMP.s2Var_stamp_make ()
val (pfgc, pfat | p) = ptr_alloc<s2Var_struct> ()
prval () = free_gc_elim {s2Var_struct?} (pfgc)
//
val () = begin
p->s2Var_loc := loc;
p->s2Var_cnt := cnt;
p->s2Var_srt := s2t;
(*
p->s2Var_varknd := 0;
*)
p->s2Var_link := None ();
p->s2Var_svar := None ();
p->s2Var_szexp :=
  S2ZEVar ($UN.cast{s2Var}(p));
//
p->s2Var_sVarlst := $UN.cast{ptr}(list_nil);
//
p->s2Var_lbs := list_nil ();
p->s2Var_ubs := list_nil ();
//
p->s2Var_stamp := stamp;
//
end // end of [val]
//
in
//
ref_make_view_ptr {s2Var_struct} (pfat | p)
//
end // end of [s2Var_make_srt]

implement s2Var_make_var (loc, s2v) = let
//
val cnt = $CNTR.counter_getinc (the_s2Var_name_counter)
val stamp = $STMP.s2Var_stamp_make ()
val s2t = s2var_get_srt s2v
val (pfgc, pfat | p) = ptr_alloc_tsz {s2Var_struct} (sizeof<s2Var_struct>)
prval () = free_gc_elim {s2Var_struct?} (pfgc)
//
val () = begin
p->s2Var_loc := loc;
p->s2Var_cnt := cnt;
p->s2Var_srt := s2t;
(*
p->s2Var_varknd := 0;
*)
p->s2Var_link := None ();
p->s2Var_svar := None ();
p->s2Var_szexp :=
  S2ZEVar ($UN.cast {s2Var}(p));
//
p->s2Var_sVarlst := $UN.cast{ptr}(list_nil);
//
p->s2Var_lbs := list_nil ();
p->s2Var_ubs := list_nil ();
//
p->s2Var_stamp := stamp;
//
end // end of [val]
//
in
//
ref_make_view_ptr {s2Var_struct} (pfat | p)
//
end // end of [s2Var_make_var]

(* ****** ****** *)

implement
s2Var_get_cnt (s2V) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_cnt
end // end of [s2Var_get_sym]

implement
s2Var_get_srt (s2V) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_srt
end // end of [s2Var_get_srt]

implement
s2Var_get_link (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_link
end // end of [s2Var_get_link]
implement
s2Var_set_link (s2V, link) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_link := link
end // end of [s2Var_set_link]

implement
s2Var_get_szexp (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_szexp
end // end of [s2Var_get_szexp]
implement
s2Var_set_szexp (s2V, s2ze) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_szexp := s2ze
end // end of [s2Var_set_szexp]

implement
s2Var_get_sVarlst (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V)
in
  $UN.cast{s2Varlst}(p->s2Var_sVarlst)
end // end of [s2Var_get_sVarlst]
implement
s2Var_add_sVarlst (s2V, s2V2) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V)
  val s2Vs2 = $UN.cast{s2Varlst}(p->s2Var_sVarlst)
in
  p->s2Var_sVarlst := $UN.cast{ptr}(list_cons(s2V2, s2Vs2))
end // end of [s2Var_add_sVarlst]

implement
s2Var_get_lbs (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_lbs
end // end of [s2Var_get_lbs]
implement
s2Var_set_lbs (s2V, lbs) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_lbs := lbs
end // end of [s2Var_set_lbs]
implement
s2Var_get_ubs (s2V) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_ubs
end // end of [s2Var_get_ubs]
implement
s2Var_set_ubs (s2V, ubs) = let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_ubs := ubs
end // end of [s2Var_set_ubs]

implement
s2Var_get_stamp (s2V) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (s2V) in p->s2Var_stamp
end // end of [s2Var_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
s2Varlst_add_sVarlst
  (s2Vs, s2V2) = let
in
  case+ s2Vs of
  | list_cons
      (s2V, s2Vs) => let
      val () =
        s2Var_add_sVarlst (s2V, s2V2)
      // end of [val]
    in
      s2Varlst_add_sVarlst (s2Vs, s2V2)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [s2Varlst_add_sVarlst]

(* ****** ****** *)

local

assume
s2VarBound_type = '{
  s2VarBound_loc= location, s2VarBound_val= s2exp
} // end of [s2VarBound_type]

in // in of [local]

implement
s2VarBound_make (loc, s2f) = '{
  s2VarBound_loc= loc, s2VarBound_val= s2f
} // end of [s2VarBound_make]

implement s2VarBound_get_loc (x) = x.s2VarBound_loc
implement s2VarBound_get_val (x) = x.s2VarBound_val

end // end of [local]

(* ****** ****** *)

implement
lt_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) < 0)
// end of [lt_s2Var_s2Var]

implement
lte_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) <= 0)
// end of [lte_s2Var_s2Var]

implement
eq_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) = 0)
// end of [eq_s2Var_s2Var]

implement
neq_s2Var_s2Var
  (x1, x2) = (compare (x1, x2) != 0)
// end of [neq_s2Var_s2Var]

implement
compare_s2Var_s2Var (x1, x2) = let
(*
  val () = $effmask_all (
    print "compare_s2var_s2var: x1 = "; print_s2var x1; print_newline ();
    print "compare_s2var_s2var: x2 = "; print_s2var x2; print_newline ();
  ) // end of [val]
*)
in
  compare (s2Var_get_stamp (x1), s2Var_get_stamp (x2))
end // end of [compare_s2Var_s2Var]

(* ****** ****** *)

implement
fprint_s2Var (out, s2V) = let
  val () = $CNTR.fprint_count (out, s2Var_get_cnt s2V)
(*
  val () = fprint_string (out, "(")
  val () = $STMP.fprint_stamp (out, s2Var_get_stamp s2V)
  val () = fprint_string (out, ")")
*)
in
  // empty
end // end of [fprint_s2Var]

implement
print_s2Var (s2V) = fprint_s2Var (stdout_ref, s2V)
implement
prerr_s2Var (s2V) = fprint_s2Var (stderr_ref, s2V)

(* ****** ****** *)

local
//
%{^
typedef ats_ptr_type s2Var ;
%} // end of [%{^]
//
staload SET =
"libats/SATS/funset_avltree.sats"
staload _(*anon*) =
"libats/DATS/funset_avltree.dats"
//
assume s2Varset_type = $SET.set (s2Var)
//
abstype s2Var1 = $extype "s2Var"
typedef s2Var1set = $SET.set (s2Var1)
//
extern castfn of_s2Var (x: s2Var):<> s2Var1
extern castfn to_s2Var (x: s2Var1):<> s2Var
extern castfn of_s2Varset (x: s2Varset):<> s2Var1set
extern castfn to_s2Varset (x: s2Var1set):<> s2Varset
//
val cmp = $extval ($SET.cmp(s2Var1), "0")

implement
$SET.compare_elt_elt<s2Var1> (x1, x2, cmp) =
  compare_s2Var_s2Var (to_s2Var(x1), to_s2Var(x2))
// end of [implement]

in // in of [local]

implement
s2Varset_make_nil () = $SET.funset_make_nil ()

implement
s2Varset_add
  (xs, x) = xs where {
  val x = of_s2Var (x)
  var xs = of_s2Varset (xs)
  val _(*replaced*) = $SET.funset_insert<s2Var1> (xs, x, cmp)
  val xs = to_s2Varset (xs)
} // end of [s2Varset_add]

implement
s2Varset_is_member
  (xs, x) = found where {
  val x = of_s2Var (x)
  var xs = of_s2Varset (xs)
  val found = $SET.funset_is_member<s2Var1> (xs, x, cmp)
} // end of [s2Varset_is_member]

implement
s2Varset_listize (xs) = let
  val xs = of_s2Varset (xs)
  viewtypedef res = List_vt (s2Var)
in
  $UN.castvwtp_trans{res}($SET.funset_listize<s2Var1> (xs))
end // end of [s2Varset_listize]

end // end of [local]

(* ****** ****** *)

implement
fprint_s2Varlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s2Var)
// end of [fprint_s2Varlst]

implement
print_s2Varlst (xs) = fprint_s2Varlst (stdout_ref, xs)
implement
prerr_s2Varlst (xs) = fprint_s2Varlst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s2Varset
  (out, xs) = () where {
  val xs = s2Varset_listize (xs)
  val () = fprint_string (out, "[")
  val () = fprint_s2Varlst (out, $UN.linlst2lst (xs))
  val () = fprint_string (out, "]")
  val () = list_vt_free (xs)
} // end of [fprint_s2Varset]

implement
print_s2Varset (xs) = fprint_s2Varset (stdout_ref, xs)
implement
prerr_s2Varset (xs) = fprint_s2Varset (stderr_ref, xs)

(* ****** ****** *)

(* end of [pats_staexp2_svvar.dats] *)

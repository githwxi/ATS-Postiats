local

extern
fun d1exp_arity_check (d1e: d1exp, ns: List int): bool
implement
d1exp_arity_check (d1e, ns) = let
//
  fn* aux1 (d1e: d1exp, ns: List int): bool = begin
    case+ ns of list_cons (n, ns) => aux2 (d1e, n, ns) | list_nil () => true
  end // end of [aux1]
//
  and aux2 (
    d1e: d1exp, n: int, ns: List int
  ) : bool = let
(*
    print "d1exp_arith_check: n = "; print n; print_newline ();
    print "d1exp_arith_check: d1e = "; print_d1exp d1e; print_newline ();
*)
  in
    case+ d1e.d1exp_node of
    | D1Elam_dyn (_(*lin*), p1t, d1e) => let
        val narg = (case+ p1t.p1at_node of
          | P1Tlist (_(*npf*), p1ts) => list_length (p1ts) | _ => 1
        ) : int // end of [val]
      in
        if (n = narg) then aux1 (d1e, ns) else false
      end // end of [D1Elam_dyn]
    | D1Elam_met (_(*loc*), _(*met*), d1e) => aux2 (d1e, n, ns)
    | D1Elam_sta_ana (_(*loc*), _(*s1as*), d1e) => aux2 (d1e, n, ns)
    | D1Elam_sta_syn (_(*loc*), _(*s1qs*), d1e) => aux2 (d1e, n, ns)
    | _ => false
  end // end of [aux2]
//
in
  aux1 (d1e, ns)
end // end of [d1exp_arity_check]

extern
fun i1mpdec_select_d2cst
  (d1c: i1mpdec, d2is: d2itmlst): List_vt (d2cst)
implement
i1mpdec_select_d2cst
  (d1c, d2is) = let
  fun auxsel (
    d2is: d2itmlst
  ) :<cloref1> List_vt (d2cst) = begin
    case+ d2is of
    | list_cons (d2i, d2is) => begin case+ d2i of
      | D2ITMcst d2c => let
          val ns = d2cst_get_arylst (d2c)
          val test = d1exp_arity_check (d1c.i1mpdec_def, ns)
        in 
          if test then
            list_vt_cons (d2c, auxsel (d2is)) else auxsel (d2is)
          // end of [if]
        end
      | _ => auxsel (d2is)
      end // end of [list_cons]
    | list_nil () => list_vt_nil ()
  end // end of [aux]
in
  auxsel (d2is)
end // end of [i1mpdec_tr_d2cst_select]

extern
fun i1mpdec_find_d2cst
  (d1c: i1mpdec): Option_vt (d2cst)
implement
i1mpdec_find_d2cst (d1c) = let
  val qid = d1c.i1mpdec_qid
  val dq = qid.impqi0de_qua and id = qid.impqi0de_sym
  val ans = the_d2expenv_find_qua (dq, id)
//
fn auxerr1
  (qid: impqi0de): void = let
  val dq = qid.impqi0de_qua
  and id = qid.impqi0de_sym
  val () = prerr_error2_loc (qid.impqi0de_loc)
  val () = prerr ": no dynamic constant referred to by ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] can be found that matches the given implementation."
  val () = prerr_newline ()
in
  // nothing
end // end if [auxerr1]
fn auxerr2
  (qid: impqi0de): void = let
  val dq = qid.impqi0de_qua
  and id = qid.impqi0de_sym
  val () = prerr_error2_loc (qid.impqi0de_loc)
  val () = prerr ": the dynamic identifier ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] does not refer to any declared dynamic constant."
  val () = prerr_newline ()
in
  // nothing
end // end if [auxerr2]
fn auxerr3
  (qid: impqi0de): void = let
  val dq = qid.impqi0de_qua
  and id = qid.impqi0de_sym
  val () = prerr_error2_loc (qid.impqi0de_loc)
  val () = prerr ": the dynamic identifier ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
in
  // nothing
end // end if [auxerr3]
//
in
//
case+ ans of
| ~Some_vt d2i => (
  case+ d2i of
  | D2ITMcst d2c => Some_vt (d2c)
  | D2ITMsymdef (d2is) => let
      val d2cs = i1mpdec_select_d2cst (d1c, d2is)
    in
      case+ d2cs of
      | ~list_vt_cons (d2c, d2cs) => let
          val () = list_vt_free (d2cs) in Some_vt (d2c)
        end // end of [list_vt_cons]
      | ~list_vt_nil () => let
          val () = auxerr1 (qid) in None_vt ()
        end // end of [list_vt_nil]
    end
  | _ => let
      val () = auxerr2 (qid) in None_vt ()
    end // end of [_]
  ) // end of [Some_vt]
| ~None_vt () => let
    val () = auxerr3 (qid) in None_vt ()
  end // end of [None_vt]
//
end // end of [i1mpdec_find_d2cst]

in

fun i1mpdec_tr_d2cst (
  loc0: location, i1mparg: s1arglstlst, d1c: i1mpdec, d2c: d2cst
) : i2mpdec = let
//
fn auxerr1 (
  loc0: location, dq: d0ynq, id: symbol
) : void = let
  val () = prerr_error2_loc (loc0)
  val () = prerr ": the implementation for ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] should be applied to more template arguments."
  val () = prerr_newline ()
in
  // nothing
end // end of [auxerr1]
fn auxerr2 (
  loc0: location, dq: d0ynq, id: symbol
) : void = let
  val () = prerr_error2_loc (loc0)
  val () = prerr ": the implementation for ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] should be applied to less template arguments."
  val () = prerr_newline ()
in
  // nothing
end // end of [auxerr2]
//
fun auximp (
  args: s1marglst
, s2qss: s2qualstlst
, s2e: s2exp
, out_imp: &s2qualstlst
, err: &int
) :<cloref1> s2exp = begin case+ args of
| list_cons (arg, args) => begin case+ s2qss of
  | list_cons (s2qs, s2qss) => let
      var sub = stasub_make_nil ()
      val (s2vs, sub) = s1marg_bind_svarlst (arg, s2qs.0, sub)
      val () = the_s2expenv_add_svarlst s2vs
      val s2ps = s2explst_subst (sub, s2qs.1)
      val s2qs = (s2vs, s2ps)
      val () = out_imp := list_cons (s2qs, out_imp)
      val s2e = s2exp_subst (sub, s2e)
    in
      auximp (args, s2qss, s2e, out_imp, err)
    end // end of [list_cons]
  | list_nil () => (err := err + 1; s2e)
  end // end of [list_cons]
| list_nil () => let
    val () = case+ s2qss of
      | list_cons _ => (err := err - 1) | list_nil _ => ()
   in
      s2e // HX: no automatic instantiation
   end // end of [list_nil]
  end // end of [auximp]
//
fun auxtmp (
  args: t1mpmarglst
, s2qss: s2qualstlst
, s2e: s2exp
, out_tmparg: &s2explstlst
, out_tmpgua: &s2explstlst
, err: &int
) :<cloptr1> s2exp = begin case+ args of
| list_cons (arg, args) => begin case+ s2qss of
  | list_cons (s2qs, s2qss) => let
      var sub = stasub_make_nil ()
      val (s2es, sub) = t1mpmarg_bind_svarlst (arg, s2qs.0, sub)
      val s2ps = s2explst_subst (sub, s2qs.1)
      val s2e = s2exp_subst (sub, s2e)
      val () = out_tmparg := list_cons (s2es, out_tmparg)
      val () = out_tmpgua := list_cons (s2ps, out_tmpgua)
    in
      auxtmp (args, s2qss, s2e, out_tmparg, out_tmpgua, err)
    end // end of [list_cons]
  | list_nil () => (err := err + 1; s2e)
  end // end of [list_cons]
| list_nil () => let
    val () = case+ s2qss of
      | list_cons _ => (err := err - 1) | list_nil () => ()
    // end of [val]
  in
    s2e // no automatic instantiation
  end // end of [list_nil]
end // end of [auxtmp]
//
in
end // end of [i1mpdec_tr_d2cst]


end // end of [local]

(* ****** ****** *)


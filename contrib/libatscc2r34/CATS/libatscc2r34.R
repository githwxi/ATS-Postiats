######
#
# Prelude for atscc2r34
#
######

assign("libatscc2r34.is.loaded", TRUE)

######

ATSCKiseqz <-
function(x) { return (x == 0) }
ATSCKisneqz <-
function(x) { return (x != 0) }

######

ATSCKptrisnull <-
function(xs) { return(is.null(xs)) }
ATSCKptriscons <-
function(xs) { return(!is.null(xs)) }

######

ATSCKpat_int <-
function(tmp, given) { return(tmp == given) }
ATSCKpat_bool <-
function(tmp, given) { return(tmp == given) }
ATSCKpat_float <-
function(tmp, given) { return(tmp == given) }
ATSCKpat_string <-
function(tmp, given) { return(tmp == given) }

######

ATSCKpat_con0 <-
function(con, tag) { return(con == tag) }
ATSCKpat_con1 <-
function(con, tag) { return(con[[1]] == tag) }

######

ATSINScaseof_fail <-
function(errmsg) { stop(errmsg) }

######

ATSINSdeadcode_fail <-
function() { stop("ATSINSdeadcode_fail()") }

######

ATSPMVempty <-
function() { return(NULL) }

######

ATSPMVlazyval <-
function(thunk) { return(list(0, thunk)) }

######

ATSPMVlazyval_eval <-
function(lazyval) {
##
##flag, mythunk;
##
  flag = lazyval[[1]];
##
  if(flag==0)
  {
    lazyval[[1]] = 1;
    mythunk = lazyval[[2]];
    lazyval[[2]] = mythunk[[1]](mythunk);
  } else {
    lazyval[[1]] = flag + 1;
  } ## end of [if]
##
  return (lazyval[[2]]);
##
} ## end of [ATSPMVlazyval_eval]

######

ATSPMVllazyval <-
function(thunk){ return(thunk) }

ATSPMVllazyval_eval <-
function(llazyval) {
  return(llazyval[[1]](llazyval, TRUE))
} ## end of [ATSPMVllazyval_eval]

atspre_lazy_vt_free <-
function(llazyval) {
  return (llazyval[[1]](llazyval, FALSE))
} ## end of [atspre_lazy_vt_free]

######

######
#
# integer
#
######

ats2r34pre_succ_int0 <-
function(arg0) { return(arg0 + 1) }
ats2r34pre_pred_int0 <-
function(arg0) { return(arg0 - 1) }

ats2r34pre_add_int0_int0 <-
function(arg0,arg1) { return(arg0 + arg1) }
ats2r34pre_sub_int0_int0 <-
function(arg0,arg1) { return(arg0 - arg1) }
ats2r34pre_mul_int0_int0 <-
function(arg0,arg1) { return(arg0 * arg1) }
ats2r34pre_mod_int0_int0 <-
function(arg0,arg1) { return(arg0 %% arg1) }
ats2r34pre_div_int0_int0 <-
function(arg0,arg1) { return(arg0 %/% arg1) }

######

ats2r34pre_succ_int1 <-
function(arg0) { return(arg0 + 1) }
ats2r34pre_pred_int1 <-
function(arg0) { return(arg0 - 1) }

ats2r34pre_add_int1_int1 <-
function(arg0,arg1) { return(arg0 + arg1) }
ats2r34pre_sub_int1_int1 <-
function(arg0,arg1) { return(arg0 - arg1) }
ats2r34pre_mul_int1_int1 <-
function(arg0,arg1) { return(arg0 * arg1) }
ats2r34pre_mod_int1_int1 <-
function(arg0,arg1) { return(arg0 %% arg1) }
ats2r34pre_div_int1_int1 <-
function(arg0,arg1) { return(arg0 %/% arg1) }

ats2r34pre_nmod_int1_int1 <-
function(arg0,arg1) { return(arg0 %% arg1) }

######
  
ats2r34pre_lt_int0_int0 <-
function(arg0,arg1) { return(arg0 < arg1) }
ats2r34pre_lte_int0_int0 <-
function(arg0,arg1) { return(arg0 <= arg1) }

ats2r34pre_gt_int0_int0 <-
function(arg0,arg1) { return(arg0 > arg1) }
ats2r34pre_gte_int0_int0 <-
function(arg0,arg1) { return(arg0 >= arg1) }

ats2r34pre_eq_int0_int0 <-
function(arg0,arg1) { return(arg0 == arg1) }
ats2r34pre_neq_int0_int0 <-
function(arg0,arg1) { return(arg0 != arg1) }

######

ats2r34pre_lt_int1_int1 <-
function(arg0,arg1) { return(arg0 < arg1) }
ats2r34pre_lte_int1_int1 <-
function(arg0,arg1) { return(arg0 <= arg1) }

ats2r34pre_gt_int1_int1 <-
function(arg0,arg1) { return(arg0 > arg1) }
ats2r34pre_gte_int1_int1 <-
function(arg0,arg1) { return(arg0 >= arg1) }

ats2r34pre_eq_int1_int1 <-
function(arg0,arg1) { return(arg0 == arg1) }
ats2r34pre_neq_int1_int1 <-
function(arg0,arg1) { return(arg0 != arg1) }

######

ats2r34pre_print_int <-
function(x) { return(cat(x)) }
ats2r34pre_print_double <-
function(x) { return(cat(x)) }
ats2r34pre_print_string <-
function(x) { return(cat(x)) }

ats2r34pre_print_newline <-
function() { cat("\n"); utils::flush.console(); return(NULL) }

###### end of [libatscc2r34.R] ######

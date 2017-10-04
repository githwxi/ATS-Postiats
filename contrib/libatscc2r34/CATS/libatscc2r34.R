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

ats2r34pre_cloref0_app <-
function(cf)
  { return(cf[[1]](cf)); }
ats2r34pre_cloref1_app <-
function(cf, x)
  { return(cf[[1]](cf, x)); }
ats2r34pre_cloref2_app <-
function(cf, x1, x2)
  { return(cf[[1]](cf, x1, x2)); }
ats2r34pre_cloref3_app <-
function(cf, x1, x2, x3)
  { return(cf[[1]](cf, x1, x2, x3)); }

######

ats2r34pre_cloref2fun0 <-
function(cf) {
  return(
    function()
      {return(ats2r34pre_cloref0_app(cf))}
  )
}
ats2r34pre_cloref2fun1 <-
function(cf) {
  return(
    function(x)
      {return(ats2r34pre_cloref1_app(cf, x))}
  )
}
ats2r34pre_cloref2fun2 <-
function(cf) {
  return(
    function(x1, x2)
      {return(ats2r34pre_cloref2_app(cf, x1, x2))}
  )
}
ats2r34pre_cloref2fun3 <-
function(cf) {
  return(
    function(x1, x2, x3)
      {return(ats2r34pre_cloref3_app(cf, x1, x2, x3))}
  )
}

######

ats2r34pre_assert_errmsg_bool0 <-
function(claim, errmsg) {
  if(!claim) { stop(errmsg) }; return(NULL)
}
ats2r34pre_assert_errmsg_bool1 <-
  ats2r34pre_assert_errmsg_bool0
  
######

######
#
# integer
#
######

######

ats2r34pre_neg_int0 <-
function(x) { return(-x) }
ats2r34pre_abs_int0 <-
function(x) { return(abs(x)) }

ats2r34pre_succ_int0 <-
function(x) { return(x + 1) }
ats2r34pre_pred_int0 <-
function(x) { return(x - 1) }

ats2r34pre_add_int0_int0 <-
function(x,y) { return(x + y) }
ats2r34pre_sub_int0_int0 <-
function(x,y) { return(x - y) }
ats2r34pre_mul_int0_int0 <-
function(x,y) { return(x * y) }
ats2r34pre_mod_int0_int0 <-
function(x,y) { return(x %% y) }
ats2r34pre_div_int0_int0 <-
function(x,y) { return(x %/% y) }

######

ats2r34pre_succ_int1 <-
function(x) { return(x + 1) }
ats2r34pre_pred_int1 <-
function(x) { return(x - 1) }

ats2r34pre_add_int1_int1 <-
function(x,y) { return(x + y) }
ats2r34pre_sub_int1_int1 <-
function(x,y) { return(x - y) }
ats2r34pre_mul_int1_int1 <-
function(x,y) { return(x * y) }
ats2r34pre_mod_int1_int1 <-
function(x,y) { return(x %% y) }
ats2r34pre_div_int1_int1 <-
function(x,y) { return(x %/% y) }

ats2r34pre_nmod_int1_int1 <-
function(x,y) { return(x %% y) }

######
  
ats2r34pre_lt_int0_int0 <-
function(x,y) { return(x < y) }
ats2r34pre_lte_int0_int0 <-
function(x,y) { return(x <= y) }

ats2r34pre_gt_int0_int0 <-
function(x,y) { return(x > y) }
ats2r34pre_gte_int0_int0 <-
function(x,y) { return(x >= y) }

ats2r34pre_eq_int0_int0 <-
function(x,y) { return(x == y) }
ats2r34pre_neq_int0_int0 <-
function(x,y) { return(x != y) }

######

ats2r34pre_lt_int1_int1 <-
function(x,y) { return(x < y) }
ats2r34pre_lte_int1_int1 <-
function(x,y) { return(x <= y) }

ats2r34pre_gt_int1_int1 <-
function(x,y) { return(x > y) }
ats2r34pre_gte_int1_int1 <-
function(x,y) { return(x >= y) }

ats2r34pre_eq_int1_int1 <-
function(x,y) { return(x == y) }
ats2r34pre_neq_int1_int1 <-
function(x,y) { return(x != y) }

######

######
#
# booleans
#
######

ats2r34pre_int2bool0 <-
function(x) { return(x != 0) }
ats2r34pre_int2bool1 <-
function(x) { return(x != 0) }

######

ats2r34pre_bool2int0 <-
function(x) { return(if(x) 1 else 0) }
ats2r34pre_bool2int1 <-
function(x) { return(if(x) 1 else 0) }

######

ats2r34pre_neg_bool0 <-
  function(x) { return(!x) }
ats2r34pre_neg_bool1 <-
  function(x) { return(!x) }

######

ats2r34pre_add_bool0_bool0 <-
  function(x, y) { return (x || y) }
ats2r34pre_add_bool0_bool1 <-
  function(x, y) { return (x || y) }
ats2r34pre_add_bool1_bool0 <-
  function(x, y) { return (x || y) }
ats2r34pre_add_bool1_bool1 <-
  function(x, y) { return (x || y) }

######

ats2r34pre_mul_bool0_bool0 <-
  function(x, y) { return (x && y) }
ats2r34pre_mul_bool0_bool1 <-
  function(x, y) { return (x && y) }
ats2r34pre_mul_bool1_bool0 <-
  function(x, y) { return (x && y) }
ats2r34pre_mul_bool1_bool1 <-
  function(x, y) { return (x && y) }

######

######
#
# floating points
#
######

######

ats2r34pre_succ_double <-
function(x) { return(x + 1) }
ats2r34pre_pred_double <-
function(x) { return(x - 1) }

######

ats2r34pre_add_int_double <-
function(x,y) { return(x + y) }
ats2r34pre_add_double_int <-
function(x,y) { return(x + y) }

ats2r34pre_sub_int_double <-
function(x,y) { return(x - y) }
ats2r34pre_sub_double_int <-
function(x,y) { return(x - y) }

ats2r34pre_mul_int_double <-
function(x,y) { return(x * y) }
ats2r34pre_mul_double_int <-
function(x,y) { return(x * y) }

ats2r34pre_div_int_double <-
function(x,y) { return(x / y) }
ats2r34pre_div_double_int <-
function(x,y) { return(x / y) }

######

ats2r34pre_add_double_double <-
function(x,y) { return(x + y) }

ats2r34pre_sub_double_double <-
function(x,y) { return(x - y) }

ats2r34pre_mul_double_double <-
function(x,y) { return(x * y) }

ats2r34pre_div_double_double <-
function(x,y) { return(x / y) }

######

ats2r34pre_lt_int_double <-
function(x,y) { return(x < y) }
ats2r34pre_lt_double_int <-
function(x,y) { return(x < y) }

ats2r34pre_lte_int_double <-
function(x,y) { return(x <= y) }
ats2r34pre_lte_double_int <-
function(x,y) { return(x <= y) }

ats2r34pre_gt_int_double <-
function(x,y) { return(x > y) }
ats2r34pre_gt_double_int <-
function(x,y) { return(x > y) }

ats2r34pre_gte_int_double <-
function(x,y) { return(x >= y) }
ats2r34pre_gte_double_int <-
function(x,y) { return(x >= y) }

ats2r34pre_eq_int_double <-
function(x,y) { return(x == y) }
ats2r34pre_eq_double_int <-
function(x,y) { return(x == y) }

ats2r34pre_neq_int_double <-
function(x,y) { return(x != y) }
ats2r34pre_neq_double_int <-
function(x,y) { return(x != y) }

######

ats2r34pre_lt_double_double <-
function(x,y) { return(x < y) }
ats2r34pre_lte_double_double <-
function(x,y) { return(x <= y) }

ats2r34pre_gt_double_double <-
function(x,y) { return(x > y) }
ats2r34pre_gte_double_double <-
function(x,y) { return(x >= y) }

ats2r34pre_eq_double_double <-
function(x,y) { return(x == y) }
ats2r34pre_neq_double_double <-
function(x,y) { return(x != y) }

######
##
ats2r34pre_print_int <-
  function(x) { return(cat(x)) }
ats2r34pre_print_double <-
  function(x) { return(cat(x)) }
ats2r34pre_print_string <-
  function(x) { return(cat(x)) }
##
ats2r34pre_print_newline <-
function() {
  cat("\n"); utils::flush.console(); return(NULL)
} ## ats2r34pre_print_newline
##
######

######
#
# R34vector
#
######

######

ats2r34pre_R34vector_length <-
function(xs) { return(length(xs)) }

######
#
ats2r34pre_R34vector_get_at <-
function(xs, i) { return(xs[i]) }
#
# HX-2017-10-03:
# No call-by-reference in R!!!
#
# ats2r34pre_R34vector_set_at <-
# function(xs, i, x0) { xs[i] <- x0; return(NULL) }
#
######

ats2r34pre_R34vector_match <-
function(x, xs) {
  return(match(x, xs, nomatch=0))
} ## ats2r34pre_R34vector_match

######

ats2r34pre_R34vector_map_fun <-
function(xs, fopr)
{
  n0 = length(xs)
  if (n0 == 0) return(c())
  y1 = fopr(xs[[1]]); ys = rep(y1, n0)
  if (n0 >= 2)
  {
    for (i in 2:n0) ys[[i]]<-fopr(xs[[i]])
  } ; return(ys)
} ## ats2r34pre_R34vector_map_fun

######

######
#
# R34dframe
#
######

######

ats2r34pre_R34dframe_nrow <-
  function(xss) { return(nrow(xss)) }
ats2r34pre_R34dframe_ncol <-
  function(xss) { return(ncol(xss)) }

######

ats2r34pre_R34dframe_names <-
  function(xss) { return(names(xss)) }

######

ats2r34pre_R34dframe_getcol_at <-
function(xss, jcol) { return(xss[[jcol]]) }
ats2r34pre_R34dframe_getcol_by <-
function(xss, name) { return(xss[[name]]) }

######


###### end of [libatscc2r34.R] ######

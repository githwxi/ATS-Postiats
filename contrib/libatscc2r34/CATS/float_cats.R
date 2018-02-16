############################################
#
# HX-2017-10:
#
# for R code translated from ATS
#
############################################

############################################
#beg of [float_cats.R]
############################################

assign(
  "libatscc2r34_float.is.loaded", TRUE
)#assign

############################################

ats2r34pre_neg_double <-
function(x) { return( -x ) }
ats2r34pre_abs_double <-
function(x) { return(abs(x)) }

############################################

ats2r34pre_succ_double <-
function(x) { return(x + 1) }
ats2r34pre_pred_double <-
function(x) { return(x - 1) }

############################################

ats2r34pre_sqrt_double <-
function(x) { return(sqrt(x)) }

############################################

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

############################################

ats2r34pre_add_double_double <-
function(x,y) { return(x + y) }

ats2r34pre_sub_double_double <-
function(x,y) { return(x - y) }

ats2r34pre_mul_double_double <-
function(x,y) { return(x * y) }

ats2r34pre_div_double_double <-
function(x,y) { return(x / y) }

############################################

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

############################################

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

############################################
#
ats2r34pre_max_double_double <-
  function(x,y) { return(max(x,y)) }
ats2r34pre_min_double_double <-
  function(x,y) { return(min(x,y)) }
#
############################################
#
ats2r34pre_exp_double <-
  function(x) { return(exp(x)) }
ats2r34pre_pow_double_double <-
  function(x,y) { return((x)^(y)) }
#
############################################
#
ats2r34pre_log_double <-
  function(x) { return(log(x)) }
ats2r34pre_log2_double <-
  function(x) { return(log2(x)) }
ats2r34pre_log10_double <-
  function(x) { return(log10(x)) }
#  
############################################
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
############################################

############################################
#end of [float_cats.R]
############################################

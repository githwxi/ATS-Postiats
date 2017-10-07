############################################
#
# HX-2017-10:
#
# for R code translated from ATS
#
############################################

############################################
#beg of [integer_cats.R]
############################################

assign(
  "libatscc2r34_integer.is.loaded", TRUE
)#assign

############################################

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

############################################

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

############################################
  
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

############################################

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

############################################

ats2r34pre_max_int0_int0 <-
function(x,y) { return(max(x, y)) }
ats2r34pre_min_int0_int0 <-
function(x,y) { return(min(x, y)) }

ats2r34pre_max_int1_int1 <-
function(x,y) { return(max(x, y)) }
ats2r34pre_min_int1_int1 <-
function(x,y) { return(min(x, y)) }
  
############################################
#end of [integer_cats.R]
############################################

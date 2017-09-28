######
#
# Prelude for atscc2r3
#
######

assign("libatscc2r3.is.loaded", TRUE)

######
#
# integer
#
######

ats2r3pre_succ_int0 <- function(arg0) { return(arg0 + 1) }
ats2r3pre_pred_int0 <- function(arg0) { return(arg0 - 1) }

ats2r3pre_add_int0_int0 <- function(arg0,arg1) { return(arg0 + arg1) }
ats2r3pre_sub_int0_int0 <- function(arg0,arg1) { return(arg0 - arg1) }
ats2r3pre_mul_int0_int0 <- function(arg0,arg1) { return(arg0 * arg1) }

######

ats2r3pre_lt_int0_int0 <- function(arg0,arg1) { return(arg0 < arg1) }
ats2r3pre_lte_int0_int0 <- function(arg0,arg1) { return(arg0 <= arg1) }

ats2r3pre_gt_int0_int0 <- function(arg0,arg1) { return(arg0 > arg1) }
ats2r3pre_gte_int0_int0 <- function(arg0,arg1) { return(arg0 >= arg1) }

ats2r3pre_eq_int0_int0 <- function(arg0,arg1) { return(arg0 == arg1) }
ats2r3pre_neq_int0_int0 <- function(arg0,arg1) { return(arg0 != arg1) }

###### end of [libatscc2r3.R] ######

######
#
# Prelude for atscc2r34
#
######

assign("libatscc2r34.is.loaded", TRUE)

######

ATSCKiseqz <- function(x) { return (x == 0) }
ATSCKisneqz <- function(x) { return (x != 0) }

######

ATSCKpat_int <- function(tmp, given) { return(tmp == given) }
ATSCKpat_bool <- function(tmp, given) { return(tmp == given) }
ATSCKpat_float <- function(tmp, given) { return(tmp == given) }
ATSCKpat_string <- function(tmp, given) { return(tmp == given) }

######

ATSCKptrisnil <- function(tmp) { return(is.null(tmp)) }
ATSCKptriscons <- function(tmp) { return(!is.null(tmp)) }

######

######
#
# integer
#
######

ats2r34pre_succ_int0 <- function(arg0) { return(arg0 + 1) }
ats2r34pre_pred_int0 <- function(arg0) { return(arg0 - 1) }

ats2r34pre_add_int0_int0 <- function(arg0,arg1) { return(arg0 + arg1) }
ats2r34pre_sub_int0_int0 <- function(arg0,arg1) { return(arg0 - arg1) }
ats2r34pre_mul_int0_int0 <- function(arg0,arg1) { return(arg0 * arg1) }

######

ats2r34pre_succ_int1 <- function(arg0) { return(arg0 + 1) }
ats2r34pre_pred_int1 <- function(arg0) { return(arg0 - 1) }

ats2r34pre_add_int1_int1 <- function(arg0,arg1) { return(arg0 + arg1) }
ats2r34pre_sub_int1_int1 <- function(arg0,arg1) { return(arg0 - arg1) }
ats2r34pre_mul_int1_int1 <- function(arg0,arg1) { return(arg0 * arg1) }

######
  
ats2r34pre_lt_int0_int0 <- function(arg0,arg1) { return(arg0 < arg1) }
ats2r34pre_lte_int0_int0 <- function(arg0,arg1) { return(arg0 <= arg1) }

ats2r34pre_gt_int0_int0 <- function(arg0,arg1) { return(arg0 > arg1) }
ats2r34pre_gte_int0_int0 <- function(arg0,arg1) { return(arg0 >= arg1) }

ats2r34pre_eq_int0_int0 <- function(arg0,arg1) { return(arg0 == arg1) }
ats2r34pre_neq_int0_int0 <- function(arg0,arg1) { return(arg0 != arg1) }

######

ats2r34pre_lt_int1_int1 <- function(arg0,arg1) { return(arg0 < arg1) }
ats2r34pre_lte_int1_int1 <- function(arg0,arg1) { return(arg0 <= arg1) }

ats2r34pre_gt_int1_int1 <- function(arg0,arg1) { return(arg0 > arg1) }
ats2r34pre_gte_int1_int1 <- function(arg0,arg1) { return(arg0 >= arg1) }

ats2r34pre_eq_int1_int1 <- function(arg0,arg1) { return(arg0 == arg1) }
ats2r34pre_neq_int1_int1 <- function(arg0,arg1) { return(arg0 != arg1) }

######

###### end of [libatscc2r34.R] ######

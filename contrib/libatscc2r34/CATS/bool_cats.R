############################################
#
# HX-2017-10:
#
# for R code translated from ATS
#
############################################

############################################
#beg of [bool_cats.R]
############################################

assign(
  "libatscc2r34_bool.is.loaded", TRUE
)#assign

############################################

ats2r34pre_int2bool0 <-
function(x) { return(x != 0) }
ats2r34pre_int2bool1 <-
function(x) { return(x != 0) }

############################################

ats2r34pre_bool2int0 <-
function(x) { return(if(x) 1 else 0) }
ats2r34pre_bool2int1 <-
function(x) { return(if(x) 1 else 0) }

############################################

ats2r34pre_neg_bool0 <-
  function(x) { return(!x) }
ats2r34pre_neg_bool1 <-
  function(x) { return(!x) }

############################################

ats2r34pre_add_bool0_bool0 <-
  function(x, y) { return (x || y) }
ats2r34pre_add_bool0_bool1 <-
  function(x, y) { return (x || y) }
ats2r34pre_add_bool1_bool0 <-
  function(x, y) { return (x || y) }
ats2r34pre_add_bool1_bool1 <-
  function(x, y) { return (x || y) }

############################################

ats2r34pre_mul_bool0_bool0 <-
  function(x, y) { return (x && y) }
ats2r34pre_mul_bool0_bool1 <-
  function(x, y) { return (x && y) }
ats2r34pre_mul_bool1_bool0 <-
  function(x, y) { return (x && y) }
ats2r34pre_mul_bool1_bool1 <-
  function(x, y) { return (x && y) }

############################################

############################################
#end of [bool_cats.R]
############################################

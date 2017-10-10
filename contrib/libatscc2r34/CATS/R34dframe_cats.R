############################################
#
# HX-2017-10:
#
# for R code translated from ATS
#
############################################

############################################
#beg of [R34dframe_cats.R]
############################################

assign(
  "libatscc2r34_R34dframe.is.loaded", TRUE
)#assign

############################################

ats2r34pre_R34dframe_nrow <-
  function(xss) { return(nrow(xss)) }
ats2r34pre_R34dframe_ncol <-
  function(xss) { return(ncol(xss)) }

############################################

ats2r34pre_R34dframe_names <-
  function(xss) { return(names(xss)) }

############################################

ats2r34pre_R34dframe_getcol_at <-
function(xss, jcol) { return(xss[[jcol]]) }
ats2r34pre_R34dframe_getcol_by <-
function(xss, name) { return(xss[[name]]) }

############################################

ats2r34pre_R34dframe_na_omit <-
  function(xss) { return(na.omit(xss)) }

############################################
#end of [R34dframe_cats.R]
############################################

############################################
#
# HX-2017-10:
#
# for R code translated from ATS
#
############################################

############################################
#beg of [R34vector_cats.R]
############################################

assign(
  "libatscc2r34_R34vector.is.loaded", TRUE
)#assign

############################################

ats2r34pre_R34vector_length <-
function(xs) { return(length(xs)) }

############################################
#
ats2r34pre_R34vector_get_at <-
function(xs, i) { return(xs[[i]]) }
#
# HX-2017-10-03:
# No call-by-reference in R!!!
#
# ats2r34pre_R34vector_set_at <-
# function(xs, i, x0) { xs[[i]] <- x0; return(NULL) }
#
############################################

ats2r34pre_R34vector_match <-
function(x, xs) {
  return(match(x, xs, nomatch=0))
} ## ats2r34pre_R34vector_match

############################################

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

############################################

ats2r34pre_R34vector_tabulate_fun <-
function(n0, fopr)
{
  if (n0 == 0) return(c())
  x1 = fopr(0); xs = rep(x1, n0)
  if (n0 >= 2)
  {
    for (i in 2:n0) { xs[[i]] <- fopr(i-1) }
  } ; return(xs)
} ## ats2r34pre_R34vector_tabulate_fun

############################################
#end of [R34vector_cats.R]
############################################

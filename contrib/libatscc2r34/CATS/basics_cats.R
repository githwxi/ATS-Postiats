############################################
#
# HX-2017-10:
#
# for R code translated from ATS
#
############################################

############################################
#beg of [basics_cats.R]
############################################

assign(
  "libatscc2r34_basics.is.loaded", TRUE
)#assign

############################################

ATSCKiseqz <-
function(x) { return (x == 0) }
ATSCKisneqz <-
function(x) { return (x != 0) }

############################################

ATSCKptrisnull <-
function(xs) { return(is.null(xs)) }
ATSCKptriscons <-
function(xs) { return(!is.null(xs)) }

############################################

ATSCKpat_int <-
function(tmp, given) { return(tmp == given) }
ATSCKpat_bool <-
function(tmp, given) { return(tmp == given) }
ATSCKpat_float <-
function(tmp, given) { return(tmp == given) }
ATSCKpat_string <-
function(tmp, given) { return(tmp == given) }

############################################

ATSCKpat_con0 <-
function(con, tag) { return(con == tag) }
ATSCKpat_con1 <-
function(con, tag) { return(con[[1]] == tag) }

############################################

ATSINScaseof_fail <-
function(errmsg) { stop(errmsg) }

############################################

ATSINSdeadcode_fail <-
function() { stop("ATSINSdeadcode_fail()") }

############################################

ATSPMVempty <-
function() { return(NULL) }

############################################

ATSPMVlazyval <-
function(thunk) { return(list(0, thunk)) }

############################################

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
##
## HX-2017-12-22: nightmare!!!
##
    lazyval[ 2 ] = list(mythunk[[1]](mythunk));
  } else {
    lazyval[[1]] = flag + 1;
  } ## end of [if]
##
  return (lazyval[[2]]);
##
} ## end of [ATSPMVlazyval_eval]

############################################

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

############################################

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

############################################

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

############################################

ats2r34pre_assert_errmsg_bool0 <-
function(claim, errmsg) {
  if(!claim) { stop(errmsg) }; return(NULL)
}
ats2r34pre_assert_errmsg_bool1 <-
  ats2r34pre_assert_errmsg_bool0
  
############################################
#end of [basics_cats.R]
############################################

######
#
# HX-2014-11:
# for Perl code translated from ATS
#
######

######
#beg of [float_cats.pl]
######

############################################
#
sub
ats2plpre_double2int($) { return int($_[0]); }
sub
ats2plpre_int_of_double($) { return int($_[0]); }
#
sub
ats2plpre_int2double($) { return ($_[0]) ; }
sub
ats2plpre_double_of_int($) { return ($_[0]) ; }
#
############################################
#
sub
ats2plpre_abs_double($) { return abs($_[0]); }
sub
ats2plpre_neg_double($) { return ( -$_[0] ); }
#
sub
ats2plpre_succ_double($) { return ($_[0] + 1); }
sub
ats2plpre_pred_double($) { return ($_[0] + 1); }
#
############################################
#
sub
ats2plpre_add_int_double($$) { return ($_[0] + $_[1]); }
sub
ats2plpre_sub_int_double($$) { return ($_[0] - $_[1]); }
sub
ats2plpre_mul_int_double($$) { return ($_[0] * $_[1]); }
sub
ats2plpre_div_int_double($$) { return ($_[0] / $_[1]); }
#
############################################
#
sub
ats2plpre_add_double_int($$) { return ($_[0] + $_[1]); }
sub
ats2plpre_sub_double_int($$) { return ($_[0] - $_[1]); }
sub
ats2plpre_mul_double_int($$) { return ($_[0] * $_[1]); }
sub
ats2plpre_div_double_int($$) { return ($_[0] / $_[1]); }
#
############################################
#
sub
ats2plpre_add_double_double($$) { return ($_[0] + $_[1]); }
sub
ats2plpre_sub_double_double($$) { return ($_[0] - $_[1]); }
sub
ats2plpre_mul_double_double($$) { return ($_[0] * $_[1]); }
sub
ats2plpre_div_double_double($$) { return ($_[0] / $_[1]); }
#
############################################
#
sub
ats2plpre_lt_double_double($$) { return ($_[0] < $_[1]); }
sub
ats2plpre_lte_double_double($$) { return ($_[0] <= $_[1]); }
sub
ats2plpre_gt_double_double($$) { return ($_[0] > $_[1]); }
sub
ats2plpre_gte_double_double($$) { return ($_[0] >= $_[1]); }
#
sub
ats2plpre_eq_double_double($$) { return ($_[0] == $_[1]); }
sub
ats2plpre_neq_double_double($$) { return ($_[0] != $_[1]); }
#
############################################

######
1; #note that it is needed by 'use' or 'require'
######

######
#end of [float_cats.pl]
######

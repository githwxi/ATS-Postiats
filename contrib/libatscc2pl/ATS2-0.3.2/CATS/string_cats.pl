######
#
# HX-2014-11:
# for Perl code translated from ATS
#
######

######
#beg of [string_cats.pl]
######

############################################

sub
ats2plpre_lt_string_string($$) { return ($_[0] < $_[1]); }
sub
ats2plpre_lte_string_string($$) { return ($_[0] <= $_[1]); }
sub
ats2plpre_gt_string_string($$) { return ($_[0] > $_[1]); }
sub
ats2plpre_gte_string_string($$) { return ($_[0] >= $_[1]); }
sub
ats2plpre_eq_string_string($$) { return ($_[0] == $_[1]); }
sub
ats2plpre_neq_string_string($$) { return ($_[0] != $_[1]); }

############################################

######
1; #note that it is needed by 'use' or 'require'
######

###### end of [string_cats.pl] ######

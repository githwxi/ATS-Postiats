######
#
# HX-2014-11:
# for Perl code translated from ATS
#
######

######
#beg of [PLarray_cats.pl]
######

sub
ats2plpre_PLarray_nil() { return []; }
sub
ats2plpre_PLarray_sing($) { return [$_[0]]; }
sub
ats2plpre_PLarray_pair($$) { return [$_[0], $_[1]]; }

######

sub
ats2plpre_PLarray_get_at($$)
{
  my($A, $i) = @_; return $A->[$i];
}
sub
ats2plpre_PLarray_set_at($$$)
{
  my($A, $i, $x) = @_; $A->[$i] = $x; return;
}

######

sub
ats2plpre_PLarray_length($)
{
  return scalar(@{$_[0]});
}

######

sub
ats2plpre_PLarray_pop_0($) { return pop(@{$_[0]}); }
sub
ats2plpre_PLarray_pop_1($$) { return splice(@{$_[0]}, $_[1], 1); }

######

sub
ats2plpre_PLarray_push($$) { return push(@{$_[0]}, $_[1]); }

######

sub
ats2plpre_PLarray_extend($$) { push(@{$_[0]}, $_[1]); return; }

######
#
sub
ats2plpre_PLarray_reverse($)
{
  my $A = @_;
  my $i = 0 ;
  my $j = scalar(@{$A}) - 1;
  while ($i < $j)
  {
    my $tmp = $A->[i]; $A->[i] = $A->[j]; $A->[j] = $tmp; $i++; $j--;
  }
  return;
} #ats2plpre_PLarray_reverse
#
######

sub
ats2plpre_PLarray_copy($)
{
  my @A2 = @{$_[0]}; return \@A2;
}
sub
ats2plpre_PLarray_revcopy($)
{
  my @A2 = reverse(@{$_[0]}); return \@A2;
}

######

sub
ats2plpre_PLarray_append_2($$)
{
  my @res = (@{$_[0]}, @{$_[1]}); return \@res;
}
sub
ats2plpre_PLarray_append_3($$$)
{
  my @res = (@{$_[0]}, @{$_[1]}, @{$_[2]}); return \@res;
}

######

######
1; #note that it is needed by 'use' or 'require'
######

######
#end of [PLarray_cats.pl]
######

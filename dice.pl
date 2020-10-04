#!/usr/bin/env perl
# DICEWARE GENERATOR
use strict;
use warnings;

my $num = $ARGV[0] ||= 4;

for(my $i = 0; $i < $num; ++$i)
{
  for(my $j = 0; $j < 5; ++$j)
  {
  print int(rand(6) + 1);
  }
  print "\n";
}
